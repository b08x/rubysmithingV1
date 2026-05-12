# frozen_string_literal: true

module Rubysmithing
  # Agent-aware structured logging mixin for journald integration
  # Provides correlation tracking, performance metrics, and agent context
  module Logging
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # Get logger with agent class context
      def agent_logger
        @agent_logger ||= Rubysmithing.logger
      end
    end

    # Get logger instance with agent context
    def logger
      self.class.agent_logger
    end

    # Log agent operation with structured fields
    def log_agent_operation(level, operation, **fields)
      agent_fields = {
        agent_class: self.class.name,
        agent_id: agent_id,
        operation: operation,
        correlation_id: Rubysmithing.current_correlation_id
      }

      Rubysmithing.log_agent_event(level, "Agent operation: #{operation}", **agent_fields.merge(fields))
    end

    # Log agent coordination events (handoffs, delegation, etc.)
    def log_coordination(level, event, target_agent: nil, **fields)
      coordination_fields = {
        event_type: "coordination",
        coordination_event: event,
        source_agent: agent_id,
        target_agent: target_agent,
        correlation_id: Rubysmithing.current_correlation_id
      }

      Rubysmithing.log_agent_event(level, "Agent coordination: #{event}", **coordination_fields.merge(fields))
    end

    # Log performance metrics for operations
    def log_performance(operation, duration_ms, **metrics)
      performance_fields = {
        event_type: "performance",
        operation: operation,
        duration_ms: duration_ms,
        agent_class: self.class.name,
        correlation_id: Rubysmithing.current_correlation_id
      }

      Rubysmithing.log_agent_event(:info, "Performance: #{operation} (#{duration_ms}ms)",
                                  **performance_fields.merge(metrics))
    end

    # Measure and log operation performance
    def with_performance_logging(operation, **extra_fields)
      start_time = Time.current
      log_agent_operation(:info, "#{operation}_start", **extra_fields)

      result = yield

      duration_ms = ((Time.current - start_time) * 1000).round(2)
      log_performance(operation, duration_ms, success: true, **extra_fields)

      result
    rescue => error
      duration_ms = ((Time.current - start_time) * 1000).round(2) if defined?(start_time)

      log_agent_operation(:error, "#{operation}_error",
                         error_class: error.class.name,
                         error_message: error.message,
                         duration_ms: duration_ms,
                         **extra_fields)
      raise
    end

    # Log structured errors with context
    def log_error(error, context: nil, **fields)
      error_fields = {
        event_type: "error",
        error_class: error.class.name,
        error_message: error.message,
        backtrace: error.backtrace&.first(5),
        agent_class: self.class.name,
        agent_id: agent_id,
        context: context,
        correlation_id: Rubysmithing.current_correlation_id
      }

      Rubysmithing.log_agent_event(:error, "Agent error: #{error.class.name}",
                                  **error_fields.merge(fields))
    end

    # Generate unique agent ID for this instance
    def agent_id
      @agent_id ||= "#{self.class.name.demodulize.underscore}_#{object_id}_#{Process.pid}"
    end

    # Hub-and-spoke specific logging methods
    def log_hub_event(event, **fields)
      log_coordination(:info, event,
                      hub_role: "coordinator",
                      spoke_count: fields[:spoke_count],
                      **fields)
    end

    def log_spoke_event(event, hub_agent: nil, **fields)
      log_coordination(:info, event,
                      spoke_role: "worker",
                      target_agent: hub_agent,
                      **fields)
    end

    # Survey → Resolve → Dispatch → Audit flow logging
    def log_workflow_stage(stage, status: :start, **fields)
      stage_fields = {
        workflow_stage: stage,
        stage_status: status,
        workflow_type: "survey_resolve_dispatch_audit"
      }

      log_agent_operation(:info, "workflow_#{stage}_#{status}", **stage_fields.merge(fields))
    end
  end
end