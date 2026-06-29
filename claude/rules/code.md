---
paths:
  - "**/*.{js,jsx,ts,tsx,mjs,cjs,py,go,rs,rb,java,kt,kts,swift,c,cc,cpp,h,hpp,m,mm,sh,bash,zsh,lua,php,vue,svelte,scala,cs,sql}"
---

# Code rules

Loaded only when editing source files. Cross-cutting policy lives in `~/.claude/CLAUDE.md`.

## Comments

- Default to NO comment; add one only for the *why* (tradeoffs, gotchas, non-obvious constraints), never to restate code (`// increment i`)
- No docstrings on self-evident functions, no section banners; never explain the same point in both the code and a test name
- Match the tone/density of comments already in the file; keep them short, one line when possible
- Mark a deliberate shortcut with a comment naming its ceiling and upgrade path (e.g. global lock, O(n^2) scan, naive heuristic)

## Code Style

- Write for the next human reading it, not for the machine
- Names say intent in plain words - short, real words, no `tmp2`/`dataObj`/`handlerFn`
- One thing per function; if it needs a "and" to describe, split it
- Flat over nested - early returns, no deep pyramids
- No clever one-liners that need a second read; boring and obvious wins
- Small functions over comments explaining a big one
- No AI patterns: code must look human-written; no defensive checks for impossible cases, no unnecessary abstractions, no boilerplate wrappers

## Bug Fixes

- Fix the shared function once: grep all callers and fix the common point; patching only the path the ticket names leaves sibling callers broken

## Error Handling

- Let errors propagate by default - don't catch unless you can do something useful
- Catch at boundaries only - UI error boundaries, top-level API handlers for user feedback
- Early return over try/catch nesting
- Never silently swallow errors - no empty catch blocks
