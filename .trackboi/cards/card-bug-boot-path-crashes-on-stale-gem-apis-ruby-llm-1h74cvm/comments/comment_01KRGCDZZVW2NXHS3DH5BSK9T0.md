---
id: "comment_01KRGCDZZVW2NXHS3DH5BSK9T0"
cardId: "card-bug-boot-path-crashes-on-stale-gem-apis-ruby-llm-1h74cvm"
createdAt: "2026-05-13T09:59:33.115Z"
updatedAt: "2026-05-13T09:59:33.115Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
## Resolved (Path B — pre-prod rewrite)

User chose Path B with "knock down the faulty walls" framing (project never shipped → no migration ceremony, no backward-compat).

### Changes

**`lib/rubysmithing/llm_providers.rb` — full rewrite**
- Dropped `configure_mistral_provider!`, `configure_openrouter_provider!`, `configure_huggingface_provider!` entirely.
- `configure!` now sets options flat against the single `RubyLLM.configure` block: `config.mistral_api_key=`, `config.openrouter_api_key=`, `config.openrouter_api_base=`, `config.log_level=`, `config.request_timeout=`, `config.max_retries=`, `config.retry_backoff_factor=`.
- Hugging Face removed — no provider exists in ruby_llm 1.15.0.
- Custom model registries (`mistral.models = {...}` etc.) removed — not supported in 1.15.0's config; future need can use `config.model_registry_file`.
- OpenRouter `headers = {...}` removed — not in openrouter's options (`%i[openrouter_api_key openrouter_api_base]`).
- Kept `provider_for_use_case`, `client_for_use_case`, `test_providers!` (real orchestration value).
- `provider_available?` and `default_model_for_provider` updated — HF case removed.

**`lib/rubysmithing/instrumentation.rb:36` — journald arity fix**
- Was: `logger.public_send(level, message, structured_fields)` (raised ArgumentError: 2 args)
- Now: `logger.tag(**structured_fields) { logger.public_send(level, message) }` — block form scopes tags to this single log call rather than mutating the logger's permanent tag set.

**`lib/rubysmithing/boot.rb`** — removed `hf_configured:` from the LLM-complete log payload.

**`exe/rubysmithing`** — fixed 2 more sites of the `fetch(:k, "")` positional-default misuse that I missed in the earlier `lib/`-only audit (and dropped the `hf_configured` warn line). Bringing the actual cumulative count of fetch-misuse sites fixed this session to **10**, not 8.

### Verification

```
$ bundle exec exe/rubysmithing
rubysmithing: boot complete (no command given; CLI not yet implemented)
  mistral_configured=true
  openrouter_configured=true
$ echo $?
0
```

Boot path now executes cleanly end-to-end. Both providers configured from `.env`. No exceptions raised.

### Retroactive implications

- **Card 5** (`Implement exe/rubysmithing as the runtime entry`) — acceptance criterion "boots without errors" is **now actually met**. Card 5's earlier-flagged 2.70/5.0 lenient close stands as documented history, but the underlying acceptance is satisfied.
- **Card 6** (`Migrate config/boot.rb importers`) — can now be done against a working boot baseline. Each migrated importer can be verified by load-and-boot rather than load-only.

### Config dead weight (NOT addressed)

`Rubysmithing::Config#apply_provider_defaults!` still seeds `:hf_inference_api_base`, `:hf_api_key`, `:mistral_api_base` — all unused after this rewrite. Leaving them as dead-but-harmless config keys for the user to triage. Removing them is a Config-cleanup card if wanted; doesn't block anything.