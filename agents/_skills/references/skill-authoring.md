# Writing a skill for this vault

Rules distilled from Anthropic's Agent Skills documentation (overview, best practices, and the engineering post "Equipping agents for the real world with Agent Skills"). Read before writing or reviewing a skill. `second-brain-new-agent` applies the same discipline to agent descriptions.

## Structure

1. A folder named like the skill, with `SKILL.md` required. Optional: `scripts/`, `references/`, `assets/`.
2. YAML frontmatter with `name` and `description`. Body in markdown with actionable instructions.

## name

- Max 64 characters. Lowercase letters, numbers and hyphens only. No XML tags. No reserved words (`anthropic`, `claude`).

## description

- Not empty. Max 1,024 characters. No XML.
- Says WHAT the skill does and WHEN to use it, with concrete triggers, and what it is NOT for (name the sibling skill). It is the discovery field: the agent decides from it whether to load the body.

## Body

- Progressive disclosure: at startup only `name` and `description` load; the body loads on activation. Keep the body under 500 lines. Long detail goes to `references/` with a table of contents when it passes about 100 lines. No deeply nested references.
- Inputs section first: required and optional, with defaults. If a required input is missing, ask once and stop.
- A copyable checklist, then numbered steps that match it one to one.
- Concrete examples. When to use and when not. Anti-patterns. A verification step before reporting. Scripts for deterministic work, marked "run" versus "read as reference".
- Hard don'ts as a short list. Evaluation scenarios at the end: three or four input-to-outcome pairs a reviewer can replay.
- Consistent terminology with `AGENTS.md`: Owner, Chief, Assistant, Librarian, Compiler, vault, manual.

## Vault conventions

- English. Output language is an input (`language`), default the language of the request.
- Never name a platform, a person or a path: take `vault`, `manual` and names from inputs or `LOCAL.md`.
- Skills that write say exactly which paths they may touch. Skills that audit write nothing but their report.
- Git only if the manual assigns it to the caller. Never `git add -A`, never `--force`.

## Review checklist

- [ ] name and description within limits, description has triggers and a "not for"
- [ ] inputs with defaults; missing required input stops after one question
- [ ] checklist and steps match
- [ ] writes only the paths it declares
- [ ] verification step before reporting
- [ ] evaluation scenarios present
- [ ] no platform, person or path hard-coded
