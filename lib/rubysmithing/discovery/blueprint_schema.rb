# frozen_string_literal: true

require "ruby_llm-schema"

module Rubysmithing
  module Discovery
    # Schema for extracting blueprint metadata from code patterns
    class BlueprintSchema < RubyLlm::Schema::Base
      description "Metadata for a reusable code pattern blueprint"

      property :name, 
               type: :string, 
               description: "A concise, descriptive name for the pattern (e.g., 'Sequel Async Pipeline')"
      
      property :category, 
               type: :string, 
               description: "The architectural category (e.g., 'Database', 'TUI', 'Networking')"
      
      property :description, 
               type: :string, 
               description: "A detailed explanation of what the code does and its architectural rationale"
      
      property :code, 
               type: :string, 
               description: "The actual Ruby code snippet following Standard Mode conventions"

      required :name, :category, :description, :code
    end
  end
end
