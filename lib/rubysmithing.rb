# frozen_string_literal: true

require "journald/logger"
require "logger"
require "socket"
require "tty-config"
require "zeitwerk"

module Rubysmithing
  class << self
    def config
      @config ||= begin
        c = TTY::Config.new
        c.filename = "rubysmithing"
        c.extname = ".yml"
        c.append_path(File.expand_path("~/.config/rubysmithing"))
        c.append_path(Dir.pwd)
        
        # Enable environment variable loading
        c.env_prefix = "RUBYSMITHING"
        c.autoload_env
        
        # Defaults with ENV fallbacks
        c.set(:database_url, value: ENV.fetch("DATABASE_URL", "postgres:///rubysmithing_rag"))
        c.set(:gem_db_dir, value: ENV.fetch("RUBY_GEM_DB_DIR", File.expand_path("~/.config/rubysmithing/db")))
        c.set(:log_level, value: ENV.fetch("LOG_LEVEL", "INFO"))
        c.set(:ollama_api_base, value: ENV.fetch("OLLAMA_API_BASE", "http://localhost:11434/v1"))
        
        # LLM Defaults
        c.set(:blueprint_embedding_provider, value: :ollama)
        c.set(:blueprint_embedding_model, value: "embeddinggemma:latest")
        
        c.set(:rag_embedding_provider, value: :openrouter)
        c.set(:rag_embedding_model, value: "mistralai/mistral-embed")
        
        c.set(:builder_model, value: "google/gemini-2.0-flash-lite-001")
        
        # Read from file if it exists
        begin
          c.read if c.exist?
        rescue Errno::EISDIR
          # Fallback or skip if it still hits a directory
        end
        c
      end
    end

    def configure
      yield(config)
    end

    def reset_config!
      @config = nil
    end

    def logger
      @logger ||= begin
        level_str = config.fetch(:log_level).upcase
        level = Logger.const_get(level_str) rescue Logger::INFO

        # Initialize Journald Logger with enhanced structured fields
        l = Journald::Logger.new("rubysmithing")
        l.level = level

        # Base tags for all log entries
        l.tag(
          app: "rubysmithing",
          version: Rubysmithing::VERSION rescue "unknown",
          environment: ENV.fetch("RAILS_ENV", "development"),
          hostname: Socket.gethostname
        )
        l
      end
    end

    # Enhanced logging for agent coordination with structured fields
    def log_agent_event(level, message, **fields)
      # Merge agent context with user fields
      structured_fields = {
        timestamp: Time.current.iso8601,
        thread_id: Thread.current.object_id,
        process_id: Process.pid
      }.merge(fields)

      logger.public_send(level, message, structured_fields)
    end

    # Generate correlation ID for tracking agent handoffs
    def new_correlation_id
      @correlation_counter ||= 0
      @correlation_counter += 1
      "#{Process.pid}-#{Thread.current.object_id}-#{@correlation_counter}-#{Time.current.to_f}"
    end

    # Set correlation ID for current thread context
    def with_correlation_id(correlation_id = nil)
      correlation_id ||= new_correlation_id
      Thread.current[:correlation_id] = correlation_id
      yield correlation_id
    ensure
      Thread.current[:correlation_id] = nil
    end

    # Get current correlation ID from thread context
    def current_correlation_id
      Thread.current[:correlation_id]
    end

    def logger=(custom_logger)
      @logger = custom_logger
    end

    def loader
      @loader ||= begin
        l = Zeitwerk::Loader.for_gem
        l.setup
        l
      end
    end

    def boot!
      # Ensure directories
      ensure_directories!

      # Configure LLMs
      configure_llm!

      # Setup Autoloading
      loader

      # Run migrations if applicable
      Rubysmithing::Database.migrate(db) if db
    end

    def db
      @db ||= Rubysmithing::Database.connect
    end

    private

    def configure_llm!
      RubyLLM.configure do |c|
        c.ollama_api_base = config.fetch(:ollama_api_base)
      end
    end

    def ensure_directories!
      [
        File.expand_path("~/.config/rubysmithing"),
        config.fetch(:gem_db_dir)
      ].each do |dir|
        FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
      end
    end
  end
end
