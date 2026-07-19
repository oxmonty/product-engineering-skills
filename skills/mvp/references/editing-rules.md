# Editing rules for living documents

These rules govern every edit to an instantiated `MVP.md`, `ROADMAP.md`, or `PRD.md`. They exist because the default failure mode of AI-edited docs is *accretive editing*: keeping obsolete text and tacking corrections onto it, until the document is a sediment of its own history instead of a statement of what's true.

## The prime directive

> When updating prose, replace obsolete text with accurate text rather than preserving the obsolete text and adding a correction. The final document should read as if it were written correctly from the beginning.

This is a way of thinking, not a style rule. Before writing any edit, ask: *what would this sentence say if the author had known the current truth when they first wrote it?* Write that sentence. The reader of this document cares about what is true now; they do not care how it became true. (Background on the failure mode: [Accretive Editing](https://justindfuller.com/programming/accretive-editing).)

Where change history legitimately belongs:

- **Git** — every edit to these docs should be a commit with a message describing the change.
- **Your chat summary** — narrate what changed and why to the user, in conversation.
- **A changelog or announcement** — if the change is user-facing enough to warrant one, offer to write it as a separate artifact.
- **The Open Questions log** — a resolved question keeps its answer there, as the record of what was decided and how; one of two places in the doc set where history is preserved on purpose.
- **Epic write-ups** — when an epic completes, a dated, append-only narrative goes to `docs/write-ups/E<n>-<slug>.md`: what shipped, the evidence, the decisions made along the way, what surprised. Write-ups are history by definition, so the accretion rules do not police them — they are never passed to the doc linter and never feed back into spec prose.

Never inline in the specification prose. "Now uses X (previously Y)", "no longer supports Z", "instead of the old approach" — each of these is history leaking into the spec body; the sanctioned homes above are where it belongs instead.

## Edit propagation

A decision never lives in one place. When a design decision changes:

1. Rewrite the owning section in the PRD as if the new decision were always the decision.
2. Follow the links: rewrite roadmap epics/stories that reference the changed section. Stories specifying the old behavior are rewritten or deleted, not struck through.
3. Sweep for echoes: the hero example, "Usable as" bullets, config examples, the tech stack list, and the surfaces table all tend to restate decisions. Grep for the old term across all project docs and fix every occurrence.
4. If a completed (ticked) story is invalidated by the change, do not untick it silently — surface it to the user: "E2-3 was done against the old design; the change reopens it. Reopen, or add a new story?"

When an open question is resolved, keep it and record the answer on it — mark it resolved with the decision and the evidence that settled it, rather than deleting it. Still fold that decision into the owning section so the spec body reads as current truth; the resolved question stays in Open Questions as the log of what was asked and how it was decided. The section therefore holds both live questions and settled ones with their answers — it is the project's decision log, not a list that shrinks to nothing.

## The tick-off protocol (roadmap updates)

A checked box is a claim: *this story is verifiably done*. The protocol keeps that claim honest.

**Default: propose-then-tick.**

1. After completing work (or when the user says "update the roadmap"), diff reality against the roadmap: which stories does the work plausibly complete?
2. Present the candidates with one line of evidence each — a commit, a passing test, a command that now works (`biscuit generate ./spec.yaml` exits 0). No evidence, no candidate.
3. Ask via the structured question tool: confirm all / select which / none. The user is the verifier of record.
4. Tick only the confirmed boxes. Ticking is the *only* edit this operation makes — no drive-by rewording of story text, no "✓ done 2026-07-15" annotations, no strikethrough. `- [ ]` becomes `- [x]`; nothing else in the line changes.
5. If confirmed work revealed the story was mis-scoped, that's a separate, explicitly-narrated edit — not something to fold into the tick.

**Opt-in: auto-tick.** If the user has said they trust automatic ticking (offer to record this preference in the project's CLAUDE.md or memory), tick without asking but always end the session with a "ticked this session" list in chat so the claim is auditable. Never auto-tick a story whose evidence is your own assertion that code "should work" — evidence means an executed verification.

**Session hygiene.** At the start of any session touching the project, read the roadmap in full before writing code — it is the shared memory of what's decided and done. At the end, reconcile: work landed but unticked, ticks proposed but unconfirmed, and open questions the session resolved.

## Accretion self-check

After any edit, before presenting the result, scan the changed files:

```bash
grep -nE "no longer|previously|instead of the (old|previous)|used to([^a-z]|$)|formerly|deprecated in favor|\(was |has been (removed|replaced)|as of (v|now)" ROADMAP.md PRD.md MVP.md 2>/dev/null
```

Every hit in document *body* text is a candidate accretion — inspect it and rewrite unless it is genuinely specifying behavior (e.g., a deprecation *policy* in API versioning legitimately says "deprecated endpoints are removed after two minor versions"). When a hit is legitimate policy prose, mark the line with an HTML comment — `<!-- accretion-ok: reason -->` — so a mechanical linter (like `check-doc.sh`) can allowlist it instead of training readers to ignore failures. The check is a tripwire, not a ban list: absence of these phrases doesn't prove clean editing, and their presence isn't automatically wrong. The prime directive is the test; the grep just catches the common tells.

Also verify structural integrity:

- Every roadmap `→ [section](#anchor)` link resolves to a real heading (anchors break silently when headings are reworded — recompute them after any heading change).
- The "Usable as" bullets still summarize the Surfaces table.
- Epic/story counts still respect the ~6-story cap after additions.
