---
name: second-brain-refresh-index
description: >-
  Rebuilds the wiki index of a second-brain style vault from the wiki/
  articles themselves and appends one entry to the wiki log, after an approved
  compile or another approved wiki change. Groups articles by domain folder
  with a one-line summary each. Triggers on a handoff from
  second-brain-compile-plan or on an explicit request to refresh the wiki
  index. Never runs without that approval. Not for audits
  (second-brain-audit), compiling (second-brain-compile-plan) or project
  folders (second-brain-new-project).
---
## Inputs
- `vault` (required): absolute path to a local clone.
- `approval` (required): the approved plan or change, and who approved it.
- `landed` (optional): files that actually changed in wiki/.
- `index` (optional, default `wiki/_master-index.md`).
- `log` (optional, default `wiki/_log.md`).
- `manual` (optional, default `AGENTS.md` at the vault root, else `CLAUDE.md`). Where the manual is stricter, the manual wins.

If `approval` is missing, stop. Silence is not approval.

## Procedure
1. List every article under wiki/ except the index and the log, grouped by its first folder (the domain).
2. For each article take its H1 (or the file stem if there is none) and the first sentence of its first paragraph.
3. Rewrite the index from scratch. Keep the header text above the first `## ` heading, then:
   ```
   ## <Domain>
   - [[wiki/<Domain>/<slug>|<H1>]]: <first sentence>
   ```
   Domains and articles in alphabetical order. With no articles, keep the header and one line saying there are none yet, in the manual's language.
4. Compare with the previous index: added, removed and changed lines.
5. Append to the log, never rewriting old entries:
   ```
   ## [YYYY-MM-DD] <op> | <one-line summary>
   - wrote: `<stem>`
   - updated: `<stem>`
   - flagged: `<stem>`: <reason>
   ```
   `<op>` is `compile`, `refresh` or what the approval names. File stems go in backticks, not wikilinks.
6. Verify: every index wikilink resolves, and the log grew by exactly one entry.
7. Report to the approver: the index diff and the log entry.

## Hard don'ts
- Never run without approval.
- Never edit wiki articles, raw/, or any file other than the index and the log.
- Never rewrite old log entries.
- Never commit or push unless the manual assigns git to the caller.
