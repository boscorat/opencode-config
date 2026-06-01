#!/usr/bin/env bash
# install.sh — bootstrap boscorat/opencode-config on a new machine.
#
# Idempotent and non-destructive. Safe to re-run. Refuses to clobber
# pre-existing real files or unrelated symlinks; backs up before
# replacing.

set -euo pipefail

REPO_URL="https://github.com/boscorat/opencode-config.git"
REPO_DIR="${HOME}/.config/opencode/repo"
AGENTS_DIR="${HOME}/.config/opencode/agents"
COMMANDS_DIR="${HOME}/.config/opencode/commands"
SKILLS_DIR="${HOME}/.agents/skills"

# Third-party skills to install on every machine. Format: "git-url:skill-name".
# Leave empty if you do not want any.
THIRD_PARTY_SKILLS=(
  # "https://github.com/microsoft/azure-skills.git:microsoft-foundry"
)

log()  { printf '\033[1;34m[install]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[warn]\033[0m %s\n' "$*" >&2; }
err()  { printf '\033[1;31m[err]\033[0m %s\n'  "$*" >&2; }

# 1. Verify the opencode CLI is installed.
if ! command -v opencode >/dev/null 2>&1; then
  err "opencode CLI not found on PATH. Install it first: https://opencode.ai/docs"
  exit 1
fi
log "opencode CLI: $(opencode --version 2>/dev/null || echo unknown)"

# 2. Ensure runtime directories exist.
mkdir -p "${HOME}/.config/opencode" "${SKILLS_DIR}"

# 3. Clone or pull the repo.
if [ ! -d "${REPO_DIR}" ]; then
  log "Cloning ${REPO_URL} -> ${REPO_DIR}"
  git clone --depth=1 "${REPO_URL}" "${REPO_DIR}"
else
  log "Pulling latest into ${REPO_DIR}"
  (cd "${REPO_DIR}" && git pull --ff-only) || warn "git pull failed; continuing with existing checkout"
fi

# 4. Helper: replace a runtime path with a symlink to the repo, with backup.
link_repo_subdir() {
  local target="$1"  # e.g. ~/.config/opencode/agents
  local name
  name="$(basename "${target}")"
  local repo_subdir="${REPO_DIR}/${name}"

  if [ ! -d "${repo_subdir}" ]; then
    warn "Repo has no ${name}/ subdir; skipping ${target}"
    return 0
  fi

  if [ -L "${target}" ]; then
    local current
    current="$(readlink "${target}")"
    if [ "${current}" = "${repo_subdir}" ]; then
      log "${target} already symlinked to ${repo_subdir}"
      return 0
    fi
    warn "${target} is a symlink to ${current}, not the repo; leaving alone"
    return 0
  fi

  if [ -e "${target}" ]; then
    local backup="${target}.pre-opencode-config.bak"
    warn "Backing up ${target} -> ${backup}"
    mv "${target}" "${backup}"
  fi

  ln -s "${repo_subdir}" "${target}"
  log "Linked ${target} -> ${repo_subdir}"
}

link_repo_subdir "${AGENTS_DIR}"
link_repo_subdir "${COMMANDS_DIR}"

# 5. Symlink each skill subdir.
if [ -d "${REPO_DIR}/skills" ]; then
  for skill_dir in "${REPO_DIR}/skills"/*; do
    [ -d "${skill_dir}" ] || continue
    local_name="$(basename "${skill_dir}")"
    target="${SKILLS_DIR}/${local_name}"

    if [ -L "${target}" ]; then
      current="$(readlink "${target}")"
      if [ "${current}" = "${skill_dir}" ]; then
        log "${target} already symlinked"
        continue
      fi
      warn "${target} is a symlink to ${current}, not the repo skill; leaving alone"
      continue
    fi

    if [ -e "${target}" ]; then
      warn "${target} already exists as a real path; leaving alone (third-party skill? remove it manually if you want to symlink)"
      continue
    fi

    ln -s "${skill_dir}" "${target}"
    log "Linked ${target} -> ${skill_dir}"
  done
else
  warn "No skills/ subdir in repo; skipping skills"
fi

# 6. Third-party skill installs. The "microsoft-foundry" entry is
#    intentionally NOT in the default list: it is a large clone of a
#    Microsoft repo that updates on its own cadence, and we sync it via
#    a separate manual step. Add entries here if you want a third-party
#    skill tracked centrally.
if [ "${#THIRD_PARTY_SKILLS[@]}" -gt 0 ]; then
  for entry in "${THIRD_PARTY_SKILLS[@]}"; do
    url="${entry%%:*}"
    name="${entry##*:}"
    target="${SKILLS_DIR}/${name}"
    if [ -e "${target}" ]; then
      log "Third-party skill ${name} already present; skipping"
      continue
    fi
    log "Cloning third-party skill ${name} from ${url}"
    tmp="$(mktemp -d)"
    git clone --depth=1 "${url}" "${tmp}/repo"
    # The third-party repo's SKILL.md is usually at the repo root or under
    # .github/plugins/<name>/skills/<name>/. Try common locations in order.
    found=""
    for candidate in \
        "${tmp}/repo/skills/${name}/SKILL.md" \
        "${tmp}/repo/.github/plugins/${name}/skills/${name}/SKILL.md"; do
      if [ -f "${candidate}" ]; then
        skill_parent="$(dirname "$(dirname "${candidate}")")"
        mkdir -p "${target}"
        cp -R "${skill_parent}/." "${target}/"
        found=1
        break
      fi
    done
    if [ -z "${found}" ]; then
      warn "Could not locate SKILL.md for ${name} in ${url}; skipping"
    fi
    rm -rf "${tmp}"
  done
else
  log "No third-party skills configured (THIRD_PARTY_SKILLS is empty)"
fi

log "Bootstrap complete. Restart opencode, then try /new-agent or @opencode-agent-expert."
log "Provider config (not synced): edit ~/.config/opencode/opencode.json on this machine."
