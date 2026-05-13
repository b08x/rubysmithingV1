# frozen_string_literal: true

require "zeitwerk"

require_relative "rubysmithing/version"
require_relative "rubysmithing/config"
require_relative "rubysmithing/instrumentation"
require_relative "rubysmithing/boot"

# Public facade for the Rubysmithing gem. Every responsibility lives in a
# dedicated submodule; this file is intentionally a thin pass-through so the
# top-level API surface (`Rubysmithing.config`, `.logger`, `.boot!`, ...) is
# easy to scan in one screen.
module Rubysmithing
  class << self
    def config
      @config ||= Rubysmithing::Config.build
    end

    def configure
      yield(config)
    end

    def reset_config!
      @config = nil
    end

    def logger
      Instrumentation.logger
    end

    def logger=(custom_logger)
      Instrumentation.logger = custom_logger
    end

    def log_agent_event(level, message, **fields)
      Instrumentation.log_agent_event(level, message, **fields)
    end

    def new_correlation_id
      Instrumentation.new_correlation_id
    end

    def with_correlation_id(correlation_id = nil, &block)
      Instrumentation.with_correlation_id(correlation_id, &block)
    end

    def current_correlation_id
      Instrumentation.current_correlation_id
    end

    def loader
      @loader ||= begin
        l = Zeitwerk::Loader.for_gem
        l.setup
        l
      end
    end

    def boot!
      Boot.boot!
    end

    def db
      @db ||= Rubysmithing::Database.connect
    end
  end
end
