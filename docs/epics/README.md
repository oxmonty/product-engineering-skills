# Epics

One file per epic, named `E<nn>-<slug>.md` (zero-padded so listings sort in epic order), with a fixed structure: the `# E<n>: Name` title, the outcome line with its link into the PRD section that specifies it, `## Stories` with their tick state, and — once `/epic` has run — `## Exit criteria`: the artifact the epic exits with, the regression command that gates its tick, and the demo that proves it done. Ticks live here — nowhere else — so a tick's blast radius is one epic's file.

The epic order, one-line outcomes, and the MVP cut live in [`ROADMAP.md`](../../ROADMAP.md) at the repo root — the index, deliberately kept free of story detail. Completed epics get a dated, append-only narrative in [`../write-ups/`](../write-ups/).

This directory is intentionally not listed here: the roadmap is the single index, and a second list would be one more thing to keep in sync.
