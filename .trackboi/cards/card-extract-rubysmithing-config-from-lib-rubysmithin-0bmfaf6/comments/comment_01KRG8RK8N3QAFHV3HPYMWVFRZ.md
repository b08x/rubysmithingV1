---
id: "comment_01KRG8RK8N3QAFHV3HPYMWVFRZ"
cardId: "card-extract-rubysmithing-config-from-lib-rubysmithin-0bmfaf6"
createdAt: "2026-05-13T08:55:26.229Z"
updatedAt: "2026-05-13T08:55:26.229Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
## Done

**Changes:**
- New module `lib/rubysmithing/config.rb` — `Rubysmithing::Config.build` returns a fully-seeded `TTY::Config`. Defaults grouped by `apply_path_defaults!`, `apply_database_defaults!`, `apply_provider_defaults!`, `apply_model_assignment_defaults!`, `apply_sfl_defaults!`. `Errno::EISDIR` rescue preserved as `load_file_if_present!`.
- `lib/rubysmithing.rb`: `Rubysmithing.config` now memoizes `Rubysmithing::Config.build`. Removed `require "tty-config"` (moved into config.rb). Added `require_relative "rubysmithing/config"` so config is loadable before Zeitwerk runs.

**Verification (smoke test via `bundle exec ruby -e`):**
- All 19 config keys return correct values.
- `.env` overrides via `RUBYSMITHING` env prefix still apply (`ollama_api_base`, `mistral_api_key` came from env).
- `Rubysmithing.reset_config!` works.
- `Rubysmithing::Config` constant and `Rubysmithing.config` method coexist cleanly.

**Defect discovered & fixed (out of scope but blocking):**
- `lib/rubysmithing.rb:36` had `version: Rubysmithing::VERSION rescue "unknown",` inside `l.tag(...)` — Ruby 3.4.4's Prism parser rejects `rescue` modifier inside hash literal arguments. Parenthesized as `(Rubysmithing::VERSION rescue "unknown")`. This was preventing the file from loading at all on Ruby 3.4. Belongs to card 3 (Logging extraction) territory but had to be fixed here to verify.

**Pre-existing, NOT addressed (separate concern):**
- `spec/lib/rubysmithing/gem_verifier_spec.rb` has a broken `require_relative "../../../spec_helper"` path (one `..` too many).
- `lib/rubysmithing/verification/integrator.rb:24` does `require_relative "../../scripts/context_cache"` which resolves to `lib/scripts/context_cache` (doesn't exist — actual file is at repo-root `scripts/context_cache`).

Both predate this refactor — flagging for follow-up.