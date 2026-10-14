---
description: Report-only health check of this vault with the second-brain-audit skill. Writes the report where AGENTS.md says and nothing else.
---

# /audit

1. `git pull --ff-only`. If it fails, stop and say so.
2. Read `LOCAL.md` for `language`.
3. Read `agents/_skills/second-brain-audit/SKILL.md` in full and follow it with: `vault` = this repo's root, `report_to` = the Owner in this chat, `manual` = `AGENTS.md`, `language` = `language` from `LOCAL.md`.
4. Write the report to `projects/operations/outputs/YYYY-MM-DD-audit-vault.md` (the manual's audit section, step 5). This command runs only step 3 of that section: it does not commit unpushed files, refresh the projects table, or append to `_log.md`; those belong to the Chief or the Librarian.
5. Fix nothing. Do not commit. Tell the Owner the report path and that the Chief or the Librarian logs and commits it, or that they can commit it themselves with the message `owner: audit YYYY-MM-DD`.
