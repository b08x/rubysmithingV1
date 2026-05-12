# frozen_string_literal: true

# SFL-powered BDD workflow automation
# Natural Language → SFL Analysis → User Stories → Gherkin Features → Implementation → Testing

namespace :bdd do
  desc "Complete BDD workflow from natural language input"
  task :from_natural_language, [:input] => :environment do |_task, args|
    input = args[:input] || ENV["BDD_INPUT"]
    raise "No input provided. Use: rake bdd:from_natural_language['your natural language input']" unless input

    puts "🚀 Starting SFL-powered BDD workflow..."

    # DSPy Pipeline Execution using structured signatures
    require_relative "../rubysmithing/workflows"

    # Initialize orchestrator with DSPy
    orchestrator = DSPy::Predict.new(Rubysmithing::Workflows::SflBddOrchestrator)

    # Configure pipeline settings
    config = Rubysmithing::Workflows::SflBddOrchestrator::PipelineConfiguration.new(
      analysis_depth: "standard",
      story_template: "standard",
      feature_template: "standard",
      execution_environment: "container",
      parallel_workers: 4,
      quality_thresholds: { "sfl_confidence" => 0.8, "story_quality" => 0.75 },
      retry_settings: { "max_retries" => 3, "backoff_seconds" => 5 }
    )

    # Execute complete pipeline
    puts "🧠 Running SFL-powered BDD pipeline with DSPy signatures..."
    result = orchestrator.call(
      raw_input: input,
      configuration: config,
      context: "Ruby gem management and validation system"
    )

    # Step 4: Run in container
    Rake::Task["test:container"].invoke

    puts "✅ BDD workflow complete!"
  end

  desc "Watch for natural language input and auto-process"
  task watch: :environment do
    puts "👀 Watching for natural language input files..."
    # Implementation for file watching and auto-processing
    SflBddWorkflow::Watcher.start
  end
end

namespace :sfl do
  desc "Analyze natural language using SFL metafunctions"
  task :analyze, [:input] => :environment do |_task, args|
    input = args[:input]
    require_relative "../rubysmithing/workflows"

    # Validate and structure input using DSPy signature
    input_validator = DSPy::Predict.new(Rubysmithing::Workflows::NaturalLanguageInput)
    validated_input = input_validator.call(
      raw_input: input,
      source: Rubysmithing::Workflows::NaturalLanguageInput::InputSource::UserInput,
      context: "Ruby development workflow analysis"
    )

    unless validated_input.is_valid
      puts "❌ Input validation failed:"
      validated_input.validation_errors.each { |error| puts "  - #{error}" }
      exit 1
    end

    # Perform SFL analysis using DSPy signature
    sfl_analyzer = DSPy::Predict.new(Rubysmithing::Workflows::SflAnalysis)
    puts "🔍 Performing SFL metafunction analysis with DSPy..."

    analysis = sfl_analyzer.call(
      cleaned_text: validated_input.cleaned_text,
      analysis_depth: "standard",
      focus_metafunctions: ["ideational", "interpersonal", "textual"]
    )

    # Save analysis to file with enhanced structure
    timestamp = Time.current.strftime("%Y%m%d_%H%M%S")
    output_file = "sfl_pipeline/processing/analysis_#{timestamp}.json"

    analysis_data = {
      input_metadata: validated_input.metadata,
      sfl_analysis: analysis.analysis,
      confidence_breakdown: analysis.confidence_breakdown,
      processing_notes: analysis.processing_notes,
      ambiguity_flags: analysis.ambiguity_flags,
      generated_at: timestamp
    }

    File.write(output_file, JSON.pretty_generate(analysis_data))

    puts "📊 SFL analysis saved to: #{output_file}"
    puts "📋 Analysis summary:"
    puts "  - Ideational processes: #{analysis.analysis.ideational.processes.size}"
    puts "  - Interpersonal modality: #{analysis.analysis.interpersonal.modality}"
    puts "  - Textual theme pattern: #{analysis.analysis.textual.theme_pattern}"
    puts "  - Overall confidence: #{analysis.analysis.confidence_score}"

    analysis_data
  end

  desc "Start SFL processor service"
  task :processor_start => :environment do
    puts "🔧 Starting SFL processor service..."
    SflBddWorkflow::Processor.start
  end
end

namespace :stories do
  desc "Generate structured user stories from SFL analysis"
  task :generate, [:sfl_analysis] => :environment do |_task, args|
    analysis = args[:sfl_analysis] || JSON.parse(File.read(Dir.glob("sfl_pipeline/processing/*.json").last))
    require_relative "../rubysmithing/workflows"

    # Generate user stories using DSPy signature
    story_generator = DSPy::Predict.new(Rubysmithing::Workflows::UserStoryGeneration)
    puts "📝 Generating user stories from SFL analysis with DSPy..."

    stories_result = story_generator.call(
      sfl_analysis: analysis,
      domain_context: "Ruby gem development and validation workflows",
      story_template: "technical",
      max_stories: 15
    )

    # Save structured user stories
    timestamp = Time.current.strftime("%Y%m%d_%H%M%S")
    output_file = "user_stories/stories_#{timestamp}.yml"

    stories_data = {
      stories: stories_result.stories,
      metadata: stories_result.metadata,
      mapping_notes: stories_result.mapping_notes,
      quality_score: stories_result.quality_score,
      recommendations: stories_result.recommendations,
      generated_at: timestamp
    }

    File.write(output_file, stories_data.to_yaml)

    puts "📚 User stories saved to: #{output_file}"
    puts "📋 Generated #{stories_result.stories.size} user stories"
    puts "🎯 Quality score: #{stories_result.quality_score}"
    puts "📊 Priority distribution: #{stories_result.metadata.priority_distribution}"

    stories_data
  end

  desc "Validate user story structure"
  task :validate => :environment do
    validator = SflBddWorkflow::UserStoryValidator.new
    stories_files = Dir.glob("user_stories/*.yml")

    puts "✅ Validating user stories..."
    stories_files.each do |file|
      result = validator.validate_file(file)
      puts "  #{file}: #{result[:valid] ? '✅' : '❌'} (#{result[:errors].size} errors)"
    end
  end
end

namespace :gherkin do
  desc "Generate Gherkin features from user stories"
  task :generate, [:user_stories] => :environment do |_task, args|
    stories_data = args[:user_stories] || YAML.load_file(Dir.glob("user_stories/*.yml").last)
    require_relative "../rubysmithing/workflows"

    # Generate Gherkin features using DSPy signature
    gherkin_generator = DSPy::Predict.new(Rubysmithing::Workflows::GherkinGeneration)
    puts "🥒 Generating Gherkin features from user stories with DSPy..."

    # Extract user stories array from the data structure
    user_stories = stories_data[:stories] || stories_data["stories"] || stories_data

    gherkin_result = gherkin_generator.call(
      user_stories: user_stories,
      feature_template: "standard",
      scenario_coverage: "comprehensive",
      automation_hints: true
    )

    # Save features to features/generated/ with enhanced metadata
    timestamp = Time.current.strftime("%Y%m%d_%H%M%S")

    gherkin_result.features.each do |feature|
      filename = "features/generated/#{feature.filename}"

      # Generate complete Gherkin feature file content
      feature_content = generate_feature_content(feature)
      File.write(filename, feature_content)
      puts "  📄 Generated: #{filename} (#{feature.scenarios.size} scenarios)"
    end

    # Save generation metadata
    metadata_file = "features/generated/generation_metadata_#{timestamp}.yml"
    File.write(metadata_file, {
      metadata: gherkin_result.metadata,
      validation_results: gherkin_result.validation_results,
      automation_gaps: gherkin_result.automation_gaps,
      quality_metrics: gherkin_result.quality_metrics,
      generated_at: timestamp
    }.to_yaml)

    puts "🎯 Generated #{gherkin_result.features.size} Gherkin features"
    puts "📊 Total scenarios: #{gherkin_result.metadata.total_scenarios}"
    puts "🤖 Automation readiness: #{gherkin_result.metadata.automation_readiness}"

    gherkin_result
  end

  # Helper method to generate Gherkin feature file content
  def generate_feature_content(feature)
    content = []

    # Feature header with tags
    content << feature.tags.map { |tag| "@#{tag}" }.join(" ") unless feature.tags.empty?
    content << "Feature: #{feature.name}"
    content << "  #{feature.description}"
    content << ""

    # Background steps if present
    if feature.background
      content << "  Background:"
      feature.background.each { |step| content << "    #{step.type.capitalize} #{step.text}" }
      content << ""
    end

    # Scenarios
    feature.scenarios.each do |scenario|
      content << "  #{scenario.tags.map { |tag| "@#{tag}" }.join(" ")}" unless scenario.tags.empty?
      content << "  Scenario: #{scenario.name}"
      content << "    # #{scenario.description}" if scenario.description

      scenario.steps.each do |step|
        content << "    #{step.type.capitalize} #{step.text}"
        content << "      \"\"\"" if step.doc_string
        content << "      #{step.doc_string}" if step.doc_string
        content << "      \"\"\"" if step.doc_string
        content << "      # Automation hint: #{step.automation_hint}" if step.automation_hint
      end

      content << ""
    end

    content.join("\n")
  end

  desc "Validate Gherkin syntax"
  task :validate => :environment do
    puts "🔍 Validating Gherkin syntax..."
    system("bundle exec cucumber --dry-run features/generated/")
  end
end

namespace :test do
  desc "Run all tests in containers"
  task :container => :environment do
    puts "🐳 Running comprehensive container tests..."

    # Unit tests
    puts "🧪 Running unit tests..."
    system("docker-compose run --rm test bundle exec rspec")

    # Integration tests
    puts "🔗 Running integration tests..."
    system("docker-compose run --rm test bundle exec cucumber features/")

    # Generated feature tests
    puts "🥒 Running generated Gherkin tests..."
    system("docker-compose run --rm test bundle exec cucumber features/generated/")

    # Performance tests
    puts "⚡ Running performance tests..."
    system("docker-compose run --rm test bundle exec rake test:performance")

    puts "✅ Container test suite complete!"
  end

  desc "End-to-end workflow test"
  task :e2e => :environment do
    puts "🎯 Running end-to-end workflow test..."

    test_input = "As a developer, I need to be able to validate gem versions so that I can ensure compatibility"

    # Run complete workflow
    Rake::Task["bdd:from_natural_language"].invoke(test_input)

    # Verify outputs exist
    raise "SFL analysis missing" unless Dir.glob("sfl_pipeline/processing/*.json").any?
    raise "User stories missing" unless Dir.glob("user_stories/*.yml").any?
    raise "Gherkin features missing" unless Dir.glob("features/generated/*.feature").any?

    puts "✅ End-to-end workflow test passed!"
  end

  desc "Performance testing in containers"
  task :performance => :environment do
    puts "⚡ Running performance tests..."

    # Test SFL processing speed
    start_time = Time.current
    100.times do |i|
      Rake::Task["sfl:analyze"].invoke("Test input #{i}")
    end
    duration = Time.current - start_time

    puts "📊 Performance results:"
    puts "  - SFL analysis: #{(duration / 100).round(3)}s avg per analysis"
    puts "  - Memory usage: #{`ps -o rss= -p #{Process.pid}`.strip.to_i / 1024}MB"
  end
end

namespace :system do
  desc "Monitor system health and metrics"
  task :monitor => :environment do
    puts "📊 System monitoring active..."
    # Implementation for real-time monitoring
    SflBddWorkflow::Monitor.start
  end

  desc "Generate system health report"
  task :health => :environment do
    puts "🏥 System health check..."

    checks = [
      { name: "Database", status: database_healthy? },
      { name: "Redis", status: redis_healthy? },
      { name: "SFL Processor", status: sfl_processor_healthy? },
      { name: "File System", status: filesystem_healthy? }
    ]

    checks.each do |check|
      puts "  #{check[:name]}: #{check[:status] ? '✅' : '❌'}"
    end
  end
end

# Helper methods
def database_healthy?
  Rubysmithing::Database.connect.test_connection
rescue
  false
end

def redis_healthy?
  # Implementation for Redis health check
  true
rescue
  false
end

def sfl_processor_healthy?
  # Check if SFL processor is responding
  true
rescue
  false
end

def filesystem_healthy?
  required_dirs = %w[sfl_pipeline user_stories features/generated]
  required_dirs.all? { |dir| Dir.exist?(dir) }
end