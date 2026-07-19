# product-engineering-skills

> Repo: https://github.com/oxmonty/product-engineering-skills

product-engineering-skills is a collection of agent skills (Agent Skills standard, Markdown) that carries a product from idea to shipped artifact. The entrypoint, `/mvp`, interviews you section-by-section into a decision-complete document set — a living `ROADMAP.md` and a dated PRD — and the companion skills run the build loop against those documents: `/epic` kicks off an epic from its spec, `/delegate` hands implementation down, `/spike` settles design questions with measured evidence, `/regression` pins finished features against silent breakage, `/demo-ideas` turns finished work into something showable, and `/wrap-up` closes the day with anti-accretive doc updates and propose-then-tick honesty. Unlike process-owning frameworks (BMAD, Spec-Kit) or full methodologies (superpowers), the collection owns the document and the loop around it — small, hackable skills producing a single source of truth.

```
npx skills add oxmonty/product-engineering-skills --all -g   # install the collection
/mvp          # in any repo or empty dir: interview → ROADMAP.md + docs/plans/<date>-prd.md
/epic E1      # kick off an epic against its PRD section
/wrap-up      # close the day: propose ticks, update docs, summarize
```

Usable as:
- **Claude Code skills**: user-invoked `/mvp`, `/epic`, `/demo-ideas`, `/wrap-up`, `/delegate`, `/spike`, `/regression`; update mode is also model-invoked for tick-offs and doc edits.
- **Packaged `.skill` bundles**: one per skill, attached to GitHub Releases for claude.ai import.
- **Any Agent-Skills harness**: Codex and others, via the skills.sh installer.

---

## Roadmap

Each epic's stories, status, and spec link live in its file under [`docs/epics/`](docs/epics/); this list is the order and the MVP cut.

- [x] **E1: Walking skeleton** — the flagship skill installs through both planned channels and triggers end-to-end in a clean project. → [E1](docs/epics/E01-walking-skeleton.md)
- [x] **E2: Doc linter** — `scripts/check-doc.sh` mechanically enforces the document invariants the skills promise. → [E2](docs/epics/E02-doc-linter.md)
- [x] **E3: Create-mode evals** — golden briefs prove the `/mvp` interview produces valid documents without hand-holding. → [E3](docs/epics/E03-create-mode-evals.md)
- [x] **E4: Update-mode evals** — the tick protocol and edit propagation behave under test; they pin `/wrap-up`'s editing behavior. → [E4](docs/epics/E04-update-mode-evals.md)
- [x] **E5: /mvp entrypoint** — the flagship skill is the collection's front door, and its roadmaps are artifact-first. → [E5](docs/epics/E05-mvp-entrypoint.md)
- [x] **E6: wrap-up skill** — one command closes a working session with honest documents. → [E6](docs/epics/E06-wrap-up-skill.md)

---
*MVP line — E1–E6 ship as v0.1: the loop's core — `/mvp` writes the documents, `/wrap-up` keeps them truthful, the linter and evals prove both.*

- [x] **E7: epic skill** — `/epic E<n>` kicks off an epic from its PRD section; dogfooding on this repo's own epics is the feedback loop. → [E7](docs/epics/E07-epic-skill.md)
- [x] **E8: demo-ideas skill** — every shipped epic gets something showable; demo requests are the user-signal channel. → [E8](docs/epics/E08-demo-ideas-skill.md)
- [x] **E9: delegate skill** — implementation goes to the cheapest capable tier while judgment stays in the main loop. → [E9](docs/epics/E09-delegate-skill.md)
- [x] **E10: Claude Code plugin packaging** — `.claude-plugin/` manifest and marketplace listing for subscribe-rather-than-fork installs. → [E10](docs/epics/E10-plugin-packaging.md)
- [x] **E11: Dogfooding sharpenings** — the loop absorbs the first round of field feedback: core-first walking skeletons, brownfield create mode, session-memory reads, and tightened exit criteria. → [E11](docs/epics/E11-dogfooding-sharpenings.md)
- [x] **E12: spike skill** — `/spike` settles one design question with measured evidence and a decision matrix folded into the PRD. → [E12](docs/epics/E12-spike-skill.md)
- [x] **E13: regression skill** — `/regression` pins each epic's feature with a layered suite whose green run gates the tick. → [E13](docs/epics/E13-regression-skill.md)

**Future (considered, unscheduled)**: automated eval runs in CI via the skill-creator harness ([here](docs/plans/2026-07-15-prd.md#validation-strategy)); Codex-native plugin manifest ([here](docs/plans/2026-07-15-prd.md#distribution)).
