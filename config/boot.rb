# frozen_string_literal: true

require "bundler/setup"
require "dotenv"
require "zeitwerk"

# Load environment variables from the plugin directory
Dotenv.overload(File.expand_path("../.env", __dir__))

# Run Pre-flight checks (creates ~/.config/rubysmithing, etc.)
require_relative "../lib/rubysmithing"
require_relative "../lib/rubysmithing/pre_flight"
Rubysmithing::PreFlight.run!

# Configure Zeitwerk loader
loader = Zeitwerk::Loader.new
loader.push_dir(File.expand_path("../lib", __dir__))
loader.setup

# Initialize Database
require_relative "../lib/rubysmithing/database"
DB = Rubysmithing::Database.connect

# Auto-migrate if DB is connected
Rubysmithing::Database.migrate(DB) if DB
