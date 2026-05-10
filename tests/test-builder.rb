# frozen_string_literal: true

require_relative "../plugins/rubysmithing/config/boot"

Rubysmithing.logger.level = Logger::INFO
puts "=== Sovereign Builder Agent Test ==="

# 1. Ensure the blueprint is archived first
librarian = Rubysmithing::Discovery::BlueprintLibrarian.new
librarian.archive({
  name: "Sequel Async Connection",
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

# 2. Instantiate the Builder Agent
builder = Rubysmithing::Agents::Builder.new

puts "\n--- Initiating Builder Request ---"
prompt = "I need to write a new database class to connect to Postgres. Can you give me the connection method? Please check the librarian first for the async pattern."
puts "Prompt: '#{prompt}'\n\n"

# Execute the agent
response = builder.ask(prompt)

puts "--- Builder Response ---"
puts response.content
