---
name: demo-ideas
description: Propose 2–3 demos of the product's current state — runnable commands, screenshots, live URLs — sized to what is actually built and verified. Use when an epic ships, when the user asks "what can we demo", "show something", "demo ideas", or before a release, stakeholder update, or user conversation.
---

# Demo ideas

Every epic should end in something you can show someone. This skill turns the current state of the project into demos — grounded in what actually runs today, not in what the roadmap promises.

## Steps

1. **Read the ground truth.** The PRD's Workflow section and the hero example say what the product is supposed to show; the roadmap's ticked stories say what exists. The gap between them is the boundary no demo may cross.
2. **Verify before proposing.** Run the hero command, hit the URL, install the package — whatever the candidate demo claims, see it work first. A demo proposed from an unticked box or an unverified claim fails in front of exactly the person it was meant to impress. Anything you could not verify is marked untested, prominently, or dropped.
3. **Propose 2–3 demos**, each with:
   - a one-line pitch — who it lands with and why;
   - the exact runnable steps, from a clean start;
   - the expected output, and roughly how long it takes.

   Above the MVP line, demos are **artifact proof**: fresh install, hero loop end to end, the release page. Below it, demos are **feedback bait**: built to put the product in front of a real user and collect a signal — say what to ask them and what to watch for.
4. **Make the winner repeatable.** Offer to script the chosen demo (a `demo.sh`, a README snippet, a recorded command sequence) so it survives beyond the session that invented it.
