---
name: second-brain-audit
description: >-
  Audits a second-brain style vault (immutable raw/ sources, a compiled wiki/,
  project folders and master indexes) and reports findings without patching:
  broken wikilinks, orphan wiki articles, raw/ sources no article cites,
  contradictions, project folders that drift from the template, missing
  frontmatter, files over their line limits and uncommitted files, plus any
  extra checks the vault manual lists. Triggers on requests to audit,
  health-check or lint a vault, and on a scheduled vault audit. The caller
  passes the vault path and who gets the report. Not for compiling sources
  (second-brain-compile-plan), rebuilding an index
  (second-brain-refresh-index) or creating projects
  (second-brain-new-project).
---
Report only. The audit never fixes what it finds; the caller decides.

## Inputs
- `vault` (required): absolute path to a local clone of the vault.
- `report_to` (required): who receives the summary.
- `manual` (optional, default `AGENTS.md` at the vault root, else `CLAUDE.md`): its audit section lists limits, extra checks and where the report file goes. Where the manual is stricter than this skill, the manual wins.
- `language` (optional, default: the language of the request).

If `vault` or `report_to` is missing, ask once and stop.

## Procedure
Copy this checklist:
```
- [ ] 1. Manual audit section and indexes read
- [ ] 2. Wikilinks checked
- [ ] 3. Orphans and pending sources listed
- [ ] 4. Contradictions noted
- [ ] 5. Template and frontmatter checked
- [ ] 6. Line limits checked
- [ ] 7. Git status checked
- [ ] 8. Extra checks from the manual run
- [ ] 9. Report written and summary sent
```
1. Read the manual's audit section and every index it names.
2. Wikilinks: outside fenced code and inline code, every `[[target]]` or `[[target|alias]]` must resolve to `target.md` from the vault root. List broken ones with the file that holds them.
3. Orphans: wiki articles with no inbound link from the wiki index or another article. Pending sources: raw/ files that no wiki article lists in its `Source` frontmatter. Compare file names against `Source` entries; do not open raw/ files.
4. Contradictions: the same topic with different claims across wiki/ articles. Quote both sides with paths. Do not read raw/ to look for contradictions unless the manual asks for it: source versus wiki is checked at compile time.
5. Template: every project folder has each path the manual's template lists, and each project README has the frontmatter fields the manual requires.
6. Limits: files over the line limits the manual sets. Propose the archive the manual describes; move nothing.
7. Git: run `git status --porcelain` and list uncommitted or untracked files, with the `author` from their frontmatter when present.
8. Run every extra check the manual lists (for example, a sweep of lessons files, or drift between agent scopes and project READMEs).
9. Write the report where the manual says (if it says nothing, write no file) and send the summary to `report_to`.

## Report template
```
Audit | <vault> | <YYYY-MM-DD>
Broken links
- <file>: [[<target>]]
Orphans
- <wiki path>
Pending sources
- <raw path>
Contradictions
- <path A> says "<quote>"; <path B> says "<quote>"
Template and frontmatter
- <project>: missing <path or field>
Over limits
- <file>: <lines> lines (limit <n>). Proposal: <archive>
Uncommitted
- <file> (author: <slug or unknown>)
Extra checks
- <finding>
Recommended next step
- <one line>
```
Empty sections say "none". If every section is empty, the summary is one line saying there are no material findings, in the requested language.

## Hard don'ts
- Never edit wiki/, raw/, indexes, logs, project files or agent files during an audit. The only file an audit may write is its report, and only where the manual says.
- Never invent sources or quotes.
- Never commit or push; that is the caller's job.

## Evaluation scenarios
1. A wiki article links to a deleted note: the link appears under Broken links with both paths, and nothing is edited.
2. A raw/ file is in no `Source`: it appears under Pending sources.
3. A project folder lacks `references/`: it appears under Template and frontmatter.
4. Nothing found: a one-line summary and no other output.
