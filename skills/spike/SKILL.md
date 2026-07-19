---
name: spike
description: Timebox a spike that answers one open design question with measured evidence — build the throwaway minimum, compare the candidates in a decision matrix, and fold the decision into the PRD. Use when the user says "spike", "spike this", "should we use X or Y", wants to validate a library, approach, or design against actual metrics, or when an epic story turns out to be a question rather than a feature.
---

# Spike

A spike buys a decision, not a feature. Its output is knowledge: measured evidence that settles one named question. The code it produces is disposable by default — the decision is the artifact.

## Steps

1. **Name the question and the decision it blocks.** One question per spike. If the project keeps an Open Questions log, the spike should be answering an entry there — add the question first if it's missing, with the evidence that will resolve it.
2. **Set the timebox and the finish line before starting.** A duration (hours, not days, at MVP scale) and the acceptance criteria: which metrics, measured how, settle the question. A spike without a finish line is research without an exit.
3. **Build the throwaway minimum that produces real numbers.** The smallest harness that makes the candidates comparable on the named metrics — a benchmark, a probe, a disposable prototype. Resist making it shippable; polish is scope stolen from the answer.
4. **Record the decision matrix.** Options as rows, criteria as columns, measured values in the cells; the chosen option and why in one line beneath. The table goes in chat and into the epic's write-up, if the project keeps them — it is the evidence future sessions cite.
5. **Fold the decision back.** Record the answer on the Open Questions entry (decision + evidence), rewrite the owning PRD section as if it were always the decision, and update any roadmap stories the choice reopens or retires.
6. **Ask keep or discard.** Recommend discarding the spike code — the write-up keeps the numbers. If the user keeps it, it stops being a spike: it enters the repo as real code, named, reviewed, and tested like everything else.
