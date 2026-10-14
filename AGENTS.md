# AGENTS.md: the vault manual

Every agent on the team reads this file at the start of every conversation or routine, and again only if `git pull` changed it. If any note contradicts this file, this file wins. This file names roles, never people, paths or platforms: those live in `LOCAL.md`.

## 1. What this is

- The brain of the **Chief** (the owner's orchestrator and primary bot) and the shared memory of the whole team.
- Roles: **Owner** (the human), **Chief**, **Assistant** (briefs from the projects' todos), **Librarian** (indexes and hygiene), **Compiler** (writes `wiki/` with the Owner's yes). `LOCAL.md` says which agent holds each role. A role set to `none` is covered by the Chief.
- Stores context (projects, knowledge, who the Owner is) and the team's operation (agents, protocols, skills).
- The Owner reads it in Obsidian and edits little. The Owner talks to the Chief; if the Owner writes to another agent directly, that agent answers in its own chat.
- Repo and clone path: `LOCAL.md` (`repo`, `vault_path`).

## 2. Map

```text
AGENTS.md              this manual (framework-owned)
LOCAL.md               owner values and role assignments
START.md               bootstrap for a fresh clone; inert once LOCAL.md has a non-empty `initialized`
_master-index.md       entry point: one line per project and navigation
_log.md                vault events, append-only
user/                  who the Owner is
raw/                   immutable external sources
wiki/                  compiled knowledge, with its own _master-index.md and _log.md
projects/<slug>/       one folder per project or area, copied from projects/_template/
agents/                registry, _protocols/, _blocks/, _skills/, one folder per agent
adapters/              per-runtime instructions (read the one LOCAL.md names)
docs/                  sync and Obsidian guides
```

## 3. Walls

| Path | Who writes |
|---|---|
| `agents/**` | Chief only. The Librarian audits and flags, never edits |
| `wiki/**` | Compiler only, after the Owner's yes in chat. The Librarian audits and flags |
| `raw/` | Any agent creates new files. Nobody edits or deletes |
| `projects/<x>/meetings/`, `outputs/` | Agents whose Vault block lists that project create new files and edit only their own drafts. Chief: everything |
| `projects/<x>/README.md`, `context/`, `tools/`, `references/` | Chief. Agents propose |
| New project | Librarian, skill `second-brain-new-project`, on the Chief's request |
| `user/` | Owner. Chief only what the Owner said, with `source: Owner, chat YYYY-MM-DD` |
| `_master-index.md`, `_log.md` | Chief and Librarian (log is append-only) |
| `LOCAL.md` | Chief, only on the Owner's instruction |
| `git commit` and `push` | Chief, Librarian and Compiler only |

Walls are instructions: every bot shares disk and credentials. What is executable is protected because nothing changes an agent without the Chief applying it through the runtime (see `adapters/`).

### Ownership for upgrades

Framework-owned, replaceable wholesale by a future upgrade: `AGENTS.md`, `START.md`, `CLAUDE.md`, `README.md`, `LICENSE`, `scripts/`, `projects/_template/`, `agents/_blocks/`, `agents/_skills/`, `adapters/`, `docs/` (except `docs/specs/` the Owner adds). Everything else is the Owner's and is never touched by the framework.

## 4. Git (Chief, Librarian, Compiler)

- `git pull --ff-only` before reading or writing.
- `git add` concrete paths only. Never `git add -A` or `git add .`.
- Commit `<author>: <what>`, where `<author>` is the lowercase role (for example `chief: decisions from the meeting with X`). The `author` frontmatter field in files is the agent's name as registered in `agents/README.md`. Push immediately, unless `LOCAL.md` has `repo: none`.
- Never `--force`. On conflict, stop and tell the Owner; an agent that reports to the Chief tells the Chief, who tells the Owner.
- Other agents only run `git pull --ff-only`; they never commit or push.

## 5. Efficient reading

- Enter through `_master-index.md`. Open only what the task needs.
- Project: `README.md`, then `context/memory.md` (section State), then `todo.md` or `lessons.md` if relevant.
- External knowledge: `wiki/_master-index.md` and only the articles you need.
- Do not open `raw/`, full transcripts or old outputs unless the task asks. Grep before opening.
- Agents pass each other paths, not content: everyone shares the disk.
- Files are written to be read from the top: State first, newest first, transcript last.

## 6. Flows

1. **Ingest.** A source enters `raw/` as `YYYY-MM-DD-topic.<ext>`. An original (a PDF, for example) is stored as is, never converted or duplicated. Since it has no frontmatter, the agent gives the Chief the path, the source URL and the date, and the Chief puts them in the commit message. Text an agent wrote (deep research) goes in `.md` with frontmatter `author`, `source` (URL) and `date`. Only material with reference value goes to `raw/`.
2. **Compile.** The Compiler runs `second-brain-compile-plan`: plan in chat, the Owner says yes, and only then it writes the approved `wiki/` articles, runs `second-brain-refresh-index`, and commits. The Librarian only reports pending sources (files in `raw/` no wiki `Source` cites) in the audit.
3. **Query.** Follow section 5. Answer in chat. Save to `outputs/` only if the Owner asks.
4. **Meeting.** Transcript to `projects/<x>/meetings/YYYY-MM-DD-topic.md`. The Chief moves actions to `context/todo.md` and decisions to `context/memory.md`. A meeting touching two projects lives in the main one; the other links it from its `memory.md`. No project: `projects/operations/`.
5. **Output.** The agent creates `projects/<x>/outputs/YYYY-MM-DD-topic.md` with `status: draft`. Status advances in the frontmatter; the file never moves.
6. **Task close (Chief).** Decisions to `memory.md`, actions to `todo.md`, lessons to `lessons.md`, commit of the touched paths.
7. **Owner facts.** If the Owner tells the Chief something durable about themselves, the Chief saves it in `user/` with source and date and says so in one line.
8. **New project.** The Chief asks the Librarian. The skill copies `projects/_template/`, fills the README, adds the row to `_master-index.md` and the line to `_log.md`, and commits.
9. **New agent.** The Chief runs `second-brain-new-agent`: interview, registry card, description, apply through the adapter, `agents/CHANGELOG.md` line, commit.
10. **Todos.** `context/todo.md` is the source of truth. The Assistant builds the daily brief and the weekly report from every project's `todo.md`.
11. **Audit.** Section 9, on the cadence in `LOCAL.md`.

## 7. Projects

```text
projects/<slug>/
  README.md        card (max 30 lines)
  context/
    memory.md      ## State (max 20 lines, rewritten) and ## Decisions (newest first)
    todo.md        ## Open and ## Closed
    lessons.md     what worked and what did not, newest first
  meetings/        YYYY-MM-DD-topic.md
  outputs/         YYYY-MM-DD-topic.md
  tools/           one note per tool (empty if none)
  references/      tone, format, colors, best practices, briefs
```

- **README:** frontmatter `type: area | project` (an area never ends; a project has an end) and `status: active | paused | closed`. Body: one-line objective, agents, protocols, external links.
- **memory.md:** each decision is `- YYYY-MM-DD: decision. Why. Source: [[...]]`.
- **todo.md:** `- [ ] action | owner | due date | origin [[...]]`. When closed it moves to Closed as `- [x] action | owner | closed YYYY-MM-DD`.
- **lessons.md:** `- YYYY-MM-DD: lesson. Context. Applies to: [[agents/...]]`.
- **meetings:** frontmatter `date`, `attendees`, `transcript_source`, `author`. Sections: Summary, Decisions, Actions, Transcript (last).
- **outputs:** frontmatter `date`, `author`, `type: article | post | document | strategy | report`, `status: draft | approved | published`, `published_url`.
- **tools:** frontmatter `type: repo | cli | library | api`, `url`, `installed_at`, `version`, `used_by`. Code lives in its own repo.
- **references:** what a good output looks like. Papers and research do not go here: they go to `raw/` and the wiki article is linked.

## 8. raw/ and wiki/

- `raw/`: nobody edits or deletes. Name `YYYY-MM-DD-topic.<ext>`: the original when one exists, or `.md` with frontmatter when the text is the agent's. An original has no markdown copy; its source and date are in the commit message that added it.
- Articles in `wiki/<Domain>/<slug>.md`, flat domain folders.
- Frontmatter: `Writer`, `Link`, `Source` (paths in `raw/`, append-only) and `tags` (one domain tag and one topic tag).
- Body in dense bullets with wikilinks. Every claim cites its source. Inline dates for anything that expires.
- Contradictions get a callout `> [!warning] Superseded`. Nothing is overwritten.
- Every article ends with `## Key Takeaways` (3 to 7 bullets).
- `wiki/_log.md`: `## [YYYY-MM-DD] <op> | summary` with bullets `wrote:`, `updated:`, `flagged:`. File stems in backticks, not wikilinks.
- `user/` and `projects/` are cited but never raw material for the wiki.

## 9. Audit (Librarian routine)

The routine runs with no memory of its own: it starts by reading this file. The skill `second-brain-audit` covers step 3 only and therefore writes only its report and does not commit. Steps 1, 2, 4 and 5 belong to the routine.

1. `git pull --ff-only`.
2. `git status --porcelain`: commit files agents left unpushed, one commit per author (from the frontmatter), message `librarian: <file> (author <name>)`. A file with no author is not committed and is reported.
3. Skill `second-brain-audit` with these checks: broken wikilinks (outside code blocks); orphan wiki articles and pending sources in `raw/`; contradictions only between `wiki/` articles, quoting both sides, without opening `raw/`; projects against the template and missing frontmatter, excluding `projects/_template` itself; limits (project README 30 lines, State 20 lines, `memory.md`, `todo.md` or `lessons.md` over 200 lines, proposing an archive to `context/<file>-archive-YYYY.md`, this file 200 lines); drift between each agent's Vault block scope and the agents each project README lists; a sweep of every project's `lessons.md` for protocol and prompt improvements.
4. Refresh the projects table in `_master-index.md` from each project README's frontmatter, excluding `projects/_template`.
5. Report to `projects/operations/outputs/YYYY-MM-DD-audit-vault.md`, one line in `_log.md`, commit and push (no push if `repo: none`).
6. Fixes nothing silently, except the commit in step 2 and the table in step 4. The Chief reads the latest report in its next brief.

## 10. Writing rules

- Vault content in the language `LOCAL.md` sets. Headings, frontmatter keys and folder names stay in English. No em dashes. Short sentences.
- Wikilinks with the path from the root (for example `[[projects/brand/README]]`). Every new note links to its index or folder.
- Never store tokens, passwords, government ids, tax ids or full bank details.
- Logs are append-only.
- Owner-specific rules live in `agents/_protocols/README.md` under `## Owner rules`.

## 11. Conflicts

- This file wins over any note.
- Team rules: `agents/_protocols/README.md`. If an agent's description is stricter, the description wins. If it is more permissive, the global rules win and the Chief corrects the description.
