#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: ./setup.sh [pi|claude|copilot|agents|codex|kiro] [skills-directory]

Install every bundled skill and Ponytail into a flat skill directory.
Install mattpocock/skills as a plugin for Claude Code, Copilot CLI, and Codex
when using the default directory and a CLI with plugin support.
Archive matching standalone copies after installing the plugin.
Otherwise, copy mattpocock/skills into the selected skill directory.
Copy AGENTS.md to the agent configuration directory containing that skill directory.
Move previously installed deprecated Advisor skills outside the skill directory.
External skills are downloaded from GitHub; curl, tar, and network access are required.

Agent directories:
  pi       ~/.pi/agent/skills
  claude   ~/.claude/skills
  copilot  ~/.copilot/skills
  agents   ~/.agents/skills
  codex    ~/.codex/skills
  kiro     ~/.kiro/skills

The second argument overrides the selected agent directory.
SKILLS_DIR also overrides the selected agent directory when no second argument is given.

For Pi runtime packages and configuration, run ./install-pi.sh separately.
USAGE
}

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_dir="$script_dir/skills"
agent="${1:-pi}"

case "$agent" in
  pi)
    default_target="$HOME/.pi/agent/skills"
    ;;
  claude)
    default_target="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills"
    ;;
  copilot)
    default_target="${COPILOT_HOME:-$HOME/.copilot}/skills"
    ;;
  agents)
    default_target="$HOME/.agents/skills"
    ;;
  codex)
    default_target="${CODEX_HOME:-$HOME/.codex}/skills"
    ;;
  kiro)
    default_target="$HOME/.kiro/skills"
    ;;
  -h|--help)
    usage
    exit 0
    ;;
  *)
    echo "Unknown agent: $agent" >&2
    usage >&2
    exit 1
    ;;
esac

target_dir="${2:-${SKILLS_DIR:-$default_target}}"
agent_config_dir="$(dirname "$target_dir")"

if [[ ! -d "$source_dir" ]]; then
  echo "Skill source directory not found: $source_dir" >&2
  exit 1
fi

external_skills="$(mktemp -d)"
trap 'rm -rf "$external_skills"' EXIT
mkdir -p "$external_skills/ponytail"
curl --fail --silent --show-error --location \
  "https://raw.githubusercontent.com/DietrichGebert/ponytail/main/skills/ponytail/SKILL.md" \
  --output "$external_skills/ponytail/SKILL.md"

plugin_command=""
marketplace="mattpocock"
case "$agent" in
  claude)
    plugin_command="install"
    marketplace="claude-plugins-official"
    ;;
  copilot) plugin_command="install" ;;
  codex) plugin_command="add" ;;
esac

source_skills=("$source_dir"/* "$external_skills/ponytail")
if [[ "$target_dir" == "$default_target" && -n "$plugin_command" ]] &&
  command -v "$agent" >/dev/null 2>&1 &&
  "$agent" plugin "$plugin_command" --help >/dev/null 2>&1; then
  if [[ "$marketplace" == "mattpocock" ]]; then
    "$agent" plugin marketplace add mattpocock/skills
  fi
  "$agent" plugin "$plugin_command" "mattpocock-skills@$marketplace"

  case "$agent" in
    claude|codex)
      plugin_dirs=("$agent_config_dir/plugins/cache/$marketplace/mattpocock-skills"/*)
      ;;
    copilot)
      plugin_dirs=("$agent_config_dir/installed-plugins/$marketplace/mattpocock-skills")
      ;;
  esac

  mattpocock_archive=""
  for plugin_dir in "${plugin_dirs[@]}"; do
    # Only these two upstream buckets are shipped as plugin skills.
    for plugin_skill in "$plugin_dir"/skills/{engineering,productivity}/*; do
      installed_skill="$target_dir/$(basename "$plugin_skill")"
      [[ -f "$plugin_skill/SKILL.md" && -d "$installed_skill" ]] || continue
      diff -qr "$plugin_skill" "$installed_skill" >/dev/null || continue

      if [[ -z "$mattpocock_archive" ]]; then
        mkdir -p "$agent_config_dir/deprecated"
        mattpocock_archive="$(mktemp -d "$agent_config_dir/deprecated/mattpocock-skills.XXXXXX")"
      fi
      mv "$installed_skill" "$mattpocock_archive/"
      echo "Archived $installed_skill -> $mattpocock_archive/"
    done
  done
else
  curl --fail --silent --show-error --location \
    "https://codeload.github.com/mattpocock/skills/tar.gz/refs/heads/main" \
    --output "$external_skills/mattpocock.tar.gz"
  mkdir -p "$external_skills/mattpocock"
  tar -xzf "$external_skills/mattpocock.tar.gz" \
    -C "$external_skills/mattpocock" --strip-components=1

  while IFS= read -r -d '' skill_file; do
    source_skills+=("$(dirname "$skill_file")")
  done < <(find "$external_skills/mattpocock/skills" -name SKILL.md -type f -print0)
fi

mkdir -p "$target_dir"
installed=0
for source_skill in "${source_skills[@]}"; do
  [[ -d "$source_skill" ]] || continue

  skill_name="$(basename "$source_skill")"
  skill_file="$source_skill/SKILL.md"
  target_skill="$target_dir/$skill_name"

  if [[ ! -f "$skill_file" ]]; then
    echo "Skipping $skill_name: SKILL.md is missing" >&2
    continue
  fi

  if [[ -e "$target_skill" && ! -d "$target_skill" ]]; then
    echo "Cannot install $skill_name: $target_skill exists and is not a directory" >&2
    exit 1
  fi

  mkdir -p "$target_skill"
  rsync -a --delete "$source_skill/" "$target_skill/"
  echo "Installed $skill_name -> $target_skill"
  ((installed += 1))
done

if [[ "$installed" -eq 0 ]]; then
  echo "No skills were installed." >&2
  exit 1
fi

cp "$script_dir/AGENTS.md" "$agent_config_dir/AGENTS.md"
echo "Installed AGENTS.md -> $agent_config_dir/AGENTS.md"

archive_dir=""
for deprecated_skill in "$script_dir"/deprecated/*; do
  [[ -f "$deprecated_skill/SKILL.md" ]] || continue
  installed_skill="$target_dir/$(basename "$deprecated_skill")"
  [[ -d "$installed_skill" ]] || continue

  if [[ -z "$archive_dir" ]]; then
    mkdir -p "$agent_config_dir/deprecated"
    archive_dir="$(mktemp -d "$agent_config_dir/deprecated/advisor-skills.XXXXXX")"
  fi
  mv "$installed_skill" "$archive_dir/"
  echo "Archived $installed_skill -> $archive_dir/"
done

setup_bin() {
  local bin_src="$script_dir/bin"
  local bin_dst="$HOME/.local/bin"
  [[ -d "$bin_src" ]] || return 0

  mkdir -p "$bin_dst"
  for script in "$bin_src"/*; do
    [[ -f "$script" && -x "$script" ]] || continue
    ln -sf "$script" "$bin_dst/$(basename "$script")"
  done
}

setup_bin

# Keep the skill-copy command independent from Pi package installation.
# Run ./install-pi.sh separately when configuring the Pi runtime.
echo "Installed $installed skills for $agent in $target_dir"
