# product-engineering-skills

[![skills.sh](https://badgen.net/badge/skills.sh/oxmonty%2Fproduct-engineering-skills/black?icon=vercel)](https://skills.sh/oxmonty/product-engineering-skills) [![Downloads](https://badgen.net/github/assets-dl/oxmonty/product-engineering-skills)](https://github.com/oxmonty/product-engineering-skills/releases) [![Latest release](https://badgen.net/github/release/oxmonty/product-engineering-skills)](https://github.com/oxmonty/product-engineering-skills/releases/latest)

A collection of agent skills (Agent Skills standard, Markdown) that carries a product from idea to shipped artifact: an interview that produces a decision-complete MVP document set (a living `ROADMAP.md` and a dated PRD) and a build loop that runs against those documents and keeps them truthful as work lands.

## Install

```sh
npx skills add oxmonty/product-engineering-skills --all -g
```

One command, any agent: [skills.sh](https://skills.sh/oxmonty/product-engineering-skills) detects every agent on your machine (Claude Code, Codex, Cursor, Amp, Cline, OpenCode, Copilot CLI, and ~70 more) and installs all seven skills as hackable Markdown copies, user-level. Drop `-g` to install into the current project instead. Refresh to the latest main anytime:

```sh
npx skills update -g
```

Two special cases:

| Surface | How |
|---|---|
| **Claude Code plugin**: managed instead of hackable; updates arrive per release | `/plugin marketplace add oxmonty/product-engineering-skills` then `/plugin install product-engineering-skills@product-engineering-skills` |
| **claude.ai**: one skill at a time | import a `.skill` bundle from the latest [Release](https://github.com/oxmonty/product-engineering-skills/releases/latest) via Settings → Capabilities → Skills |

Compatibility: the skills are plain Agent Skills Markdown with no runtime, so any harness that reads skills can run them. Two graceful degradations elsewhere: the interview's multiple-choice widget falls back to plain-text lettered questions where no question tool exists, and `/delegate`'s Claude model ladder reads as small/mid/large tiers on other stacks.

## The loop

Kick it off with `/mvp` and paste everything you have: product notes, feature lists, a half-formed idea. The more you hand the interview, the fewer questions it asks. An existing project or POC works too: brownfield repos get a feature inventory as the baseline.

| Command | When | Does |
|---|---|---|
| `/mvp` | day zero, bare or existing repo | section-by-section interview → `ROADMAP.md` + `docs/plans/<date>-prd.md` + `docs/epics/`; brownfield repos get a feature-inventory baseline first |
| `/epic E1` | starting an epic | kickoff from the epic's PRD section: story order, then exit criteria (artifact, regression command, demo) written into the epic's file |
| `/delegate` | during the build | implementation to the cheapest capable model tier; judgment stays in the main loop |
| `/spike` | a design question blocks a story | timeboxed measurement of the candidates → decision matrix → decision folded into the PRD |
| `/regression` | a feature nears done | layered suite pinning each sub-section's edge cases, then the feature e2e; its green run gates the epic's tick |
| `/demo-ideas` | an epic ships | 2–3 demos of the current state, with runnable steps |
| `/wrap-up` | end of any session | propose ticks with evidence, non-accretive doc updates, epic write-up with a try-it-yourself handover, summary, closing commit |

> [!WARNING]
> The loop assumes a top-tier model in the main loop (Claude Fable, or whatever leads the SWE benchmarks in your harness). It spends that model on judgment (specs, review, synthesis) while `/delegate` hands implementation down to cheaper tiers; run a small model in the main loop and the judgment seat is exactly what degrades.

Every pre-MVP epic ends in a shippable artifact: a pushed repo, a published package, a live URL, a cut release. Post-MVP, epics name the feedback loop they open instead.

Each skill is also importable into claude.ai individually from the `.skill` bundles attached to every [Release](https://github.com/oxmonty/product-engineering-skills/releases).

## Philosophy

- **The document is the product.** One interview writes a decision-complete spec; the loop's skills are the only things allowed to edit it.
- **Rewrite, don't accrete.** Obsolete text is replaced, not annotated; the spec reads as if written correctly from the start ([why accretive editing rots documents](https://justindfuller.com/programming/accretive-editing)). The open-questions section doubles as the decision log.
- **A checkbox is a claim.** Ticks need executed evidence and your confirmation, never an assertion that code "should work".
- **Artifacts over intentions.** An epic isn't done when the code exists; it's done when there's something shippable to show.
- **Prose, not runtime.** Portable to any file-and-text harness; it observes nothing and phones nowhere.

## Where things live

- [`ROADMAP.md`](ROADMAP.md): at the repo root, the epic index and MVP cut; the project's front page and living memory.
- [`docs/epics/`](docs/epics/): one zero-padded file per epic (`E01-…`) holding stories, status, spec link, and exit criteria.
- [`docs/plans/2026-07-15-prd.md`](docs/plans/2026-07-15-prd.md): the specification each epic links into.
- [`docs/write-ups/`](docs/write-ups/): a dated, append-only narrative per completed epic.
- [`skills/`](skills/): the collection (`mvp/`, `epic/`, `delegate/`, `spike/`, `regression/`, `demo-ideas/`, `wrap-up/`).

This repo is self-hosting: it maintains its own roadmap and PRD with the skills it ships.

## License

[MIT](LICENSE). The license covers the skills; documents they produce in your projects are entirely yours.
