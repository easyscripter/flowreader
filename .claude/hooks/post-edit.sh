#!/usr/bin/env bash
# PostToolUse hook (Edit|Write|MultiEdit): formats the edited file and runs the
# linter right away (CLAUDE.md). Exit code 2 sends the errors back to the agent.
#   .rs   -> rustfmt on the file, cargo clippy -D warnings on its crate
#   .dart -> dart format on the file, dart analyze on the file
set -uo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
. "$here/lib.sh"

file="$(json_string file_path)"
[ -n "$file" ] || exit 0
file="$(to_unix "$file")"
root="$(project_root)"

case "$file" in
  "$root"/*) rel="${file#"$root"/}" ;;
  *) exit 0 ;; # outside the project
esac
[ -f "$file" ] || exit 0

# Keep the agent's context small: show only the tail of a long report.
report() {
  echo "$1" >&2
  printf '%s\n' "$2" | tail -n 60 >&2
  exit 2
}

case "$rel" in
  rust/*.rs)
    out="$(rustfmt --edition 2021 "$file" 2>&1)" || report "rustfmt failed on $rel:" "$out"
    # The crate is the nearest folder with Cargo.toml above the file.
    dir="$(dirname "$file")"
    while [ "$dir" != "$root/rust" ] && [ "$dir" != "$root" ] && [ ! -f "$dir/Cargo.toml" ]; do
      dir="$(dirname "$dir")"
    done
    [ -f "$dir/Cargo.toml" ] || exit 0
    crate="$(sed -nE 's/^name[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/p' "$dir/Cargo.toml" | head -n 1)"
    [ -n "$crate" ] || exit 0
    out="$(cd "$root/rust" && cargo clippy -q -p "$crate" --all-targets --color never -- -D warnings 2>&1)" ||
      report "cargo clippy -p $crate found problems after editing $rel (fix them now):" "$out"
    ;;
  lib/src/rust/* | lib/l10n/app_localizations*.dart | *.g.dart | *.freezed.dart)
    exit 0 # generated code: regenerate instead of editing by hand
    ;;
  *.dart)
    out="$(cd "$root" && dart format "$rel" 2>&1)" || report "dart format failed on $rel:" "$out"
    # --fatal-infos: lint findings are "info" and would not fail the run otherwise.
    out="$(cd "$root" && dart analyze --fatal-infos "$rel" 2>&1)" ||
      report "dart analyze found problems after editing $rel (fix them now):" "$out"
    ;;
esac
exit 0
