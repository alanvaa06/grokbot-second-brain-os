---
description: Compile pending raw/ sources into wiki/ with the second-brain-compile-plan skill. Plan in chat, the Owner's yes, and only then write.
argument-hint: "[raw/ files or a topic; empty = everything pending]"
---

# /compile

This command does not define the compile. It runs the vault's skills with this repo's parameters. If this file and a skill differ, the skill wins. If the skill and `AGENTS.md` differ, `AGENTS.md` wins.

## Before starting

1. `git pull --ff-only`. If it fails, stop and say so.
2. Read `LOCAL.md` for `language`, `owner` and `compiler`. If `compiler` is not `claude-code`, stop and say: "The Compiler for this vault is `<value>`; set `compiler: claude-code` in LOCAL.md if you want to compile here." `wiki/` is Compiler-only (manual, section Walls).
3. Read `agents/_skills/second-brain-compile-plan/SKILL.md` in full and follow it.

## Parameters

- `vault`: the root of this repo.
- `approver`: the Owner, directly in this chat.
- `manual`: `AGENTS.md`.
- `scope`: `$ARGUMENTS`. If empty, every `raw/` source that no wiki `Source` cites.
- `language`: `language` from `LOCAL.md`.
- `exclusions`: none unless the Owner states them in the chat.

## Phase 1: plan

- Follow phase 1 of the skill. The plan goes in the chat with the skill's template. It is not saved as a file.
- `raw/` sources may be original PDFs. Read them with the Read tool (`pages` parameter past 10 pages). If reading fails for a missing renderer, extract text with `pdftotext -layout -enc UTF-8` into the session's temporary folder, never inside the repo. Do not convert or write anything in `raw/`.
- An original has no frontmatter. Its source and date are in the commit message that added it: `git log --diff-filter=A --format=%s -- <path>`. That gives the article's `Link`.
- If nothing is pending, say so in one line and stop.

## Phase 2: write

- Only after the Owner's explicit yes in this chat. Silence is not approval.
- Follow phase 2 of the skill, then hand off to `agents/_skills/second-brain-refresh-index/SKILL.md` with the approved plan.
- Commit only when the Owner says so: `git add` of the written articles, `wiki/_master-index.md` and `wiki/_log.md`; message `compiler: compile <topic>` (the Compiler role, per the manual's author convention); push unless `LOCAL.md` has `repo: none`.
