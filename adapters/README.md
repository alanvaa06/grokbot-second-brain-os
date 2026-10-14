# adapters/

One folder per runtime. `LOCAL.md` names the one in use; skills read `adapters/<runtime>/README.md` whenever they need to create an agent, apply a description, wake an agent, set a routine, or know where the clone lives. Every adapter has the same table:

| Row | Meaning |
|---|---|
| Create agent | how the Chief creates a new agent with a description, or "not available: print and ask the Owner" |
| Apply description | how a description change is applied to an existing agent, self included |
| Wake agent | how the Chief sends work to another agent |
| Routines | whether scheduled runs exist and how the audit cadence is set |
| Vault path | where the clone lives and whether it persists between sessions |
| Git auth | how `gh auth` is set up on this runtime |
| Skills | where SKILL.md files are read from (default: straight from the clone) |

Adding a runtime: copy `generic/README.md`, fill the seven rows, add a line to the table in the root `README.md`.
