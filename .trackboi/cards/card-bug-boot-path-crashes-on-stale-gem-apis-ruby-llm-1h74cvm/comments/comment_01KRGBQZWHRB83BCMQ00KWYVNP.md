---
id: "comment_01KRGBQZWHRB83BCMQ00KWYVNP"
cardId: "card-bug-boot-path-crashes-on-stale-gem-apis-ruby-llm-1h74cvm"
createdAt: "2026-05-13T09:47:32.113Z"
updatedAt: "2026-05-13T09:47:32.113Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
## Update: 3rd ruby_llm drift symptom + user-applied workaround

Two new observations from `./bin/console` boot attempt:

### Symptom 3 — `config.retry_backoff=` removed in ruby_llm 1.15.0
`lib/rubysmithing/llm_providers.rb:31`
```ruby
config.retry_backoff = 2.0
# => NoMethodError: undefined method 'retry_backoff=' for an instance of RubyLLM::Configuration
# Did you mean? retry_backoff_factor=
```
Setting renamed `retry_backoff` → `retry_backoff_factor`. Likely a one-line rename. Verify semantics in the ruby_llm changelog before swapping — if the type changed (e.g. seconds → multiplier), the value `2.0` may need adjustment.

### User-applied workaround (intentional, NOT to be reverted)
The user has already commented out two `ruby_llm` settings in `llm_providers.rb`:
```ruby
# Enable request logging for cost monitoring
#config.log_requests = true        # removed in ruby_llm 1.15.0
#config.request_logger = Rubysmithing.logger  # paired setting
```
This unblocks the previously-reported symptom 1 (`log_requests=`). Card scope now narrows to:

1. ~~`config.log_requests=`~~ — user commented out. Decision needed: leave commented (lose request logging) or migrate to the new ruby_llm logging API.
2. **`config.retry_backoff=`** — open. Rename to `retry_backoff_factor` (likely) or remove.
3. **`logger.public_send(level, message, structured_fields)`** — open (journald-logger arity mismatch in `instrumentation.rb:36`). Use `logger.tag(structured_fields).public_send(level, message)` chain.

### Recommended audit pattern
The fact that we've hit three `ruby_llm` API renames in one method (`configure_ruby_llm!`) suggests broader drift between the version this code was written against and 1.15.0. Worth doing a complete API survey against `ruby_llm` 1.15.0's `Configuration` class — likely cheaper than chasing one method-missing at a time.

### Pre-existing call sites that may still drift (not yet exercised)
`llm_providers.rb` also configures `RubyLLM.configure { |c| c.mistral do |m| ... end }`, `.openrouter`, `.huggingface` — each with `.api_key=`, `.api_base=`, `.models=`, `.headers=`. Worth verifying these survived to 1.15.0 too, before declaring boot fixed.