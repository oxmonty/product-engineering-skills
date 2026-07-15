# {{ project_name }}

> Repo: {{ repo_url }}

<!-- MVP DESCRIPTION — 1–3 sentences. Formula: what it is (artifact + language/platform),
     what it takes in and puts out, and the one-line positioning against the incumbent
     or gap it fills. If you can't write the positioning clause, the MVP isn't defined yet. -->
{{ one_paragraph_description }}

```
{{ hero_usage_example }}   <!-- the single command/call that demonstrates the core loop -->
```

Usable as:
- **{{ surface_1 }}**: {{ e.g. library — the pure public API entrypoint and its signature }}
- **{{ surface_2 }}**: {{ e.g. CLI — the top-level commands }}

---

## Roadmap

> **Format conventions** (how to fill this section — keep this blockquote in the template, delete it from instantiated docs once the team knows the rules):
> - **Epics** are task-list items `- [ ] **E<n>: Name** — outcome`, each a single sentence stating what is true when the epic is done — ordered by dependency, not by excitement.
> - **Stories** are task-list one-liners indented under their epic: each independently shippable, verifiable, small enough for one PR, and tickable as work lands.
> - **E1 is usually a walking skeleton**: the product installs through every planned distribution channel and runs end-to-end while doing almost nothing — this proves CI, releases, and packaging before any feature exists, and every later epic ships through pipes that already work.
> - Every epic (and story where useful) **links to the design subheading that specifies it** — the roadmap says *what and in what order*; the linked section says *how*. If a story has no section to link to, either the design is missing or the story is speculative.
> - A horizontal rule marks the **MVP line**: everything above it constitutes the smallest releasable product; below is post-MVP, and "Future" items are considered-but-unscheduled.
> - Keep the roadmap near the top of the doc — it doubles as the table of contents — and update links when headings change.
> - Cap epics at ~6 stories; a larger epic is two epics, and its linked design section probably needs splitting too.

- [ ] **E1: {{ epic_name }}** — {{ one_line_outcome_statement }}. → [{{ linked_section }}](#{{ anchor }})
    - [ ] {{ story_one_liner }}
    - [ ] {{ story_one_liner }}

- [ ] **E2: {{ epic_name }}** — {{ outcome }}. → [{{ linked_section }}](#{{ anchor }})
    - [ ] {{ story_one_liner }}

<!-- ...continue E3..En for everything MVP-required... -->

---
*MVP line — E1–E{{ n }} ship as v0.1: {{ smallest_releasable_product_in_one_clause }}.*

- [ ] **E{{ n+1 }}: {{ post_mvp_epic }}** — {{ outcome }}. → [{{ linked_section }}](#{{ anchor }})
    - [ ] {{ story_one_liner }}

**Future (considered, unscheduled)**: {{ future_item }} ([here](#{{ anchor }})); {{ future_item }} ([here](#{{ anchor }})).

---

## Workflow

<!-- Sits directly after the roadmap because epics/stories link into these loops —
     the reader goes "what we're building, in what order" straight into "how it flows
     end to end". For each core loop: a fenced ASCII pipeline of the happy path,
     config examples users actually copy-paste, and an "implementation traps"
     list — the 2–4 gotchas that would silently break it (auth tokens, ordering,
     determinism, cache invalidation...). Traps are the highest-value content in the doc. -->

### {{ primary_workflow_name }}

```yaml
# {{ config_file_name }}
{{ minimal_config_example }}
```

```
{{ ascii_pipeline_of_happy_path }}
```

Implementation traps:
- {{ trap_and_its_fix }}
- {{ trap_and_its_fix }}

### Future: {{ deferred_workflow }}

{{ how_current_design_keeps_it_cheap_later — the "API discipline now, feature later" note }}

---

## Surfaces

<!-- Every place the product manifests — web app, CLI, TUI, API, library, mobile,
     MCP server, editor extension, CI action — and what's on each. This is the
     section that catches seam bugs: capabilities that exist on one surface but not
     another, or views nobody owns. Rules:
     - One row (or subsection) per surface: what it's for, what views/commands/
       endpoints it exposes, and its primary user (human dev, CI, agent, end user).
     - For UI surfaces, enumerate views/screens as one-liners: the data shown and
       the 1–2 primary actions on each. If a view needs a paragraph, it needs a
       design section — link it.
     - Mark capability parity deliberately: shared core vs surface-specific, so
       "why can't the CLI do X" has a written answer.
     - The "Usable as" bullets at the top of the doc are this section's summary —
       keep them in sync. -->

| Surface | Primary user | What's on it |
|---|---|---|
| {{ surface }} | {{ who }} | {{ views/commands/endpoints_one_liner }} |

**Surface-specific (deliberate non-parity):** {{ capability }} only on {{ surface }} because {{ reason }}.

---

## Validation strategy

<!-- How you'll know the MVP is *good*, not just done. Pick the validation model(s)
     that fit the product — most MVPs combine two or three:
     - COMPETITOR BENCHMARK: parity/quality vs a named incumbent (biscuit model) —
       state why naive metrics (e.g. textual diff %) fail and what you measure instead.
     - GOLDEN / INTEGRATION TESTS: known inputs → committed expected outputs; the
       output must also *work* (compile, run, round-trip), not just match.
     - PERFORMANCE BENCHMARKS: latency/throughput/memory with a stated budget and a
       committed bench harness, so regressions fail CI rather than get noticed.
     - CORRECTNESS / CONFORMANCE SUITE: a spec or standard to conform to; track %
       of the suite passing.
     - USER-FACING METRICS: activation, task completion, time-to-first-success —
       only if the MVP will have real users before v0.2.
     Whichever you pick: define 2–3 measurable tiers in order of value, name the
     reference target (incumbent, dataset, budget), end with the command/process
     that produces the number and where it gets published. -->
{{ validation_models_chosen_and_reference_target_and_why }}

1. **{{ metric_tier_1 }}** ({{ primary/cheap/objective }}) — {{ how_measured }}
2. **{{ metric_tier_2 }}** ({{ the_metric_that_matters }}) — {{ how_measured }}
3. **{{ metric_tier_3 }}** ({{ tertiary }}) — {{ how_measured }}

Shipped as: `{{ validation_command }}` → {{ report_artifact }}.

---

## Features

<!-- One ### subsection per feature area. Each subsection is the *specification* a
     roadmap story links to — write it decision-complete: syntax/grammar first,
     then a table or list of behaviors, then deliberate deviations from prior art
     (marked, with the measurable claim they enable). Include a "scope" subsection
     stating what is in, future, and out — with reasons, so scope debates end here. -->

### {{ feature_area_1 }}

{{ specification }}

### {{ feature_area_2 }}

| {{ input_shape }} | {{ syntax_or_behavior }} |
|---|---|
| {{ ... }} | {{ ... }} |

**Deviation to explore:** {{ where_you_intentionally_differ_from_incumbent_and_how_youll_measure_it }}

### Scope

**In scope:** {{ what_and_why }}
**Future work (considered, not scheduled):** {{ what_and_the_cost_that_defers_it }}
**Out of scope:** {{ what_and_the_reason_it_stays_out }}

---

## API design

<!-- Include when the MVP exposes an API (backend service, hosted product, or a
     library whose public API is the product). API-first discipline:
     - SPEC AS SOURCE OF TRUTH: the OpenAPI/proto/schema file is committed and
       reviewed *before* handlers exist; clients, docs, and mocks generate from it.
       Name the spec's path in the repo.
     - RESOURCE TABLE: method, path, purpose — one line each. Nesting and naming
       conventions stated once, not per-endpoint.
     - AUTH MODEL: scheme(s), token lifetimes, scopes; which endpoints are public.
     - CONVENTIONS: error envelope (one shape, shown once), pagination, idempotency
       keys for mutations, rate-limit headers.
     - VERSIONING & COMPATIBILITY: URL vs header versioning, what counts as a
       breaking change, deprecation window, breaking-change detection in CI.
     - For a library-as-product: the exported types/functions and the promise —
       what's stable, what's internal, what the deprecation policy is. -->

Spec: `{{ path/to/openapi.yaml }}` — committed before implementation; {{ what_generates_from_it }}.

| Method | Path | Purpose |
|---|---|---|
| {{ VERB }} | {{ /resource }} | {{ one_liner }} |

**Auth:** {{ scheme_scopes_lifetimes }}
**Conventions:** {{ error_envelope, pagination, idempotency }}
**Versioning:** {{ policy_and_breaking_change_detection }}

---

## Project structure

```
{{ project_slug }}/
├── {{ ... }}                # {{ what_lives_here }}
└── {{ ... }}
```

Principles: {{ the_3_5_structural_rules_that_survive_refactors — e.g. small public API,
internal/ for everything else, tests-as-golden-files, CI check that matters most }}

### {{ pipeline_or_runtime_model }}

<!-- If the MVP has a processing pipeline: phases, their concurrency/ordering
     boundaries, the invariant that removes synchronization, determinism rules. -->
{{ phases_and_invariants }}

## {{ output_or_artifact_structure }}

<!-- If the MVP emits artifacts (repos, files, reports): their structure, and which
     prior-art shape they deliberately mirror. -->

---

## Distribution

<!-- How users get it: package managers, install commands, release automation,
     signing/secrets handling. Include the naming-collision check results. -->
{{ channels_and_release_automation }}

**Naming note:** {{ registry_availability_findings_and_decision }}

---

## CI/CD

<!-- How the project *itself* is built, gated, versioned, and released — distinct from
     Distribution (how users install) though the two meet at the publish step. Cover:
     - QUALITY GATES: what runs on every PR (lint, unit, golden/integration, the
       one check that matters most for this product), and which gates are required.
     - VERSIONING: scheme (semver) and what drives bumps (conventional commits,
       release automation, or domain-specific rules like breaking-change detection).
     - RELEASE FLOW: the trigger → build → publish pipeline as one fenced diagram,
       naming the automation (e.g. release-please → tag → goreleaser → registries).
     - SECRETS & SIGNING: where publish credentials live (scoped environments, OIDC
       over long-lived tokens), what gets signed/notarized.
     - ENVIRONMENTS: if there's anything deployed (docs site, hosted API), how
       staging/prod promotion works. Omit if N/A. -->

**Quality gates (every PR):** {{ checks_and_which_are_required }}

**Versioning:** {{ scheme_and_what_drives_bumps }}

```
{{ release_flow_diagram — trigger → build → publish }}
```

**Secrets & signing:** {{ credential_and_signing_posture }}

---

## Additional design considerations

<!-- The cross-cutting one-liners that don't own a section but bite if forgotten:
     retries, error/exit contracts, secret handling, telemetry stance, generated tests.
     One bold-led bullet each, with the reason it matters. -->
- **{{ consideration }}**: {{ decision_and_why }}

## {{ competitive_landscape_section }}

<!-- Incumbent gaps, unshipped promises, and the migration/adoption opportunity.
     End with the pitch line and, if one exists, the candidate command that
     operationalizes migration. -->
{{ gaps_and_opportunity }}

## Tech stack

- {{ language_with_one_line_rationale }}
- {{ key_dependency }} ({{ role }}), {{ ... }}

## Reference codebases

| Project | Lesson |
|---|---|
| {{ repo }} | {{ the_one_thing_to_steal_and_when_to_consult_it }} |

## License

{{ license_choice + patent/trademark/output-ownership_posture + the_decide-before-contributions_warning }}

## Open questions

<!-- Only questions with a forcing function — note what decision each blocks and
     what evidence (benchmark, availability check, spike) resolves it. Resolved
     questions move into their section; this list should shrink toward zero by v0.1. -->
- {{ question }} ({{ what_resolves_it }})
