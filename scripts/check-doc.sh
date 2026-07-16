#!/usr/bin/env bash
# check-doc.sh — mechanical invariants for living MVP docs (ROADMAP.md, PRDs).
#
# Usage: ./scripts/check-doc.sh <file.md> [more.md ...]
#
# Per file:
#   1. Accretion tells absent from body text. Fenced code is skipped; a line
#      carrying an "accretion-ok" marker is exempt — the allowlist for
#      legitimate policy prose (e.g. a versioning rule that says "previously").
#   2. Every markdown link resolves. Relative paths are resolved from the
#      file's own directory (so cross-file docs/plans/*#anchor links work), and
#      every #fragment must match a real heading anchor in its target file.
#   3. Roadmap structure. Index files (roadmap epic lines at column 0): the
#      MVP line is present, no epic carries more than six inline stories, and
#      every epic links somewhere. Epic files (H1 of the form "# E<n>: ..."):
#      at most six stories, and a link into a plans/ section is present.
#
# Exit 0 if every file passes, 1 otherwise. grep/awk/sed only — no deps, so it
# drops into any target project the same way it guards this one.

set -u

fail=0

# GitHub-style heading anchors for a file, one slug per line.
anchors_of() {
  grep -E '^#{1,6}[[:space:]]+' "$1" 2>/dev/null \
    | sed -E 's/^#{1,6}[[:space:]]+//' \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9 _-]//g; s/ /-/g'
}
# ponytail: no duplicate-heading -1/-2 suffixing; add it if a doc ever links to
# the second occurrence of a repeated heading.

check_accretion() {
  awk -v F="$1" '
    /^```/ { fence = !fence; next }
    fence          { next }
    /accretion-ok/ { next }
    /no longer|previously|instead of the (old|previous)|used to([^a-z]|$)|formerly|deprecated in favor|\(was |has been (removed|replaced)|as of (v|now)/ {
      printf "%s:%d: accretion tell -> %s\n", F, NR, $0
    }
  ' "$1"
}

check_links() {
  local file="$1" dir="$(dirname "$1")" match line target path frag resolved
  grep -nEo '\]\([^)]+\)' "$file" 2>/dev/null | while IFS= read -r match; do
    line=${match%%:*}
    target=${match#*:}; target=${target#](}; target=${target%)}
    case "$target" in http://*|https://*|mailto:*|"#") continue ;; esac
    case "$target" in
      *"#"*) frag=${target#*#}; path=${target%%#*} ;;
      *)     frag=""; path="$target" ;;
    esac
    if [ -n "$path" ]; then
      resolved="$dir/$path"
      if [ ! -e "$resolved" ]; then
        printf "%s:%s: broken link -> %s (missing %s)\n" "$file" "$line" "$target" "$resolved"
        continue
      fi
    else
      resolved="$file"
    fi
    if [ -n "$frag" ] && ! anchors_of "$resolved" | grep -qxF "$frag"; then
      printf "%s:%s: broken anchor -> %s (#%s absent from %s)\n" "$file" "$line" "$target" "$frag" "$resolved"
    fi
  done
}

check_structure() {
  local file="$1" stories
  if grep -qE '^# E[0-9]+:' "$file"; then                  # per-epic file
    stories=$(grep -cE '^- \[[ x]\]' "$file")
    [ "$stories" -gt 6 ] && printf "%s: structural -> %d stories (max 6)\n" "$file" "$stories"
    grep -qE '\]\((\.\./|docs/)plans/' "$file" \
      || printf "%s: structural -> no link into a plans/ section\n" "$file"
    return 0
  fi
  grep -qE '^- \[[ x]\] \*\*E[0-9]+' "$file" || return 0   # not a roadmap
  grep -qE 'MVP line' "$file" || printf "%s: structural -> MVP line marker missing\n" "$file"
  awk -v F="$file" '
    function close_epic() {
      if (epic == "") return
      if (count > 6)   printf "%s:%d: structural -> epic %s has %d stories (max 6)\n", F, eline, epic, count
      if (haslink == 0) printf "%s:%d: structural -> epic %s links to no section\n", F, eline, epic
    }
    /^- \[[ x]\] \*\*E[0-9]+/ {
      close_epic()
      eline = NR; count = 0; haslink = ($0 ~ /\]\(/) ? 1 : 0
      match($0, /E[0-9]+/); epic = substr($0, RSTART, RLENGTH)
      next
    }
    /^[[:space:]]+- \[[ x]\]/ { if (epic != "") count++ }
    END { close_epic() }
  ' "$file"
}

for f in "$@"; do
  findings=$( check_accretion "$f"; check_links "$f"; check_structure "$f" )
  if [ -n "$findings" ]; then
    printf '%s\n' "$findings"
    fail=1
  else
    printf 'ok: %s\n' "$f"
  fi
done

exit $fail
