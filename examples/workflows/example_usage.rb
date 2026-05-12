# frozen_string_literal: true

require_relative "../../lib/rubysmithing/workflows"

# Example usage of the SFL-BDD DSPy workflow
module Rubysmithing
  module Workflows
    class ExampleUsage
      def self.demo_pipeline
        puts "🚀 SFL-BDD DSPy Pipeline Demo"
        puts "=" * 50

        # 1. Natural Language Input Validation
        puts "\n1️⃣ Input Validation Stage"
        input_validator = DSPy::Predict.new(NaturalLanguageInput)

        input_result = input_validator.call(
          raw_input: "As a Ruby developer, I need reliable gem version validation so that I can ensure my applications use compatible dependencies and avoid runtime conflicts.",
          source: NaturalLanguageInput::InputSource::UserInput,
          context: "Ruby gem management system"
        )

        puts "✅ Input valid: #{input_result.is_valid}"
        puts "📝 Cleaned text: #{input_result.cleaned_text[0..100]}..."

        # 2. SFL Analysis
        puts "\n2️⃣ SFL Metafunction Analysis"
        sfl_analyzer = DSPy::Predict.new(SflAnalysis)

        sfl_result = sfl_analyzer.call(
          cleaned_text: input_result.cleaned_text,
          analysis_depth: "standard",
          focus_metafunctions: ["ideational", "interpersonal", "textual"]
        )

        puts "🧠 Analysis confidence: #{sfl_result.analysis.confidence_score}"
        puts "🎭 Speech function: #{sfl_result.analysis.interpersonal.speech_function}"
        puts "⚙️ Process types: #{sfl_result.analysis.ideational.processes.map(&:serialize).join(', ')}"

        # 3. User Story Generation
        puts "\n3️⃣ User Story Generation"
        story_generator = DSPy::Predict.new(UserStoryGeneration)

        story_result = story_generator.call(
          sfl_analysis: sfl_result.analysis.serialize,
          domain_context: "Ruby gem management",
          story_template: "technical",
          max_stories: 5
        )

        puts "📚 Generated #{story_result.stories.size} user stories"
        puts "🎯 Quality score: #{story_result.quality_score}"

        # 4. Gherkin Generation
        puts "\n4️⃣ Gherkin Feature Generation"
        gherkin_generator = DSPy::Predict.new(GherkinGeneration)

        gherkin_result = gherkin_generator.call(
          user_stories: story_result.stories.map(&:serialize),
          feature_template: "standard",
          scenario_coverage: "comprehensive"
        )

        puts "🥒 Generated #{gherkin_result.features.size} features"
        puts "📊 Total scenarios: #{gherkin_result.metadata.total_scenarios}"

        # 5. Complete Orchestration Example
        puts "\n5️⃣ Complete Pipeline Orchestration"
        orchestrator = DSPy::Predict.new(SflBddOrchestrator)

        config = SflBddOrchestrator::PipelineConfiguration.new(
          analysis_depth: "standard",
          story_template: "technical",
          feature_template: "standard",
          execution_environment: "development",
          parallel_workers: 2,
          quality_thresholds: { "sfl_confidence" => 0.7, "story_quality" => 0.6 },
          retry_settings: { "max_retries" => 2, "backoff_seconds" => 3 }
        )

        complete_result = orchestrator.call(
          raw_input: input_result.raw_input,
          configuration: config,
          context: "Ruby gem validation system"
        )

        puts "🎉 Pipeline success: #{complete_result.success}"
        puts "⏱️  Total duration: #{complete_result.result.total_duration_ms}ms"
        puts "📋 Generated artifacts: #{complete_result.result.generated_artifacts.keys.join(', ')}"

        puts "\n✨ SFL-BDD Pipeline Demo Complete!"
        puts "=" * 50

        complete_result
      end

      def self.validate_schemas
        puts "\n🔍 Validating DSPy Signature Schemas"
        puts "-" * 40

        AVAILABLE_SIGNATURES.each do |signature|
          name = signature.name.split('::').last

          puts "\n#{name}:"
          puts "  Input schema: #{signature.input_json_schema.keys.size} fields"
          puts "  Output schema: #{signature.output_json_schema.keys.size} fields"

          # Validate schema structure
          input_schema = signature.input_json_schema
          output_schema = signature.output_json_schema

          puts "  ✅ Valid JSON schema structure" if input_schema.is_a?(Hash) && output_schema.is_a?(Hash)
        end

        puts "\n✨ Schema validation complete!"
      end
    end
  end
end

# Run demo if script is executed directly
if __FILE__ == $0
  Rubysmithing::Workflows::ExampleUsage.demo_pipeline
end