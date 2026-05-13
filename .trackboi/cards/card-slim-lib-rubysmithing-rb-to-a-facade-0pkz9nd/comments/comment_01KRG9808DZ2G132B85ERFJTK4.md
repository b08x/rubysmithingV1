---
id: "comment_01KRG9808DZ2G132B85ERFJTK4"
cardId: "card-slim-lib-rubysmithing-rb-to-a-facade-0pkz9nd"
createdAt: "2026-05-13T09:03:51.053Z"
updatedAt: "2026-05-13T09:03:51.053Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
## Done

**LOC trajectory:**
- Baseline: `lib/rubysmithing.rb` = 190 LOC
- After card 2 (Config): 129 LOC
- After card 3 (Instrumentation): 95 LOC
- **After card 4 (Boot extracted): 67 LOC** ✓ under 80-LOC target

**Changes:**
- New `lib/rubysmithing/boot.rb` (55 LOC). Module `Rubysmithing::Boot` with:
  - `boot!` — orchestrates the four startup steps
  - `ensure_directories!` — moved from facade's private section
  - `configure_llm_providers!` — moved from facade's private section
  - `run_migrations!` — split out of inline `boot!` for symmetry; calls `Rubysmithing::Database.migrate(db) if db`
- `lib/rubysmithing.rb` now: 3 requires + `class << self` with 11 public delegators. Zero private methods. No state besides `@config`, `@loader`, `@db` memoization.

**Acceptance check:**
- ✓ File is 67 LOC (target: <80).
- ✓ Public API surface unchanged — all 11 expected singleton methods present (`config`, `configure`, `reset_config!`, `logger`, `logger=`, `log_agent_event`, `new_correlation_id`, `with_correlation_id`, `current_correlation_id`, `loader`, `boot!`, `db`).
- ✓ Zeitwerk loader still resolves (`Rubysmithing.loader → Zeitwerk::GemLoader`).
- ✓ Correlation flow round-trips with explicit IDs.

**Note on Boot dependency direction:**
`Rubysmithing::Boot.configure_llm_providers!` calls `Rubysmithing.log_agent_event(...)` — i.e. boot depends on the facade. This is intentional; Boot is the only module that needs cross-cutting access to config + logger + database, so going through the facade keeps the dependency surface narrow rather than threading three module references through every method.