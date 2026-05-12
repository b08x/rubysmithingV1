# frozen_string_literal: true

# SFL-BDD Workflow DSPy Signatures
# Type-safe, structured LLM programming for linguistic analysis and test generation
#
# Pipeline Flow:
# 1. NaturalLanguageInput  -> Validate and structure input text
# 2. SflAnalysis          -> Perform metafunction analysis
# 3. UserStoryGeneration  -> Generate structured user stories
# 4. GherkinGeneration    -> Create executable Gherkin features
# 5. TestExecution        -> Run tests and analyze results
# 6. SflBddOrchestrator   -> Coordinate complete pipeline
#
# Usage:
#   orchestrator = DSPy::Predict.new(Rubysmithing::Workflows::SflBddOrchestrator)
#   result = orchestrator.call(
#     raw_input: "As a developer, I need reliable gem validation...",
#     configuration: pipeline_config,
#     context: "Ruby gem management system"
#   )

require_relative "workflows/natural_language_input"
require_relative "workflows/sfl_analysis"
require_relative "workflows/user_story_generation"
require_relative "workflows/gherkin_generation"
require_relative "workflows/test_execution"
require_relative "workflows/sfl_bdd_orchestrator"

module Rubysmithing
  # SFL-powered BDD workflow signatures using DSPy structured programming
  #
  # These signatures provide type-safe contracts for each stage of the
  # natural language -> Gherkin -> test execution pipeline, with rich
  # Sorbet types and comprehensive error handling.
  module Workflows
    # Available workflow stages as DSPy signatures
    AVAILABLE_SIGNATURES = [
      NaturalLanguageInput,
      SflAnalysis,
      UserStoryGeneration,
      GherkinGeneration,
      TestExecution,
      SflBddOrchestrator
    ].freeze

    # Quick access to signature schemas for validation
    def self.schemas
      AVAILABLE_SIGNATURES.each_with_object({}) do |signature, schemas|
        name = signature.name.split('::').last.underscore
        schemas[name] = {
          input_schema: signature.input_json_schema,
          output_schema: signature.output_json_schema
        }
      end
    end

    # Validate that all required DSPy dependencies are available
    def self.validate_dependencies!
      required_gems = %w[dspy sorbet-runtime]
      missing = required_gems.reject { |gem| Gem.loaded_specs.key?(gem) }

      unless missing.empty?
        raise DependencyError, "Missing required gems: #{missing.join(', ')}"
      end

      true
    end

    class DependencyError < StandardError; end
  end
end