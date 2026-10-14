---
name: second-brain-compile-plan
description: >-
  Proposes a compile plan for a second-brain style vault (raw/ sources compiled
  into wiki/ articles, with a master index and an append-only log): which wiki
  articles to create or update, contradictions between raw/ and wiki/, and which
  raw/ sources stay pending. Stops for an explicit human yes. After approval it
  writes only the approved wiki/ articles, verifies them, and hands index and
  log updates to second-brain-refresh-index. Triggers on requests to compile,
  process new raw/ sources, or propose what goes into the wiki. The caller
  passes the vault location and the approver. Not for audits
  (second-brain-audit), index or log refresh alone (second-brain-refresh-index),
  or answering questions from a vault (a plain read following the manual).
---
Two phases. Phase 1 plans and stops. Phase 2 runs only after an explicit yes and only writes approved wiki/ articles. Index and log writes belong to `second-brain-refresh-index`, never to this skill.

## Inputs
- `vault` (required): a GitHub repo `owner/name` plus branch, or an absolute local path.
- `approver` (required): who must say yes and through which channel (for example, "the user, relayed by the lead agent"). The plan goes there.
- `manual` (optional, default `AGENTS.md` at the vault root, else `CLAUDE.md`): vault rules. Where the manual is stricter than this skill, the manual wins.
- `index` (optional, default `wiki/_master-index.md`): index of wiki/.
- `log` (optional, default `wiki/_log.md`): append-only log of wiki/ changes.
- `scope` (optional): specific raw/ files or a topic. Default: every raw/ source not yet compiled.
- `language` (optional, default: the language of the request): language of the plan and report.
- `exclusions` (optional): names, topics or folders the caller says must never appear in wiki/.

If `vault` or `approver` is missing, ask the caller once and stop.

## Expected layout

| Path | Role | This skill |
|---|---|---|
| `raw/` | Source files | Read only |
| `wiki/` | Compiled articles | Writes approved articles in phase 2 |
| `index` | Index of wiki/ | Read only (refresh-index writes it) |
| `log` | Append-only wiki/ log | Read only (refresh-index writes it) |
| Folders the manual marks human-owned or cite-only (for example `user/`, `projects/`) | Context | Read and cite; never raw material for wiki/, never written |

## Phase 1: plan (no writes)
Copy this checklist:
```
- [ ] 1. Manual and index read end to end
- [ ] 2. Candidate raw/ sources listed
- [ ] 3. Each source and the wiki/ articles it touches read
- [ ] 4. Each source classified; contradictions noted
- [ ] 5. Plan sent to approver in template format
- [ ] 6. Stopped
```
1. Read the manual and the index end to end.
2. List candidate raw/ sources: files in `scope`, or else raw/ files that no wiki/ article lists in its `Source` frontmatter (if the manual names another provenance field, use that one).
3. Read each candidate, then the wiki/ articles it would touch (find them through the index).
4. Classify each source: create, update, or pending (with a reason: thin, duplicate, out of scope, needs a human call). Record contradictions with both sides quoted and both paths.
5. Send the plan to the approver using the template below.
6. Stop. Write nothing to wiki/, the index or the log.

### Plan template
```
Compile plan | <vault> | <YYYY-MM-DD>
Create
- <wiki path>: <one-line reason> (sources: <raw paths>)
Update
- <wiki path>: <what changes and why> (sources: <raw paths>)
Contradictions
- <path A> says "<quote>"; <path B> says "<quote>". Proposal: <how to resolve or mark open>
Pending
- <raw path>: <reason>
Not touching
- <cite-only folders, exclusions>
Approve all, some lines, or none?
```
Empty sections say "none". Paths use `/`.

### Example
```
Compile plan | acme/notes-vault@main | 2026-10-08
Create
- wiki/marketing/pricing-experiments.md: no article on pricing tests yet (sources: raw/2026-10-01-pricing-test.md, raw/2026-10-03-pricing-call.md)
Update
- wiki/sales/discovery-calls.md: add the three-question opener; article has only two (sources: raw/2026-10-02-sales-notes.md)
Contradictions
- wiki/sales/discovery-calls.md says "send the agenda 24h before"; raw/2026-10-02-sales-notes.md says "same-day agenda got more replies". Proposal: keep both, mark as open.
Pending
- raw/2026-10-04-podcast-transcript.md: single anecdote, wait for a second source
Not touching
- user/, projects/
Approve all, some lines, or none?
```

## Phase 2: write approved articles
Branch on the answer:
- Yes to all: write every Create and Update line.
- Partial yes: write only the approved lines; the rest move to Pending.
- Changes requested: revise the plan, send it again (phase 1, step 5).
- No, or no answer: do nothing. Silence is not approval.

Steps:
1. Write each approved article. Frontmatter per the manual (default: `Writer`, `Link`, `Source`, `tags`). Every claim cites a raw/ file or a URL. Internal links as `[[wikilink]]`. When the manual asks for them, mark a contradicted claim with a `> [!warning] Superseded` callout instead of overwriting it, and close each article with `## Key Takeaways`.
2. Verify each written article, fix, and check again until all pass:
   - [ ] every claim has a citation
   - [ ] every cited raw/ path or URL exists
   - [ ] every `[[wikilink]]` resolves to an existing file
   - [ ] frontmatter complete
   - [ ] only paths approved in the plan were touched
   If an article cannot pass, stop editing it and list it as failed in the report.
3. Hand off to `second-brain-refresh-index` with the approved plan and the list of files that landed. Do not touch the index or the log here.
4. Report to the approver: landed, failed, still pending, and the refresh-index result.

## When to use
- New raw/ sources need to be compiled into wiki/.
- Someone asks what should go into the wiki, or for a compile plan.
- An approved compile plan must be executed (phase 2).

## When not to use
- Checking a vault for contradictions, orphans or broken links without compiling: `second-brain-audit`.
- Refreshing the index or log after an approved change: `second-brain-refresh-index`.
- Answering a question from a vault: a plain read following the manual's efficient-reading rules.
- Vaults without the raw/ to wiki/ layout.

## Hard don'ts
- Never edit raw/.
- Never write wiki/ without an explicit yes from the approver.
- Never write the index or the log; that is `second-brain-refresh-index`.
- Never use cite-only folders as raw material for wiki/.
- Never write other agents' folders without an explicit ask.
- Never invent citations or sources.
- Never write anything listed in `exclusions`.

## Evaluation scenarios
1. Three new raw/ files, one contradicting an article: plan follows the template, quotes both sides, and nothing is written.
2. Partial yes (one of two lines): only that article is written, it passes the verification checklist, the other line moves to Pending, refresh-index gets the handoff.
3. Approver silent or says no: no writes, no handoff.
4. Article cites a raw/ path that does not exist: verification catches it, citation fixed or article reported as failed.
