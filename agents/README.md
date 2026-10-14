# agents/

Registry of the team: who exists, their current description, how they collaborate and which skills they use. Only the Chief edits this folder and applies changes to the agents through the runtime (`adapters/<runtime>/README.md`).

## Change protocol

1. A change is proposed: the Owner asks the Chief, or an agent proposes it to the Chief.
2. The Chief edits `agents/<agent>/README.md` (block "Current description"), the protocol, the global rules or the skill.
3. Commit, one change per commit, saying which agent and what changed (for example `chief: assistant gets a weekly report`).
4. The Chief applies it through the adapter (apply description, apply skill).
5. The Chief notes it in [[agents/CHANGELOG]] with date, agent and reason.

Before applying, the Chief keeps the previous description in the agent's README under "Previous descriptions". New agents are created with the skill `second-brain-new-agent`.

## Contents

| Path | For what |
|---|---|
| [[agents/_protocols/README]] | Global rules every agent reads |
| `_protocols/<team>/` | One folder per team flow, when the Owner's team grows |
| `_blocks/` | Role blocks (chief, assistant, librarian) appended to agent descriptions |
| `_skills/` | Shared skills, read straight from this clone |
| `<agent>/README.md` | Card and current description of each agent |
| [[agents/CHANGELOG]] | History of changes to agents and protocols |

## Team

Role names come from `AGENTS.md`; who holds each role is in `LOCAL.md`. Rows added by init and by `second-brain-new-agent`. Status is `active` or `pending-creation` (the Owner still has to create it in the runtime).

| Role or team | Agent | Reports to | Status |
|---|---|---|---|

## Agent card format

```text
# <Name>

| Field | Value |
|---|---|
| id | <runtime id, if any> |
| Name | <name> (role name, not a person) |
| Role | chief, assistant, librarian or domain: <team> |
| Reports to | Owner or Chief |
| Status | active or pending-creation |

## Current description
Version YYYY-MM-DD. If you change this block, apply it through the adapter and note it in CHANGELOG.

(verbatim description, including the Vault block)

## Can / cannot
| Can | Cannot |

## Skills
## Files it reads and writes
## Previous descriptions
```
