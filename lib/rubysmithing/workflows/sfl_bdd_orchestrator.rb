# frozen_string_literal: true

require "dspy"

module Rubysmithing
  module Workflows
    # Main orchestrator for the complete SFL-BDD pipeline
    # Coordinates all workflow stages with comprehensive error handling
    class SflBddOrchestrator < DSPy::Signature
      description "Orchestrate complete SFL-powered BDD workflow from natural language to test execution"

      class PipelineStage < T::Enum
        enums do
          Input = new('input_validation')
          Analysis = new('sfl_analysis')
          Stories = new('story_generation')
          Features = new('gherkin_generation')
          Execution = new('test_execution')
          Complete = new('pipeline_complete')
        end
      end

      class PipelineStatus < T::Enum
        enums do
          Success = new('success')
          Warning = new('warning')
          Error = new('error')
          Retry = new('retry_required')
        end
      end

      class StageResult < T::Struct
        const :stage, PipelineStage
        const :status, PipelineStatus
        const :duration_ms, Float
        const :output_data, T::Hash[String, T.untyped]
        const :error_details, T.nilable(String)
        const :quality_score, Float
        const :warnings, T::Array[String]
      end

      class PipelineConfiguration < T::Struct
        const :analysis_depth, String
        const :story_template, String
        const :feature_template, String
        const :execution_environment, String
        const :parallel_workers, Integer
        const :quality_thresholds, T::Hash[String, Float]
        const :retry_settings, T::Hash[String, Integer]
      end

      class ComprehensiveResult < T::Struct
        const :pipeline_id, String
        const :stage_results, T::Array[StageResult]
        const :final_status, PipelineStatus
        const :total_duration_ms, Float
        const :quality_metrics, T::Hash[String, Float]
        const :generated_artifacts, T::Hash[String, String]  # stage -> file_path
        const :sfl_insights, T::Array[String]
        const :recommendations, T::Array[String]
        const :execution_summary, String
      end

      input do
        const :raw_input, String, desc: "Original natural language input"
        const :configuration, PipelineConfiguration, desc: "Pipeline execution settings"
        const :context, T.nilable(String), desc: "Additional domain context"
        const :resume_from_stage, T.nilable(PipelineStage), desc: "Resume from specific stage if retry"
      end

      output do
        const :result, ComprehensiveResult, desc: "Complete pipeline execution results"
        const :success, T::Boolean, desc: "Overall pipeline success indicator"
        const :stage_artifacts, T::Hash[String, T.untyped], desc: "Outputs from each stage"
        const :performance_analysis, T::Hash[String, Float], desc: "Performance metrics per stage"
        const :failure_recovery, T.nilable(String), desc: "Recovery strategy if failed"
        const :next_iteration_suggestions, T::Array[String], desc: "Improvements for next run"
      end
    end
  end
end