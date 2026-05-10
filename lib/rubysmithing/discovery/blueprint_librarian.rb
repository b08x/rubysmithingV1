# frozen_string_literal: true

require "ruby_llm"

module Rubysmithing
  module Discovery
    class BlueprintLibrarian
      attr_reader :db

      def initialize(db: nil)
        @db = db || Rubysmithing::Database.connect
      end

      # Archives a code pattern as a blueprint
      # @param blueprint_params [Hash] matching BlueprintSchema
      def archive(blueprint_params)
        return unless db

        Rubysmithing.logger.debug "Archiving blueprint: #{blueprint_params[:name]}"
        # Generate embedding for the description (semantic search target)
        embedding = generate_embedding(blueprint_params[:description])
        Rubysmithing.logger.debug "Generated #{embedding.length}-dim embedding for blueprint"

        db[:blueprints].insert(
          name: blueprint_params[:name],
          category: blueprint_params[:category],
          description: blueprint_params[:description],
          code: blueprint_params[:code],
          embedding: "[#{embedding.join(',')}]"
        )
        Rubysmithing.logger.info "Successfully archived blueprint: #{blueprint_params[:name]}"
      end

      # Finds the closest blueprints to a natural language query
      # @param query [String] The search query
      # @param limit [Integer] Max results
      # @return [Array<Hash>] Sorted by similarity
      def search(query, limit: 5)
        return [] unless db

        Rubysmithing.logger.debug "Searching for blueprints matching: '#{query}' (limit: #{limit})"
        query_embedding = generate_embedding(query)
        Rubysmithing.logger.debug "Generated #{query_embedding.length}-dim embedding for query"
        
        # pgvector cosine distance: <=> operator
        results = db[:blueprints]
          .select(:id, :name, :category, :description, :code)
          .select_append { (Sequel.lit("1 - (embedding <=> ?)", "[#{query_embedding.join(',')}]")).as(:similarity) }
          .order(Sequel.lit("embedding <=> ?", "[#{query_embedding.join(',')}]"))
          .limit(limit)
          .all
          
        Rubysmithing.logger.info "Found #{results.length} matching blueprints"
        results
      end


      private

      def generate_embedding(text)
        # Use Ollama with embeddinggemma:latest (768 dimensions)
        response = RubyLLM.embed(
          text,
          provider: :ollama,
          model: "embeddinggemma:latest"
        )
        
        response.vectors
      end
    end
  end
end
