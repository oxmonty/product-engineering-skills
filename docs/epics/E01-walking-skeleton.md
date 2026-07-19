# E1: Walking skeleton

The flagship skill installs through both planned channels and triggers end-to-end in a clean project. → [Distribution](../plans/2026-07-15-prd.md#distribution)

## Stories

- [x] Repo scaffold in superpowers layout: `skills/<skill>/{SKILL.md, references/, assets/}`, scripts/, tests/, MIT LICENSE, CLAUDE.md/AGENTS.md, README pointing at this roadmap
- [x] CI validates SKILL.md frontmatter and Markdown on every PR
- [x] Release workflow packages `.skill` bundles and attaches them to a GitHub Release on tag
- [x] Verified install: `npx skills add` of this repo in a clean directory, skill triggers on "spec out this MVP"
