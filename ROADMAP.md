# product-engineering-skills

> Repo: https://github.com/oxmonty/product-engineering-skills

product-engineering-skills is a collection of agent skills (Agent Skills standard, Markdown) that carries a product from idea to shipped artifact. The entrypoint, `/mvp`, interviews you section-by-section into a decision-complete document set — a living `ROADMAP.md` and a dated PRD — and the companion skills run the build loop against those documents: `/epic` kicks off an epic from its spec, `/delegate` hands implementation down, `/demo-ideas` turns finished work into something showable, and `/wrap-up` closes the day with anti-accretive doc updates and propose-then-tick honesty. Unlike process-owning frameworks (BMAD, Spec-Kit) or full methodologies (superpowers), the collection owns the document and the loop around it — small, hackable skills producing a single source of truth.

```
npx skills add oxmonty/product-engineering-skills   # install the collection
/mvp          # in any repo or empty dir: interview → ROADMAP.md + docs/plans/<date>-prd.md
/epic E1      # kick off an epic against its PRD section
/wrap-up      # close the day: propose ticks, update docs, summarize
```

Usable as:
- **Claude Code skills**: user-invoked `/mvp`, `/epic`, `/demo-ideas`, `/wrap-up`, `/delegate`; update mode is also model-invoked for tick-offs and doc edits.
- **Packaged `.skill` bundles**: one per skill, attached to GitHub Releases for claude.ai import.
- **Any Agent-Skills harness**: Codex and others, via the skills.sh installer.

---

## Roadmap

- [x] **E1: Walking skeleton** — the flagship skill installs through both planned channels and triggers end-to-end in a clean project. → [Distribution](docs/plans/2026-07-15-mvp-roadmap-prd.md#distribution)
    - [x] Repo scaffold in superpowers layout: `skills/<skill>/{SKILL.md, references/, assets/}`, scripts/, tests/, MIT LICENSE, CLAUDE.md/AGENTS.md, README pointing at this roadmap
    - [x] CI validates SKILL.md frontmatter and Markdown on every PR
    - [x] Release workflow packages `.skill` bundles and attaches them to a GitHub Release on tag
    - [x] Verified install: `npx skills add` of this repo in a clean directory, skill triggers on "spec out this MVP"

- [x] **E2: Doc linter** — `scripts/check-doc.sh` mechanically enforces the document invariants the skills promise. → [Validation strategy](docs/plans/2026-07-15-mvp-roadmap-prd.md#validation-strategy)
    - [x] Accretion-tell grep over doc body text with an allowlist for legitimate policy prose
    - [x] Roadmap link/anchor resolution check, including cross-file `docs/plans/*#anchor` links
    - [x] Structural checks: MVP line present, ≤6 stories per epic, every epic links to a real section
    - [x] CI runs check-doc.sh against this repo's own ROADMAP.md and PRD (self-hosting gate)

- [ ] **E3: Create-mode evals** — golden briefs prove the `/mvp` interview produces valid documents without hand-holding. → [Validation strategy](docs/plans/2026-07-15-mvp-roadmap-prd.md#validation-strategy)
    - [x] Three golden briefs committed under tests/ (CLI tool, hosted API, library) with expected structural assertions
    - [x] Assertions runnable via check-doc.sh plus per-brief expectations (e.g. API section present only for the API brief)
    - [ ] One recorded transcript per brief reviewed for question quality: one decision per turn, recommendation always present

- [ ] **E4: Update-mode evals** — the tick protocol and edit propagation behave under test; they pin `/wrap-up`'s editing behavior. → [Update-mode workflow](docs/plans/2026-07-15-mvp-roadmap-prd.md#workflow)
    - [ ] Fixture: doc + fake work evidence → skill proposes exactly the evidenced ticks, asks before striking
    - [ ] Fixture: changed decision → owning section, linked stories, and echoes all rewritten; accretion grep comes back clean
    - [ ] Fixture: tick edit touches checkbox characters only (diff assertion)

- [x] **E5: /mvp entrypoint** — the flagship skill is the collection's front door, and its roadmaps are artifact-first. → [mvp (entrypoint)](docs/plans/2026-07-15-mvp-roadmap-prd.md#mvp-entrypoint)
    - [x] Skill payload lives at skills/mvp; `/mvp` triggers the interview
    - [x] Create mode closes by printing the journey: `/epic` → build with `/delegate` → `/demo-ideas` → `/wrap-up`
    - [x] Artifact-first roadmaps: pre-MVP epics name a shippable artifact as exit criterion, post-MVP epics name their feedback loop (template + synthesis rules)
    - [x] Clean install re-verified: `npx skills add oxmonty/product-engineering-skills` in a clean directory installs the collection

- [x] **E6: wrap-up skill** — one command closes a working session with honest documents. → [wrap-up](docs/plans/2026-07-15-mvp-roadmap-prd.md#wrap-up)
    - [x] skills/wrap-up: diff reality vs roadmap → propose ticks with executed evidence → confirmed ticks only, checkbox characters only
    - [x] Non-accretive doc updates including the open-questions decision log, then a chat summary of the session
    - [x] Offers the closing commit; recommends `/compact` rather than pretending to compact

---
*MVP line — E1–E6 ship as v0.1: the loop's core — `/mvp` writes the documents, `/wrap-up` keeps them truthful, the linter and evals prove both.*

- [ ] **E7: epic skill** — `/epic E<n>` kicks off an epic from its PRD section; dogfooding on this repo's own epics is the feedback loop. → [epic (kickoff)](docs/plans/2026-07-15-mvp-roadmap-prd.md#epic-kickoff)
    - [ ] Reads the epic and its linked section; decision-complete → execution kickoff (story order, artifact target, demo exit)
    - [ ] Gaps in the section → grill only the gaps, fold answers back non-accretively
    - [ ] Placeholder skill replaced; description drops the not-yet-implemented notice

- [ ] **E8: demo-ideas skill** — every shipped epic gets something showable; demo requests are the user-signal channel. → [demo-ideas](docs/plans/2026-07-15-mvp-roadmap-prd.md#demo-ideas)
    - [ ] Reads Workflow + hero example + actual build state; proposes 2–3 demos with runnable steps
    - [ ] Placeholder skill replaced; description drops the not-yet-implemented notice

- [ ] **E9: delegate skill** — implementation goes to the cheapest capable tier while judgment stays in the main loop. → [delegate](docs/plans/2026-07-15-mvp-roadmap-prd.md#delegate)
    - [ ] Tier-selection rules and verify-by-owner discipline as a full skill
    - [ ] Placeholder skill replaced; description drops the not-yet-implemented notice

- [ ] **E10: Claude Code plugin packaging** — `.claude-plugin/` manifest and marketplace listing for subscribe-rather-than-fork installs. → [Distribution](docs/plans/2026-07-15-mvp-roadmap-prd.md#distribution)
    - [ ] Plugin manifest and `/plugin marketplace add oxmonty/product-engineering-skills` verified
    - [ ] README documents the two install philosophies (hackable copy vs managed bundle)

**Future (considered, unscheduled)**: automated eval runs in CI via the skill-creator harness ([here](docs/plans/2026-07-15-mvp-roadmap-prd.md#validation-strategy)); Codex-native plugin manifest ([here](docs/plans/2026-07-15-mvp-roadmap-prd.md#distribution)).
