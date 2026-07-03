# RTK - Rust Token Killer

Token-optimized CLI proxy (60-90% savings on dev operations). A PreToolUse hook rewrites supported commands automatically (`git status` -> `rtk git status`) - never prefix commands yourself.

## Meta Commands (use rtk directly)

```bash
rtk gain              # Show token savings analytics
rtk gain --history    # Show command usage history with savings
rtk discover          # Analyze Claude Code history for missed opportunities
rtk proxy <cmd>       # Execute raw command without filtering (for debugging)
```
