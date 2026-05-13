# frozen_string_literal: true

require "ruby_llm"

module Rubysmithing
  # Multi-provider LLM configuration for ruby_llm 1.15.0.
  #
  # 1.15.0 uses flat top-level config options (`config.mistral_api_key=`,
  # `config.openrouter_api_key=`) rather than the older `config.mistral do |m|`
  # provider-block pattern. Custom model registries and per-provider HTTP
  # headers are no longer supported via the configure block — model metadata
  # lives in `config.model_registry_file` if needed.
  class LlmProviders
    class << self
      def configure!
        RubyLLM.configure do |config|
          config.log_level = Rubysmithing.config.fetch(:log_level, default: "INFO").downcase.to_sym
          config.request_timeout = 30
          config.max_retries = 3
          config.retry_backoff_factor = 2.0

          mistral_key = Rubysmithing.config.fetch(:mistral_api_key, default: "")
          config.mistral_api_key = mistral_key unless mistral_key.empty?

          openrouter_key = Rubysmithing.config.fetch(:openrouter_api_key, default: "")
          unless openrouter_key.empty?
            config.openrouter_api_key = openrouter_key
            config.openrouter_api_base = Rubysmithing.config.fetch(:openrouter_api_base)
          end
        end

        Rubysmithing.log_agent_event(
          :info,
          "RubyLLM providers configured",
          mistral: provider_available?(:mistral),
          openrouter: provider_available?(:openrouter)
        )
      end

      def provider_for_use_case(use_case)
        case use_case.to_sym
        when :reasoning
          { provider: Rubysmithing.config.fetch(:reasoning_provider),
            model: Rubysmithing.config.fetch(:reasoning_model) }
        when :coding
          { provider: Rubysmithing.config.fetch(:coding_provider),
            model: Rubysmithing.config.fetch(:coding_model) }
        when :lightweight
          { provider: Rubysmithing.config.fetch(:lightweight_provider),
            model: Rubysmithing.config.fetch(:lightweight_model) }
        when :embedding
          { provider: Rubysmithing.config.fetch(:embedding_provider),
            model: Rubysmithing.config.fetch(:embedding_model) }
        when :sfl_analysis
          { provider: Rubysmithing.config.fetch(:sfl_analysis_provider),
            model: Rubysmithing.config.fetch(:sfl_analysis_model) }
        when :experimental
          { provider: Rubysmithing.config.fetch(:experimental_provider),
            model: Rubysmithing.config.fetch(:experimental_model) }
        else
          { provider: :mistral, model: "mistral-small" }
        end
      end

      def client_for_use_case(use_case, **options)
        cfg = provider_for_use_case(use_case)
        RubyLLM.client(provider: cfg[:provider], model: cfg[:model], **options)
      end

      def test_providers!
        providers_tested = []
        %i[mistral openrouter].each do |provider|
          next unless provider_available?(provider)
          client = RubyLLM.client(provider: provider, model: default_model_for_provider(provider))
          response = client.complete("Test connection", max_tokens: 10)
          Rubysmithing.log_agent_event(:info, "Provider test successful",
                                       provider: provider,
                                       response_length: response.length)
          providers_tested << provider
        rescue => error
          Rubysmithing.log_agent_event(:error, "Provider test failed",
                                       provider: provider,
                                       error: error.message)
        end
        providers_tested
      end

      private

      def provider_available?(provider)
        case provider
        when :mistral
          !Rubysmithing.config.fetch(:mistral_api_key, default: "").empty?
        when :openrouter
          !Rubysmithing.config.fetch(:openrouter_api_key, default: "").empty?
        else
          false
        end
      end

      def default_model_for_provider(provider)
        case provider
        when :mistral then "mistral-small"
        when :openrouter then "qwen/qwen-2.5-72b-instruct"
        end
      end
    end
  end
end
