#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: ./setup.sh [pi|claude|copilot|agents] [skills-directory]

Install every bundled skill into a flat skill directory.

Agent directories:
  pi       ~/.pi/agent/skills
  claude   ~/.claude/skills
  copilot  ~/.copilot/skills
  agents   ~/.agents/skills

The second argument overrides the selected agent directory.
SKILLS_DIR also overrides the selected agent directory when no second argument is given.
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
    default_target="$HOME/.claude/skills"
    ;;
  copilot)
    default_target="$HOME/.copilot/skills"
    ;;
  agents)
    default_target="$HOME/.agents/skills"
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

if [[ ! -d "$source_dir" ]]; then
  echo "Skill source directory not found: $source_dir" >&2
  exit 1
fi

mkdir -p "$target_dir"

installed=0
for source_skill in "$source_dir"/*; do
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

echo "Installed $installed skills for $agent in $target_dir"
