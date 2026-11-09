#!/usr/bin/env bash
# SessionStart hook: makes sure git uses the project's pre-commit hook
# (AGENTS.md, section 1: `git config core.hooksPath .githooks`).
set -uo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
. "$here/lib.sh"

cd "$(project_root)" || exit 0
if [ "$(git config --get core.hooksPath)" != ".githooks" ]; then
  git config core.hooksPath .githooks &&
    echo "Enabled the project pre-commit hook: git config core.hooksPath .githooks"
fi
exit 0
