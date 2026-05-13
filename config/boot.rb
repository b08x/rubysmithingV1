# frozen_string_literal: true
#
# Test- and script-side bootstrap shim.
#
# `exe/rubysmithing` is the canonical runtime entry. This file exists because
# test scripts and Cucumber load the library *into their own process* and so
# need the same Bundler + Dotenv + `Rubysmithing.boot!` setup that `exe/`
# performs — they can't shell out to the binary.
#
# New code should `require "rubysmithing"` + call `Rubysmithing.boot!`
# directly. Scripts under `tests/` and `features/support/env.rb` continue to
# require this shim until they're individually migrated.

require "bundler/setup"
require "dotenv"

Dotenv.overload(File.expand_path("../.env", __dir__))

require_relative "../lib/rubysmithing"

Rubysmithing.boot!

# DEPRECATED: use `Rubysmithing.db` in new code. The top-level `DB` constant
# is preserved here for legacy test scripts that predate the
# `Rubysmithing.db` accessor. Once all callers are migrated, this assignment
# and the entire file can be deleted.
DB = Rubysmithing.db
