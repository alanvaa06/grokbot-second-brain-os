---
name: second-brain-new-project
description: >-
  Creates a new project folder in a second-brain style vault by copying the
  vault's project template, filling its README (type, status, objective,
  agents, protocols, links), adding the project row to the master index and
  one line to the vault log. Triggers when the lead agent or the owner asks
  to create, open or register a new project or area in the vault. The caller
  passes the vault path and the project data. Not for editing an existing
  project, compiling knowledge (second-brain-compile-plan) or audits
  (second-brain-audit).
---
## Inputs
- `vault` (required): absolute path to a local clone.
- `slug` (required): kebab-case folder name.
- `name` (required): display name.
- `type` (required): `area` (never ends) or `project` (has an end).
- `objective` (required): one line.
- `requested_by` (required): who asked.
- `agents` (optional): list of `agent-slug: role in this project`.
- `protocols` (optional): list of protocol folder names.
- `links` (optional): external links (Drive, repos, sheets).
- `template` (optional, default `projects/_template`), `index` (default `_master-index.md`), `log` (default `_log.md`), `manual` (default `AGENTS.md`, else `CLAUDE.md`).

If a required input is missing or `type` is unclear, ask the caller once and stop. Never guess the type.

## Procedure
Copy this checklist:
```
- [ ] 1. Preconditions checked
- [ ] 2. Template copied
- [ ] 3. README filled
- [ ] 4. Links verified
- [ ] 5. Index row added
- [ ] 6. Log line appended
- [ ] 7. Committed (if the manual allows) and reported
```
1. Preconditions: `projects/<slug>/` does not exist; the template exists; every agent in `agents` has `agents/<agent-slug>/README.md`; every protocol has `agents/_protocols/<protocol>/README.md`. If one fails, report which and stop.
2. Copy the template: `cp -r <template> projects/<slug>`.
3. Fill `projects/<slug>/README.md`: frontmatter `type` and `status: active`; H1 = `name`; the objective line; agents as `[[agents/<agent-slug>/README|<Name>]] (<role>)`; protocols as `[[agents/_protocols/<protocol>/README|<protocol>]]`; links. Remove every template placeholder. Stay under the manual's README line limit.
4. Verify every wikilink in the new README resolves.
5. Add a row to the projects table in `index`, in alphabetical order: `| [[projects/<slug>/README\|<slug>]] | <type> | active | <objective> |`.
6. Append to `log`: `- <YYYY-MM-DD> | <caller> | new project [[projects/<slug>/README|<slug>]] (requested by <requested_by>)`.
7. If the manual assigns git to the caller: `git add projects/<slug> <index> <log>`, commit `<caller role>: new project <slug>`, push unless the manual's local values say there is no remote. Report the paths created and the index row.

## Hard don'ts
- Never overwrite an existing project folder.
- Never invent agents, protocols or links; leave the line out instead.
- Never write outside `projects/<slug>/`, the index and the log.
- Never use `git add -A`.

## Evaluation scenarios
1. Valid request: the folder has every template path, the README is filled, the index row and the log line exist.
2. Slug already exists: nothing written, caller told.
3. Unknown agent slug: nothing written, caller told which slug failed.
4. Type missing: one question to the caller, nothing written.
