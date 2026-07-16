# E1: Walking skeleton — write-up

> Completed: 2026-07-15 · Written: 2026-07-16 · Append-only history; not linted.

## What shipped

A repo that installs through both planned channels while doing almost nothing — the whole point. The bundle's skill payload went in as a separable baseline commit (`b3b6996`) before any new work, then three small commits added the scaffold (`5590903`: MIT LICENSE, README, `scripts/`, `tests/`), CI (`c92cf97`: SKILL.md frontmatter validation + pinned markdownlint), and the release pipeline (`1dfde08`, refined by `72e5cdf` to mark semver pre-release tags `--prerelease`).

## Evidence

- CI green on the first real run: `actions/runs/29403604743`.
- `v0.1.0-alpha.1` cut by tag push; the attached `.skill` had a byte-identical file set to the hand-built artifact the project started from (`diff` of `unzip -Z1` listings came back empty).
- Clean-dir install via skills.sh found and installed the skill with no manifest beyond frontmatter — which also settled the first open question in the PRD.

## Decisions along the way

- Markdownlint was configured as a structural safety net, not a prose reformatter: the docs are long-form by design, so the style rules that fight that (line length, list spacing) were disabled rather than the docs rewritten.
- The packaging command was matched to the delivered artifact (`zip -r -X -D`) instead of inventing a new layout, so claude.ai imports see the same shape either way.

## What surprised

- The GitHub org repo already existed — private, with pull-only access — which blocked the first push entirely until access was granted and visibility flipped. The lesson: verify write access before assuming a clean `gh repo create`.
- The repo was renamed twice within two days of E1 completing (org move, then the collection pivot). The verified-install story was deliberately written name-agnostically afterwards, and re-verified under the final name during E5.
