# CLAUDE.md

## Response Format

- Be extremely concise — sacrifice grammar for concision
- No explanation of what you just did unless asked
- No trailing summaries — the diff speaks for itself
- Show diffs/edits, not full file reprints
- No preamble ("Sure!", "Of course!", "Great question!")

## Principles

- **Simplicity first** — simplest correct solution wins
- **TDD** — where a test framework exists, new features start with a failing test
- **No laziness** — find root causes; no temp hacks
- **Minimal impact** — touch only what's necessary
- **Linters own style** — never spend context on formatting
- **No AI patterns** — code must look human-written. No defensive checks for impossible cases, no unnecessary abstractions, no boilerplate wrappers
- **Respect existing code** — read before editing, match existing patterns, don't introduce new libraries/patterns when the codebase already has a way
- **Multiline if-else** — never write single-line `if`/`else` bodies; always use braces and newlines

## Comments

- Default to NO comment. Add one only when the code's intent stays unclear after a careful read — err on the side of fewer
- One comment per non-obvious thing; never explain the same point in both the code and a test name
- Comment sparingly — only where intent isn't obvious from the code
- No restating what the code says (`// increment i`)
- No section banners, no docstrings on self-evident functions
- Write like a teammate leaving a note, not documentation — terse, lowercase ok, no ceremony
- Leave a comment only for the *why*: tradeoffs, gotchas, non-obvious constraints
- Match the tone/density of comments already in the file
- Keep comments short — one line when possible; if it spans multiple lines, rewrite shorter

## No AI Tells

Applies to comments, commits, PRs, docs, and prose. Goal: text reads human-written.

- **Punctuation**: no em-dash (`—`); use hyphen, comma, or parens. No semicolons in prose; split or use a comma.
- **No emoji** in code, comments, or commits.
- **Filler words** banned: leverage, utilize, robust, seamless, comprehensive, crucial, vital, essential, pivotal. Use plain words: use, strong, smooth, key.
- **Empty phrasings** banned: "not just X, it's Y", "it's worth noting", "it's important to note", "at its core", "delve into".
- **No stacked transitions** at sentence starts: Moreover, Furthermore, Additionally, Notably.
- **No filler closers**: "In summary", "Let me know if...", "I hope this helps".
- **No rhetorical questions** in comments ("But what does this mean?").
- Vary sentence length; avoid mechanical tricolons and identically-shaped list items.

## Code Style

- Write for the next human reading it, not for the machine
- Names say intent in plain words — short, real words, no `tmp2`/`dataObj`/`handlerFn`
- One thing per function; if it needs a "and" to describe, split it
- Flat over nested — early returns, no deep pyramids
- No clever one-liners that need a second read; boring and obvious wins
- Consistent with the file's existing style over personal preference
- Small functions over comments explaining a big one

## Boundaries

- Never auto-commit — only commit when explicitly asked
- Never push without asking
- Never refactor code not touched by the current task
- Never add features beyond what was asked
- When ambiguous, ask instead of guessing
- If a task seems larger than expected, check before proceeding

## Files

- Prefer editing existing files over creating new ones
- No unsolicited docs/README/scripts — only what was asked
- Ask before adding a new dependency

## Error Handling

- Let errors propagate by default — don't catch unless you can do something useful
- Catch at boundaries only — UI error boundaries, top-level API handlers for user feedback
- Early return over try/catch nesting
- Never silently swallow errors — no empty catch blocks

## Verification

- Never claim done/fixed/passing without running it and seeing output
- Evidence before assertions — quote the result, don't assume
- Never weaken, skip, or delete a test to make it pass — fix the code

## Git Conventions

- Conventional Commits 1.0.0: `<type>[scope]: <description>`
- Types: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, `perf`
- Breaking changes: append `!` or add `BREAKING CHANGE:` footer
- Subject line ≤72 chars, imperative mood
- Keep PRs small and focused — one logical change per PR

## Security

- Never commit `.env`, credentials, or any file containing secrets
- Never log sensitive data (tokens, passwords, PII)
- Warn explicitly if asked to do either

## Plans

At the end of each plan, give me a list of unresolved questions to answer, if any. Extremely concise.

## Code Review After Edits

After completing edits, suggest (don't act) concrete improvements in the edited file: duplication, readability, bugs, patterns, simplification, performance, missing edge cases (null/empty/boundary), resource leaks (unclosed handles/connections/listeners), hardcoded values that should be constants. Ranked by impact, one line per item.

@RTK.md
