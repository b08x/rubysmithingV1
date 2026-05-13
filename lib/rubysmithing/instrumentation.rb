# frozen_string_literal: true

require "journald/logger"
require "logger"
require "socket"

module Rubysmithing
  # Process-level instrumentation: the Journald logger and the correlation ID
  # machinery used to trace work across agent handoffs.
  #
  # Distinct from `Rubysmithing::Logging`, which is a per-instance mixin that
  # *consumes* this layer via `Rubysmithing.logger` / `.log_agent_event` /
  # `.current_correlation_id`.
  module Instrumentation
    module_function

    def logger
      @logger ||= build_logger
    end

    def logger=(custom_logger)
      @logger = custom_logger
    end

    def reset_logger!
      @logger = nil
    end

    # Journald::Logger's level methods accept only a message; structured
    # fields are emitted by tagging the logger for the scope of the call.
    # Block form of `tag` ensures tags are scoped to this single log line
    # rather than mutating the logger's permanent tag set.
    def log_agent_event(level, message, **fields)
      structured_fields = {
        timestamp: Time.now.iso8601,
        thread_id: Thread.current.object_id,
        process_id: Process.pid
      }.merge(fields)

      logger.tag(**structured_fields) { logger.public_send(level, message) }
    end

    def new_correlation_id
      @correlation_counter ||= 0
      @correlation_counter += 1
      "#{Process.pid}-#{Thread.current.object_id}-#{@correlation_counter}-#{Time.now.to_f}"
    end

    def with_correlation_id(correlation_id = nil)
      correlation_id ||= new_correlation_id
      Thread.current[:correlation_id] = correlation_id
      yield correlation_id
    ensure
      Thread.current[:correlation_id] = nil
    end

    def current_correlation_id
      Thread.current[:correlation_id]
    end

    class << self
      private

      def build_logger
        level_str = Rubysmithing.config.fetch(:log_level).upcase
        level = begin
          ::Logger.const_get(level_str)
        rescue NameError
          ::Logger::INFO
        end

        l = Journald::Logger.new("rubysmithing")
        l.level = level
        l.tag(
          app: "rubysmithing",
          version: (defined?(Rubysmithing::VERSION) ? Rubysmithing::VERSION : "unknown"),
          environment: ENV.fetch("RAILS_ENV", "development"),
          hostname: Socket.gethostname
        )
        l
      end
    end
  end
end
