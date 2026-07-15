# Working on this repo

This repo is self-hosting: its own planning documents are maintained by the skill it ships.

Before any work, read in this order:
1. `ROADMAP.md` — what's decided and what's done; it is the shared memory across sessions.
2. `docs/plans/2026-07-15-mvp-roadmap-prd.md` — the specification each epic links into.
3. `skills/mvp-roadmap/references/editing-rules.md` — the rules for every edit to the docs above.

Rules of engagement:
- The current work is **E1** (walking skeleton). Ship it through the CI/CD section of the PRD.
- When work completes, follow the tick protocol: propose ticks with executed evidence, wait for confirmation, then change checkbox characters only.
- When a decision changes, rewrite the owning PRD section and propagate to linked stories and echoes. The final document reads as if written correctly from the beginning; history goes in commit messages.
- Run the accretion self-check (editing-rules.md) on any doc you edit. Once `scripts/check-doc.sh` exists (E2), run that instead.
