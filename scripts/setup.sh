#!/usr/bin/env bash
set -euo pipefail
usage() {
  echo 'Usage: bash scripts/setup.sh [--target generic|codex|claude | --skill-dir PATH]'
}
skill_dir="$PWD/.browser-harness"
selected=0
while [ "$#" -gt 0 ]; do
  case "$1" in
    --help|-h) usage; exit 0 ;;
    --target|--skill-dir)
      [ "$#" -ge 2 ] || { usage >&2; exit 2; }
      [ "$selected" -eq 0 ] || { echo 'Choose one target or skill directory.' >&2; exit 2; }
      selected=1
      if [ "$1" = '--skill-dir' ]; then
        [ -n "$2" ] || { echo 'Skill directory cannot be empty.' >&2; exit 2; }
        skill_dir="$2"
      else
        case "$2" in
          generic) skill_dir="$PWD/.browser-harness" ;;
          codex) skill_dir="${CODEX_HOME:-$HOME/.codex}/skills/browser-harness" ;;
          claude) skill_dir="$HOME/.claude/skills/browser-harness" ;;
          *) echo 'Unknown target. Use --skill-dir for other agents.' >&2; exit 2 ;;
        esac
      fi
      shift 2 ;;
    *) usage >&2; exit 2 ;;
  esac
done
if ! command -v uv >/dev/null 2>&1; then
  echo 'Install uv first: https://docs.astral.sh/uv/getting-started/installation/' >&2
  exit 1
fi
uv tool install --python 3.12 --upgrade --force browser-harness
mkdir -p "$skill_dir"
tmp_file=$(mktemp "$skill_dir/.SKILL.XXXXXX")
trap 'rm -f "$tmp_file"' EXIT
harness_bin="$(uv tool dir --bin)/browser-harness"
"$harness_bin" skill > "$tmp_file"
test -s "$tmp_file"
if [ -f "$skill_dir/SKILL.md" ]; then
  backup_file=$(mktemp "$skill_dir/SKILL.md.backup.XXXXXX")
  cp "$skill_dir/SKILL.md" "$backup_file"
fi
mv "$tmp_file" "$skill_dir/SKILL.md"
printf 'Instructions saved to: %s/SKILL.md\n' "$skill_dir"
echo 'Open Chrome, enable remote debugging, then run: bash scripts/check.sh'
