# frozen_string_literal: true

require "fileutils"

module Rubysmithing
  # Handles environment and directory initialization before the suite runs.
  module PreFlight
    CONFIG_DIR = File.expand_path("~/.config/rubysmithing")
    DB_DIR = File.join(CONFIG_DIR, "db")

    def self.run!
      ensure_directories
      validate_environment
    end

    def self.ensure_directories
      [CONFIG_DIR, DB_DIR].each do |dir|
        unless Dir.exist?(dir)
          # puts "[Pre-flight] Creating directory: #{dir}"
          FileUtils.mkdir_p(dir)
        end
      end
    end

    def self.validate_environment
      # Set default RUBY_GEM_DB_DIR if not present
      ENV["RUBY_GEM_DB_DIR"] ||= DB_DIR
    end
  end
end
