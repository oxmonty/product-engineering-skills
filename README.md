# product-engineering-skills

> The document is the product.

A collection of agent skills (Agent Skills standard, Markdown) that carries a product from idea to shipped artifact: an interview that produces a decision-complete MVP document set — a living `ROADMAP.md` and a dated PRD — and a build loop that runs against those documents and keeps them truthful as work lands.

## Install

```sh
npx skills add oxmonty/product-engineering-skills --all -g
```

All five skills, every detected agent, user-level, no prompts. Drop `-g` to install into the current project instead (a hackable copy that travels with the repo).

Two install philosophies, pick by how you want updates:

- **Hackable copy** (skills.sh, above) — the skills are copied as plain Markdown into your project or home directory. Edit them freely; they're yours, and they never change under you.
- **Managed bundle** (Claude Code plugin) — subscribe to the collection and pick up improvements as they ship:

  ```
  /plugin marketplace add oxmonty/product-engineering-skills
  /plugin install product-engineering-skills@product-engineering-skills
  ```

## The loop

| Command | When | Does |
|---|---|---|
| `/mvp` | day zero, in any repo or empty dir | section-by-section interview → `ROADMAP.md` + `docs/plans/<date>-prd.md` |
| `/epic E1` | starting an epic | kickoff from the epic's PRD section: story order, artifact target, demo exit |
| `/delegate` | during the build | implementation to the cheapest capable model tier; judgment stays in the main loop |
| `/demo-ideas` | an epic ships | 2–3 demos of the current state, with runnable steps |
| `/wrap-up` | end of any session | propose ticks with evidence, non-accretive doc updates, summary, closing commit |

Every pre-MVP epic ends in a shippable artifact — a pushed repo, a published package, a live URL, a cut release. Post-MVP, epics name the feedback loop they open instead.

Each skill is also importable into claude.ai individually from the `.skill` bundles attached to every [Release](https://github.com/oxmonty/product-engineering-skills/releases).

## Philosophy

- **The document is the product.** One interview writes a decision-complete spec; the loop's skills are the only things allowed to edit it.
- **Rewrite, don't accrete.** Obsolete text is replaced, not annotated; the spec reads as if written correctly from the start. The open-questions section doubles as the decision log.
- **A checkbox is a claim.** Ticks need executed evidence and your confirmation, never an assertion that code "should work".
- **Artifacts over intentions.** An epic isn't done when the code exists; it's done when there's something shippable to show.
- **Prose, not runtime.** Portable to any file-and-text harness; it observes nothing and phones nowhere.

## Where things live

- [`ROADMAP.md`](ROADMAP.md) — the epic index and MVP cut; the project's front page and living memory.
- [`docs/epics/`](docs/epics/) — one file per epic: stories, status, and the spec link.
- [`docs/plans/2026-07-15-mvp-roadmap-prd.md`](docs/plans/2026-07-15-mvp-roadmap-prd.md) — the specification each epic links into.
- [`skills/`](skills/) — the collection: `mvp/`, `wrap-up/`, and the specified placeholders `epic/`, `demo-ideas/`, `delegate/`.

This repo is self-hosting: it maintains its own roadmap and PRD with the skills it ships.

## License

[MIT](LICENSE). The license covers the skills; documents they produce in your projects are entirely yours.
