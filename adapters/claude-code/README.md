# Adapter: claude-code

Claude Code (and, with the same files, Codex and Cursor) reads the vault and runs compile and audit with the Owner in the chat. It does not create or change agents.

| Row | How |
|---|---|
| Create agent | Not available. Use the runtime where the Chief lives, or `adapters/generic`. |
| Apply description | Not available here. Print the block and ask the Owner to append it to the agent's description in the runtime where that agent lives. Confirm before continuing. |
| Wake agent | Not available. The Chief tells the Owner what to ask which agent, with the paths to read. |
| Routines | None from Claude Code. Audit is `/audit` on demand. |
| Vault path | The repo folder Claude Code is opened in. Persists. |
| Git auth | The Owner's own `gh` and git credentials on their machine. |
| Skills | Read from the clone. `.claude/commands/compile.md` and `audit.md` wrap the two skills with this repo's parameters. |

## Setup

1. Open the vault folder in Claude Code. `CLAUDE.md` imports `AGENTS.md`.
2. `LOCAL.md` `compiler: claude-code` if the Owner compiles here. The Chief then never compiles.
3. Commands: `/compile [raw files or topic]` and `/audit`. `/compile` refuses unless `compiler: claude-code`, and commits as `compiler:` only when the Owner says so in the chat. `/audit` writes the report file and nothing else.

## Codex and Cursor

Point the instructions file at `AGENTS.md` (Codex reads `AGENTS.md` natively; for Cursor add a rule that says "read AGENTS.md first"). Copy the two command files into the equivalent commands folder if the runtime has one; otherwise paste their text as the prompt.
