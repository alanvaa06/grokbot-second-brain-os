# Sync: git is the only mechanism

There is no other sync. Every clone of the vault is a full copy; git moves changes between them.

## Rules that keep it safe (all in AGENTS.md, section Git)

- `git pull --ff-only` before reading or writing. If it refuses, this clone and the remote have diverged: stop and tell the Owner. Agents never resolve a divergence.
- `git add` concrete paths only. Never `-A` or `.`.
- Commit `<author>: <what>`. Push immediately after every commit.
- Never `--force`. On a conflict, stop and tell the Owner.

Conflicts need two edits to the same file without a pull in between. By design that is rare: humans edit `user/` and `projects/` seldom; agents never edit `raw/` or `wiki/` on their own; logs are append-only.

## Scenario 1: one machine

The Owner and a local agent (Claude Code, for example) share one clone. Obsidian opens it. A remote is optional but recommended as backup; `second-brain-init` offers to create it.

## Scenario 2: one box plus the Owner's machine (the common case)

- The Chief's box has the clone (for Grok Bot: `adapters/grok-bot/README.md` says where). Agents pull before every task and push after every commit.
- The Owner's machine has a second clone opened in Obsidian with the Obsidian Git plugin pulling on an interval (`docs/obsidian.md`).
- The Owner's edits: commit and push from Obsidian Git or a terminal. Keep them small and push soon after.

## Scenario 3: several boxes

Same as scenario 2 with more agents. Only the Chief, the Librarian and the Compiler have git; every other agent writes files and the Chief commits them. Two git-capable agents never run at the same minute on purpose: routines are scheduled apart (audit at 02:00, briefs in the morning).

## Recovering from a refused pull

1. `git status --porcelain`: list what is uncommitted on this clone. Uncommitted files alone do not block a fast-forward pull unless the pull would overwrite them; commit them by author (frontmatter `author`) as the audit routine does, then pull again.
2. If the pull still refuses, the clone has local commits the remote does not have. Only the Owner resolves that, by hand (`git pull --rebase` or a merge), never an agent.

## Adding a remote later

If init ended with `repo: none`, run this from the vault folder once `gh auth login` is done (the Owner or the Chief):

```bash
gh repo create <vault_name> --private --source=. --push
```

Then write the remote URL in `LOCAL.md` (`repo`), commit `chief: remote added` and push. Init does not run again; this is the only step it leaves open.

## What never syncs

Local Obsidian state (`.obsidian/workspace*`, caches, plugin data) is in `.gitignore`. Secrets are in `.gitignore` and must never be in the vault at all.
