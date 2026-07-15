# Golden brief — library

A committed scenario for create-mode evals. The **player** answers from `## Idea`
and `## Answers` (defaulting to the recommended option everywhere `## Answers` is
silent) and never reveals `## Expect`. The **judge** checks `## Expect`.

## Idea

`whenish` — a TypeScript library that parses loose natural-language time
expressions ("next tuesday 3pm", "in 2 weeks", "end of month") into a concrete
`Date` or range, deterministically against a supplied reference time. Positioning:
`chrono-node` is the incumbent but is loosely typed and pulls its own timezone
assumptions; `whenish` is fully typed, tree-shakeable, and pure — same input plus
same reference time always yields the same output, so it is safe in tests and on
the server. Deliberately worse: English only at MVP, and it parses a smaller
grammar than chrono in exchange for total determinism.

## Answers

Deviations from "pick the recommended option"; everything else takes the
recommendation.

- **Surfaces:** a library (the product) plus a tiny CLI that wraps `parse` for
  shell use. The library's public API is the product.
- **Stability:** the exported `parse()` and its result types are the stable
  surface; the grammar internals are private. Deprecations get one minor-version
  notice before removal.
- **Validation:** golden tests — a table of `input × reference-time → expected
  output`, which must round-trip, is the tier that matters.

## Expect

- Passes `scripts/check-doc.sh` (structure, links, no accretion tells).
- **`## API design` section present** — a library whose public API is the
  product still gets the section, in its library-as-product form.
- The section describes **stability and a deprecation policy** (what is exported
  and stable vs internal), and states **no networked auth** (no `**Auth:**` line
  / bearer token — it is a library, not a service).
- A library surface is listed in the Surfaces table.
- `## Roadmap` with an `E1` walking skeleton and an MVP line.
