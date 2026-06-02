# opencode-config

Synced global OpenCode agents, commands, and skills. One public repo, one
`./install.sh` on every machine, and a `git pull` keeps everything in sync.

The runtime config locations are symlinked into this repo's folders, so a
`git pull` is enough to update OpenCode on every machine after a restart.

## Contents

```
agents/    → ~/.config/opencode/agents       (subagents, primary agents)
commands/  → ~/.config/opencode/commands     (/new-agent, /new-skill, /new-command)
skills/    → ~/.agents/skills/               (per-skill folder layout)
```

The current contents are:

- `opencode-agent-expert` — a subagent specialised in creating, configuring,
  and validating OpenCode agents, subagents, skills, and commands. Strict
  mode rejects deprecated fields, broken naming, and self-invocation loops.
- `/new-agent`, `/new-skill`, `/new-command` — three commands that all hand
  off to the expert via `subtask: true`, so the primary context stays clean.
- The `opencode-agent-expert` skill — the deep schema reference the expert
  loads on demand. Synthesized from opencode.ai/docs (May 2026) and
  Razuer/handy-opencode.

## Bootstrap on a new machine

```sh
git clone https://github.com/boscorat/opencode-config.git
cd opencode-config
./install.sh
```

`install.sh` is idempotent and non-destructive. It will:

1. Verify the `opencode` CLI is on `PATH`.
2. Clone this repo to `~/.config/opencode/repo/`.
3. Symlink `agents/` and `commands/` into `~/.config/opencode/`.
4. Symlink each skill subdirectory into `~/.agents/skills/`.
5. Run any third-party skill installs configured in the `THIRD_PARTY_SKILLS`
   list (empty by default; see `install.sh` to add entries).

If a runtime path already exists as a real file or directory, `install.sh`
backs it up to `<name>.pre-opencode-config.bak` before replacing it with a
symlink. If it already is a symlink into this repo, it is left alone.

## Daily workflow

```sh
cd ~/.config/opencode/repo      # or wherever you cloned the repo
git pull
# restart opencode
```

That's it. New agents, commands, and skills become available after a restart.

## Using agents

After a restart, all agents in this repo are available as subagents. Invoke
any of them with `@<agent-name>` in the TUI, or list what is available:

```sh
opencode agent list
```

### opencode-agent-expert

Designs, validates, and writes OpenCode agents, skills, and commands. Strict
mode rejects deprecated fields, broken naming, and self-invocation loops.
Loads the `opencode-agent-expert` skill on demand for the full schema
reference.

```
/new-agent <description>      # interactive, runs in a subtask
/new-skill <description>
/new-command <description>

@opencode-agent-expert design an agent that does X
```

### python-pyside6-reviewer

Reviews Python 3.14 + PySide6 code. Favouring later 3.x features (PEP 604
unions, pattern matching, `type` aliases, exception groups, `dataclass(slots=True)`,
`Self`, `tomllib`) where they remain readable to a PCEP/PCAP-level
intermediate. Willing to suggest structural shifts (OOP <-> functional) when
there is tangible benefit. Prefers descriptive names. Never modifies files —
only reports findings with a verdict of `APPROVE` / `APPROVE WITH SUGGESTIONS`
/ `REQUEST CHANGES`.

```
@python-pyside6-reviewer review path/to/file.py
```

or paste code directly. See the agent's full prompt in
`agents/python-pyside6-reviewer.md` for the review structure.

## Per-machine provider setup

This repo does **not** contain `opencode.json` (provider keys, model
defaults, MCP tokens). Set that up once per machine:

```sh
$EDITOR ~/.config/opencode/opencode.json
```

Minimal example:

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "anthropic": { "options": { "apiKey": "..." } }
  },
  "model": "anthropic/claude-sonnet-4-20250514"
}
```

## Adding a third-party skill

Third-party skills are not vendored in this repo (they would go stale and
bloat the repo). To add one for every machine:

1. Add an entry to the `THIRD_PARTY_SKILLS` array in `install.sh`:
   ```sh
   THIRD_PARTY_SKILLS=(
     "github.com/microsoft/azure-skills:microsoft-foundry"
   )
   ```
2. Re-run `./install.sh` on every machine.

## Conventions

See [AGENTS.md](AGENTS.md) for the schema rules every contribution must
follow. The expert enforces them in strict mode; the same rules apply to
human commits.

A GitHub Actions workflow
([`.github/workflows/validate-frontmatter.yml`](.github/workflows/validate-frontmatter.yml))
runs the same rules on every PR and direct push to `master`. Run the
validator locally before opening a PR:

```sh
bash .github/workflows/scripts/validate-frontmatter.sh
```

## License

MIT. See [LICENSE](LICENSE).
