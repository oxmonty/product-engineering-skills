# product-engineering-skills — PRD

> Dated: 2026-07-15 · Living roadmap: [`ROADMAP.md`](../../ROADMAP.md) · Status: pre-v0.1

## Workflow

### Create mode

```
survey repo/context ──▶ phased interview ──▶ draft section per phase ──▶ synthesize roadmap ──▶ emit files
  (no questions)         (one decision/turn,     (user confirms while      (derived, not asked;     ROADMAP.md +
                          recommendation always)  misreads are cheap)       MVP line confirmed)      docs/plans/<date>-prd.md
```

```yaml
# no config file — the skill's inputs are the conversation and the working directory.
# Behavioral preferences (e.g. auto-tick trust) are recorded in the target project's CLAUDE.md:
mvp:
  tick_mode: propose   # propose | auto
```

Implementation traps:
- **Question-tool divergence across harnesses** — Claude Code has `AskUserQuestion`, claude.ai has its own widget, bare Codex has neither. The skill must specify plain-text one-question-at-a-time as the universal fallback, or interviews silently degrade into question walls.
- **Skipping the survey** — the highest-frequency failure is interrogating the user about facts sitting in the repo. Step 0 is worded as a hard precondition; evals in E3 assert no survey-answerable questions appear in transcripts.
- **Anchor rot** — roadmap links break silently when headings are reworded, and cross-file links (`docs/plans/…#anchor`) rot in two ways (path and fragment). The linter, not vigilance, is the defense.
- **Accretion-grep false positives** — deprecation *policy* prose legitimately contains "deprecated"; the linter needs an allowlist mechanism or it trains users to ignore it.

### Update mode

```
read ROADMAP.md fully ──▶ do the work ──▶ diff reality vs roadmap ──▶ propose ticks + evidence ──▶ user confirms ──▶ tick (checkbox chars only) ──▶ accretion self-check
```

The tick protocol and edit-propagation rules are specified in the skill itself (`references/editing-rules.md`); this repo's E4 evals pin their behavior.

### The build loop

The documents `/mvp` emits are step one of a loop the collection runs end to end:

```
idea ──/mvp──▶ ROADMAP + PRD ──/epic──▶ execution kickoff ──build (/delegate)──▶ artifact ──/demo-ideas──▶ something showable
                    ▲                                                                                            │
                    └──────────────────────────── /wrap-up (ticks, doc updates, summary) ◀───────────────────────┘
```

Each companion skill is specified in [Features](#features). Skills stay flat under `skills/<name>/` — they share one domain, so domain grouping would add a directory level for nothing — and every skill must be self-contained when copied: no file references across skill directories, because installers copy skills individually.

## Surfaces

| Surface | Primary user | What's on it |
|---|---|---|
| Claude Code skills | human dev | `/mvp` interview plus companions `/epic`, `/demo-ideas`, `/wrap-up`, `/delegate`, `/spike`, `/regression`; model-invoked for tick-offs and doc updates |
| skills.sh install | human dev | `npx skills add oxmonty/product-engineering-skills` copies hackable versions of every skill into the project |
| `.skill` release artifacts | claude.ai user | one packaged bundle per skill attached to GitHub Releases, importable via Save skill |
| Other Agent-Skills harnesses | human dev | inherited for free via skills.sh; no harness-specific code |

**Surface-specific (deliberate non-parity):** the structured multiple-choice interview exists only where a question tool exists; elsewhere the skill falls back to plain-text single questions. Parity of *process*, not of widget.

## Validation strategy

Validating a skill means validating documents it produces and edits it makes — both mechanically checkable — plus interview quality, which needs eyes. Three tiers, plus self-hosting as the standing proof:

1. **Doc invariants** (primary/cheap/objective) — `scripts/check-doc.sh`: accretion tells absent from body text, all roadmap links resolve, MVP line present, ≤6 stories/epic, every epic links to a real section. Runs in CI on this repo's own docs.
2. **Golden-brief evals** (the metric that matters) — three committed briefs (CLI tool, hosted API, library) run through create mode; outputs must pass tier 1 plus per-brief expectations (skip logic fired correctly, walking-skeleton E1 present). Update-mode fixtures assert tick discipline and edit propagation, in both the inline-roadmap and epic-file layouts (a tick must land in the epic's own file).
3. **Transcript review** (tertiary, human) — per golden brief, one recorded transcript reviewed against the interview rules: one decision per turn, recommendation always offered, no survey-answerable questions.

Shipped as: `./scripts/check-doc.sh <files>` in CI, plus `tests/` run manually via the skill-creator harness → pass/fail table in the release notes.

## Features

### mvp (entrypoint)
The collection's front door, in two modes. Create mode is the phased interview specified in `references/decision-tree.md`: ten phases in dependency order, positioning-clause gate, propose-don't-ask trap elicitation, roadmap synthesized last with artifact-first epics — pre-MVP epics exit in a shippable artifact (pushed repo, published package, live URL, cut release), post-MVP epics name their feedback loop, E1 built core-primitive-first and shipping through one channel — and output shape as the final question. On a repo with working features, create mode opens with a feature inventory instead: the baseline is recorded as already-true specification, E1 becomes characterization coverage of it, and a single-feature request is pushed back into a full roadmap. It closes by printing the journey: the companion command to run at each later stage. Update mode is anti-accretive editing per `references/editing-rules.md`: prime directive (rewrite as if written correctly from the beginning), edit propagation across section → linked stories → echoes, propose-then-tick with executed evidence, checkbox-only tick diffs; `/wrap-up` is its user-invoked face.

### wrap-up
Session close as one command: read the roadmap fully, diff reality against it, propose ticks with one line of executed evidence each (confirm via structured question; the user is the verifier of record; an epic-completing tick includes its kickoff-named regression checks run and passing), tick checkbox characters only, apply non-accretive updates including the open-questions decision log, offer an epic write-up (`docs/write-ups/E<nn>-<slug>.md`, dated and append-only, with a fixed header set: What shipped, Try it yourself, Evidence, then Decisions made along the way, What surprised, and Left open where they apply — What shipped reads for junior and senior engineers alike and names what the work enables for developer and end user; Try it yourself is the handover, the exact steps the user runs to test the artifact, presented in chat with a pause for them to run it; the understanding loop continues until they could explain what shipped, handing to a teaching skill where one is installed) when an epic completed that session, verify with check-doc.sh where the project has it, summarize in chat, offer the closing commit, and recommend `/compact` when the conversation has grown long — a skill cannot compact the conversation itself — plus a fresh session for the next epic when one completed; the documents are the handoff. Ships self-contained: the operative tick protocol is inlined so the copied skill carries no cross-skill file references.

### epic (kickoff)
`/epic E<n>` starts an epic from its spec rather than re-interviewing: read the epic, its linked PRD section, and the write-ups of completed epics it builds on — in a fresh session those are the only memory of past decisions. If the section is decision-complete — and still true where it rests on external facts that age — go straight to execution kickoff: story order, the artifact the epic exits with, the regression checks it leaves behind (layered per sub-section with edge cases, then the feature e2e, in the most appropriate framework — installed with permission rather than settled around, built via `/regression`), the demo that proves it done, and which stories go to `/delegate` or are really `/spike` questions — with the confirmed exit criteria (artifact, regression command, demo) recorded in the epic's own file under `## Exit criteria`, the written contract `/wrap-up` gates the tick against. If it has gaps, grill only the gaps and fold the answers back non-accretively. It never asks what the PRD already answers; plans and finished work are narrated in enablement terms legible to junior and senior engineers alike, and built work is reviewed before `/wrap-up` proposes ticks.

### demo-ideas
Reads the Workflow section, the hero example, and the actual build state, then proposes 2–3 demos sized to what exists today, each with runnable steps. Pre-MVP the demos prove the artifact is real — install it, hit the URL, run the hero command; post-MVP they are built to put the product in front of users and collect a signal.

### delegate
The full delegate-with-judgement doctrine, Claude-native by design: a concrete model ladder (haiku for mechanical edits, sonnet for well-specified implementation, opus for ambiguous or security-sensitive work; the top tier is never a subagent — it specs, reads every diff, and pushes back to the same agent until it passes), the inheritance trap called out (every spawn sets `model:` explicitly — subagents otherwise silently inherit the premium main model), fan-out cost mechanics (scoped file sets, `effort: low` for mechanical dimensions, capped return payloads), and a followable fan-out: every subagent named, labeled `<tier>: <role>`, with stable `color:` chips for recurring agent roles. This is the one skill that names concrete Claude tiers — on other harnesses the ladder degrades to small/mid/large. The subagent only types; the main model owns correctness.

### regression
`/regression` builds the suite that pins an epic's feature: one test layer per sub-section covering its edge cases, then the whole feature end to end through its real surface, in the most appropriate framework — reusing the repo's runner first, installing the right one with permission rather than settling. Tests pin behavior through public interfaces (the suite survives refactors and fails only on behavior change), the behavior list is confirmed with the user (critical paths first), and every test is observed failing at least once. The one-command run it leaves behind is the tick evidence `/wrap-up` demands; with a TDD skill driving development, `/regression` is the exit audit that completes the layers rather than a replacement for test-first.

### spike
`/spike` buys a decision, not a feature: name the one question and the decision it blocks (an Open Questions entry), set a timebox and the metrics that settle it, build the throwaway minimum that produces real numbers, and record a decision matrix — options against measured criteria. The decision folds back per the editing rules (answer recorded on the question, owning section rewritten as if always true); the code is discarded by default — kept only if the user promotes it to real, reviewed code.

### Doc linter
`scripts/check-doc.sh` extracts the collection's doc self-check into a standalone, CI-runnable script — usable by *target* projects too, which makes it the collection's only executable deliverable and its clearest differentiator.

**Deviation to explore:** superpowers and mattpocock's skills treat plan documents as write-once artifacts that downstream skills consume; this collection treats the document as the mutable system of record with enforced editing discipline. The measurable claim: a project maintained via update mode shows zero accretion-grep hits over its life, verified by the self-hosting gate on this repo.

### Scope
**In scope:** the seven skills (mvp, wrap-up, epic, demo-ideas, delegate, spike, regression), the doc linter, the eval suites, two install channels.
**Future work (considered, not scheduled):** plugin packaging (E10); CI-automated evals (manual runs are cheap at this scale).
**Out of scope:** test-first TDD orchestration (the inner red-green loop), issue-tracker integration, hosting or deployment automation — superpowers and mattpocock's skills own the inner development process; this collection owns the document and the loop around it — including the regression suite that gates an epic's tick — and composes with them.

## Project structure

The layout follows superpowers' shape (skills under `skills/`, repo tooling in `scripts/`, fixtures in `tests/`, agent-facing repo instructions at root), so adding a skill is a new directory, not a restructure:

```
product-engineering-skills/
├── skills/
│   ├── mvp/                     # entrypoint: SKILL.md + references/ (decision-tree, editing-rules) + assets/mvp-template.md
│   ├── wrap-up/                 # session close: SKILL.md (self-contained)
│   ├── epic/                    # epic kickoff (placeholder until its epic lands)
│   ├── demo-ideas/              # demos of current state (placeholder until its epic lands)
│   └── delegate/                # tiered delegation (placeholder until its epic lands)
├── scripts/check-doc.sh         # doc linter (tier-1 validation); repo tooling, not skill payload
├── tests/                       # golden briefs + fixtures for create/update-mode evals
├── docs/plans/                  # dated PRDs — this file lives here; the repo dogfoods its own convention
├── docs/epics/                  # one file per epic (E<n>-slug.md): stories, status, spec link; ROADMAP.md is the thin index
├── docs/write-ups/              # dated, append-only narrative per completed epic — history's sanctioned home, never linted
├── .claude-plugin/              # plugin manifest (lands with E10)
├── .github/workflows/           # ci.yml (gates), release.yml (.skill packaging)
├── CLAUDE.md / AGENTS.md        # instructions for agents working on this repo — including "maintain docs via these skills"
├── README.md                    # install + pitch; points at ROADMAP.md
└── ROADMAP.md                   # living, root, undated
```

Principles: each SKILL.md stays under ~150 lines with depth pushed to references/; skill payload (`skills/`) is strictly separated from repo tooling (`scripts/`, `tests/`) — only the payload ships to users; the linter is the only code — everything else is prose; the repo's own docs pass the repo's own linter (self-hosting is a required CI gate, not a demo); paths inside a skill are relative to that skill's directory and never cross into a sibling skill, so each survives being copied alone into target projects; the roadmap splits by churn — `ROADMAP.md` is the thin index carrying epic order and the MVP cut, while each epic's stories live in their own `docs/epics/` file, so a tick's blast radius is one epic's file and concurrent sessions never collide on shared lines.

## Distribution

Channels: skills.sh (public repo with skills under `skills/` is the discoverable shape — the same layout mattpocock and superpowers ship), GitHub Releases carrying one packaged `.skill` bundle per skill for claude.ai import, and a Claude Code plugin marketplace hosted by this repo (`.claude-plugin/`): one bundled plugin carrying all six skills — the loop is designed to be used together, so the managed channel installs it whole rather than à la carte. Release automation: tag push → package each `skills/<name>/` → attach artifacts.

**Naming note:** the repo lives at `oxmonty/product-engineering-skills`; skills.sh addresses by `owner/repo`, so `npx skills add oxmonty/product-engineering-skills` is the whole install string and the repo path is the only thing it pins. The repo name names the domain; each skill keeps its own short invocation name (`/mvp`, `/epic`, `/demo-ideas`, `/wrap-up`, `/delegate`, `/spike`, `/regression`), clean as slash commands. No package-registry presence is planned, which removes the usual npm/PyPI check. Verified by the E5 clean-install story rather than by assertion.

## CI/CD

**Quality gates (every PR):** SKILL.md frontmatter validation across every `skills/*/` (name must match its directory), markdownlint, `check-doc.sh` against ROADMAP.md and the current PRD, link check. All required.

**Versioning:** semver git tags; a breaking change is anything that alters the documented interview contract or the linter's pass/fail behavior on previously-passing docs. <!-- accretion-ok: versioning policy, "previously-passing" is spec not history -->

```
tag push (vX.Y.Z) ──▶ package one .skill per skills/<name>/ ──▶ GitHub Release + artifacts ──▶ release notes include eval pass/fail table
```

**Secrets & signing:** none — `GITHUB_TOKEN` with default scopes covers releases; nothing is published to external registries.

## Additional design considerations

- **Harness portability**: every instruction in SKILL.md must be executable by an agent with only file tools and plain text — widget use is an enhancement, never a dependency.
- **Template versioning**: `assets/mvp-template.md` changes alter what "valid" means; template changes bump minor at least and get a linter update in the same PR.
- **No telemetry**: the skill is prose; it observes nothing and phones nowhere. Stated so it never becomes ambiguous.

## Competitive landscape

Spec-Kit, BMAD, and GSD own the development process end-to-end, which makes their failures hard to debug and their opinions hard to escape. superpowers is composable but is a full methodology; mattpocock's skills grill well but leave document maintenance undisciplined — nothing in the landscape addresses the doc-rot problem (accretive editing, stale checklists, broken anchors) as its core concern. This collection's pitch: *the document is the product* — `/mvp` writes a decision-complete spec, the companion skills are the only things allowed to edit it, and the loop ends every epic in a shippable artifact. The linter operationalizes adoption: any existing project can run `check-doc.sh` on its docs today and see the rot before installing anything.

## Tech stack

- Markdown + YAML frontmatter (Agent Skills standard) — the skill is prose by design; zero runtime.
- Bash (`check-doc.sh`) — grep/awk suffice for the linter; no dependency footprint in target projects.
- GitHub Actions (CI + release), skill-creator harness (evals, dev-time only).

## Reference codebases

| Project | Lesson |
|---|---|
| mattpocock/skills | grilling discipline (one question, recommendation always); user- vs model-invoked split; setup-skill pattern for recording per-repo preferences |
| obra/superpowers | plans as cross-session memory; `docs/plans/YYYY-MM-DD-slug.md` convention; checkbox discipline with human checkpoints |
| anthropics skill-creator | progressive disclosure (metadata → body → references); eval/packaging tooling; pushy descriptions to combat under-triggering |

## License

MIT. Documents produced by the skill in target projects belong entirely to their authors — the license covers the skill, not its outputs. Decided now, before any contribution arrives.

## Open questions

- ~~Does skills.sh index repos in the `skills/` layout without extra manifest metadata?~~ **Resolved:** yes — E1's clean install (`npx skills add` of this repo in a clean directory) discovered and installed the skill with no manifest beyond SKILL.md frontmatter.
- Should `check-doc.sh` ship as a separately-installable script for non-users of the skill? (Resolved by whether anyone asks after v0.1 — blocks nothing; noted because it changes the Distribution section if yes.)
- ~~Does create mode hold the Phase 9/10 boundary — roadmap synthesis before the closing questions?~~ **Resolved:** it drifts — two of three golden-brief runs pulled a closing item ahead of roadmap synthesis (api: output shape; cli: license), while the library run held order. The decision-tree's Phase 10 now opens with a hard boundary cue (nothing in it before the roadmap is confirmed; shape always last), and the committed eval transcripts pin the expectation.
