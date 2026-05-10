# frozen_string_literal: true

Given("the Librarian system is running") do
  @librarian = Rubysmithing::Discovery::BlueprintLibrarian.new
end

When("I archive a blueprint named {string}") do |name|
  @blueprint_name = name
end

When("its description is {string}") do |description|
  blueprint = {
    name: @blueprint_name,
    category: "Database",
    description: description,
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
  }
  
  @librarian.archive(blueprint)
end

When("I search the Librarian for {string}") do |query|
  @search_results = @librarian.search(query, limit: 1)
end

Then("I should find exactly {int} match") do |count|
  expect(@search_results.length).to eq(count)
end

Then("the top match should be named {string}") do |expected_name|
  expect(@search_results.first[:name]).to eq(expected_name)
end

Then("the match similarity should be above {float}") do |threshold|
  expect(@search_results.first[:similarity]).to be > threshold
end
