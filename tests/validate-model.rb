# frozen_string_literal: true

require_relative "../plugins/rubysmithing/config/boot"
require "ruby_llm"

puts "Fetching and validating OpenRouter models..."

# Find OpenRouter models that support tools and contain 'free' in their ID
free_tool_models = RubyLLM.models.by_provider(:openrouter).select do |model|
  # We want a free model, or at least one of the flash/lite models if free isn't clearly marked
  is_free = model.id.downcase.include?("free") || model.pricing&.prompt.to_f == 0.0
  supports_tools = model.capabilities.include?(:tools)
  
  is_free && supports_tools
end

if free_tool_models.empty?
  puts "No strictly free models with tool support found. Broadening search to cheap gemini flash models..."
  cheap_tool_models = RubyLLM.models.by_provider(:openrouter).select do |model|
    model.capabilities.include?(:tools) && model.id.include?("flash-lite")
  end
  
  if cheap_tool_models.any?
    selected = cheap_tool_models.first
    puts "✅ Selected fallback cheap model: #{selected.id}"
    puts "Capabilities: #{selected.capabilities.join(', ')}"
  else
    puts "❌ Could not find a suitable low-cost model with tool support."
  end
else
  selected = free_tool_models.first
  puts "✅ Selected free model: #{selected.id}"
  puts "Capabilities: #{selected.capabilities.join(', ')}"
end
