---
id: "comment_01KRG8YV1DVAEPV3V9486MVHMP"
cardId: "card-extract-rubysmithing-logging-logger-correlation--1vxxfaj"
createdAt: "2026-05-13T08:58:50.797Z"
updatedAt: "2026-05-13T08:58:50.797Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
## Done — with namespace adaptation

**Discovery that reshaped the card:**
`lib/rubysmithing/logging.rb` already exists as the **agent mixin** (`include Rubysmithing::Logging` in agent classes — provides `log_agent_operation`, `log_coordination`, `log_performance`, `with_performance_logging`, `log_hub_event`, `log_spoke_event`, `log_workflow_stage`, `agent_id`). It *consumes* the singleton API (`Rubysmithing.logger`, `.log_agent_event`, `.current_correlation_id`).

Reusing that namespace for the singleton infrastructure would have collapsed two distinct concerns. Split into two modules:
- `Rubysmithing::Logging` (existing, untouched) — per-instance mixin for agents
- `Rubysmithing::Instrumentation` (new) — process-level logger init + correlation IDs + `log_agent_event`

**Changes:**
- New `lib/rubysmithing/instrumentation.rb`: `logger`, `logger=`, `reset_logger!`, `log_agent_event`, `new_correlation_id`, `with_correlation_id`, `current_correlation_id`. Journald tag block (`app`, `version`, `environment`, `hostname`) preserved.
- `lib/rubysmithing.rb`: all singleton logger/correlation methods become thin delegators to `Instrumentation`. Removed top-level requires for `journald/logger`, `logger`, `socket` (moved into instrumentation.rb).
- `Time.current` → `Time.now` (drops a latent ActiveSupport dependency that was never explicitly required).
- `version: (Rubysmithing::VERSION rescue "unknown")` → `defined?(Rubysmithing::VERSION) ? Rubysmithing::VERSION : "unknown"` (cleaner, no exception-driven control flow).

**Verification (smoke):**
- `Rubysmithing.logger` returns `Journald::Logger`.
- `Rubysmithing.with_correlation_id` yields a new ID, sets `Thread.current[:correlation_id]`, clears it after.
- Explicit IDs round-trip correctly.
- `Rubysmithing.logger=` setter works; `Instrumentation.reset_logger!` rebuilds.
- `Rubysmithing::Logging` mixin still loads as a distinct module.

**Pre-existing defect surfaced (NOT addressed):**
- `log_agent_event` calls `logger.public_send(level, message, structured_fields)` — but journald-logger 3.1.0's level methods accept 0–1 args, not 2. Raises `ArgumentError: wrong number of arguments (given 2, expected 0..1)`. This bug existed in the original code; preserving identical behavior. Should be fixed via `logger.tag(structured_fields).public_send(level, message)` pattern, but that's a behavior change and belongs on a follow-up bug card.