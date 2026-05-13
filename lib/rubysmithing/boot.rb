# frozen_string_literal: true

require "fileutils"

module Rubysmithing
  # Process-level boot orchestration. Owns the side-effecting steps that
  # `Rubysmithing.boot!` performs at startup:
  #
  #   1. Ensure on-disk directories exist
  #   2. Trigger the Zeitwerk loader
  #   3. Configure multi-provider LLM stack
  #   4. Run database migrations (if a connection is available)
  #
  # Each step is exposed as a public module-function so callers can run them
  # in isolation (useful for tests and for the future `exe/rubysmithing` entry
  # point where Bundler/Dotenv setup happens before `boot!`).
  module Boot
    module_function

    def boot!
      ensure_directories!
      Rubysmithing.loader
      configure_llm_providers!
      run_migrations!
    end

    def ensure_directories!
      [
        File.expand_path("~/.config/rubysmithing"),
        Rubysmithing.config.fetch(:gem_db_dir)
      ].each do |dir|
        FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
      end
    end

    def configure_llm_providers!
      require_relative "llm_providers"
      Rubysmithing::LlmProviders.configure!

      Rubysmithing.log_agent_event(
        :info,
        "Multi-provider LLM configuration complete",
        mistral_configured: !Rubysmithing.config.fetch(:mistral_api_key, default: "").empty?,
        openrouter_configured: !Rubysmithing.config.fetch(:openrouter_api_key, default: "").empty?,
        sfl_filter_enabled: Rubysmithing.config.fetch(:sfl_filter_enabled)
      )
    end

    def run_migrations!
      db = Rubysmithing.db
      Rubysmithing::Database.migrate(db) if db
    end
  end
end
