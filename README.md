<p align="center"><strong>English</strong> · <a href="README.es.md">Español</a></p>

<p align="center">
  <img src="docs/assets/grok-bot-banner.png" alt="Grok Bot" width="430">
</p>

<h1 align="center">grokbot-second-brain-os</h1>

<p align="center">
  <strong>The operating system for your team of bots.</strong><br>
  One chief of staff, specialist bots, and a shared brain in plain markdown that you own. The chief installs it. You read it in Obsidian.
</p>

<p align="center">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-22c55e.svg"></a>
  <img alt="Built for Grok Bot" src="https://img.shields.io/badge/built%20for-Grok%20Bot-3b82f6.svg">
  <img alt="Markdown only" src="https://img.shields.io/badge/stack-markdown%20%2B%20git-f59e0b.svg">
  <img alt="Obsidian ready" src="https://img.shields.io/badge/UI-Obsidian-7c3aed.svg">
  <a href="docs/acceptance.md"><img alt="Status: beta" src="https://img.shields.io/badge/status-beta-ec4899.svg"></a>
  <img alt="PRs welcome" src="https://img.shields.io/badge/PRs-welcome-14b8a6.svg">
</p>

---

## 🚀 Quick start

Paste this to your chief-of-staff bot:

```text
Set up my second brain from https://github.com/alanvaa06/grokbot-second-brain-os
```

That is the whole install. The chief clones this repo, creates a **private repo on your GitHub** from it, and interviews you one question at a time: your name, language and timezone; your projects; the agents you already have; the rules every agent must never break. It registers everything, creates an assistant and a librarian if you want them, and commits. You never touch GitHub.

> **What the chief's machine needs:** `git`, the `gh` CLI, and `gh` logged into your GitHub account. Not logged in yet? The chief works locally and asks for it once at the end.

## 🔗 Connect GitHub (git + gh)

Your chief needs two free tools on its machine to create your private repo. If you do not code, ask the chief to do these steps for you, or follow them once:

1. Create a free account at [github.com](https://github.com) if you do not have one.
2. Install `git` ([git-scm.com](https://git-scm.com/downloads)) and the GitHub CLI `gh` ([cli.github.com](https://cli.github.com)).
3. Run `gh auth login`, choose GitHub.com and HTTPS, and sign in with your browser.
4. Check it worked with `gh auth status`.

Never paste a password or token into a chat or a file in the vault.

## 🧠 What it is

Not another memory plugin for one coding agent. This is how a **team** of bots works together: a chief of staff that orchestrates, specialists that do the work, an assistant that briefs you, a librarian that keeps the place clean. All of them read the same manual and write to the same folders, so what one bot learns the next one finds.

The shared brain, on disk, in your repo:

| Folder | What lives there |
|---|---|
| 👤 `user/` | Who you are: the facts you tell your chief, with the date you said them |
| 📁 `projects/` | One folder per project or area: state, decisions, open tasks, lessons, meetings, outputs |
| 📥 `raw/` | Sources you drop in: papers, transcripts, research. Never edited, never deleted |
| 📚 `wiki/` | Knowledge compiled from `raw/`, only with your yes, every claim cited. Bots read it on demand, by its index |
| 🤖 `agents/` | Who each bot is, what it may and may not do, and the skills they share |

`raw/` and `wiki/` follow [Andrej Karpathy's LLM wiki pattern](https://x.com/karpathy/status/2039805659525644595): immutable sources go in, an LLM compiles them into a linked wiki with an index and a log, and nothing gets retrieved by vector search. Here the compile step needs your yes, the wiki has its own `_master-index.md`, and any bot on the team can consult it on demand: open the index, read only the articles the task needs, cite them. No bot loads the whole wiki into context.

One file, **`AGENTS.md`**, is the manual every bot reads before working. It says who writes where (the walls), how to read without wasting tokens, and what never happens: no invented sources, no secrets on disk, no email sent without your yes.

## ✨ Why run your bots as a team

- **One front door.** You talk to the chief. The chief delegates, collects what comes back, and answers you. You stop routing tasks between bots by hand.
- **The whole team shares one brain.** The chief passes paths, not pasted text. An agent that writes a meeting summary puts it where the next agent will find it.
- **Context survives.** Decisions, tasks and lessons live in files, not in a chat that scrolls away. Every bot picks up tomorrow where the team left off today.
- **Every bot has one job and clear limits.** Each agent is registered with what it does, what it never does, and which folders it may write. New agents are added through an interview that enforces that.
- **You stay in control.** It is your repo, on your GitHub, readable in Obsidian. Nothing is compiled into the wiki, no agent is created, no message is sent without your yes in the chat.
- **It stays clean.** A librarian role audits the vault on a schedule: broken links, orphan notes, sources nobody compiled, files over their limits. It reports; it never fixes things behind your back.
- **It grows with you.** Add projects and agents through the chief. Every new agent gets a short Vault block that tells it how to use the brain.

## 👥 The default team

Three roles, each a block of text added to a bot **you name yourself**. No characters, no personas shipped.

| Role | Job | Writes |
|---|---|---|
| 🎩 **Chief** | Orchestrates the team, closes tasks into the vault, applies agent changes | `agents/`, `projects/`, `user/`, git |
| 📋 **Assistant** | Daily brief and weekly report built from every project's open tasks | Nothing; reports to the chief |
| 🗂️ **Librarian** | Indexes and hygiene, audit every few days, new project folders | Indexes, logs, audit reports |

Add domain agents (research, writing, finance, whatever you need) with the `second-brain-new-agent` skill: one job, one voice, explicit anti-jobs, and the Vault block.

## 💜 Use Obsidian, keep the control

The best way to live with this brain is a local clone opened in Obsidian:

1. Clone your new vault repo to your computer and open the folder as a vault.
2. Install the **Obsidian Git** plugin with auto pull. Your bots push after every change, so you always see the latest.
3. Start at `_master-index.md`. Every note links from there.
4. Edit what is yours (`user/`, your project notes) and commit. Leave `raw/`, `wiki/` and `agents/` to the bots.

That is the point: **the brain of your bots is a folder you own**, you can read, and you can edit. Not a hidden memory inside a vendor. Details in [`docs/obsidian.md`](docs/obsidian.md) and [`docs/sync.md`](docs/sync.md).

## 🔌 Runtimes

| Runtime | Adapter | What it does |
|---|---|---|
| **Grok Bot** | [`adapters/grok-bot/`](adapters/grok-bot/README.md) | Full: creates agents, applies descriptions, schedules routines |
| Claude Code, Codex, Cursor | [`adapters/claude-code/`](adapters/claude-code/README.md) | Reads the vault, `/compile` and `/audit`; no agent creation |
| Anything with a shell and git | [`adapters/generic/`](adapters/generic/README.md) | Manual: prints descriptions, you paste them |

## 🧩 How it is built

- **Markdown plus git is the whole product.** "Install" means clone plus interview. No server, no database, no binary.
- **Framework and your content are separated by folder**, so a future upgrade can replace the framework without touching your vault. The ownership table is in `AGENTS.md`.
- **Walls are instructions, not enforcement.** Agents share disk and credentials; the manual says who writes where, and the audit catches drift.
- **Nothing is invented.** No source, number, date or person without a citation. What could not be verified is marked unverified.
- **Skills follow the Agent Skills format**: a folder with a `SKILL.md`, read straight from the clone. Six ship with the repo: `init`, `new-agent`, `new-project`, `compile-plan`, `refresh-index`, `audit`.

```text
AGENTS.md        the manual every agent reads first
LOCAL.md         your values: name, language, timezone, runtime, who holds each role
user/  raw/  wiki/  projects/
agents/          registry, rules, role blocks, skills
adapters/        grok-bot, claude-code, generic
docs/            sync, Obsidian, acceptance test, design spec
```

## 🛠️ Contributing

Issues and pull requests welcome, especially reports from a real first run: every point where your chief had to guess is a bug in the framework.

Run `bash scripts/dev-check.sh` before a pull request. It rejects private identifiers, platform paths outside adapters, oversize manual or blocks, unknown placeholders and em dashes. Release gate in [`docs/acceptance.md`](docs/acceptance.md).

## 📄 License

[MIT](LICENSE). Use it, fork it, build your own team on it.

The Grok Bot name and logo belong to their owner; this is an independent project built for that platform first, not an official product.
