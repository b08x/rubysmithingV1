---
id: "track-refactor-decompose-lib-rubysmithing-rb-and-reloc-12z2j3j"
title: "Refactor: decompose lib/rubysmithing.rb and relocate boot loading"
slug: "refactor-decompose-lib-rubysmithing-rb-and-relocate-boot-loading"
createdAt: "2026-05-13T05:10:33.287Z"
updatedAt: "2026-05-13T05:10:33.287Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
`lib/rubysmithing.rb` has grown to ~190 lines mixing config, logging, correlation IDs, LLM provider wiring, directory bootstrap, DB access, and boot orchestration. Split it into focused modules and move runtime boot loading out of `config/boot.rb` into `exe/rubysmithing`.