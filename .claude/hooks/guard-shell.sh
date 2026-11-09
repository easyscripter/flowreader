#!/usr/bin/env bash
# PreToolUse hook (Bash|PowerShell): blocks git commands that AGENTS.md forbids
# without the human's explicit permission. Exit code 2 refuses the command and
# tells the agent why. A human can still run these commands themselves.
set -uo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
. "$here/lib.sh"

cmd="$(json_string command)"
[ -n "$cmd" ] || exit 0

deny() {
  echo "Blocked by .claude/hooks/guard-shell.sh: $1" >&2
  echo "AGENTS.md, section 1 (Git). Ask the human in chat; they can run it themselves." >&2
  exit 2
}

has() { printf '%s' "$cmd" | grep -Eq -- "$1"; }

if has 'git[^|;&]*--no-verify'; then
  deny "--no-verify skips the pre-commit checks."
fi
if has 'git[^|;&]*push[^|;&]*(--force|--force-with-lease|[[:space:]]-f([[:space:]]|$)|[[:space:]]\+)'; then
  deny "force push rewrites published history."
fi
if has 'git[^|;&]*push[^|;&]*([[:space:]]|:)main([[:space:]]|$)'; then
  deny "pushing to main is forbidden; push the task branch and open a PR."
fi
if has 'git[^|;&]*config[^|;&]*core\.hooksPath' && ! has 'core\.hooksPath[[:space:]]+\.githooks([[:space:]]|$)'; then
  deny "core.hooksPath must stay .githooks."
fi
exit 0
