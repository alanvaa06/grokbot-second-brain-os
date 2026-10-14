---
name: second-brain-new-agent
description: >-
  Designs and registers a new agent for a second-brain style vault: a short
  interview (one job, one voice, explicit anti-jobs, who it reports to, which
  vault folders it may write, which skills), then the registry card in
  agents/<slug>/README.md, the description with its Vault block, applying it
  through the runtime adapter, a CHANGELOG line and a commit. Triggers when
  the owner or the chief asks to create, add or design a new agent or bot for
  the team. Not for the initial team setup (second-brain-init), for changing
  an existing agent (edit its README and apply), or for projects
  (second-brain-new-project).
---
Run by the Chief. One question at a time. Nothing is created until the Owner confirms the final description.

## Inputs
- `vault` (required): absolute path to the local clone.
- `manual` (optional, default `AGENTS.md` at the vault root). Where the manual is stricter, the manual wins.
- `requested_by` (required): who asked.
- `language` (optional, default: the language in `LOCAL.md`).

Read `LOCAL.md` for `runtime`, `chief`, `vault_path`, `language` (fills `{{lang}}`). Read `adapters/<runtime>/README.md` for "Create agent" and "Apply description".

## Procedure
Copy this checklist:
```
- [ ] 1. Interview done (job, voice, anti-jobs, reports to, vault scope, skills, name)
- [ ] 2. Description drafted and shown
- [ ] 3. Owner confirmed
- [ ] 4. Registry card written
- [ ] 5. Agent created or description applied through the adapter
- [ ] 6. Registry table row and CHANGELOG line added
- [ ] 7. Committed and reported
```
1. Interview, in this order, one question per message:
   1. **Job.** "What is the one job of this agent?" If the answer has two jobs, say so and ask which one; the other is a second agent or a skill.
   2. **Voice.** "How should it sound?" (one line: language, register, length).
   3. **Anti-jobs.** "What must it never do?" Add the framework defaults if missing: never sends email or messages on the Owner's behalf; never writes to the Owner unless the Chief asks or the Owner wrote to it; never commits or pushes (it only runs `git pull --ff-only`; the Chief commits for it) unless the Owner explicitly gives it git under the manual's rules; never invents sources.
   4. **Reports to.** Default: the Chief.
   5. **Vault scope.** Which projects it serves. Its Vault block then lists `projects/<slug>/meetings/` and `projects/<slug>/outputs/` for those projects as the only folders it creates files in, plus read access to the whole vault through the manual's efficient-reading rules.
   6. **Skills.** Which existing skills from `agents/_skills/` it uses, if any.
   7. **Name.** A lane name, not a real person (global rule 7). The Owner picks it.
2. Draft the description: one paragraph of persona (job, voice, anti-jobs, reports to), then the Vault block:
   ```
   Vault. The repo at {{vault_path}} is the team's memory. Before every task: git pull --ff-only, read AGENTS.md (again only if the pull changed it). You serve: <project slugs>. You create files only in <projects/<slug>/meetings/ and outputs/ list>, frontmatter per AGENTS.md, status draft; you edit only your own drafts. You read the rest of the vault by its indexes. Git: you only run git pull --ff-only; you never commit or push. {{chief}} commits what you produce. You report to {{chief}} only. Write in {{lang}}, no em dashes.
   ```
   Fill the placeholders from `LOCAL.md`. Show the full description and the can/cannot table to the Owner.
3. Wait for an explicit yes. Silence is not approval. On changes, redraft and show again.
4. Write `agents/<slug>/README.md` with the card format from `agents/README.md`: fields, "Current description" (verbatim), can/cannot, skills, files it reads and writes. Slug: kebab-case of the name.
5. Create the agent with the adapter's "Create agent" step (description = the confirmed text). If the adapter says "not available", print the description, ask the Owner to create it, and set the card's `Status` row to `pending-creation` until the Owner confirms, then set it to `active`.
6. Add the row to the Team table in `agents/README.md` (`| domain: <team> | [[agents/<slug>/README\|<Name>]] | <reports to> | active |`, or `pending-creation`) and the line to `agents/CHANGELOG.md` (`- YYYY-MM-DD | <slug> | created: <one-line job> | applied by <chief>`). If the agent serves projects, add it to each project README's Agents line.
7. `git add agents/<slug> agents/README.md agents/CHANGELOG.md` plus any project README touched; commit `chief: new agent <slug>`; push unless `LOCAL.md` has `repo: none`. Report the paths and the final description.

## Hard don'ts
- Never create an agent with two jobs, no anti-jobs, or tools it does not need.
- Never apply a description the Owner has not confirmed verbatim.
- Never name an agent after a real person or let it speak as one.
- Never write outside `agents/<slug>/`, `agents/README.md`, `agents/CHANGELOG.md` and the project READMEs it is added to.
- Never `git add -A`.

## Evaluation scenarios
1. Owner describes a research agent for one project: seven questions, one description shown, yes, card written, agent created, table row, changelog line, one commit.
2. Owner describes "writes posts and manages my calendar": the skill names the two jobs and asks which one; nothing is written until answered.
3. Runtime has no "Create agent": description printed, card written with `pending-creation`, Owner told how to create it.
4. Owner says "no" to the draft: redraft, show again, nothing written.
