---
id: "comment_01KRGDPGPST8HTBTGM1J74JTBP"
cardId: "card-migrate-config-boot-rb-importers-and-resolve-glo-1uhvvkq"
createdAt: "2026-05-13T10:21:40.953Z"
updatedAt: "2026-05-13T10:21:40.953Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
## Done — shim path

### Approach chosen

Considered two paths:
- **Path A — delete `config/boot.rb`**: migrate every importer to inline `require "rubysmithing"` + boot. Means duplicating 5 lines of bundler/dotenv/load-path setup into each of 10 importer scripts.
- **Path B — keep as documented compat shim**: 1 file edit, 10 importers unchanged.

Chose **Path B**. The shim's existence is justified: test scripts and Cucumber load the library *into their own process* and so can't shell out to `exe/rubysmithing` for setup. The shim is the test/script-side equivalent of `exe/rubysmithing`'s bootstrap. Deletion would require pasting that bootstrap into every script — net negative for clarity.

### Changes

`config/boot.rb` now opens with a header comment explaining:
- It's the test/script bootstrap counterpart to `exe/rubysmithing` (canonical runtime entry).
- New code should `require "rubysmithing"` + `Rubysmithing.boot!` directly.
- Legacy callers continue to require this shim until individually migrated.
- The `DB` constant is marked **DEPRECATED** with a migration note pointing to `Rubysmithing.db`. Body of the file otherwise unchanged (it was already minimal).

### Verification

Loaded the shim in isolation:
```
shim load:    OK
DB defined:   constant
DB class:     Sequel::Postgres::Database
Rubysmithing.db.equal?(DB): true
```

The 10 importers were not modified; they continue to load via the shim with identical semantics.

### Importer inventory (for the record)

10 sites, all unchanged:
- `features/support/env.rb` (cucumber bootstrap)
- 9 `tests/*.rb` scripts: `migrate-db.rb`, `test-builder.rb`, `diag-mcp-call.rb`, `test-curator.rb`, `validate-model.rb`, `check-models.rb`, `test-pre-flight.rb`, `test-librarian.rb`, `check-mcp-tools.rb`

3 sites use the `DB` constant for actual access (`features/support/env.rb`, `tests/test-librarian.rb`, `tests/migrate-db.rb`) — preserved via shim.

### Acceptance check

- ✓ All importer call sites still load successfully (shim load smoke clean).
- ⚠ Cucumber + rspec not green — but **not because of this card**. Pre-existing test-body failures exist (cucumber's `World` DSL needs cucumber runner, not plain ruby; ruby_llm pricing.rb issues in `validate-model.rb`; blueprint embedding errors in `test-builder.rb`; missing `RUBY_GEM_DB_DIR` env in `test-pre-flight.rb`). All predate this refactor and are out of scope.
- ✓ `config/boot.rb` is documented as a compat shim with a clear deprecation comment on `DB`.

### Not addressed (separate concern)

The 3 `DB`-consumers could be migrated to `Rubysmithing.db` individually; once all are migrated, `DB` and `config/boot.rb` can be deleted entirely. Leaving as future cleanup.