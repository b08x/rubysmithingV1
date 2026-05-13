---
id: "card-refactor-parent-split-lib-rubysmithing-rb-move-b-17y56dd"
boardId: "default"
title: "Refactor parent: split lib/rubysmithing.rb + move boot to exe"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: "track-refactor-decompose-lib-rubysmithing-rb-and-reloc-12z2j3j"
column: "backlog"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-13T05:10:44.495Z"
updatedAt: "2026-05-13T05:10:44.495Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
Umbrella card. See subtasks for execution order. Track owns full context.

**Order of operations** (subtasks should be done roughly in this sequence to keep the hub-file risk contained):

1. Extract `Rubysmithing::Config` (pure data + TTY::Config wiring).
2. Extract `Rubysmithing::Logging` (logger + correlation IDs).
3. Slim `lib/rubysmithing.rb` to a facade.
4. Build out `exe/rubysmithing` as the runtime entry.
5. Migrate `config/boot.rb` importers and decide its fate.