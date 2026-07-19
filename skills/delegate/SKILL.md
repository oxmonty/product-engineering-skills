---
name: delegate
description: Delegate coding tasks to subagents on the cheapest model that can do each job well, keeping design, review, and synthesis in the main model. Use when the user says "delegate", "dwj", "use subagents", "use your judgement to delegate", "delegate to subagents of appropriate model", "fan out", "parallelize this", when running a multi-agent review, or when a turn contains several well-specified implementation tasks that don't need the main model's full power. Never use fable as a subagent model — fable reviews subagent work and pushes back.
---

# Delegate with Judgement

Match each subagent's model to the difficulty of its task. This is about
capability fit first; cost saving follows from it.

## The inheritance trap — always set the model explicitly

Subagents default to `model: inherit` — **when the main model is Fable, every
subagent you spawn without an explicit override silently runs Fable too.**
This is the number-one cause of ballooning cost.

- **Every Agent call MUST carry an explicit `model:` override.** No
  exceptions. If you catch yourself spawning without one, stop and pick a
  tier.
- Model resolution order: `CLAUDE_CODE_SUBAGENT_MODEL` env var → per-call
  `model` param → agent-definition frontmatter → inherit. The env var is a
  global clamp (it overrides even explicit per-call params) — suggest it to
  the user only as an emergency backstop for runaway sessions, not as the
  default strategy: `export CLAUDE_CODE_SUBAGENT_MODEL=sonnet`.

## Model ladder

Subagent `model:` accepts the aliases `haiku`, `sonnet`, `opus`, `fable`,
full model IDs, or `inherit`. Aliases resolve to the newest model in each
tier — prefer them; the resolved lineup and relative cost:

| Alias | Resolves to | Cost vs haiku | Use for |
|---|---|---|---|
| **haiku** | Haiku 4.5 (200K ctx) | 1× | Mechanical, precisely-specified edits: rename, delete dead code, apply an exact spec, doc updates, formatting, style/naming checks |
| **sonnet** | Sonnet 5 (1M ctx) | 3× | Substantive implementation with a clear spec: new functions, refactors, tests, multi-file changes, most review dimensions |
| **opus** | Opus 4.8 (1M ctx) | 5× | Ambiguous scope, long autonomous runs, concurrency, migrations, security-sensitive code, bug-hunting review |
| **fable** | Fable 5 (1M ctx) | 10× | **Main model only — never a subagent.** Design, review of subagent output, synthesis, final sign-off |

Older models (Opus 4.7/4.6/4.5, Sonnet 4.6/4.5) remain addressable by full
ID but cost the same as their tier's newest model — there is no reason to
delegate to them.

## Fable's role: review and push back

When the main model is Fable, it:

1. Specs and delegates implementation to haiku/sonnet/opus subagents.
2. Reads every diff the subagents produce.
3. Pushes back with specific, actionable feedback when work is wrong or
   incomplete — a follow-up message to the same subagent (SendMessage) with
   exactly what to fix, not a vague "try again."
4. Only reports done after the output passes its own review.

Fable's edge over Opus widens with task difficulty — which is why it belongs
in the judgment seat. Burning it on implementation wastes the premium on work
Opus does fine.

**Fable refusal caveat:** Fable's safety classifiers can refuse
security-review and cybersecurity-adjacent content. If a Fable review round
gets blocked, either scope the prompt ("exclude cybersecurity aspects") or
route that dimension to an opus subagent — opus has no classifiers and is
the right tier for security analysis anyway.

## Review fan-out: tier per dimension

A multi-agent review that fans out N subagents must not run them all on one
tier. Assign per dimension:

| Review dimension | Tier |
|---|---|
| Naming consistency, style, formatting | **haiku** |
| Code reuse / duplication, dead code | **haiku** |
| Test coverage, docs accuracy | **sonnet** |
| Correctness / logic bugs | **sonnet** (opus if the diff is subtle) |
| Security, concurrency, data loss | **opus** |
| Cross-dimension synthesis, final verdict | **main model** |

## Cost mechanics (why fan-outs get expensive)

Input tokens dominate review cost, not output. Each subagent starts with a
**cold cache** (own context, 5-minute TTL) — N subagents that each re-read
the full diff pay for it N times. Contain this in the spec, not by skipping
delegation:

- **Scope each subagent's file set.** Name the exact files/hunks each
  dimension needs; don't let 8 agents each re-read the whole branch.
- **Lower `effort` for mechanical work.** Subagents accept
  `effort: low|medium|high|xhigh|max`; use `low` for haiku-tier mechanical
  dimensions — fewer tool calls, less thinking, same result.
- **Cap the return payload.** Tell each subagent to return findings only
  (file:line + one sentence), not restate the code.

## Labels and colors — make the fan-out followable

Claude Code gives every subagent an identity; use all of it so the user can
read the fan-out from the outside:

- **Name every spawn.** The Agent call's `name` is a short kebab-case role
  ("parser-refactor", "verify-auth"). The name is also the push-back handle —
  follow-ups go to the same name via SendMessage, reusing its warm cache; an
  unnamed agent is unaddressable.
- **Carry the tier in the label.** One convention per session,
  `<tier>: <role>` (task description or label: "sonnet: parser refactor",
  "haiku: dead-code sweep") — the user should never have to open a task to
  know which model is running it and why.
- **Color persistent roles.** Agent types defined in `.claude/agents/*.md`
  take a `color:` frontmatter field — `red`, `blue`, `green`, `yellow`,
  `purple`, `orange`, `pink`, `cyan` — rendered as the agent's chip in the
  task list and transcript. Give recurring roles stable colors (reviewers
  red, researchers green, writers purple) so a glance sorts the fan-out;
  ad-hoc named spawns get a color assigned automatically, keyed to the name.

## Process

1. **Spec before spawn.** The main model has the context; the subagent
   doesn't. Each task prompt gets: exact files/symbols, what to change, what
   NOT to touch, how to verify (test command), and what to return.
2. **Partition by files, not by topic.** Disjoint file sets run in parallel
   (one message, multiple Agent calls). Shared files run sequentially, or
   assign distinct regions and say so in both prompts.
3. **Spawn with explicit `model:`** (and `effort: low` where the work is
   mechanical), named and tier-labeled per the convention above. Never
   `fable`, never omitted.
4. **Review in the main model.** Read the diff, run the tests yourself,
   check acceptance criteria. Wrong or incomplete → push back to the same
   subagent with specific fixes. Repeat until it passes. Delegation lowers
   who types the code, never who owns it.

## Judgement heuristics

- One task, five minutes, trivial diff → do it inline; a subagent has
  spin-up cost too.
- If writing the spec takes longer than the change, the task was too small
  to delegate.
- When unsure between tiers, go one up: a wrong cheap answer costs more than
  the tier difference.
- Downgrade the tier, never the spec: haiku with a precise spec beats sonnet
  with a vague one.
- For a re-run on the same large context, prefer pushing back to the
  existing subagent (its cache is warm) over spawning a fresh one.
