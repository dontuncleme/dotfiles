import Cocoa

// launchd sends stdout to a file, which is block-buffered by default
setvbuf(stdout, nil, _IOLBF, 0)

let promptOption = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary
if !AXIsProcessTrustedWithOptions(promptOption) {
    print("Access required: System Settings → Privacy & Security → Accessibility.")
    print("Grant it to this binary (or to Terminal when run with `swift`) and run again.")

    exit(1)
}

let blockedPixels: CGFloat = 3

func activeDisplays() -> [CGDirectDisplayID] {
    var count: UInt32 = 0
    CGGetActiveDisplayList(0, nil, &count)
    var ids = [CGDirectDisplayID](repeating: 0, count: Int(count))
    CGGetActiveDisplayList(count, &ids, &count)

    return ids
}

let displays = activeDisplays()
for (index, display) in displays.enumerated() {
    let bounds = CGDisplayBounds(display)
    let mainLabel = display == CGMainDisplayID() ? " (main)" : ""
    print("[\(index)] id=\(display) \(Int(bounds.width))x\(Int(bounds.height)) @ (\(Int(bounds.minX)), \(Int(bounds.minY)))\(mainLabel)")
}

let requestedIndex = CommandLine.arguments.count > 1 ? Int(CommandLine.arguments[1]) : nil

// nil means the main display, looked up on every event since it can change after a reconnect
var fixedDisplay: CGDirectDisplayID?

func resolveFixedDisplay() {
    guard let index = requestedIndex else { return }

    let displays = activeDisplays()
    fixedDisplay = displays.indices.contains(index) ? displays[index] : nil
}

// The Dock keeps a window at layer 20 that covers the whole display it sits on
func dockDisplay() -> CGDirectDisplayID? {
    let windows = CGWindowListCopyWindowInfo(.optionAll, kCGNullWindowID) as? [[String: Any]] ?? []
    let dockWindow = windows.first {
        $0[kCGWindowOwnerName as String] as? String == "Dock" && $0[kCGWindowLayer as String] as? Int == 20
    }
    guard let boundsInfo = dockWindow?[kCGWindowBounds as String] as? NSDictionary,
          let bounds = CGRect(dictionaryRepresentation: boundsInfo) else { return nil }

    return activeDisplays().first { CGDisplayBounds($0) == bounds }
}

let pushMarker: Int64 = 0x646F636B

var pushEdge: CGPoint?

// There's no API to move the Dock, so fake a push against the target's bottom edge, then put the cursor back.
// Pushes go out on a timer because sleeping here would stall this process's own event tap.
func moveDockToTarget() {
    guard pushEdge == nil else { return }

    let target = fixedDisplay ?? CGMainDisplayID()
    guard dockDisplay() != target else { return }

    let active = activeDisplays()
    let bounds = CGDisplayBounds(target)
    let freeEdgeX = stride(from: bounds.maxX - 50, to: bounds.minX, by: -50).first { x in
        !active.contains { CGDisplayBounds($0).contains(CGPoint(x: x, y: bounds.maxY + 1)) }
    }
    guard let x = freeEdgeX else {
        print("Display id=\(target) has no free bottom edge, can't move the Dock there.")

        return
    }

    print("Moving the Dock to display id=\(target).")
    let original = CGEvent(source: nil)!.location
    let edge = CGPoint(x: x, y: bounds.maxY - 1)
    pushEdge = edge
    CGWarpMouseCursorPosition(edge)

    // 0.3 s of pushes was enough in testing, 0.4 s leaves some headroom
    var pushesLeft = 20
    Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
        let push = CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: edge, mouseButton: .left)!
        push.setIntegerValueField(.mouseEventDeltaY, value: 10)
        push.setIntegerValueField(.eventSourceUserData, value: pushMarker)
        push.post(tap: .cghidEventTap)

        pushesLeft -= 1
        guard pushesLeft == 0 else { return }

        timer.invalidate()
        pushEdge = nil
        CGWarpMouseCursorPosition(original)
    }
}

var pendingDockMove: DispatchWorkItem?

// Display change callbacks only arrive in a process that runs NSApplication. Prohibited keeps it out of the Dock.
let app = NSApplication.shared
app.setActivationPolicy(.prohibited)

resolveFixedDisplay()
CGDisplayRegisterReconfigurationCallback({ _, flags, _ in
    guard !flags.contains(.beginConfigurationFlag) else { return }

    resolveFixedDisplay()

    // One reconnect fires this for every display, and macOS may still move the Dock itself, so wait for it to settle
    pendingDockMove?.cancel()
    let move = DispatchWorkItem { moveDockToTarget() }
    pendingDockMove = move
    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: move)
}, nil)

print("Dock locked to display id=\(fixedDisplay ?? CGMainDisplayID()).")

// Without this, macOS freezes the cursor for a moment after every warp
CGEventSource(stateID: .combinedSessionState)?.localEventsSuppressionInterval = 0

var eventTap: CFMachPort?

let callback: CGEventTapCallBack = { _, type, event, _ in
    if type == .tapDisabledByTimeout || type == .tapDisabledByUserInput {
        if let tap = eventTap { CGEvent.tapEnable(tap: tap, enable: true) }

        return Unmanaged.passUnretained(event)
    }

    // Real movement during a push would pull the cursor off the edge and the Dock would stay put
    if let edge = pushEdge {
        guard event.getIntegerValueField(.eventSourceUserData) != pushMarker else { return Unmanaged.passUnretained(event) }

        CGWarpMouseCursorPosition(edge)

        return nil
    }

    var cursor = event.location
    let active = activeDisplays()
    let target = fixedDisplay ?? CGMainDisplayID()

    // Target display is gone: blocking every edge would break the Dock on the remaining screens
    guard active.contains(target) else { return Unmanaged.passUnretained(event) }

    for display in active where display != target {
        let bounds = CGDisplayBounds(display)
        guard cursor.x >= bounds.minX, cursor.x < bounds.maxX, cursor.y >= bounds.minY, cursor.y <= bounds.maxY else { continue }

        // A display right below means this edge leads somewhere, so the cursor must be free to cross it
        let below = CGPoint(x: cursor.x, y: bounds.maxY + 1)
        if active.contains(where: { CGDisplayBounds($0).contains(below) }) { continue }

        let limit = bounds.maxY - blockedPixels
        guard cursor.y > limit else { continue }

        cursor.y = limit
        event.location = cursor
        CGWarpMouseCursorPosition(cursor)
    }

    return Unmanaged.passUnretained(event)
}

let types: [CGEventType] = [.mouseMoved, .leftMouseDragged, .rightMouseDragged, .otherMouseDragged]
let mask = types.reduce(CGEventMask(0)) { $0 | (CGEventMask(1) << $1.rawValue) }

guard let tap = CGEvent.tapCreate(tap: .cgSessionEventTap,
                                  place: .headInsertEventTap,
                                  options: .defaultTap,
                                  eventsOfInterest: mask,
                                  callback: callback,
                                  userInfo: nil) else {
    print("Failed to create the event tap (check Accessibility permissions).")

    exit(1)
}
eventTap = tap

let source = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)
CFRunLoopAddSource(CFRunLoopGetCurrent(), source, .commonModes)
CGEvent.tapEnable(tap: tap, enable: true)
moveDockToTarget()
app.run()
