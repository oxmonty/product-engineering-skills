# Working on this repo

This repo is self-hosting: its own planning documents are maintained by the skills it ships.

Before any work, read in this order:

1. `ROADMAP.md` — the epic index and MVP cut; it is the shared memory across sessions.
2. `docs/epics/E<nn>-*.md` — one file per epic (zero-padded), stories, status, and the spec link. Read the file for any epic you touch.
3. `docs/plans/2026-07-15-prd.md` — the specification each epic links into.
4. `skills/mvp/references/editing-rules.md` — the rules for every edit to the docs above.

Rules of engagement:

- The roadmap says what's next: work the first unticked epic unless told otherwise.
- When work completes, follow the tick protocol: propose ticks with executed evidence, wait for confirmation, then change checkbox characters only.
- When a decision changes, rewrite the owning PRD section and propagate to linked stories and echoes. The final document reads as if written correctly from the beginning; history goes in commit messages and the open-questions decision log.
- Run `scripts/check-doc.sh ROADMAP.md docs/plans/*.md docs/epics/*.md` after editing any doc.
