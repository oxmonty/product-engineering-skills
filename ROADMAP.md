# mvp-roadmap

> Repo: https://github.com/monthy-app/mvp-roadmap

mvp-roadmap is an agent skill (Agent Skills standard, Markdown) that interviews you section-by-section to turn an idea into a decision-complete MVP document set — a living `ROADMAP.md` and a dated PRD — and then keeps those documents truthful as work lands, with anti-accretive editing and a propose-then-tick roadmap protocol. Unlike process-owning frameworks (BMAD, Spec-Kit) or full methodologies (superpowers), it owns only the document: one small, hackable skill producing a single source of truth.

```
npx skills add monthy-app/mvp-roadmap   # install
/mvp-roadmap                               # in any repo or empty dir: interview → ROADMAP.md + docs/plans/<date>-prd.md
```

Usable as:
- **Claude Code skill**: user-invoked `/mvp-roadmap`; also model-invoked for roadmap tick-offs and doc updates.
- **Packaged `.skill`**: attached to GitHub Releases for claude.ai import.
- **Any Agent-Skills harness**: Codex and others, via the skills.sh installer.

---

## Roadmap

- [x] **E1: Walking skeleton** — the skill installs through both planned channels and triggers end-to-end in a clean project. → [Distribution](docs/plans/2026-07-15-mvp-roadmap-prd.md#distribution)
    - [x] Repo scaffold in superpowers layout: skills/mvp-roadmap/{SKILL.md, references/, assets/}, scripts/, tests/, MIT LICENSE, CLAUDE.md/AGENTS.md, README pointing at this roadmap
    - [x] CI validates SKILL.md frontmatter and Markdown on every PR
    - [x] Release workflow packages `mvp-roadmap.skill` and attaches it to a GitHub Release on tag
    - [x] Verified install: `npx skills add monthy-app/mvp-roadmap` in a clean directory, skill triggers on "spec out this MVP"

- [x] **E2: Doc linter** — `scripts/check-doc.sh` mechanically enforces the document invariants the skill promises. → [Validation strategy](docs/plans/2026-07-15-mvp-roadmap-prd.md#validation-strategy)
    - [x] Accretion-tell grep over doc body text with an allowlist for legitimate policy prose
    - [x] Roadmap link/anchor resolution check, including cross-file `docs/plans/*#anchor` links
    - [x] Structural checks: MVP line present, ≤6 stories per epic, every epic links to a real section
    - [x] CI runs check-doc.sh against this repo's own ROADMAP.md and PRD (self-hosting gate)

- [ ] **E3: Create-mode evals** — golden briefs prove the interview produces valid documents without hand-holding. → [Validation strategy](docs/plans/2026-07-15-mvp-roadmap-prd.md#validation-strategy)
    - [x] Three golden briefs committed under tests/ (CLI tool, hosted API, library) with expected structural assertions
    - [x] Assertions runnable via check-doc.sh plus per-brief expectations (e.g. API section present only for the API brief)
    - [ ] One recorded transcript per brief reviewed for question quality: one decision per turn, recommendation always present

- [ ] **E4: Update-mode evals** — the tick protocol and edit propagation behave under test. → [Update-mode workflow](docs/plans/2026-07-15-mvp-roadmap-prd.md#workflow)
    - [ ] Fixture: doc + fake work evidence → skill proposes exactly the evidenced ticks, asks before striking
    - [ ] Fixture: changed decision → owning section, linked stories, and echoes all rewritten; accretion grep comes back clean
    - [ ] Fixture: tick edit touches checkbox characters only (diff assertion)

---
*MVP line — E1–E4 ship as v0.1: installable through both channels, self-hosting its own docs, with the linter and a small eval suite proving both modes.*

- [ ] **E5: Claude Code plugin packaging** — `.claude-plugin/` manifest and marketplace listing for subscribe-rather-than-fork installs. → [Distribution](docs/plans/2026-07-15-mvp-roadmap-prd.md#distribution)
    - [ ] Plugin manifest and `/plugin marketplace add monthy-app/mvp-roadmap` verified
    - [ ] README documents the two install philosophies (hackable copy vs managed bundle)

**Future (considered, unscheduled)**: automated eval runs in CI via the skill-creator harness ([here](docs/plans/2026-07-15-mvp-roadmap-prd.md#validation-strategy)); growth path to a multi-skill collection if a second skill materializes ([here](docs/plans/2026-07-15-mvp-roadmap-prd.md#scope)); Codex-native plugin manifest ([here](docs/plans/2026-07-15-mvp-roadmap-prd.md#distribution)).
