# CLAUDE.md

In all interactions and commit messages, be extremely concise and sacrifice grammar for the sake of concision.

## Plans

At the end of each plan, give me a list of unresolved questions to answer, if any. Make the questions extremely concise. Sacrifice grammar for the sake of concision.

## Markdown Style Rules

When writing or editing **any** Markdown file (`.md`, `.mdx`), you MUST strictly follow the markdownlint rules from <https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md>

### Core rules to enforce at all times

#### Headings

- MD001: Heading levels increment by one level only (no skipping from `#` to `###`)
- MD003: Use consistent heading style — ATX style (`## Heading`) throughout
- MD022: Headings must be surrounded by blank lines (before and after)
- MD023: Headings must start at the beginning of the line (no indentation)
- MD024: No duplicate heading text at the same level
- MD025: Only one top-level `#` heading per document
- MD026: No trailing punctuation in headings (no `.`, `!`, `:` at end)
- MD041: First line must be a top-level `#` heading

#### Lists

- MD004: Use consistent unordered list marker (`-` preferred)
- MD007: Unordered list indentation — 2 spaces per level
- MD029: Ordered list items must use sequential numbers (1. 2. 3.)
- MD030: One space after list markers
- MD032: Lists must be surrounded by blank lines

#### Code

- MD031: Fenced code blocks must be surrounded by blank lines
- MD040: Fenced code blocks must specify a language (e.g. ```python)

#### Whitespace & formatting

- MD009: No trailing spaces
- MD010: No hard tabs — use spaces only
- MD012: No multiple consecutive blank lines
- MD027: No multiple spaces after blockquote `>` symbol

#### Links & images

- MD011: No reversed link syntax — correct: `[text](url)`, not `(text)[url]`
- MD034: No bare URLs — always wrap in `<url>` or `[text](url)`
- MD042: No empty links `[text]()`
- MD045: Images must have alt text `![alt text](url)`

#### Misc

- MD033: No inline HTML unless explicitly required
- MD036: Do not use emphasis (`**bold**`) as a substitute for a heading
- MD037: No spaces inside emphasis markers (`**text**` not `** text **`)
- MD038: No spaces inside code span backticks
- MD039: No spaces inside link text brackets
