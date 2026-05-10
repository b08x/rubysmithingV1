# frozen_string_literal: true

require "sequel"
require "json"
require "ruby_llm/mcp"

module Rubysmithing
  module Discovery
    # Interfaces with the RubyGemDB and Context7 MCP to provide whitelisted gem context.
    class GemCurator
      DEFAULT_DB_NAME = "rubygemdb.sqlite"

      # @param db_path [String, nil] Path to the rubygemdb.sqlite database.
      # @param api_key [String, nil] Context7 API key for SSE connection.
      def initialize(db_path: nil, api_key: nil)
        @db_path = db_path || File.join(Rubysmithing.config.fetch(:gem_db_dir), DEFAULT_DB_NAME)
        @db = Sequel.sqlite(@db_path) if File.exist?(@db_path)
        @api_key = api_key || ENV["CONTEXT7_API_KEY"]

        # Initialize the Context7 MCP Client via :streamable
        # This transport is optimized for MCP servers providing SSE-based tool execution.
        @c7_client = RubyLLM::MCP.client(
          name: "context7",
          transport_type: :streamable,
          config: {
            url: "https://mcp.context7.com/mcp",
            headers: {
              "CONTEXT7_API_KEY" => @api_key,
              "Accept" => "application/json, text/event-stream"
            }
          }
        )
      end

      # Find gems by name or category.
      # @param query [String, nil] Name pattern to search for.
      # @param category [String, nil] Primary category to filter by.
      # @return [Array<Hash>] List of gem records.
      def find_gems(query = nil, category: nil)
        return [] unless @db

        ds = @db[:classified_gems]
        ds = ds.where(Sequel.like(:name, "%#{query}%")) if query
        
        if category
          # classification is a JSON string in SQLite
          ds = ds.where(Sequel.like(:classification, "%\"primary\": \"#{category}\"%"))
        end

        ds.all.map { |r| parse_json_columns(r) }
      end

      # Generates a combined cheatsheet for a list of gem names.
      # @param gem_names [Array<String>] Names of gems to include.
      # @param query [String] Optional query to focus the snippets (e.g. "usage examples").
      # @return [String] Markdown formatted cheatsheet.
      def generate_cheatsheet(gem_names, query: "basic usage examples and common patterns")
        return "" unless @db

        gems = @db[:classified_gems].where(name: gem_names).all.map { |r| parse_json_columns(r) }
        build_markdown(gems, query: query)
      end

      private

      def parse_json_columns(record)
        record[:classification] = JSON.parse(record[:classification]) if record[:classification]
        record[:role] = JSON.parse(record[:role]) if record[:role]
        record[:capabilities] = JSON.parse(record[:capabilities]) if record[:capabilities]
        record[:risks] = JSON.parse(record[:risks]) if record[:risks]
        record[:signals] = JSON.parse(record[:signals]) if record[:signals]
        record[:dependencies] = JSON.parse(record[:dependencies]) if record[:dependencies]
        record[:sub_categories] = JSON.parse(record[:sub_categories]) if record[:sub_categories]
        record
      end

      def build_markdown(gems, query: nil)
        header = "# Combined Cheatsheet: #{gems.map { |g| g[:name] }.join(', ')}\n\n"
        header += "**Generated**: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}\n\n"
        header += "**Gems**: #{gems.size}\n\n"

        body = gems.map do |gem|
          section = "### #{gem[:name]}\n\n"
          
          inventory = @db[:inventory].where(name: gem[:name]).first
          lib_id = inventory[:context7_id] if inventory
          
          section += "Library ID: `#{lib_id}`\n\n" if lib_id
          section += "#{gem[:description]}\n\n" if gem[:description]
          
          if lib_id
            snippets = fetch_mcp_snippets(lib_id, query)
            if snippets && !snippets.empty?
              section += "#{snippets}\n\n"
            else
              section += "> [No Context7 snippets found via MCP for query: \"#{query}\"]\n\n"
            end
          else
            section += "> [No Context7 Library ID found for this gem]\n\n"
          end
          
          section += "--------------------------------\n\n"
          section
        end.join("\n")

        header + body
      end

      def fetch_mcp_snippets(lib_id, query)
        return nil unless @api_key

        # Direct execution of the context7 query-docs tool
        result = @c7_client.execute_tool(
          name: "query-docs",
          parameters: {
            libraryId: lib_id,
            query: query
          }
        )
        
        # Result is typically the verbatim documentation text or a content block
        if result.is_a?(Hash)
          result["text"] || result["content"] || result.to_s
        elsif result.is_a?(Array)
          result.map { |c| c.is_a?(Hash) ? c["text"] : c }.join("\n")
        else
          result.to_s
        end
      rescue => e
        # warn "[GemCurator] MCP tool execution failed: #{e.message}"
        nil
      end
    end
  end
end
