# frozen_string_literal: true

require_relative "../plugins/rubysmithing/config/boot"
require "ruby_llm/mcp"

puts "Attempting to connect to Context7 MCP via :streamable..."

client = RubyLLM::MCP.client(
  name: "context7",
  transport_type: :streamable,
  config: {
    url: "https://mcp.context7.com/mcp",
    headers: {
      "CONTEXT7_API_KEY" => ENV["CONTEXT7_API_KEY"],
      "Accept" => "application/json, text/event-stream"
    }
  }
)

begin
  tools = client.tools
  puts "Successfully connected! Available tools:"
  tools.each do |tool|
    puts "- #{tool.name}: #{tool.description}"
  end
rescue => e
  puts "Connection failed: #{e.message}"
  puts e.backtrace.first(5)
end
