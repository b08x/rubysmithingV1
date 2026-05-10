# frozen_string_literal: true

require "rspec/expectations"
World(RSpec::Matchers)

require "ruby_llm"
require_relative "../../config/boot"

# Before each scenario, clear the blueprints table to ensure test isolation
Before do
  DB[:blueprints].delete
  
  # Configure RubyLLM to use Ollama for tests
  RubyLLM.configure do |config|
    config.ollama_api_base = ENV.fetch("OLLAMA_API_BASE", "http://tinybot:11434/v1")
  end
  
  Rubysmithing.logger.level = Logger::INFO
end
