# frozen_string_literal: true

require "dspy"

module Rubysmithing
  module Workflows
    # DSPy signature for test execution and result analysis
    # Final stage of the SFL-BDD pipeline with comprehensive reporting
    class TestExecution < DSPy::Signature
      description "Execute Gherkin features and analyze test results for SFL-BDD pipeline"

      class TestStatus < T::Enum
        enums do
          Passed = new('passed')
          Failed = new('failed')
          Skipped = new('skipped')
          Pending = new('pending')
          Undefined = new('undefined')
        end
      end

      class ExecutionEnvironment < T::Enum
        enums do
          Development = new('development')
          Testing = new('testing')
          Staging = new('staging')
          Production = new('production')
          Container = new('container')
        end
      end

      class StepResult < T::Struct
        const :step_text, String
        const :status, TestStatus
        const :duration_ms, Float
        const :error_message, T.nilable(String)
        const :screenshot_path, T.nilable(String)
        const :automation_notes, T::Array[String]
      end

      class ScenarioResult < T::Struct
        const :scenario_name, String
        const :status, TestStatus
        const :duration_ms, Float
        const :step_results, T::Array[StepResult]
        const :tags, T::Array[String]
        const :failure_reason, T.nilable(String)
      end

      class FeatureResult < T::Struct
        const :feature_name, String
        const :filename, String
        const :status, TestStatus
        const :duration_ms, Float
        const :scenario_results, T::Array[ScenarioResult]
        const :coverage_percentage, Float
        const :source_story_id, String
      end

      class ExecutionMetrics < T::Struct
        const :total_features, Integer
        const :total_scenarios, Integer
        const :total_steps, Integer
        const :pass_rate, Float
        const :execution_time_ms, Float
        const :environment, ExecutionEnvironment
        const :parallel_workers, Integer
        const :memory_usage_mb, Float
      end

      class QualityAssessment < T::Struct
        const :sfl_coverage_score, Float     # How well tests cover SFL analysis
        const :story_traceability, Float     # Link quality back to user stories
        const :automation_quality, Float     # Step automation effectiveness
        const :maintainability_score, Float  # Test maintenance difficulty
        const :performance_score, Float      # Execution efficiency
      end

      input do
        const :features, T::Array[T::Hash[String, T.untyped]], desc: "Gherkin features to execute"
        const :environment, ExecutionEnvironment, desc: "Target execution environment"
        const :execution_options, T::Hash[String, T.untyped], default: {}, desc: "Custom execution settings"
        const :parallel_workers, Integer, default: 4, desc: "Number of parallel test workers"
        const :timeout_seconds, Integer, default: 300, desc: "Maximum execution time"
      end

      output do
        const :execution_results, T::Array[FeatureResult], desc: "Detailed test execution results"
        const :metrics, ExecutionMetrics, desc: "Execution performance metrics"
        const :quality_assessment, QualityAssessment, desc: "Quality and coverage analysis"
        const :failure_analysis, T::Array[String], desc: "Root cause analysis of failures"
        const :recommendations, T::Array[String], desc: "Improvement suggestions"
        const :sfl_insights, T::Array[String], desc: "Linguistic insights from test results"
        const :next_steps, T::Array[String], desc: "Recommended follow-up actions"
      end
    end
  end
end