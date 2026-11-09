# Shared helpers for Claude Code hooks (sourced, not executed).
# Hooks get JSON on stdin; jq is not assumed to be installed.

# json_string FIELD < json — prints the first string value of FIELD, unescaped.
json_string() {
  sed -nE 's/.*"'"$1"'"[[:space:]]*:[[:space:]]*"(([^"\\]|\\.)*)".*/\1/p' |
    head -n 1 |
    sed -e 's/\\"/"/g' -e 's/\\\\/\\/g'
}

# to_unix PATH — converts a Windows path (D:\a\b) to the form bash uses.
to_unix() {
  if command -v cygpath >/dev/null 2>&1; then
    cygpath -u "$1"
  else
    printf '%s\n' "$1"
  fi
}

project_root() {
  to_unix "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}"
}
