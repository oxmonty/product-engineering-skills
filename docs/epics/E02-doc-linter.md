# E2: Doc linter

`scripts/check-doc.sh` mechanically enforces the document invariants the skills promise. → [Validation strategy](../plans/2026-07-15-prd.md#validation-strategy)

## Stories

- [x] Accretion-tell grep over doc body text with an allowlist for legitimate policy prose
- [x] Roadmap link/anchor resolution check, including cross-file `docs/plans/*#anchor` links
- [x] Structural checks: MVP line present, ≤6 stories per epic, every epic links to a real section
- [x] CI runs check-doc.sh against this repo's own ROADMAP.md and PRD (self-hosting gate)
