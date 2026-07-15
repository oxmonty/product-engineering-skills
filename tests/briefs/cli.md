# Golden brief — CLI tool

A committed scenario for create-mode evals. The **player** answers from `## Idea`
and `## Answers` (defaulting to the recommended option everywhere `## Answers` is
silent) and never reveals `## Expect`. The **judge** checks `## Expect`.

## Idea

`ghlabel` — a command-line tool (Go) that syncs a repository's GitHub issue
labels from a checked-in `labels.yaml`: it reads the file, diffs it against the
repo's current labels, and creates, renames, recolours, or deletes to match.
Positioning: label config today lives only in the GitHub UI, so it drifts and is
invisible in review — `ghlabel` makes labels a reviewable file, the way
Terraform made infrastructure one. Deliberately worse than the UI: no
discovery/autocomplete of colours, and it only manages labels, nothing else.

## Answers

Deviations from "pick the recommended option"; everything else takes the
recommendation.

- **Surfaces:** CLI only. No library, no API — the binary is the whole product.
- **Distribution:** Homebrew + a `go install` path; GitHub Releases for binaries.
- **Validation:** golden/integration tests (a fake labels.yaml → expected API
  calls) as the tier that matters.

## Expect

- Passes `scripts/check-doc.sh` (structure, links, no accretion tells).
- **No `## API design` section** — the CLI exposes no API, so skip logic must
  fire and omit it entirely.
- A CLI surface is listed in the Surfaces table.
- `## Roadmap` with an `E1` epic that is a walking skeleton (installs through the
  planned channels, does almost nothing), and an MVP line.
- Distribution names Homebrew and the binary channel.
