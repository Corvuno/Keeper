#!/bin/sh
# Copies the generic Keeper into a product. Usage: install.sh <keeper checkout> <product root>
# Everything under core/ lands under the product's .claude/ at the same path. Files a previous
# run installed and this one no longer ships are removed. The list of installed files and the
# Keeper commit they came from are kept in .claude/keeper-core.txt.
set -e
SRC="$1"; DST="$2"
[ -d "$SRC/core" ] && [ -d "$DST" ] || { echo "usage: install.sh <keeper checkout> <product root>" >&2; exit 2; }
# The generic part stays small: a Keeper that has grown past these sizes is not installed.
SIZE=$(cat "$SRC"/core/skills/keeper/*.md "$SRC"/core/agents/*.md | wc -c | tr -d ' ')
MAIN=$(wc -c < "$SRC/core/skills/keeper/SKILL.md" | tr -d ' ')
if [ "$SIZE" -gt 24000 ] || [ "$MAIN" -gt 9000 ]; then
  echo "Keeper not installed: it has grown too large ($SIZE characters in all, $MAIN in SKILL.md). Shorten it first." >&2
  exit 1
fi
LIST="$DST/.claude/keeper-core.txt"
NEW=$(cd "$SRC/core" && find . -type f | sed 's#^\./##' | LC_ALL=C sort)
if [ -f "$LIST" ]; then
  grep -v '^#' "$LIST" | while IFS= read -r f; do
    [ -n "$f" ] || continue
    printf '%s\n' "$NEW" | grep -qxF "$f" || rm -f "$DST/.claude/$f"
  done
fi
printf '%s\n' "$NEW" | while IFS= read -r f; do
  mkdir -p "$DST/.claude/$(dirname "$f")"
  cp -p "$SRC/core/$f" "$DST/.claude/$f"
done
{
  echo "# Generic Keeper files, copied from https://github.com/Corvuno/Keeper. Never edit these here."
  echo "# Source commit: $(git -C "$SRC" rev-parse --short HEAD 2>/dev/null || echo unknown)"
  printf '%s\n' "$NEW"
} > "$LIST"
echo "Keeper installed: $(printf '%s\n' "$NEW" | wc -l | tr -d ' ') files."
