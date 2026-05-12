#!/usr/bin/env ruby
# frozen_string_literal: true

# Demo of enhanced journald logging for agent coordination
# Run this to see structured logging in action for hub-and-spoke architecture

require_relative "../lib/rubysmithing"
require_relative "agents/example_sovereign_agent"

puts "🚀 Enhanced Journald Logging Demo"
puts "🔍 Structured logging for agent coordination on systemd"
puts "=" * 60

# Initialize the rubysmithing system
Rubysmithing.boot!

# Create example agent
agent = Rubysmithing::Agents::ExampleSovereignAgent.new(
  max_spokes: 3,
  timeout: 30,
  environment: "demo"
)

puts "\n📋 Watch journald logs with:"
puts "   journalctl -f -t rubysmithing"
puts "   journalctl -f -t rubysmithing --output=json-pretty"
puts "\n🔍 Filter by correlation ID:"
puts "   journalctl -f CORRELATION_ID=<id>"
puts "\n🎯 Filter by agent operations:"
puts "   journalctl -f OPERATION=survey"
puts "   journalctl -f EVENT_TYPE=coordination"

puts "\n" + "=" * 60
puts "🚀 Starting agent workflow..."

# Simulate different types of requests
requests = [
  { type: "gem_analysis", target: "rails", version: "~> 7.0" },
  { type: "security_audit", scope: "dependencies" },
  { type: "performance_check", benchmark: "response_time" }
]

requests.each_with_index do |request, index|
  puts "\n🔄 Processing request #{index + 1}: #{request[:type]}"

  begin
    result = agent.execute_workflow(request)
    puts "✅ Workflow completed: #{result[:status]} (score: #{result[:overall_score]})"
  rescue => error
    puts "❌ Workflow failed: #{error.message}"
  end

  # Small delay between workflows
  sleep 1
end

puts "\n" + "=" * 60
puts "✨ Demo complete!"
puts "\n📊 Check structured logs with:"
puts "   journalctl -t rubysmithing --since='5 minutes ago' --output=json-pretty"
puts "\n🎯 Query specific events:"
puts "   journalctl -t rubysmithing WORKFLOW_STAGE=survey"
puts "   journalctl -t rubysmithing EVENT_TYPE=performance"
puts "   journalctl -t rubysmithing AGENT_CLASS=ExampleSovereignAgent"