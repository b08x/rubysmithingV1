---
id: "card-slim-lib-rubysmithing-rb-to-a-facade-0pkz9nd"
boardId: "default"
title: "Slim lib/rubysmithing.rb to a facade"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: "track-refactor-decompose-lib-rubysmithing-rb-and-reloc-12z2j3j"
column: "done"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-13T05:10:56.372Z"
updatedAt: "2026-05-13T09:21:57.998Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
After Config and Logging extractions, reduce `lib/rubysmithing.rb` to:

- Top-of-file requires (zeitwerk + the new submodules).
- `module Rubysmithing` with VERSION + a tiny `class << self` exposing `config`, `configure`, `reset_config!`, `logger`, `logger=`, `loader`, `boot!`, `db`, and the correlation helpers — all delegating to the new modules.
- `boot!` keeps orchestration only: `ensure_directories!`, `loader`, `configure_llm_providers!`, `Database.migrate`.

**Acceptance**
- File is well under 80 LOC.
- No behavior change in public API.
- Zeitwerk loader still autoloads `Rubysmithing::*`.