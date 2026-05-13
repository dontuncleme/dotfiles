# CLAUDE.md

## Response Format

- Be extremely concise — sacrifice grammar for concision
- No explanation of what you just did unless asked
- No trailing summaries — the diff speaks for itself
- Show diffs/edits, not full file reprints
- No preamble ("Sure!", "Of course!", "Great question!")

## Principles

- **Simplicity first** — simplest correct solution wins
- **Human-Readable** — clarity over cleverness
- **Clean Code** — comments explain *why*, never *what*
- **TDD** — new features start with a failing test
- **No laziness** — find root causes; no temp hacks
- **Minimal impact** — touch only what's necessary
- **Linters own style** — never spend context on formatting
- **No AI patterns** — code must look human-written. No verbose names like `isProcessingComplete`, no over-commented obvious logic, no defensive checks for impossible cases, no unnecessary abstractions, no boilerplate wrappers
- **Respect existing code** — read before editing, match existing patterns, don't introduce new libraries/patterns when the codebase already has a way
- **Multiline if-else** — never write single-line `if`/`else` bodies; always use braces and newlines

## Boundaries

- Never auto-commit — only commit when explicitly asked
- Never push without asking
- Never refactor code not touched by the current task
- Never add features beyond what was asked
- When ambiguous, ask instead of guessing
- If a task seems larger than expected, check before proceeding

## Error Handling

- Let errors propagate by default — don't catch unless you can do something useful
- Catch at boundaries only — UI error boundaries, top-level API handlers for user feedback
- Early return over try/catch nesting
- Never silently swallow errors — no empty catch blocks

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
