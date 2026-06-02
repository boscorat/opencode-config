# GitHub workflows

CI for this repo.

## validate-frontmatter.yml

Runs on every pull request and on direct pushes to `master` when
`agents/`, `skills/`, `commands/`, or the workflow itself change.

The job executes
[scripts/validate-frontmatter.sh](workflows/scripts/validate-frontmatter.sh),
which mirrors the strict validation rules in
[`skills/opencode-agent-expert/SKILL.md` §6 anti-pattern index](../skills/opencode-agent-expert/SKILL.md).
The script exits non-zero on any violation and prints a numbered report
grouped by artifact so reviewers can scan the failures.

Rules enforced:

- **Agents** (`agents/*.md`): `description` 1-300 chars; `mode` ∈
  `{primary, subagent, all}`; no deprecated `maxSteps`; no deprecated
  `tools:` block; no shadowing of built-ins (`build`, `plan`, `general`,
  `explore`, `scout`); unique filenames matching
  `^[a-z0-9]+(-[a-z0-9]+)*$`; no `permission.task: "*": "allow"` (catches
  self-invocation loops); reviewer/audit subagents must set `bash: deny`.
- **Skills** (`skills/*/SKILL.md`): `name` 1-64 chars, matches the regex,
  equals the directory name; `description` 1-1024 chars and contains
  "USE FOR" and "DO NOT USE FOR" cues; frontmatter keys ⊆
  `{name, description, license, compatibility, metadata}`.
- **Commands** (`commands/*.md`): `description` required; `agent` (if set)
  refers to an existing agent file; unique filenames matching the regex.

Run the validator locally before opening a PR:

```sh
bash .github/workflows/scripts/validate-frontmatter.sh
```

The script accepts an optional path argument for testing fixtures:

```sh
bash .github/workflows/scripts/validate-frontmatter.sh /path/to/test/repo
```
