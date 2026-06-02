#!/usr/bin/env bash
# validate-frontmatter.sh
#
# Mirrors the strict validation rules in
# skills/opencode-agent-expert/SKILL.md §6 anti-pattern index. Used by CI
# (.github/workflows/validate-frontmatter.yml) and runnable locally:
#
#   bash .github/workflows/scripts/validate-frontmatter.sh
#
# Exit 0 if every artifact is valid, 1 if any violation is found. Prints a
# numbered error report grouped by artifact so PR reviewers can scan it.
#
# POSIX shell; depends on awk, grep, sed, find. No Python, no jq, no network.

set -eu

# Resolve repo root. Default: this script's parent's parent (the git repo).
# Override with the first argument for ad-hoc local testing.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEFAULT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
REPO_ROOT="${1:-${DEFAULT_ROOT}}"
cd "${REPO_ROOT}"

AGENTS_DIR="${REPO_ROOT}/agents"
SKILLS_DIR="${REPO_ROOT}/skills"
COMMANDS_DIR="${REPO_ROOT}/commands"

errors=0
report=""

# section(name) -> starts a new section in the report
section() { report="${report}"$'\n'"--- $1 ---"$'\n'; }

# fail(artifact, rule, msg) -> appends a failure line
fail() {
  report="${report}  [$1] $2: $3"$'\n'
  errors=$((errors + 1))
}

# ok(artifact, rule, msg) -> appends a passing line (only if VERBOSE=1)
ok() { [ "${VERBOSE:-0}" = "1" ] && report="${report}  [$1] $2: $3"$'\n' || true; }

# Extract the value of a top-level YAML key from a markdown frontmatter block.
# Usage: fm_field FILE KEY        -> prints the value (may be multiline)
#        fm_has_field FILE KEY     -> exits 0 if present, 1 if not
fm_field() {
  awk -v key="$2" '
    /^---$/ { c++; next }
    c==1 {
      # match "key:" at start of line (allow leading spaces for nested)
      # we only want top-level keys (no leading whitespace)
      if ($0 ~ "^"key":") {
        sub("^"key":[ \t]*", "")
        in_block=1
        print
        next
      }
      # blank line or new top-level key ends the block
      if (in_block && ($0 ~ /^[a-zA-Z_]/ || $0 == "")) {
        in_block=0
      } else if (in_block) {
        print
      }
    }
  ' "$1"
}

fm_has_field() {
  awk -v key="$2" '
    /^---$/ { c++; next }
    c==1 {
      if ($0 ~ "^"key":") { found=1; exit }
    }
    END { exit (found?0:1) }
  ' "$1"
}

# Print all top-level keys (one per line). Used to check for unknown fields.
fm_keys() {
  awk '
    /^---$/ { c++; next }
    c==1 {
      if (match($0, /^([a-zA-Z_][a-zA-Z0-9_]*):/)) {
        print substr($0, RSTART, RLENGTH-1)
      }
    }
  ' "$1"
}

# Name regex per skill: ^[a-z0-9]+(-[a-z0-9]+)*$
name_regex='^[a-z0-9]+(-[a-z0-9]+)*$'

# Built-in agent names that must not be shadowed
BUILTINS="build plan general explore scout"

# --------------------------------------------------------------------------
# AGENTS
# --------------------------------------------------------------------------
section "agents/"

agent_basenames_seen=""
if [ -d "${AGENTS_DIR}" ]; then
  for f in "${AGENTS_DIR}"/*.md; do
    [ -f "$f" ] || continue
    base="$(basename "$f" .md)"
    artifact="agents/${base}.md"

    # Uniqueness
    if printf '%s\n' "${agent_basenames_seen}" | grep -qx "${base}"; then
      fail "${artifact}" "unique" "duplicate agent name '${base}'"
    fi
    agent_basenames_seen="${agent_basenames_seen}${base}"$'\n'

    # Filename naming convention
    if ! printf '%s' "${base}" | grep -Eq "${name_regex}"; then
      fail "${artifact}" "filename" "must match ${name_regex}"
    fi

    # Built-in shadowing
    for builtin in ${BUILTINS}; do
      if [ "${base}" = "${builtin}" ]; then
        fail "${artifact}" "shadow" "agent name '${base}' shadows a built-in (build/plan/general/explore/scout); requires explicit justification in PR description"
      fi
    done

    # description required, 1-300 chars
    if ! fm_has_field "$f" "description"; then
      fail "${artifact}" "description" "missing required field"
    else
      desc="$(fm_field "$f" description)"
      desc_len="${#desc}"
      if [ "${desc_len}" -lt 1 ] || [ "${desc_len}" -gt 300 ]; then
        fail "${artifact}" "description" "must be 1-300 chars, got ${desc_len}"
      else
        ok "${artifact}" "description" "${desc_len} chars"
      fi
    fi

    # mode (if set) must be one of {primary, subagent, all}
    if fm_has_field "$f" "mode"; then
      mode_val="$(fm_field "$f" mode | tr -d '[:space:]')"
      case "${mode_val}" in
        primary|subagent|all) ok "${artifact}" "mode" "${mode_val}" ;;
        *) fail "${artifact}" "mode" "must be primary|subagent|all, got '${mode_val}'" ;;
      esac
    fi

    # No deprecated maxSteps
    if grep -qE '^[[:space:]]*maxSteps:' "$f"; then
      fail "${artifact}" "deprecated" "uses deprecated 'maxSteps'; use 'steps' instead"
    fi

    # No deprecated tools: block
    if grep -qE '^[[:space:]]*tools:' "$f"; then
      fail "${artifact}" "deprecated" "uses deprecated 'tools' block; use 'permission' instead"
    fi

    # permission.task must not contain "*": "allow"
    # Detect "task:" at any indent (it is usually nested under "permission:").
    # Track in_task by matching the key; exit it when a new top-level key
    # (no leading whitespace) appears. The awk exits 0 when a match is found.
    task_match="$(awk '
      /^---$/ { c++; next }
      c==1 {
        if ($0 ~ /^[a-zA-Z_]/) { in_task=0 }
        if ($0 ~ /^[[:space:]]*task:[[:space:]]*$/) { in_task=1; next }
        if (in_task && $0 ~ /"\*"[[:space:]]*:[[:space:]]*"allow"/) { found=1 }
        if (in_task && $0 ~ /"\*"[[:space:]]*:[[:space:]]*allow[[:space:]]*$/) { found=1 }
      }
      END { exit (found?0:1) }
    ' "$f" && echo yes || echo no)"
    if [ "${task_match}" = "yes" ]; then
      fail "${artifact}" "permission.task" 'contains "*": "allow"; never allow the agent'\''s own name to be delegated to itself (self-invocation loop)'
    fi

    # Read-only heuristic: if the body mentions "review" or "audit" (case-insensitive)
    # and the body is a subagent, then bash must be denied.
    if fm_has_field "$f" "mode"; then
      mode_val="$(fm_field "$f" mode | tr -d '[:space:]')"
      if [ "${mode_val}" = "subagent" ]; then
        if grep -qiE '\b(review|audit)\b' "$f"; then
          bash_action="$(awk '
            /^---$/ { c++; next }
            c==1 {
              if ($0 ~ /^[a-zA-Z_]/) { in_bash=0 }
              if ($0 ~ /^bash:[[:space:]]*$/) { in_bash=1; val=$0; next }
              if (in_bash) { val=val " " $0 }
            }
            END {
              if (val ~ /allow/) print "allow"
              else if (val ~ /ask/) print "ask"
              else if (val ~ /deny/) print "deny"
              else print ""
            }
          ' "$f")"
          if [ "${bash_action}" != "deny" ]; then
            fail "${artifact}" "bash" "reviewer/audit subagent must set 'bash: deny' (got '${bash_action:-unset}')"
          fi
        fi
      fi
    fi
  done
fi

# --------------------------------------------------------------------------
# SKILLS
# --------------------------------------------------------------------------
section "skills/"

if [ -d "${SKILLS_DIR}" ]; then
  for d in "${SKILLS_DIR}"/*/; do
    [ -d "$d" ] || continue
    dir_name="$(basename "$d")"
    skill_md="${d}SKILL.md"
    artifact="skills/${dir_name}/SKILL.md"

    if [ ! -f "${skill_md}" ]; then
      fail "${artifact}" "missing" "directory exists but SKILL.md is absent"
      continue
    fi

    # Directory name matches regex
    if ! printf '%s' "${dir_name}" | grep -Eq "${name_regex}"; then
      fail "${artifact}" "dirname" "must match ${name_regex}"
    fi

    # name field required, 1-64 chars, matches regex, equals dir name
    if ! fm_has_field "$skill_md" "name"; then
      fail "${artifact}" "name" "missing required field"
    else
      name_val="$(fm_field "$skill_md" name | tr -d '[:space:]')"
      name_len="${#name_val}"
      if [ "${name_len}" -lt 1 ] || [ "${name_len}" -gt 64 ]; then
        fail "${artifact}" "name" "must be 1-64 chars, got ${name_len}"
      fi
      if ! printf '%s' "${name_val}" | grep -Eq "${name_regex}"; then
        fail "${artifact}" "name" "must match ${name_regex}"
      fi
      if [ "${name_val}" != "${dir_name}" ]; then
        fail "${artifact}" "name" "field ('${name_val}') does not equal directory name ('${dir_name}')"
      fi
    fi

    # description required, 1-1024 chars, contains USE FOR / DO NOT USE FOR
    if ! fm_has_field "$skill_md" "description"; then
      fail "${artifact}" "description" "missing required field"
    else
      desc="$(fm_field "$skill_md" description)"
      desc_len="${#desc}"
      if [ "${desc_len}" -lt 1 ] || [ "${desc_len}" -gt 1024 ]; then
        fail "${artifact}" "description" "must be 1-1024 chars, got ${desc_len}"
      fi
      if ! printf '%s' "${desc}" | grep -qiE 'USE[[:space:]]+FOR'; then
        fail "${artifact}" "description" "must contain 'USE FOR' cue"
      fi
      if ! printf '%s' "${desc}" | grep -qiE 'DO[[:space:]]+NOT[[:space:]]+USE[[:space:]]+FOR'; then
        fail "${artifact}" "description" "must contain 'DO NOT USE FOR' cue"
      fi
    fi

    # Frontmatter keys must be in the allowed set
    allowed="name description license compatibility metadata"
    while IFS= read -r key; do
      [ -z "${key}" ] && continue
      if ! printf '%s\n' "${allowed}" | grep -qx "${key}"; then
        fail "${artifact}" "frontmatter" "unknown key '${key}' (allowed: ${allowed})"
      fi
    done < <(fm_keys "$skill_md")
  done
fi

# --------------------------------------------------------------------------
# COMMANDS
# --------------------------------------------------------------------------
section "commands/"

cmd_basenames_seen=""
if [ -d "${COMMANDS_DIR}" ]; then
  for f in "${COMMANDS_DIR}"/*.md; do
    [ -f "$f" ] || continue
    base="$(basename "$f" .md)"
    artifact="commands/${base}.md"

    # Uniqueness
    if printf '%s\n' "${cmd_basenames_seen}" | grep -qx "${base}"; then
      fail "${artifact}" "unique" "duplicate command name '${base}'"
    fi
    cmd_basenames_seen="${cmd_basenames_seen}${base}"$'\n'

    # Filename naming convention
    if ! printf '%s' "${base}" | grep -Eq "${name_regex}"; then
      fail "${artifact}" "filename" "must match ${name_regex}"
    fi

    # description required
    if ! fm_has_field "$f" "description"; then
      fail "${artifact}" "description" "missing required field"
    fi

    # agent (if set) must refer to an existing agent file
    if fm_has_field "$f" "agent"; then
      agent_val="$(fm_field "$f" agent | tr -d '[:space:]')"
      if [ -n "${agent_val}" ] && [ ! -f "${AGENTS_DIR}/${agent_val}.md" ]; then
        fail "${artifact}" "agent" "references '${agent_val}' but agents/${agent_val}.md does not exist"
      fi
    fi
  done
fi

# --------------------------------------------------------------------------
# Report
# --------------------------------------------------------------------------
if [ "${errors}" -eq 0 ]; then
  echo "OK: all artifacts pass strict-mode validation."
  exit 0
fi

echo "${report}" >&2
echo "" >&2
echo "FAIL: ${errors} violation(s) found." >&2
echo "See skills/opencode-agent-expert/SKILL.md §6 anti-pattern index for the canonical rules." >&2
exit 1
