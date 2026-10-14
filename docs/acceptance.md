# Acceptance test (manual)

Run before publishing a release. Needs a fresh Grok Bot bot with `gh` auth on the box, and a second machine or folder with Claude Code.

## Grok Bot, fresh owner

- [ ] 1. Paste the template URL to the bot: "set up my second brain from this repo". The bot clones, reads `START.md`, follows `second-brain-init`.
- [ ] 2. A private repo named as the owner chose exists on the owner's GitHub account, created from the template, cloned under the box workspace.
- [ ] 3. After the interview: `LOCAL.md` has `initialized`; `user/README.md` has name, language and timezone; at least one project folder plus `operations` match `projects/_template/`; `agents/README.md` lists the chief; the chief's own description ends with the chief block; `_master-index.md` lists every project; `_log.md` has the init line; one commit is pushed.
- [ ] 4. Run the librarian's audit (or `/audit` in Claude Code on a clone): zero broken wikilinks, zero missing frontmatter.
- [ ] 5. Paste the URL again to the same chief: it answers "already initialized" and writes nothing (`git status --porcelain` empty).

## No auth path

- [ ] 6. Repeat step 1 on a box without `gh auth`: local clone, interview completes, auth asked once at the end, `repo: none` on refusal, one local commit.

## Claude Code

- [ ] 7. Clone the owner's repo, set `compiler: claude-code` in `LOCAL.md`, open it in Claude Code, put one `.md` with frontmatter `author`, `source`, `date` in `raw/`, run `/compile`: a plan appears in chat; after "yes", one article exists under `wiki/<Domain>/` citing the raw file in `Source`, `wiki/_master-index.md` lists it, `wiki/_log.md` grew by one entry.
- [ ] 8. `bash scripts/dev-check.sh` on the template repo passes.

