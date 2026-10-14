# Role blocks

A block is a paragraph appended to an agent's existing description. It never replaces the agent's persona. `second-brain-init` and `second-brain-new-agent` fill the placeholders from `LOCAL.md` and apply the result through the adapter.

| Block | Appended to | What it adds |
|---|---|---|
| `chief.md` | the orchestrator | the vault as its brain, git, closing tasks, owning `agents/` |
| `assistant.md` | the assistant | daily brief and weekly report from the projects' todos |
| `librarian.md` | the librarian | indexes, hygiene, audit on a cadence |

Placeholders: `{{owner}}`, `{{chief}}`, `{{vault_path}}`, `{{lang}}`, `{{assistant}}`, `{{librarian}}`, `{{compiler}}`. `{{lang}}` is the `language` field of `LOCAL.md`; the remote URL is in no block (it lives in `LOCAL.md` and may change). Keep each block under 1,200 characters so it fits next to an existing description. A role set to `none` in `LOCAL.md` gets no block: the chief block already says such roles are the chief's, and the manual's flows fall back to the Chief.
