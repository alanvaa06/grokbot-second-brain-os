# Shared skills

Anthropic Agent Skills format: a folder with `SKILL.md` (frontmatter `name` and `description`, body with the procedure). Agents read them straight from this clone; the adapter says whether the runtime also needs them registered.

| Skill | Who runs it | What |
|---|---|---|
| `second-brain-init` | Chief, once | Bootstrap interview: repo, owner, runtime, projects, team, rules |
| `second-brain-new-agent` | Chief | Interview and registration of a new agent |
| `second-brain-new-project` | Librarian | New project folder from the template, index row, log line |
| `second-brain-compile-plan` | Compiler | Plan in chat, Owner's yes, write approved wiki articles |
| `second-brain-refresh-index` | Compiler | Rebuild the wiki index and append to the wiki log |
| `second-brain-audit` | Librarian | Report-only vault health check |

Writing a new skill: `references/skill-authoring.md`.
