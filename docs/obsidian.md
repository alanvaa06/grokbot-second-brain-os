# Obsidian: the vault's UI

1. Install Obsidian. "Open folder as vault" on your clone of the vault.
2. Start at `_master-index.md`. Wikilinks use paths from the vault root (`[[projects/brand/README]]`), so set **Settings > Files and links > New link format** to "Absolute path in vault" and keep "Use `[[Wikilinks]]`" on.
3. Install the community plugin **Obsidian Git**. Recommended settings:
   - Auto pull interval: 5 minutes.
   - Auto commit and push: off. Commit yourself after you edit, with a message like `owner: <what>`.
   - Pull before push: on.
4. `.gitignore` excludes everything under `.obsidian/` except `appearance.json` and `core-plugins.json`. Commit those two once from your machine so the vault looks the same everywhere; everything else in `.obsidian/` stays local.
5. Read-only by habit: edit `user/` and `projects/` when you want; leave `raw/`, `wiki/` and `agents/` to the agents. If you change `AGENTS.md` or `LOCAL.md`, tell the Chief so it re-reads them.

## Useful views

- Graph view filtered to `path:projects` shows how projects, agents and wiki articles connect.
- A "Dataview" query is not required; `_master-index.md` is the navigation.
