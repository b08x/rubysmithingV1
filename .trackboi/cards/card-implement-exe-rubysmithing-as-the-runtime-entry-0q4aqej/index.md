---
id: "card-implement-exe-rubysmithing-as-the-runtime-entry-0q4aqej"
boardId: "default"
title: "Implement exe/rubysmithing as the runtime entry"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: "track-refactor-decompose-lib-rubysmithing-rb-and-reloc-12z2j3j"
column: "done"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-13T05:11:00.577Z"
updatedAt: "2026-05-13T09:59:36.690Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
`exe/rubysmithing` is currently an empty shebang. Make it the canonical runtime entry that absorbs what `config/boot.rb` does today.

**Scope**
- `#!/usr/bin/env ruby` + `# frozen_string_literal: true`.
- `require "bundler/setup"` and `Dotenv.overload(File.expand_path("../.env", __dir__))` (path-correct relative to `exe/`).
- `require "rubysmithing"` (use the gem's load path, not `require_relative`).
- Call `Rubysmithing.boot!`.
- Dispatch to a CLI handler (placeholder fine — could be a future `Rubysmithing::CLI.start(ARGV)`).
- `chmod +x` and ensure `bin/console` / Gemfile reference is intact.

**Acceptance**
- `bundle exec exe/rubysmithing` boots without errors.
- Works without depending on `config/boot.rb`.