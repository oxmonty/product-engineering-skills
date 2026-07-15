#!/usr/bin/env bash
# per-brief.sh <archetype> <generated-docs-dir>
#
# Mechanical per-archetype expectations on the docs create mode produced for a
# golden brief. grep only — the qualitative interview-quality checks live in the
# LLM judge (see ../judge-rubric.md). Run alongside ../../scripts/check-doc.sh,
# which owns the structural/link/accretion tier.
#
# Exit 0 if the archetype's expectations hold, 1 otherwise.

set -u
arch="${1:?usage: per-brief.sh <archetype> <dir>}"
dir="${2:?usage: per-brief.sh <archetype> <dir>}"
fail=0

# pattern present in any markdown under the generated dir?
have() { grep -rqE --include='*.md' "$1" "$dir"; }
must()   { if have "$1"; then echo "ok:   $2"; else echo "FAIL: $2"; fail=1; fi; }
mustnt() { if have "$1"; then echo "FAIL: $2"; fail=1; else echo "ok:   $2"; fi; }

# every archetype
must   '^## Roadmap'  "roadmap section present"
must   '\*\*E1'       "E1 epic present"
must   'MVP line'     "MVP line present"

case "$arch" in
  cli)
    mustnt '^## API design' "no API design section (skip logic fired)"
    ;;
  api)
    must '^## API design'     "API design section present"
    must '\*\*Auth'           "auth model stated"
    ;;
  library)
    must   '^## API design'   "API design section present (library-as-product)"
    must   '[Dd]eprecat'      "deprecation/stability policy stated"
    mustnt '\*\*Auth'         "no networked auth model (it is a library)"
    ;;
  *)
    echo "unknown archetype: $arch (expected cli|api|library)" >&2
    exit 2
    ;;
esac

exit $fail
