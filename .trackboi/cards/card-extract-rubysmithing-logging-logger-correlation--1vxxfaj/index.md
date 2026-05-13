---
id: "card-extract-rubysmithing-logging-logger-correlation--1vxxfaj"
boardId: "default"
title: "Extract Rubysmithing::Logging (logger + correlation IDs)"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: "track-refactor-decompose-lib-rubysmithing-rb-and-reloc-12z2j3j"
column: "done"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-13T05:10:52.586Z"
updatedAt: "2026-05-13T08:58:51.932Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
Move logging concerns out of `lib/rubysmithing.rb` (lines ~83–138) into `lib/rubysmithing/logging.rb`.

**Scope**
- New module: `Rubysmithing::Logging` owning `logger`, `logger=`, `log_agent_event`, `new_correlation_id`, `with_correlation_id`, `current_correlation_id`.
- Top-level `Rubysmithing.logger` / `.log_agent_event` / correlation API delegate into the module — public surface unchanged.
- Keep Journald tag block (`app`, `version`, `environment`, `hostname`) intact.

**Acceptance**
- Existing callers of `Rubysmithing.log_agent_event(...)` and `Rubysmithing.with_correlation_id(...)` work without changes.
- Logger level still reads from `config.fetch(:log_level)`.