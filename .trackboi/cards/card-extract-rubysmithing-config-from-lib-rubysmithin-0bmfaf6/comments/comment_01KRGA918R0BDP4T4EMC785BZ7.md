---
id: "comment_01KRGA918R0BDP4T4EMC785BZ7"
cardId: "card-extract-rubysmithing-config-from-lib-rubysmithin-0bmfaf6"
createdAt: "2026-05-13T09:21:53.432Z"
updatedAt: "2026-05-13T09:21:53.432Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
## Retroactive amendment (reflexion audit)

A follow-up audit surfaced **7 additional occurrences** of the same tty-config `fetch(key, "default")` misuse pattern documented under the "pre-existing bug" section here. Not all were in `llm_providers.rb` — 3 were copied into `lib/rubysmithing/boot.rb` during card 4 (by me).

All 8 sites are now fixed (using `fetch(key, default: "value")` keyword form). See the new bug card `card-bug-boot-path-crashes-on-stale-gem-apis-...` for the remaining boot-path defects (ruby_llm + journald-logger API drift).