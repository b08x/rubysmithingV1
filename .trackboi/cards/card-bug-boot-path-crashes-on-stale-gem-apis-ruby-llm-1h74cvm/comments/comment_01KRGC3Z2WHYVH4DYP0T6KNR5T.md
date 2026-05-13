---
id: "comment_01KRGC3Z2WHYVH4DYP0T6KNR5T"
cardId: "card-bug-boot-path-crashes-on-stale-gem-apis-ruby-llm-1h74cvm"
createdAt: "2026-05-13T09:54:04.508Z"
updatedAt: "2026-05-13T09:54:04.508Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
## ruby_llm 1.15.0 — full API audit (source-verified)

Read `lib/ruby_llm/configuration.rb` + provider files in installed gem. Findings:

### Configuration API in 1.15.0 — flat, not block-based

Every option is declared via `option :name, default` and accessed as `config.name=`. The whole `config.<provider> do |p| ... end` block pattern this repo uses has been **removed**. Providers self-register their config keys via `register_provider_options(%i[provider_api_key provider_api_base])` at load time.

Canonical use (from the gem's own install template):
```ruby
RubyLLM.configure do |config|
  config.openai_api_key = ENV.fetch("OPENAI_API_KEY")
  config.use_new_acts_as = true
end
```

### Cross-reference of our calls vs 1.15.0

| `llm_providers.rb` call | 1.15.0 status | Notes |
|---|---|---|
| `config.log_level=` | ✓ supported | no change needed |
| `config.log_requests=` | ✗ removed | user has commented out |
| `config.request_logger=` | ✗ removed | use `config.logger=` instead |
| `config.request_timeout=` | ✓ supported | default raised 30s → 300s |
| `config.max_retries=` | ✓ supported | |
| `config.retry_backoff=` | ✗ renamed | → `config.retry_backoff_factor=` |
| `config.mistral do |m| ... end` | ✗ **removed entirely** | provider blocks gone |
| `mistral.api_key=` | ✗ → `config.mistral_api_key=` | flat, top-level |
| `mistral.api_base=` | ✗ removed | not in mistral's options (`%i[mistral_api_key]` only) |
| `mistral.models = {...}` | ✗ removed | use model registry (`config.model_registry_file`) |
| `config.openrouter do |or| ... end` | ✗ removed | |
| `openrouter.api_key=` | ✗ → `config.openrouter_api_key=` | |
| `openrouter.api_base=` | ✓ supported as `config.openrouter_api_base=` | |
| `openrouter.headers=` | ✗ removed | not in openrouter's options (`%i[openrouter_api_key openrouter_api_base]`) |
| `openrouter.models = {...}` | ✗ removed | model registry |
| `config.huggingface do |hf| ... end` | ✗ **provider gone** | no `huggingface*` file in `lib/ruby_llm/providers/` |
| HF api_key / api_base / models | ✗ N/A | provider doesn't exist |

### Scope assessment

This is **not** a few renames. ruby_llm went through a configuration redesign between the version this code was written against and 1.15.0:

- Block-based provider config → flat top-level options
- In-config model metadata → external model registry
- Hugging Face provider removed (or repackaged under a different name — no evidence in installed source)

`configure_mistral_provider!`, `configure_openrouter_provider!`, `configure_huggingface_provider!` are all wholesale incompatible. The methods aren't fixable with edits; their entire approach to provider configuration no longer exists.

### Decision required from user

Two paths:

**Path A — pin ruby_llm to a compatible older version**
- Find the last ruby_llm release that still supports `config.mistral do |m| ... end` blocks.
- Update `Gemfile` and `Gemfile.lock`.
- Risk: pinning back may break other parts of the repo that depend on 1.15.0 features (none found in a quick survey, but worth confirming).
- Effort: ~15 min.

**Path B — rewrite `llm_providers.rb` to the 1.15.0 model**
- Flat config: `config.mistral_api_key = ...`, `config.openrouter_api_key = ...`, `config.openrouter_api_base = ...`.
- Drop Hugging Face provider entirely OR replace with a generic OpenAI-compatible endpoint.
- Move custom model definitions (`mistral.models = {...}` etc.) to a `config.model_registry_file` JSON OR drop them (1.15.0 ships its own registry).
- Risk: behavior change — features that depended on custom model cost metadata (`input_cost_per_1m`) need a new home.
- Effort: ~2 hours including testing.

### Recommendation

**Path A** as a temporary unblock so the refactor track can complete card 6 against a working boot, then **Path B** as a separate, properly-scoped initiative. Mixing a deep API migration into a refactor track muddies the diff and the verification story.