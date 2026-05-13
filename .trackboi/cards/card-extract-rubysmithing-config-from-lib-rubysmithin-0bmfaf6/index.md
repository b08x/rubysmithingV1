---
id: "card-extract-rubysmithing-config-from-lib-rubysmithin-0bmfaf6"
boardId: "default"
title: "Extract Rubysmithing::Config from lib/rubysmithing.rb"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: "track-refactor-decompose-lib-rubysmithing-rb-and-reloc-12z2j3j"
column: "done"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-13T05:10:48.697Z"
updatedAt: "2026-05-13T09:21:53.432Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
Move TTY::Config setup and all `c.set(...)` defaults out of `lib/rubysmithing.rb` (lines ~11–73) into `lib/rubysmithing/config.rb`.

**Scope**
- New module: `Rubysmithing::Config` with `.build`, `.defaults`, and the env-prefix wiring.
- Group defaults by concern: paths, database, providers (mistral/openrouter/hf), model assignments, SFL.
- Keep `Rubysmithing.config` delegating to the new module so callers are unaffected.
- Preserve the `Errno::EISDIR` rescue.

**Acceptance**
- `Rubysmithing.config.fetch(:database_url)` returns the same value as before.
- `Rubysmithing.reset_config!` still works.
- rspec + cucumber green.