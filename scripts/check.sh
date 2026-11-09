#!/usr/bin/env bash
set -euo pipefail
if ! command -v browser-harness >/dev/null 2>&1; then
  echo 'browser-harness is not on PATH. Run setup.sh, then open a new Terminal window.' >&2
  exit 1
fi
browser-harness <<'CHECK'
print(page_info())
CHECK
