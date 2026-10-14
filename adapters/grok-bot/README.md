# Adapter: grok-bot

Grok Bot gives the Chief platform tools to create and change agents, send work to them and schedule routines. The box has a persistent `/workspace`.

| Row | How |
|---|---|
| Create agent | `CreateAgent` with the name and the confirmed description. Record the returned id in the card's `id` field. If the Chief lacks `CreateAgent` (the Owner may reserve it for a bot-smith agent as an owner rule), print the description and ask that agent or the Owner to create it. |
| Apply description | `UpdateAgent` on the target id with the full new description (existing text plus the appended block). For the Chief itself, same call on its own id; the Chief reads its own id and current description from its profile (the agent settings the Owner can open), or asks the Owner to paste them. Keep the previous text in the card under "Previous descriptions" before applying. |
| Wake agent | `SendToAgent` with the agent id and a message that carries paths, not content. |
| Routines | Yes. The Chief creates the audit routine at the cadence in `LOCAL.md` (default every 3 days at 02:00 in the Owner's timezone) for the Librarian, or for itself if `librarian` is `none` or the card is `pending-creation`. Prompt: "Follow the Audit section of AGENTS.md in <vault_path>." with `vault_path` from `LOCAL.md`. If an assistant exists, two more routines for it: daily brief on weekdays at the time the Owner chose (default 08:00) and weekly report on Mondays, prompt "Follow your Vault block and AGENTS.md in <vault_path>: build the <daily brief or weekly report> and send it to the Chief." Routines run with no memory: the prompt must point at the manual. |
| Vault path | `/workspace/<vault_name>`. Persists between sessions. |
| Git auth | In the box shell: `gh auth login` (device flow) with the `repo` scope. Set `git config user.name` and `user.email` to the Chief's name and a no-reply address so commits carry the author the manual expects. |
| Skills | Read from the clone. If the runtime also needs them registered, `UpdateSkill` with the SKILL.md content; keep the clone as the source of truth and reapply after a pull changes a skill. |

## Sync with Obsidian on the Owner's machine

- The box clone is `/workspace/<vault_name>`; the Owner's clone is wherever they put it, opened as an Obsidian vault (`docs/obsidian.md`).
- Agents pull before every task and push right after every commit, so the Owner's `git pull` is always fast-forward.
- The Owner edits `user/` and `projects/` rarely and commits from Obsidian Git or the command line; nothing on the box edits those files between the Owner's pull and push except the Chief closing a task, which is rare on the same file. On a conflict the agent stops and tells the Owner (manual, section Git).
- Full scenarios: `docs/sync.md`.

## Limits worth knowing

- Description length: Grok Bot descriptions are long text; appending a block under 1,200 characters to a typical description has not hit a limit in practice. If `UpdateAgent` rejects the length, trim the persona, never the block.
- A routine has no memory of the chat: everything it needs is in the manual and `LOCAL.md`.
