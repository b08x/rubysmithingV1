# frozen_string_literal: true

require_relative "../config/boot"
require "ruby_llm"

# Configure RubyLLM for local Ollama
RubyLLM.configure do |config|
  config.ollama_api_base = ENV.fetch("OLLAMA_API_BASE", "http://tinybot:11434/v1")
end

# Set log level to DEBUG to see the new journald-logger traces
Rubysmithing.logger.level = Logger::DEBUG

librarian = Rubysmithing::Discovery::BlueprintLibrarian.new
db = DB

puts "=== Blueprint Librarian Loop Test ==="

# 1. Archive
puts "\n--- 1. Archiving Test Blueprint ---"
blueprint = {
  name: "Sequel Async Connection",
  category: "Database",
  description: "A pattern for establishing an asynchronous Sequel connection with pgvector support and circuit breaker integration.",
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

begin
  librarian.archive(blueprint)
  puts "✅ Archiving method executed."
rescue => e
  puts "❌ Archiving failed: #{e.message}"
  exit 1
end

# 2. Search
puts "\n--- 2. Performing Semantic Search ---"
query = "How do I connect to postgres using async and vector?"
puts "Query: '#{query}'"

results = librarian.search(query, limit: 1)

if results.any?
  res = results.first
  puts "✅ Match Found!"
  puts "   Name: #{res[:name]}"
  puts "   Similarity: #{(res[:similarity] * 100).round(2)}%"
  puts "   Code Snippet:\n#{res[:code].lines.take(5).join}"
else
  puts "❌ No matching blueprints found."
end
