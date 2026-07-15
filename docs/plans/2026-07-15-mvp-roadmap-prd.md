# mvp-roadmap — PRD

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
mvp-roadmap:
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

### Future: additional skills

The `skills/<name>/` layout means a second skill is a sibling directory sharing the repo's CI, linter, and release pipeline — no restructure. What a second skill *would* force is domain grouping (`skills/<domain>/<name>/`, mattpocock-style) and a README reference table; both are deferred until a second skill exists.

## Surfaces

| Surface | Primary user | What's on it |
|---|---|---|
| Claude Code skill | human dev | `/mvp-roadmap` user-invoked interview; model-invoked for tick-offs and doc updates |
| skills.sh install | human dev | `npx skills add oxmonty/mvp-skills` copies a hackable version into the project |
| `.skill` release artifact | claude.ai user | packaged bundle attached to GitHub Releases, importable via Save skill |
| Other Agent-Skills harnesses | human dev | inherited for free via skills.sh; no harness-specific code |

**Surface-specific (deliberate non-parity):** the structured multiple-choice interview exists only where a question tool exists; elsewhere the skill falls back to plain-text single questions. Parity of *process*, not of widget.

## Validation strategy

Validating a skill means validating documents it produces and edits it makes — both mechanically checkable — plus interview quality, which needs eyes. Three tiers, plus self-hosting as the standing proof:

1. **Doc invariants** (primary/cheap/objective) — `scripts/check-doc.sh`: accretion tells absent from body text, all roadmap links resolve, MVP line present, ≤6 stories/epic, every epic links to a real section. Runs in CI on this repo's own docs.
2. **Golden-brief evals** (the metric that matters) — three committed briefs (CLI tool, hosted API, library) run through create mode; outputs must pass tier 1 plus per-brief expectations (skip logic fired correctly, walking-skeleton E1 present). Update-mode fixtures assert tick discipline and edit propagation.
3. **Transcript review** (tertiary, human) — per golden brief, one recorded transcript reviewed against the interview rules: one decision per turn, recommendation always offered, no survey-answerable questions.

Shipped as: `./scripts/check-doc.sh <files>` in CI, plus `tests/` run manually via the skill-creator harness → pass/fail table in the release notes.

## Features

### Create mode
The phased interview specified in `references/decision-tree.md`: ten phases in dependency order, positioning-clause gate, propose-don't-ask trap elicitation, roadmap synthesized last. Output shape decision (single file vs split) is the final question, with the split recommended for repos.

### Update mode
Anti-accretive editing per `references/editing-rules.md`: prime directive (rewrite as if written correctly from the beginning), edit propagation across section → linked stories → echoes, propose-then-tick with executed evidence, checkbox-only tick diffs.

### Doc linter
`scripts/check-doc.sh` extracts the skill's self-check into a standalone, CI-runnable script — usable by *target* projects too, which makes it the skill's only executable deliverable and its clearest differentiator.

**Deviation to explore:** superpowers and mattpocock's skills treat plan documents as write-once artifacts that downstream skills consume; mvp-roadmap treats the document as the mutable system of record with enforced editing discipline. The measurable claim: a project maintained via update mode shows zero accretion-grep hits over its life, verified by the self-hosting gate on this repo.

### Scope
**In scope:** create mode, update mode, doc linter, evals, two install channels.
**Future work (considered, not scheduled):** plugin packaging (E5); CI-automated evals (manual runs are cheap at this scale); additional skills as sibling `skills/` directories (none exists yet).
**Out of scope:** implementation planning, TDD orchestration, issue-tracker integration — superpowers and mattpocock's skills own the process; mvp-roadmap deliberately stops at the document boundary and composes with them.

## Project structure

The layout follows superpowers' shape (skills under `skills/`, repo tooling in `scripts/`, fixtures in `tests/`, agent-facing repo instructions at root), so adding a second skill is a new directory, not a restructure:

```
mvp-roadmap/
├── skills/
│   └── mvp-roadmap/
│       ├── SKILL.md             # the skill itself
│       ├── references/          # decision-tree.md, editing-rules.md — loaded on demand
│       └── assets/mvp-template.md
├── scripts/check-doc.sh         # doc linter (tier-1 validation); repo tooling, not skill payload
├── tests/                       # golden briefs + fixtures for create/update-mode evals
├── docs/plans/                  # dated PRDs — this file lives here; the repo dogfoods its own convention
├── .claude-plugin/              # plugin manifest (lands with E5)
├── .github/workflows/           # ci.yml (gates), release.yml (.skill packaging)
├── CLAUDE.md / AGENTS.md        # instructions for agents working on this repo — including "maintain docs via the mvp-roadmap skill"
├── README.md                    # install + pitch; points at ROADMAP.md
└── ROADMAP.md                   # living, root, undated
```

Principles: SKILL.md stays under ~150 lines with depth pushed to references/; skill payload (`skills/mvp-roadmap/`) is strictly separated from repo tooling (`scripts/`, `tests/`) — only the payload ships to users; the linter is the only code — everything else is prose; the repo's own docs pass the repo's own linter (self-hosting is a required CI gate, not a demo); paths inside the skill are relative to the skill directory, so it survives being copied into target projects.

## Distribution

Channels: skills.sh (public repo with skills under `skills/` is the discoverable shape — the same layout mattpocock and superpowers ship), and GitHub Releases carrying the packaged `mvp-roadmap.skill` for claude.ai import. Release automation: tag push → package `skills/mvp-roadmap/` → attach artifact.

**Naming note:** the repo lives at `oxmonty/mvp-skills`; skills.sh addresses by `owner/repo`, so `npx skills add oxmonty/mvp-skills` is the whole install string and the repo path is the only thing it pins. The repo hosts a single skill, `mvp-roadmap` (`skills/mvp-roadmap/`), invoked as `/mvp-roadmap` — the repo path is just the address; the skill keeps the signature name, clean as a slash command. No package-registry presence is planned, which removes the usual npm/PyPI check. Verified by the E1 clean-install story rather than by assertion.

## CI/CD

**Quality gates (every PR):** SKILL.md frontmatter validation, markdownlint, `check-doc.sh` against ROADMAP.md and the current PRD, link check. All required.

**Versioning:** semver git tags; a breaking change is anything that alters the documented interview contract or the linter's pass/fail behavior on previously-passing docs. <!-- accretion-ok: versioning policy, "previously-passing" is spec not history -->

```
tag push (vX.Y.Z) ──▶ package mvp-roadmap.skill ──▶ GitHub Release + artifact ──▶ release notes include eval pass/fail table
```

**Secrets & signing:** none — `GITHUB_TOKEN` with default scopes covers releases; nothing is published to external registries.

## Additional design considerations

- **Harness portability**: every instruction in SKILL.md must be executable by an agent with only file tools and plain text — widget use is an enhancement, never a dependency.
- **Template versioning**: `assets/mvp-template.md` changes alter what "valid" means; template changes bump minor at least and get a linter update in the same PR.
- **No telemetry**: the skill is prose; it observes nothing and phones nowhere. Stated so it never becomes ambiguous.

## Competitive landscape

Spec-Kit, BMAD, and GSD own the development process end-to-end, which makes their failures hard to debug and their opinions hard to escape. superpowers is composable but is a full methodology; mattpocock's skills grill well but leave document maintenance undisciplined — nothing in the landscape addresses the doc-rot problem (accretive editing, stale checklists, broken anchors) as its core concern. mvp-roadmap's pitch: *the document is the product* — one skill that writes a decision-complete spec and is the only thing allowed to edit it. The linter operationalizes adoption: any existing project can run `check-doc.sh` on its docs today and see the rot before installing anything.

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

- Does skills.sh index root-level SKILL.md repos without extra manifest metadata? (Resolved by E1's clean-install story — blocks nothing else.)
- Should `check-doc.sh` ship as a separately-installable script for non-users of the skill? (Resolved by whether anyone asks after v0.1 — blocks nothing; noted because it changes the Distribution section if yes.)
- Does create mode ask the output-shape choice as the final question, after roadmap synthesis? An api-brief eval run put it one turn early, a Phase 9/10 slip. (Resolved by the cli and library eval runs — a repeat means the decision-tree's closing cue needs sharpening.)
