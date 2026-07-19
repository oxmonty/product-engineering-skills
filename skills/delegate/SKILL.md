---
name: delegate
description: Delegate implementation work to subagents on the cheapest model tier that can do each job well, keeping design, review, and synthesis in the main loop. Use when the user says "delegate", "dwj", "fan out", "parallelize this", or when a session holds several well-specified implementation tasks that don't need the main model's judgment.
---

# Delegate with judgment

Premium tokens buy judgment — design, review, deciding what to change and how. Implementation rarely needs them. Specify the work precisely, hand it down, and verify it yourself: the subagent only types; you own correctness.

## Tier selection

- **Substantive implementation** — new components, multi-file refactors, non-trivial logic, once the design is fully specified → a capable mid-tier model.
- **Mechanical edits** — renames, exact find-replaces, one-line changes already worked out → the smallest tier.
- **Judgment** — design decisions, tradeoffs, review, synthesis of results → never delegated; it stays in the main loop, whatever it costs.

When unsure which tier a task needs, the task is probably under-specified — sharpen the spec until the cheap tier can succeed, or keep it.

Set the tier explicitly on every delegation — most harnesses default subagents to *inherit* the main model, which silently runs every delegated task at the premium tier. Label each task with its tier and a short name when spawning ("mid-tier: parser refactor") so the fan-out is followable from the outside.

## Protocol

1. **Specify before delegating.** Exact files, the precise change, and the acceptance check the result must pass. A vague prompt to a cheap model is a rework generator that costs more than doing it yourself.
2. **Parallelize the independent, serialize the dependent.** Tasks with no shared state go out together; a task that consumes another's output waits for it.
3. **Verify every result in the main loop.** Read the diff, run the typecheck/lint/tests named in the acceptance check. Delegation transfers typing, never accountability.
4. **Re-delegate with the gap named, or take it back.** When a result is wrong, don't silently patch it — either send it back with the failure spelled out, or do it in the main loop. A silently-fixed result teaches nothing about the prompt that failed.
