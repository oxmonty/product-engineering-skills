---
name: wrap-up
description: Close out a working session against a living ROADMAP.md — diff what actually happened against the roadmap, propose tick-offs with executed evidence, apply non-accretive doc updates including the open-questions decision log, summarize the session, and offer the closing commit. Use when the user says "wrap up", "wu", "close out", "end of day", "finish up", "update the roadmap and wrap", or signals they are done working for now.
---

# Wrap-up

Close the day so the documents remain the single source of truth and nothing the session did is lost or overclaimed. This is the user-invoked face of the collection's update mode; the full editing philosophy lives with the `mvp` skill (`skills/mvp/references/editing-rules.md` in the source repo). The operative rules are inlined below so this skill stands alone wherever it's copied.

## Steps

1. **Read the roadmap in full** (and the PRD, if any decision changed this session). It is the shared memory; do not work from recollection of it.
2. **Diff reality against the roadmap.** Four buckets: work landed but unticked; ticks proposed earlier but unconfirmed; open questions the session resolved; decisions that changed.
3. **Propose ticks — evidence or nothing.** One line of *executed* evidence per candidate: a command that ran, a green CI run URL, a commit hash. Your own assertion that code "should work" is not evidence. Where the session's artifact is runnable, offer the user the exact steps to run it themselves before confirming — hands-on beats reading evidence. Ask confirm-all / pick / none via the structured question tool (plain-text lettered fallback elsewhere). The user is the verifier of record.
4. **Tick confirmed boxes only** — `- [ ]` becomes `- [x]`; nothing else on the line changes. Mis-scoped stories are a separate, explicitly-narrated edit, never folded into a tick.
5. **Apply non-accretive updates.** Changed decision → rewrite the owning section as if it were always the decision, then propagate to linked stories and echoes (grep for the old term). Resolved open question → record the answer on the question (decision + evidence — the Open Questions section is the decision log) and fold the decision into its owning section.
6. **Offer the epic write-up.** If an epic completed this session, offer to draft `docs/write-ups/E<n>-<slug>.md`: a dated, append-only narrative — what shipped, the evidence, the decisions made along the way, what surprised. Write it to land for a junior and a senior engineer alike, and name what shipping it lets the developer and the end user do now. When the epic contained a spike, the write-up carries its decision matrix — options against measured criteria — and the keep-or-discard call on the spike code. Write-ups are history by definition: they are exempt from the accretion rules, never passed to the doc linter, and never edited after the fact. The spec body stays current-truth; the write-up is where the story goes.
7. **Verify.** Run `scripts/check-doc.sh` on the touched docs if the project has it (never on write-ups); otherwise run the accretion grep and confirm roadmap links resolve.
8. **Summarize in chat**: shipped, ticked, reopened, still open, and what tomorrow starts with. The narrative lives here, in git, and in write-ups — never in the spec body.
9. **Offer the closing commit** (add / commit / push, imperative message; commit-only and skip are always options). If the conversation has grown long, recommend the user run `/compact` — you cannot compact it for them. If an epic completed, suggest starting the next one in a fresh session: the documents are the handoff — `/epic` re-reads the roadmap, the epic file, and the write-ups — so no separate handoff document is needed.
