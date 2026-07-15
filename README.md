# mvp-roadmap

An agent skill (Agent Skills standard, Markdown) that interviews you section-by-section to turn an idea into a decision-complete MVP document set — a living `ROADMAP.md` and a dated PRD — and then keeps those documents truthful as work lands, with anti-accretive editing and a propose-then-tick roadmap protocol.

## Install

```sh
npx skills add monthy-app/mvp-roadmap
```

Then, in any repo or empty directory:

```sh
/mvp-roadmap   # interview → ROADMAP.md + docs/plans/<date>-prd.md
```

Also importable into claude.ai from the `mvp-roadmap.skill` attached to each [GitHub Release](https://github.com/monthy-app/mvp-roadmap/releases).

## Where things live

- [`ROADMAP.md`](ROADMAP.md) — what's decided and what's done; the project's front page and living memory.
- [`docs/plans/2026-07-15-mvp-roadmap-prd.md`](docs/plans/2026-07-15-mvp-roadmap-prd.md) — the specification each epic links into.
- [`skills/mvp-roadmap/`](skills/mvp-roadmap/) — the skill itself: `SKILL.md`, `references/`, `assets/`.

## License

[MIT](LICENSE).
