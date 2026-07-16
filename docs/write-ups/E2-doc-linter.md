# E2: Doc linter — write-up

> Completed: 2026-07-15 · Written: 2026-07-16 · Append-only history; not linted.

## What shipped

`scripts/check-doc.sh` (`4524b21`): the collection's only executable deliverable, in plain grep/awk with zero dependencies so it drops into any target project. Three check families — accretion tells over body text (fenced code skipped, `accretion-ok` marker as the allowlist), link and `#anchor` resolution including cross-file `docs/plans/*#anchor` links, and roadmap structure (MVP line present, story cap, every epic linked). Wired into CI as the self-hosting gate (`f7fbde7`): the repo's own ROADMAP and PRD must pass the linter the repo ships.

## Evidence

- Gate green from its first run: `actions/runs/29405333534`.
- Proof-by-fixture that every check bites: a deliberately broken doc produced all seven expected findings (accretion tell, broken link, broken anchor, missing MVP line, 7-story epic, two unlinked epics), and an `accretion-ok`-marked line was correctly exempted.

## Decisions along the way

- The allowlist got its poster case immediately: the PRD's own versioning line legitimately says "previously-passing docs" — policy prose, not history — and became the first `accretion-ok` marker. Shipping the allowlist in the same commit as the grep kept the gate honest from day one.
- Anchor slugs are computed without duplicate-heading `-1`/`-2` suffixing — a named ceiling, to be added only if a doc ever links to the second occurrence of a repeated heading.

## What surprised

- The self-hosting gate failed on the repo's own PRD on the very first run — the exact accretion-tell false-positive class the E2 stories predicted. The check-then-allowlist sequence turned out to be the right order: see the linter catch something real before teaching it the exception.
