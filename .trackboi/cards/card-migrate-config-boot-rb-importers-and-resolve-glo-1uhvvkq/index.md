---
id: "card-migrate-config-boot-rb-importers-and-resolve-glo-1uhvvkq"
boardId: "default"
title: "Migrate config/boot.rb importers and resolve global DB constant"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: "track-refactor-decompose-lib-rubysmithing-rb-and-reloc-12z2j3j"
column: "done"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-13T05:11:05.524Z"
updatedAt: "2026-05-13T10:21:43.923Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
⚠️ HUB FILE: `config/boot.rb` has 10 importers per codemap. Do this last so the refactor lands behind it.

**Scope**
- Inventory importers: `rg -n "config/boot" -- .` and `rg -n "require.*boot" -- .`.
- For each importer, switch to `require "rubysmithing"` + `Rubysmithing.boot!` (or rely on the exe wrapper for runtime callers).
- Decide fate of global `DB = Rubysmithing.db`: either keep `config/boot.rb` as a thin test/dev shim that defines `DB` for legacy scripts, or migrate every reference to `Rubysmithing.db` and delete the file.
- Update `bin/console`, scripts/, tests/, features/support/ as needed.

**Acceptance**
- All importer call sites still load successfully.
- Cucumber + rspec green.
- Either `config/boot.rb` is gone OR it is reduced to a documented compat shim with a clear deprecation comment.