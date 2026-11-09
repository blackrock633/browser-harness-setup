#!/usr/bin/env bash
set -euo pipefail
if ! command -v uv >/dev/null 2>&1; then
  echo 'Install uv first: https://docs.astral.sh/uv/getting-started/installation/' >&2
  exit 1
fi
uv tool install --python 3.12 --upgrade --force browser-harness
skill_dir="${CODEX_HOME:-$HOME/.codex}/skills/browser-harness"
mkdir -p "$skill_dir"
tmp_file=$(mktemp "$skill_dir/.SKILL.XXXXXX")
trap 'rm -f "$tmp_file"' EXIT
harness_bin=$(command -v browser-harness || true)
if [ -z "$harness_bin" ]; then
  harness_bin="$(uv tool dir --bin)/browser-harness"
fi
"$harness_bin" skill > "$tmp_file"
test -s "$tmp_file"
if [ -f "$skill_dir/SKILL.md" ]; then
  cp "$skill_dir/SKILL.md" "$skill_dir/SKILL.md.backup.$(date +%Y%m%d%H%M%S)"
fi
mv "$tmp_file" "$skill_dir/SKILL.md"
echo 'Installed. Open Chrome, enable remote debugging, then run: bash scripts/check.sh'
