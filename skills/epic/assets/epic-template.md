# E{{ n }}: {{ epic_name }}

{{ one_sentence_outcome }}. → [{{ linked_section }}]({{ path_to_prd }}#{{ anchor }})

## Stories

<!-- Action-verb one-liners, ≤2 sentences, max 6 per epic. Written by /mvp
     at roadmap synthesis; ticked only via the propose-then-tick protocol. -->

- [ ] {{ story_one_liner }}
- [ ] {{ story_one_liner }}

## Acceptance criteria

<!-- Written by /epic at kickoff: 3–7 testable one-liners defining done from
     the outside, each derived from a sentence in the linked PRD section —
     a criterion with no spec sentence behind it means the section has a
     gap. /regression builds one test layer per item. -->

- {{ user_can_X }}
- {{ input_Y_produces_Z }}
- {{ error_path_fails_with_W }}

## Exit criteria

<!-- Written by /epic at kickoff; the written contract /wrap-up gates the
     tick against. The Benchmarks line is optional — include it only when
     the feature touches a metric the PRD's validation strategy names. -->

- Artifact: {{ what_someone_outside_the_session_can_touch }}
- Regression: `{{ command }}` — proves the acceptance criteria; its green run gates the tick
- Demo: {{ what_the_demo_shows }}
- Benchmarks: `{{ command }}` → {{ metric }} within {{ budget }}
