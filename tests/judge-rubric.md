# Judge rubric — interview quality

The mechanical tier (`../scripts/check-doc.sh` + `expect/per-brief.sh`) proves the
*documents* are valid. This rubric is the qualitative tier: a fresh judge agent
reads a recorded transcript (`transcripts/<brief>.md`) and scores whether the
*interview* followed the skill's rules. It is the automation of what the PRD's
validation strategy calls tier-3 transcript review.

Score each item pass/fail with a one-line justification quoting the transcript.
Overall pass requires every **critical** item to pass.

## Critical

- **One decision per turn.** Each turn raised exactly one decision (at most two
  tightly coupled). No walls of questions.
- **Recommendation always.** Every question offered a recommended option with a
  one-clause reason — never a bare "what do you want?".
- **No survey-answerable questions.** Nothing was asked that the brief's `Idea`
  already stated (language, what it does, the positioning). Note: create-mode
  evals run in an empty directory, so "survey" here means the opening context.
- **Positioning gate honored.** The interview did not proceed past identity
  without a positioning clause; if the player had withheld it, the skill stopped
  to work it out.
- **Skip logic fired.** API-design questions appeared only for surfaces that have
  an API (the api and library briefs), and not for the cli brief.

## Expected

- **Trade-offs probed, not just preferences.** Questions named what each option
  costs rather than asking an open preference.
- **Traps proposed, not demanded.** Implementation traps were offered as
  candidates to confirm/deny, not asked of the player cold.
- **Drafted as it went.** Sections were shown/summarized per phase for a quick
  confirm, not held to the end.
- **Roadmap derived last.** The roadmap was synthesized after the design
  sections, E1 is a walking skeleton, and the MVP line was confirmed with the
  player rather than inferred silently.
- **Output shape asked last.** The single-file vs split choice was the closing
  question.
