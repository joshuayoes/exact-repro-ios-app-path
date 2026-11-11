#!/bin/sh
set -u
export EXACT_FEEDBACK=0
cd "${1:-$(dirname "$0")}" || exit 2
help=$(bun exact.mjs ios --help 2>&1) || { echo "FAIL setup: bun exact.mjs ios --help failed"; echo "$help"; exit 2; }
case "$help" in
  *--print-path*) ;;
  *) echo "BUG: no way to get the built .app's path; today it is only the last line of the build log"; exit 1;;
esac
p=$(bun exact.mjs ios --print-path 2>/dev/null)
[ -d "$p" ] && case "$p" in *.app) echo "FIXED: $p"; exit 0;; esac
echo "BUG: --print-path printed '$p', not only the path of an existing .app"; exit 1
