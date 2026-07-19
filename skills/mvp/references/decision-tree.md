# Interview decision tree

Phases run in dependency order — later questions are unanswerable (or wrong) without earlier answers. Each phase lists: the template section it produces, the questions to resolve, the trade-off to probe, and its skip condition. "Q" means ask; "Infer" means derive from context/codebase and confirm only if uncertain.

Throughout: one decision point per question-tool call, always with a recommended option and the reason in one clause.

## Phase 1 — Identity → *title, description, hero example*

- Q: What is it, in the template's formula — artifact + language/platform, input → output, positioning clause against the incumbent/gap?
- Gate: if the positioning clause won't come, stop and work it out. Offer 2–3 candidate positionings you'd argue for, as options.
- Q: The hero usage example — the single command/call demonstrating the core loop. Propose one; let the user correct it.
- Repo URL (the `> Repo:` header): if the survey found a git remote, use it without asking. Otherwise ask once whether they already have a repo URL; if they don't, write a placeholder (`> Repo: <tbd>`) and propose an `owner/name` from the Phase 8 naming check — never fabricate a URL.
- Trade-off probe: what is deliberately worse than the incumbent? (An MVP with no accepted weakness is an undefined MVP.)

## Phase 2 — Surfaces → *Surfaces table, "Usable as" bullets*

- Q (multi-select): which surfaces at MVP — library, CLI, API, web, TUI, MCP server, CI action, editor extension?
- Infer: primary user of each (human dev / CI / agent / end user).
- Trade-off probe: for each capability that could exist on multiple surfaces, shared-core parity vs surface-specific. Record deliberate non-parity with its reason — this line is what ends future "why can't the CLI do X" debates.
- Q only if 2+ surfaces: which surface is the product and which is the wrapper?

## Phase 3 — Core workflow → *Workflow section*

- Infer + confirm: the happy path as an ASCII pipeline. Draft it; the user corrects a picture faster than they answer prose questions.
- Q: config file shape — name, format, the minimal example a user copy-pastes.
- **Traps interview** (highest-value content in the doc): propose 3–5 candidate implementation traps yourself — auth token lifetimes, ordering, determinism, cache invalidation, idempotency, encoding — based on the domain. Ask which are real and what's missing. Do not ask the user to produce traps cold.
- Skip: "Future workflow" subsection — infer from anything the user deferred in Phases 1–2; one line on what API discipline keeps it cheap later.

## Phase 4 — Validation → *Validation strategy*

- Q (multi-select, recommend 2–3): which validation models — competitor benchmark, golden/integration tests, performance benchmarks, conformance suite, user-facing metrics?
- Q per chosen model: the reference target (named incumbent, dataset, budget number).
- Trade-off probe: why does the naive metric fail? (e.g., textual diff % rewards the wrong thing). Force the answer into tier definitions.
- Infer: the `validation_command` from the tech stack; confirm.

## Phase 5 — Features & scope → *Features, Scope*

- Q: enumerate feature areas (offer your inferred list to edit, not a blank page).
- Per area, only where it matters: the one deviation from prior art worth exploring, and the measurable claim it enables. Skip areas that are straight ports.
- Q (the scope grill — this is where trade-offs live): for each borderline capability, in / future / out, with the reason. Push back once when "in scope" grows past what the MVP line can carry; accept the user's second answer.

## Phase 6 — API design → *API design*  — SKIP unless an API/library surface exists (Phase 2)

- Infer: spec path convention from the stack (openapi.yaml, proto, exported types).
- Q: auth model, only if the API is networked.
- Infer + confirm: conventions (error envelope, pagination, idempotency) and versioning policy — propose defaults from the ecosystem's norms.
- Library-as-product variant: ask what's stable vs internal, and the deprecation promise.

## Phase 7 — Structure & stack → *Project structure, Tech stack, Reference codebases*

- Infer almost everything from the repo if one exists; otherwise propose a layout and let the user edit.
- Q: the 3–5 structural principles that survive refactors. Offer candidates.
- Q: reference codebases — which repos to steal from and the one lesson each. The user usually has these loaded; this question is cheap and high-yield.
- Skip: pipeline/runtime model and artifact structure subsections unless the product has a pipeline or emits artifacts.

## Phase 8 — Distribution & CI/CD → *Distribution, CI/CD*

- Do, don't ask: check name availability on the relevant registries; report findings in the Naming note.
- Q (multi-select): channels — package registries, Homebrew, GHCR, curl-install.
- Infer + confirm: release automation appropriate to the stack (e.g., release-please → tag → goreleaser), quality gates, versioning driver, secrets posture (recommend OIDC over long-lived tokens by default).
- Infer + confirm: the first release tag — `0.1.0` by default (the 0.x major already signals instability); offer `0.1.0-alpha.1` only when staging toward a gated stable release.

## Phase 9 — Roadmap synthesis → *Roadmap*  — derived, not interviewed

Follow Step 2 in SKILL.md. The only questions: MVP-line placement, and confirmation of the epic order. On a brownfield repo (feature inventory in Step 0), E1 is characterization coverage of the existing baseline rather than a walking skeleton — see SKILL.md. Every epic above the MVP line carries a shippable artifact as its exit criterion (pushed repo, published package, live URL, cut release); epics below the line name the feedback loop they open (who uses it, what signal is collected).

## Phase 10 — Closing → *License, Open questions, output shape*

Nothing in this phase is asked until the Phase 9 roadmap is confirmed — license, open questions, and output shape are the interview's last three moves, in that order, shape always the final question. (Interviews reliably drift toward asking license early; hold the boundary.)

- Q: license, with a recommendation fitted to the product's adoption strategy; note the decide-before-contributions warning.
- Compile Open questions: only items with a forcing function, each annotated with the decision it blocks and what evidence resolves it. Anything resolved during the interview does not appear here.
- Q: output shape — single `MVP.md` vs `ROADMAP.md` + `PRD.md` split (recommendation logic in SKILL.md Step 3).
