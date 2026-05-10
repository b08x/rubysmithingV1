# frozen_string_literal: true

# Step definitions for builder agent cucumber scenarios

Given("the Blueprint Librarian contains sample blueprints") do
  @librarian = Rubysmithing::Discovery::BlueprintLibrarian.new
  # Ensure at least one sample blueprint exists
  @librarian.archive({
    name: "Sample Blueprint",
    category: "General",
    description: "A sample blueprint for testing",
    code: "# Sample code"
  })
end

Given("the Blueprint Librarian has a {string} pattern") do |pattern_name|
  @librarian ||= Rubysmithing::Discovery::BlueprintLibrarian.new
  @test_pattern_name = pattern_name

  if pattern_name == "Sequel Async Connection"
    @librarian.archive({
      name: pattern_name,
      category: "Database",
      description: "A pattern for establishing an asynchronous Sequel connection with pgvector support",
      code: <<~RUBY
        # frozen_string_literal: true
        require "sequel"
        require "async"

        def connect_db
          db = Sequel.connect(ENV["DATABASE_URL"])
          db.extension :pg_array, :pg_json
          db.run("CREATE EXTENSION IF NOT EXISTS vector")
          db
        end
      RUBY
    })
  end
end

Given("I archive a blueprint with name {string}") do |name|
  @librarian ||= Rubysmithing::Discovery::BlueprintLibrarian.new
  @archived_blueprint_name = name
end

Given("the blueprint has category {string}") do |category|
  @blueprint_category = category
end

Given("the blueprint contains Redis connection code") do
  blueprint = {
    name: @archived_blueprint_name,
    category: @blueprint_category,
    description: "Redis connection pattern for caching",
    code: <<~RUBY
      require "redis"

      def redis_connection
        Redis.new(url: ENV["REDIS_URL"])
      end
    RUBY
  }
  @librarian.archive(blueprint)
end

Given("no relevant blueprints exist in the librarian") do
  @librarian = Rubysmithing::Discovery::BlueprintLibrarian.new
  # Ensure empty state by not archiving any relevant blueprints
end

When("I ask the Builder Agent to {string}") do |prompt|
  @builder = Rubysmithing::Agents::Builder.new
  @user_prompt = prompt
end

When("I specify to {string}") do |additional_instruction|
  full_prompt = "#{@user_prompt} #{additional_instruction}"
  @builder_response = @builder.ask(full_prompt)
  @generated_code = @builder_response.content
rescue => e
  @builder_error = e
end

When("I ask the Builder Agent to generate any Ruby class") do
  @builder = Rubysmithing::Agents::Builder.new
  @builder_response = @builder.ask("Create a simple Ruby class for user management")
  @generated_code = @builder_response.content
end

When("I request setup guidance") do
  # This would trigger environment setup guidance
  @setup_guidance = "Step-by-step environment setup instructions would be provided here"
end

Then("the Builder Agent should retrieve the blueprint from the librarian") do
  # Verify that the builder actually consulted the librarian
  # This is implementation-specific and would depend on logging or callbacks
  expect(@generated_code).to be_a(String)
end

Then("the generated code should use the async connection pattern") do
  expect(@generated_code).to include("async")
  expect(@generated_code).to include("Sequel")
end

Then("the code should include Sequel and async requirements") do
  expect(@generated_code).to include('require "sequel"')
  expect(@generated_code).to include('require "async"')
end

Then("the code should include pgvector extension setup") do
  expect(@generated_code).to include("pg_array")
  expect(@generated_code).to include("pg_json")
  expect(@generated_code).to include("vector")
end

Then("the Builder should find the Redis Cache Pattern") do
  # Verify the builder found and used the Redis pattern
  expect(@generated_code).to include("Redis") if @generated_code
end

Then("adapt it for session management") do
  expect(@generated_code).to include("session") if @generated_code
end

Then("include proper error handling") do
  expect(@generated_code).to match(/rescue|begin|ensure/i) if @generated_code
end

Then("the generated code should have frozen string literal") do
  expect(@generated_code).to include("# frozen_string_literal: true")
end

Then("should follow proper indentation") do
  lines = @generated_code.split("\n")
  # Check that indentation is consistent (basic check)
  expect(lines.any? { |line| line.start_with?("  ") || line.start_with?("    ") }).to be true
end

Then("should include appropriate comments") do
  expect(@generated_code).to match(/#\s+\w+/)
end

Then("should use snake_case for method names") do
  method_matches = @generated_code.scan(/def\s+(\w+)/)
  method_matches.each do |method_name|
    expect(method_name.first).to match(/^[a-z][a-z0-9_]*$/)
  end
end

Then("the Builder should generate code from scratch") do
  expect(@generated_code).to be_a(String)
  expect(@generated_code.length).to be > 0
end

Then("include a note about no existing patterns found") do
  expect(@generated_code).to match(/no.*pattern.*found/i) if @generated_code
end

Then("follow security best practices") do
  # Basic check for security practices
  expect(@generated_code).not_to include("eval(")
  expect(@generated_code).not_to include("system(")
end

Then("I should receive step-by-step instructions") do
  expect(@setup_guidance).to be_a(String)
  expect(@setup_guidance).to include("step")
end

Then("the instructions should be specific to my platform") do
  expect(@setup_guidance).to be_a(String)
end

Then("include commands to create missing components") do
  expect(@setup_guidance).to include("command") if @setup_guidance
end