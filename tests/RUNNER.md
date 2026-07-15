# Create-mode eval runner

How to run a golden brief through create mode and score it. Dev-time and manual:
the roles are agents you dispatch (Claude Code's Agent tool, or any Agent-Skills
harness), not installed runtime. Automating this in CI is deliberately deferred
(see the roadmap's Future items).

## Roles

- **Player** — given one `briefs/<brief>.md`, answers the skill-runner one
  question at a time, in persona. Defaults to the recommended option; deviates
  only where the brief's `## Answers` says. Never volunteers unasked information
  and never sees `## Expect`. It is standing in for a real user.
- **Skill-runner** — given `../skills/mvp-roadmap/` and an empty scratch working
  directory, runs create mode: surveys (the dir is empty), interviews one
  decision per turn, drafts as it goes, synthesizes the roadmap last, and writes
  `ROADMAP.md` + `docs/plans/<date>-prd.md`. It knows only what the player tells
  it. Structured question widgets are unavailable to a subagent, so it uses the
  plain-text one-question path — which is exactly the portable path to exercise.
- **Judge** — scores the result (below).

## Loop

For each brief, in a fresh scratch dir:

1. Prompt the skill-runner for its next single question (or its final documents).
2. Relay that question to the player; relay the player's answer back.
3. Append both to `transcripts/<brief>.md`.
4. Repeat until the skill-runner emits the documents.

## Judge

Mechanical (deterministic):

```sh
scripts/check-doc.sh <scratch>/ROADMAP.md <scratch>/docs/plans/*.md
tests/expect/per-brief.sh <brief> <scratch>
```

Qualitative: dispatch a fresh judge agent with `transcripts/<brief>.md` and
`judge-rubric.md`; it returns pass/fail per rubric item with quoted evidence.

## Report

Fill one row per brief and paste the table into the release notes.

| Brief   | check-doc | per-brief | transcript quality |
|---------|-----------|-----------|--------------------|
| cli     |           |           |                    |
| api     |           |           |                    |
| library |           |           |                    |

Commit each `transcripts/<brief>.md` once its transcript-quality review passes.
