# frozen_string_literal: true

require_relative "../config/boot"
require "ruby_llm"

# Load models from OpenRouter
puts "Refreshing OpenRouter models..."
begin
  # This typically populates the internal registry
  # Using the MCP-documented syntax or standard RubyLLM if MCP isn't needed here
  models = RubyLLM.models.by_provider(:openrouter)
  
  puts "Filtering for free/low-cost models with 'tools' capability..."
  candidates = models.select do |m| 
    # Check for 'tools' or 'function_calling' in capabilities
    m.capabilities.include?(:tools) || m.capabilities.include?(:function_calling)
  end

  if candidates.any?
    candidates.sort_by { |m| m.pricing[:prompt] }.each do |m|
      puts "ID: #{m.id}"
      puts "  Price (Input): #{m.pricing[:prompt]}"
      puts "  Capabilities: #{m.capabilities.join(', ')}"
      puts "-" * 20
    end
  else
    puts "No models with 'tools' capability found in the registry."
    # If the registry is empty, try to list them directly if RubyLLM supports it
    puts "\nAll OpenRouter IDs in registry:"
    puts models.map(&:id).take(10)
  end
rescue => e
  puts "Error checking models: #{e.message}"
  puts e.backtrace.take(5)
end
