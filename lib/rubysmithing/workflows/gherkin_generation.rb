# frozen_string_literal: true

require "dspy"

module Rubysmithing
  module Workflows
    # DSPy signature for generating Gherkin features from user stories
    # Final transformation stage before test execution
    class GherkinGeneration < DSPy::Signature
      description "Generate executable Gherkin features from structured user stories"

      class ScenarioType < T::Enum
        enums do
          Happy = new('happy_path')
          Sad = new('sad_path')
          Edge = new('edge_case')
          Error = new('error_handling')
          Performance = new('performance')
          Security = new('security')
        end
      end

      class StepType < T::Enum
        enums do
          Given = new('given')    # Context/preconditions
          When = new('when')      # Action/event
          Then = new('then')      # Expected outcome
          And = new('and')        # Additional context
          But = new('but')        # Negative condition
        end
      end

      class GherkinStep < T::Struct
        const :type, StepType
        const :text, String
        const :table_data, T.nilable(T::Array[T::Array[String]])
        const :doc_string, T.nilable(String)
        const :automation_hint, T.nilable(String)
      end

      class GherkinScenario < T::Struct
        const :name, String
        const :type, ScenarioType
        const :description, T.nilable(String)
        const :tags, T::Array[String]
        const :steps, T::Array[GherkinStep]
        const :examples, T.nilable(T::Array[T::Array[String]])  # For scenario outlines
        const :priority, String
      end

      class GherkinFeature < T::Struct
        const :name, String
        const :description, String
        const :tags, T::Array[String]
        const :scenarios, T::Array[GherkinScenario]
        const :background, T.nilable(T::Array[GherkinStep])
        const :filename, String
        const :source_story_id, String
      end

      class GenerationMetadata < T::Struct
        const :total_features, Integer
        const :total_scenarios, Integer
        const :coverage_analysis, T::Hash[String, T.untyped]
        const :automation_readiness, Float
        const :generated_at, Time
      end

      input do
        const :user_stories, T::Array[T::Hash[String, T.untyped]], desc: "Structured user stories"
        const :feature_template, String, default: "standard", enum: ["standard", "api", "ui", "integration"]
        const :scenario_coverage, String, default: "comprehensive", enum: ["basic", "standard", "comprehensive"]
        const :automation_hints, T::Boolean, default: true, desc: "Include step automation hints"
      end

      output do
        const :features, T::Array[GherkinFeature], desc: "Generated Gherkin features"
        const :metadata, GenerationMetadata, desc: "Generation statistics"
        const :validation_results, T::Array[String], desc: "Gherkin syntax validation results"
        const :automation_gaps, T::Array[String], desc: "Steps that need automation work"
        const :quality_metrics, T::Hash[String, Float], desc: "Feature quality assessment"
      end
    end
  end
end