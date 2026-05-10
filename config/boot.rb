# frozen_string_literal: true

require "bundler/setup"
require "dotenv"

# Load environment variables from the project root
Dotenv.overload(File.expand_path("../.env", __dir__))

require_relative "../lib/rubysmithing"

# Initialize the Rubysmithing library
Rubysmithing.boot!

# Export global DB for backward compatibility with existing scripts and tests
DB = Rubysmithing.db
