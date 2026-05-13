---
id: "card-bug-boot-path-crashes-on-stale-gem-apis-ruby-llm-1h74cvm"
boardId: "default"
title: "Bug: boot path crashes on stale gem APIs (ruby_llm + journald-logger)"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: null
column: "done"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-13T09:21:50.065Z"
updatedAt: "2026-05-13T09:59:33.827Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
Surfaced during refactor track verification. The boot path has multiple pre-existing API-drift bugs that prevent `Rubysmithing.boot!` from ever succeeding. Independent of the refactor — fixing these is what makes the boot actually work.

## Bugs

### 1. `ruby_llm 1.15.0` removed `config.log_requests=`
`lib/rubysmithing/llm_providers.rb:25`
```ruby
config.log_requests = true  # NoMethodError in ruby_llm 1.15.0
```
Gem suggests `log_stream_debug=` as a near-match. Likely renamed or replaced; check ruby_llm changelog/docs for the current request-logging setting (if any).

### 2. `journald-logger 3.1.0` level methods take 0-1 args, not 2
`lib/rubysmithing/instrumentation.rb:36`
```ruby
logger.public_send(level, message, structured_fields)  # ArgumentError
```
Journald's `info`/`debug`/etc. accept only a message (or block). Structured fields should be applied via `logger.tag(fields).info(message)` pattern. Pre-existing — extracted verbatim from the original facade during card 3.

## Acceptance
- `bundle exec exe/rubysmithing` completes boot without raising.
- `bundle exec rspec` (after fixing the unrelated spec_helper path bug) runs.
- Document the ruby_llm setting equivalence (or removal) so future drift is easier to spot.

## Context
Surfaced incrementally during cards 2-5 of track `track-refactor-decompose-lib-rubysmithing-rb-and-reloc-12z2j3j`. Three other latent bugs were fixed inline during that work (hash-rescue parse error, 8x fetch-misuse, missing version require). These two remain because they require domain knowledge of the dependencies' current APIs, not just structural cleanup.