#!/bin/bash
# Snapshot Rex app settings into rex/com.superlogical.rex.plist.
# Keeps only Workspace.* and rex.* keys, dropping window frames, update checks,
# and per-machine state (last session, server route cache, migration flags).

defaults export com.superlogical.rex - | python3 -I -c '
import plistlib, sys

skip = {
    "Workspace.lastFocusedSession",
    "Workspace.programActivitySeen",
    "Workspace.activityGroupingResetToPriority",
    "rex.local-server.cached-route.v1",
    "rex.sync.hosts-migrated.v1",
}
prefs = plistlib.loads(sys.stdin.buffer.read())
kept = {
    key: value for key, value in prefs.items()
    if key.startswith(("Workspace.", "rex.")) and key not in skip
}
plistlib.dump(kept, sys.stdout.buffer, sort_keys=True)
' > "$HOME/.dotfiles/rex/com.superlogical.rex.plist"
