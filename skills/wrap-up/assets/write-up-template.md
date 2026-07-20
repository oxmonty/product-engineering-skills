# E{{ n }}: {{ epic_name }} — write-up

{{ YYYY-MM-DD }}

<!-- Dated, append-only history: exempt from accretion rules, never linted,
     never edited after the fact. Omit an optional section when it genuinely
     doesn't apply; never invent new top-level headers. -->

## What shipped

<!-- Plain language a junior and a senior engineer both follow. Lead with
     what it enables for the developer and the end user, not the mechanics. -->

{{ what_shipped_in_enablement_terms }}

## Try it yourself

<!-- The user's handover: exact steps from a clean start, expected output,
     one line on what this gives the end user. Presented in chat with a
     pause for the user to run it. -->

```sh
{{ exact_commands }}
```

{{ expected_output }} — {{ what_this_gives_the_end_user }}

## Validation notes

<!-- The developer's handover: how to re-verify what shipped — regression
     command, benchmark and budget, linter — and what healthy output looks
     like. -->

{{ how_to_re_verify }}

## Evidence

<!-- Executed proof: commands, CI runs, commits, the regression suite's
     green run, benchmark numbers (they are the baseline later epics
     regress against). -->

- {{ evidence_line }}

## Decisions made along the way

<!-- Omit if none. Spikes contribute their decision matrix — options
     against measured criteria — and the keep-or-discard call. -->

- {{ decision_and_why }}

## What surprised

<!-- Omit if none. -->

- {{ surprise }}

## Left open

<!-- Omit if none. -->

- {{ open_item }}
