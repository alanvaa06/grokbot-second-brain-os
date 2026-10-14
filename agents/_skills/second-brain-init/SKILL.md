---
name: second-brain-init
description: >-
  Bootstraps a second-brain style vault for an owner from this template: creates
  the owner's private repo with gh (or clones locally without auth), then
  interviews the owner one question at a time (owner, runtime, projects, team,
  hard rules), registers everything, applies the chief, assistant and
  librarian role blocks through the runtime adapter, builds the indexes and
  commits. Triggers when an agent is given this repo and START.md sends it
  here, or when the owner asks to set up their second brain. Runs once per
  vault; refuses if LOCAL.md already has an initialized date. Not for adding a
  project (second-brain-new-project) or an agent (second-brain-new-agent)
  later.
---
Run by the agent that will be the Chief. One question per message. Output is files, not a report. Runtime-specific actions are delegated to `adapters/<runtime>/README.md`, read from the bootstrap copy of this template (the clone `START.md` told you to make, in a temporary folder) until the vault exists.

## Inputs
- `upstream` (required): the URL of this template repo, as the owner pasted it.
- `language` (optional, default: the language the owner is writing in).

## Procedure
Copy this checklist:
```
- [ ] 0. Runtime and workspace known, adapter read
- [ ] 1. Git: repo created or cloned, remote state known
- [ ] 2. Owner: user/README.md and LOCAL.md started
- [ ] 3. Projects registered (operations always)
- [ ] 4. Team: existing agents registered, roles assigned, blocks applied
- [ ] 5. Owner rules appended
- [ ] 6. Index built, log line, initialized date, commit, push, next steps
```

### Step 0: runtime and workspace
1. Ask which runtime you run on: `grok-bot`, `claude-code` or `generic`. Describe each in one line from the first paragraph of `adapters/<name>/README.md` in the bootstrap copy.
2. Read `adapters/<runtime>/README.md` in full. Its "Vault path" row gives `<workspace>`, the persistent folder where the vault will live. If the row says to ask, ask the owner once and confirm the folder persists between sessions.
3. Its "Git auth" row says how `gh` and the git identity are set up on this runtime. Make sure `git config user.name` and `user.email` are set before step 1; if not, set them to the Chief's name and a no-reply address.

### Step 1: git
1. Run `gh --version` and `git --version`. If either is missing, stop and tell the owner what to install. A vault without git is not a vault.
2. Ask the owner the vault name (default `second-brain`). Call it `<vault_name>`.
   - If `<workspace>/<vault_name>/LOCAL.md` exists with a non-empty `initialized`, stop: "This vault is already initialized. Use second-brain-new-project or second-brain-new-agent." Nothing is created or cloned.
   - If the folder exists without that, ask the owner whether to use it as is or pick another name. Never delete it.
3. Run `gh auth status`.
   - Authenticated: `gh repo create <vault_name> --template <upstream> --private --clone` inside `<workspace>`. If it fails with a scope error, show the exact line and ask the owner to run `gh auth refresh -s repo`, then retry once. If it fails because `<upstream>` is not a template repo, fall back to the unauthenticated path below and tell the owner. If the clone comes back empty (GitHub still generating), wait ten seconds and `git pull` once.
   - Not authenticated: `git clone <upstream> <vault_name>` inside `<workspace>`, then `git remote remove origin`. Continue; a remote can be added in step 6.
4. `cd <workspace>/<vault_name>`. From here on every path is relative to this folder, and the bootstrap copy is no longer used.
5. Never `--force`, never `git add -A`.

### Step 2: owner
Ask, one per message: name; language for the vault content (`en`, `es`, ...); timezone (IANA name; no default, ask again if unclear). Write `user/README.md` (fill Name, Language, Timezone; these are the owner's own answers and carry no source line; leave the rest for the owner) and `LOCAL.md` (`owner`, `language`, `timezone`, `runtime`, `vault_path` = this folder's absolute path, `repo` = `git remote get-url origin`, or `none`). Copy any platform note the owner gives into the "Platform notes" section, one paragraph max. Headings, frontmatter keys and folder names stay in English whatever the content language.

### Step 3: projects
Ask: "Which projects and areas do you have today? For each: name, whether it is an area (never ends) or a project (has an end), and its objective in one line." Accept the list in one message, then confirm each line back. For each, run `second-brain-new-project` with `vault`, `slug` (kebab-case of the name), `name`, `type`, `objective`, `requested_by` = owner, and skip its steps 6 and 7 (log line and commit): init writes one log line and commits once in step 6. Always create `operations` (type `area`, objective "audit reports, meetings and outputs with no project"); `AGENTS.md` hard-codes that slug. If the owner has no projects, create only `operations`. Project READMEs get their Agents line in step 4.6.

### Step 4: team
1. Ask: "Which agents do you already have? For each: name, what it does, who it reports to." Register each in `agents/<slug>/README.md` (slug = kebab-case of the name) with the card format in `agents/README.md`; description: what the owner said, marked "as described by the owner, YYYY-MM-DD"; `Status: active`.
2. You are the Chief. Register yourself the same way, with your current description verbatim. Your id and current description come from the adapter's "Apply description" row (it says how to read your own); if it cannot, ask the owner to paste them from the bot's settings. Write `chief` in `LOCAL.md`.
3. Set `compiler` in `LOCAL.md` now: default `chief`; `claude-code` if the owner says they will compile from Claude Code. Blocks are filled after this, so `{{compiler}}` is never stale.
4. For `assistant` and then `librarian`, ask: "Do you already have an agent that does this (name), should I create one, or skip?" Give the one-line job from `agents/_blocks/README.md`.
   - Existing: fill the role block from `LOCAL.md` and append it to that agent's description via "Apply description". Update its card. Add a line to `agents/CHANGELOG.md`: `- YYYY-MM-DD | <slug> | <role> block appended at init | applied by <chief>`.
   - Create: ask the owner for a lane name (not a real person). Description = one line of persona ("<Name>. <Role> of <owner>'s team. Reports to <chief>.") plus the filled block. Create via "Create agent". If unavailable, print and ask the owner to create it now; when the owner confirms, `Status: active`, otherwise `Status: pending-creation` until they do. Write the card and a CHANGELOG line: `- YYYY-MM-DD | <slug> | created as <role> at init | applied by <chief>`.
   - Skip: write `none` in `LOCAL.md`; the manual's flows fall back to the Chief. No block is applied to anyone for that role.
5. Fill `agents/_blocks/chief.md` from `LOCAL.md` (a role set to `none` is filled with the Chief's own name) and apply it once to yourself with "Apply description": append, never replace. If the adapter has no self-update, print the block and ask the owner to paste it, then confirm. CHANGELOG line: `- YYYY-MM-DD | <chief slug> | chief block appended at init | applied by <chief>`.
6. Write the Team table in `agents/README.md`: one row per registered agent (`| chief | [[agents/<slug>/README\|<Name>]] | Owner | active |`, `| assistant | ... | Chief | active |`, `| librarian | ... | Chief | active |`, `| domain: <what> | ... | Chief | active |`; `pending-creation` where the Owner still has to create the agent). Then ask the owner which existing agents serve which projects and fill each project README's Agents line accordingly; leave it as the template placeholder if none.

### Step 5: owner rules
Ask: "Any rule every agent must never break? Examples: never send email without my yes, never execute real trades, never post to my accounts, never store credentials." Replace the parenthetical under `## Owner rules` in `agents/_protocols/README.md` with the rules as numbered items from 11. If none, write "(none yet)".

### Step 6: close
1. The wiki is empty, so do not run `second-brain-refresh-index`. Rebuild the projects table in `_master-index.md` from each `projects/<slug>/README.md` frontmatter, excluding `projects/_template`, one row per project in alphabetical order, in the format `second-brain-new-project` uses (`| [[projects/<slug>/README\|<slug>]] | <type> | active | <objective> |`). Check that every wikilink in `_master-index.md` and `agents/README.md` resolves to a file.
2. Append to `_log.md`: `- YYYY-MM-DD | chief | vault initialized for <owner>, projects: <slugs> [[LOCAL]]`.
3. Write `initialized: YYYY-MM-DD` and `audit_cadence` (default `every 3 days`; `manual` if the adapter has no routines) in `LOCAL.md`.
4. `git add` the concrete paths: `LOCAL.md user _master-index.md _log.md projects agents`. Commit `chief: initial vault`.
5. Remote: if there is one, `git push -u origin main`. If `repo` is `none`, ask once: "Do you want to authenticate GitHub now so the vault has a remote?" Yes: wait for `gh auth login`, then `gh repo create <vault_name> --private --source=. --push`, write `repo` in `LOCAL.md`, commit `chief: remote added`, push. No: tell the owner the vault lives only on this machine until they follow "Adding a remote later" in `docs/sync.md`.
6. If the adapter has routines ("Routines" row), create them per that row: the audit routine on the cadence in `LOCAL.md`, and the Assistant's daily brief and weekly report if an assistant exists. Ask the owner for the brief time (default 08:00 on weekdays, owner's timezone).
7. Print next steps: open `<vault_path>` in Obsidian (`docs/obsidian.md`); drop a first source into `raw/` and ask the Compiler to compile; read `docs/sync.md` if the owner edits on another machine.

## Hard don'ts
- Never skip a question or answer it for the owner. Defaults are only: vault name `second-brain`, language = the owner's chat language, compiler `chief`, cadence `every 3 days`, brief time 08:00 weekdays.
- Never replace an existing description: blocks are appended.
- Never create an agent the owner did not confirm by name.
- Never write outside the vault folder created in step 1; the bootstrap copy is read-only.
- Never run twice on an initialized vault.

## Evaluation scenarios
1. Authenticated owner on grok-bot, two projects, no existing agents, creates assistant and librarian: a private repo exists on their account, the clone has `LOCAL.md` with `initialized`, three cards in `agents/`, three project folders (two plus `operations`), a populated `_master-index.md` without a `_template` row, exactly one `_log.md` line, one pushed commit, three CHANGELOG lines, and the chief's own description ends with the chief block.
2. No gh auth on `generic`: local clone without remote, interview completes, auth asked once at the end, `repo: none` written on refusal, one local commit, every create and apply step printed for the owner.
3. Second run on the same vault: stops at step 1.2 with the "already initialized" message, nothing created or cloned.
4. Runtime `claude-code` as the Chief: agent creation prints and asks; the owner creates the agents elsewhere or skips them; blocks for existing agents are printed for the owner to paste.
