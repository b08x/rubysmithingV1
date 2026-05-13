## Current state

- `lib/rubysmithing.rb` (190 LOC) is a single `module Rubysmithing` with `class << self` containing:
  - TTY::Config setup with ~20 hardcoded defaults (LLM providers, SFL, paths)
  - Journald logger init + tag wiring
  - `log_agent_event`, `new_correlation_id`, `with_correlation_id`, `current_correlation_id`
  - Zeitwerk loader
  - `boot!` orchestration (directories, loader, LLM providers, migrations)
  - `db` accessor
  - private `configure_llm_providers!` and `ensure_directories!`
- `config/boot.rb` does `bundler/setup`, `Dotenv.overload`, requires the lib, calls `boot!`, and sets global `DB` constant.
- `exe/rubysmithing` is currently an empty shebang — no CLI entry implemented.

## Goal

- `lib/rubysmithing.rb` becomes a thin facade that requires submodules and exposes the public API.
- Configuration defaults live in a dedicated module (e.g. `Rubysmithing::Config`).
- Logger + correlation helpers live in their own module (e.g. `Rubysmithing::Logging`).
- LLM provider config stays separated (already partially extracted into `llm_providers`).
- `exe/rubysmithing` becomes the runtime entry that owns Bundler/Dotenv setup and triggers `Rubysmithing.boot!`.
- `config/boot.rb` either disappears or shrinks to a test/dev-only loader. Global `DB` constant should be reassessed — prefer `Rubysmithing.db` everywhere.

## Constraints

- `config/boot.rb` is a HUB FILE (10 importers per codemap). Removing or shrinking it requires updating every importer.
- Behavior must remain identical: `Rubysmithing.config`, `.logger`, `.boot!`, `.db`, correlation ID API must keep their current signatures.
- Zeitwerk autoload paths must keep working after the split.

## Done when

- No single file in `lib/rubysmithing/` exceeds ~80 LOC of the extracted concerns.
- `exe/rubysmithing` boots the app standalone.
- All `require_relative "config/boot"` (or equivalent) call sites continue to work or are migrated.
- Test suite (rspec + cucumber) passes.
