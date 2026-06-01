# Contribution rules

Every PR to this repo must pass the same checks that
`opencode-agent-expert` runs in strict mode. The rules below are the
authoritative reference. If you change them, update the skill body in
`skills/opencode-agent-expert/SKILL.md` to match.

## Skills (`skills/<name>/SKILL.md`)

- `name` must match `^[a-z0-9]+(-[a-z0-9]+)*$` and be ≤64 chars.
- `name` must equal the directory name.
- `description` must be 1-1024 chars.
- `description` must contain "USE FOR" and "DO NOT USE FOR" cues.
- Frontmatter may only use `name`, `description`, `license`,
  `compatibility`, `metadata`. Everything else is ignored.

## Agents (`agents/<name>.md`)

- `description` is required and ≤300 chars.
- `mode`, if set, must be one of `primary`, `subagent`, `all`.
- Filename (without `.md`) becomes the agent name and must be unique.
- Do **not** shadow built-ins (`build`, `plan`, `general`, `explore`,
  `scout`) without explicit justification in the PR description.
- No deprecated `maxSteps` — use `steps`.
- No deprecated `tools` block when `permission` would do.
- `permission.task` must never include `"*": "allow"` and must deny
  the agent's own name to prevent self-invocation loops.
- Read-only agents must have `bash: deny` (or a strict glob map).

## Commands (`commands/<name>.md`)

- `description` is required.
- `agent`, if set, must refer to an existing agent.
- `subtask: true` is the default for any command that runs a
  specialised workflow; only set it to `false` if you want the
  command to run in the primary context.
- Use the right placeholder syntax: `$ARGUMENTS`, `$1..$N`,
  `` !`shell` ``, `@file`.

## Cross-cutting

- One artifact per file. No multi-agent mega-files.
- Commit messages: short, imperative, one-line summary plus
  optional body. Example: `agents: add code-reviewer subagent`.
- License: MIT (see `LICENSE`).
