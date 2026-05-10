# frozen_string_literal: true

require "ruby_llm"
require_relative "../discovery/blueprint_librarian"

module Rubysmithing
  module Agents
    class BlueprintSearchTool < RubyLLM::Tool
      description "Searches the Librarian database for known-good architectural blueprints and code patterns."
      param :query, type: :string, desc: "A semantic natural language search query for the code pattern needed."

      def execute(query:)
        librarian = Rubysmithing::Discovery::BlueprintLibrarian.new
        results = librarian.search(query, limit: 1)
        
        if results.any?
          blueprint = results.first
          Rubysmithing.logger.info "Builder Agent retrieved blueprint: #{blueprint[:name]}"
          "Found Blueprint: #{blueprint[:name]}\n\nDescription: #{blueprint[:description]}\n\nCode:\n#{blueprint[:code]}"
        else
          Rubysmithing.logger.info "Builder Agent found no blueprints for query: '#{query}'"
          "No matching blueprint found. Proceed with standard idiomatic Ruby generation."
        end
      end
    end

    class Builder < RubyLLM::Agent
      model Rubysmithing.config.fetch(:builder_model)
      
      tools BlueprintSearchTool
      
      instructions <<~PROMPT
        You are the Sovereign Builder Agent. Your primary responsibility is generating, refactoring, and structuring Ruby code.
        
        CRITICAL DIRECTIVE: 
        Before generating any new architectural component, class, or pattern, you MUST use the `blueprint_search_tool` 
        to query the Librarian for a "known-good" blueprint. 
        
        If the tool returns a blueprint:
        1. Read the blueprint's description and code snippet.
        2. Adapt the exact structure, conventions, and logic of the blueprint to fulfill the current task.
        3. Do NOT hallucinate entirely new patterns if a blueprint provides a path.
        
        If the tool returns no matching blueprint:
        1. Generate the code natively.
        2. Strictly follow Zeitwerk, frozen_string_literal, and Rubocop conventions.
      PROMPT
    end
  end
end
