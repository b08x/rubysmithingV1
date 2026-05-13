# frozen_string_literal: true

require "tty-config"

module Rubysmithing
  # Builds and seeds the TTY::Config instance returned by `Rubysmithing.config`.
  #
  # Defaults are grouped by concern (paths, database, providers, model
  # assignments, SFL) so future changes can target a single section without
  # touching unrelated wiring.
  module Config
    module_function

    def build
      c = TTY::Config.new
      c.filename = "rubysmithing"
      c.extname = ".yml"
      c.append_path(File.expand_path("~/.config/rubysmithing"))
      c.append_path(Dir.pwd)

      c.env_prefix = "RUBYSMITHING"
      c.autoload_env

      apply_defaults!(c)
      load_file_if_present!(c)

      c
    end

    def apply_defaults!(c)
      apply_path_defaults!(c)
      apply_database_defaults!(c)
      apply_provider_defaults!(c)
      apply_model_assignment_defaults!(c)
      apply_sfl_defaults!(c)
    end

    def apply_path_defaults!(c)
      c.set(:gem_db_dir,
            value: ENV.fetch("RUBY_GEM_DB_DIR", File.expand_path("~/.config/rubysmithing/db")))
      c.set(:log_level, value: ENV.fetch("LOG_LEVEL", "INFO"))
    end

    def apply_database_defaults!(c)
      c.set(:database_url,
            value: ENV.fetch("DATABASE_URL", "postgres:///rubysmithing_rag"))
    end

    def apply_provider_defaults!(c)
      c.set(:ollama_api_base,
            value: ENV.fetch("OLLAMA_API_BASE", "http://localhost:11434/v1"))

      c.set(:mistral_api_base,
            value: ENV.fetch("MISTRAL_API_BASE", "https://api.mistral.ai/v1"))
      c.set(:mistral_api_key, value: ENV.fetch("MISTRAL_API_KEY", ""))

      c.set(:openrouter_api_base,
            value: ENV.fetch("OPENROUTER_API_BASE", "https://openrouter.ai/api/v1"))
      c.set(:openrouter_api_key, value: ENV.fetch("OPENROUTER_API_KEY", ""))

      c.set(:hf_inference_api_base,
            value: ENV.fetch("HF_API_BASE", "https://api-inference.huggingface.co"))
      c.set(:hf_api_key, value: ENV.fetch("HF_API_KEY", ""))
    end

    def apply_model_assignment_defaults!(c)
      c.set(:embedding_provider, value: :openrouter)
      c.set(:embedding_model, value: "mistralai/mistral-embed")

      c.set(:reasoning_provider, value: :mistral)
      c.set(:reasoning_model, value: "mistral-medium-3.5")

      c.set(:coding_provider, value: :mistral)
      c.set(:coding_model, value: "codestral")

      c.set(:lightweight_provider, value: :mistral)
      c.set(:lightweight_model, value: "mistral-nemo")

      c.set(:experimental_provider, value: :openrouter)
      c.set(:experimental_model, value: "qwen/qwen-2.5-72b-instruct")
    end

    def apply_sfl_defaults!(c)
      c.set(:sfl_analysis_provider, value: :mistral)
      c.set(:sfl_analysis_model, value: "mistral-small")
      c.set(:sfl_filter_enabled, value: true)
      c.set(:sfl_consistency_threshold, value: 0.85)
    end

    # TTY::Config#exist? can race with a path resolving to a directory; the
    # rescue mirrors the original behavior in lib/rubysmithing.rb.
    def load_file_if_present!(c)
      c.read if c.exist?
    rescue Errno::EISDIR
      nil
    end
  end
end
