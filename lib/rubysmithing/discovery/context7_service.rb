# frozen_string_literal: true

require "net/http"
require "json"
require "uri"

module Rubysmithing
  module Discovery
    # Interfaces with the Context7 API to fetch gem documentation and snippets.
    class Context7Service
      BASE_URL = "https://context7.com/api/v2"

      def initialize(api_key: nil)
        @api_key = api_key || ENV["CONTEXT7_API_KEY"]
      end

      # Searches for a library by name.
      # @param gem_name [String] Name of the gem.
      # @return [Array<Hash>] List of matching libraries.
      def search_libraries(gem_name)
        return [] unless @api_key

        uri = URI("#{BASE_URL}/libs/search")
        params = { libraryName: gem_name, query: "ruby gem #{gem_name} documentation" }
        uri.query = URI.encode_www_form(params)

        response = get(uri)
        return [] unless response.is_a?(Net::HTTPSuccess)

        data = JSON.parse(response.body)
        data.is_a?(Array) ? data : (data["results"] || [])
      end

      # Verifies the library ID for a gem.
      # @param gem_name [String] Name of the gem.
      # @return [String, nil] The library ID if found.
      def verify_library(gem_name)
        results = search_libraries(gem_name)
        return nil if results.empty?

        results.first["id"] || results.first["libraryId"]
      end

      # Queries documentation for a library.
      # @param lib_id [String] The Context7 library ID.
      # @param query [String] The question or task.
      # @return [String, nil] The documentation text or snippets.
      def query_context(lib_id, query)
        return nil unless @api_key

        uri = URI("#{BASE_URL}/context")
        params = { libraryId: lib_id, query: query }
        uri.query = URI.encode_www_form(params)

        response = get(uri)
        return nil unless response.is_a?(Net::HTTPSuccess)

        response.body
      end

      private

      def get(uri)
        request = Net::HTTP::Get.new(uri)
        request["Authorization"] = "Bearer #{@api_key}"
        request["Accept"] = "application/json"

        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
          http.open_timeout = 5
          http.read_timeout = 30
          http.request(request)
        end
      rescue => e
        # warn "[Context7] Request failed: #{e.message}"
        nil
      end
    end
  end
end
