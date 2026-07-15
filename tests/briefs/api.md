# Golden brief — hosted API

A committed scenario for create-mode evals. The **player** answers from `## Idea`
and `## Answers` (defaulting to the recommended option everywhere `## Answers` is
silent) and never reveals `## Expect`. The **judge** checks `## Expect`.

## Idea

`shrtn` — a self-hostable URL-shortener HTTP API (Python, FastAPI): `POST` a long
URL and get back a short code, `GET /{code}` 302-redirects, and every code
carries click analytics. Positioning: the hosted incumbents (bit.ly and friends)
lock your links and analytics behind a subscription and a vendor domain; `shrtn`
is one container you run on your own domain, links and stats yours to keep.
Deliberately worse: no dashboard UI at MVP (API only), and no custom-vanity-code
collision UX beyond a plain 409.

## Answers

Deviations from "pick the recommended option"; everything else takes the
recommendation.

- **Surfaces:** an HTTP API (the product) plus a thin CLI wrapper for scripting.
  The API is the product; the CLI is a client.
- **Auth:** API keys (per-tenant), sent as a bearer token; the redirect endpoint
  is public, everything else keyed.
- **Validation:** integration tests against a running instance (create → resolve
  → redirect round-trips) as the tier that matters.

## Expect

- Passes `scripts/check-doc.sh` (structure, links, no accretion tells).
- **`## API design` section present** — a networked API surface exists, so the
  section must appear.
- The API design section states an **auth model** (an `**Auth:**` line: API keys
  / bearer token) and a resource table (e.g. `POST /links`, `GET /{code}`).
- An API surface is listed in the Surfaces table.
- `## Roadmap` with an `E1` walking skeleton and an MVP line.
