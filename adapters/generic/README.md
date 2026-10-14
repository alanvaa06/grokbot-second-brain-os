# Adapter: generic

Any agent with a shell and git. Nothing is automated: every platform action is "print the text and ask the Owner to do it".

| Row | How |
|---|---|
| Create agent | Not available. Print the full description and ask the Owner to create the agent in their platform and paste back its name or id. Mark the card `pending-creation` until then. |
| Apply description | Not available. Print the block and ask the Owner to append it to the agent's description (their own, for the Chief). Confirm before continuing. |
| Wake agent | Not available. The Chief tells the Owner what to ask which agent, with the paths to read. |
| Routines | None. `audit_cadence: manual`. The Chief reminds the Owner to run the audit when it notices the last report is older than the cadence they wanted. |
| Vault path | The `workspace` input of init, which the Owner confirms persists between sessions. If it does not persist, warn the Owner that refusing a remote in init step 6 means the vault is lost when the session ends. |
| Git auth | `gh auth login` in the same shell the agent uses. Needs the `repo` scope. Set `git config user.name` and `user.email` once (the Chief's name and a no-reply address) or the first commit fails. |
| Skills | Read from `agents/_skills/<name>/SKILL.md` in the clone. |

Runtimes that read an instructions file (Codex, Cursor, others): point it at `AGENTS.md`, or copy `.claude/commands/` into the equivalent commands folder.
