---
owner:
language:
timezone:
runtime:
vault_path:
repo:
chief:
assistant:
librarian:
compiler: chief
audit_cadence: every 3 days
initialized:
---

# LOCAL.md: this vault's values

Filled by `second-brain-init`. Edited afterwards only by the Chief on the Owner's instruction. `AGENTS.md` names roles; this file says who holds each one.

- `owner`: the human's name.
- `language`: language of the vault content (`en`, `es`, ...). Framework files stay in English.
- `timezone`: IANA name, for example `Europe/Lisbon`.
- `runtime`: `grok-bot`, `claude-code` or `generic`. Agents read `adapters/<runtime>/README.md`.
- `vault_path`: absolute path of the clone on the machine where the Chief runs.
- `repo`: git remote URL, or `none` until the Owner authenticates.
- `chief`, `assistant`, `librarian`: agent names, or `none` (the Chief covers that role).
- `compiler`: `chief`, `claude-code`, or an agent name. Whoever it is, compile needs the Owner's yes in chat.
- `audit_cadence`: `every N days` or `manual`.
- `initialized`: `YYYY-MM-DD`. Non-empty means `START.md` is inert; the template ships it empty.

## Platform notes

(One paragraph max, written by init from what the Owner said. Empty is fine.)
