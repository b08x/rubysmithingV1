# frozen_string_literal: true

require "ruby_llm"

module Rubysmithing
  # Multi-provider LLM configuration using DSPy RubyLLM adapter
  # Supports Mistral direct, OpenRouter, and Hugging Face Inference
  # with SFL-based filtering for consistent outputs
  class LlmProviders
    class << self
      # Configure all LLM providers based on rubysmithing config
      def configure!
        configure_ruby_llm!
        configure_mistral_provider!
        configure_openrouter_provider!
        configure_huggingface_provider!
      end

      # Configure base RubyLLM settings
      def configure_ruby_llm!
        RubyLLM.configure do |config|
          config.log_level = Rubysmithing.config.fetch(:log_level, "INFO").downcase.to_sym

          # Enable request logging for cost monitoring
          config.log_requests = true
          config.request_logger = Rubysmithing.logger

          # Default timeout and retry settings
          config.request_timeout = 30
          config.max_retries = 3
          config.retry_backoff = 2.0
        end
      end

      # Configure Mistral direct provider for native models
      def configure_mistral_provider!
        mistral_api_key = Rubysmithing.config.fetch(:mistral_api_key)
        return if mistral_api_key.empty?

        RubyLLM.configure do |config|
          config.mistral do |mistral|
            mistral.api_key = mistral_api_key
            mistral.api_base = Rubysmithing.config.fetch(:mistral_api_base)

            # Native Mistral models
            mistral.models = {
              "mistral-medium-3.5" => {
                max_tokens: 32_768,
                context_length: 32_768,
                input_cost_per_1m: 2700, # $2.70 per 1M tokens
                output_cost_per_1m: 8100  # $8.10 per 1M tokens
              },
              "devstral-2" => {
                max_tokens: 8192,
                context_length: 16_384,
                input_cost_per_1m: 1000,
                output_cost_per_1m: 3000
              },
              "codestral" => {
                max_tokens: 8192,
                context_length: 32_768,
                input_cost_per_1m: 1000,
                output_cost_per_1m: 3000
              },
              "mistral-small" => {
                max_tokens: 8192,
                context_length: 32_768,
                input_cost_per_1m: 200,
                output_cost_per_1m: 600
              },
              "mistral-nemo" => {
                max_tokens: 8192,
                context_length: 128_000,
                input_cost_per_1m: 300,
                output_cost_per_1m: 300
              }
            }
          end
        end

        Rubysmithing.log_agent_event(:info, "Mistral provider configured",
                                    models: %w[mistral-medium-3.5 devstral-2 codestral mistral-small mistral-nemo])
      end

      # Configure OpenRouter for open-source model access
      def configure_openrouter_provider!
        openrouter_api_key = Rubysmithing.config.fetch(:openrouter_api_key)
        return if openrouter_api_key.empty?

        RubyLLM.configure do |config|
          config.openrouter do |openrouter|
            openrouter.api_key = openrouter_api_key
            openrouter.api_base = Rubysmithing.config.fetch(:openrouter_api_base)

            # HTTP headers for OpenRouter
            openrouter.headers = {
              "HTTP-Referer" => "https://rubysmithing.dev",
              "X-Title" => "Rubysmithing Agent Framework"
            }

            # Open-source models via OpenRouter
            openrouter.models = {
              "mistralai/mistral-embed" => {
                type: :embedding,
                max_tokens: 8192,
                input_cost_per_1m: 100
              },
              "qwen/qwen-2.5-72b-instruct" => {
                max_tokens: 32_768,
                context_length: 32_768,
                input_cost_per_1m: 400,
                output_cost_per_1m: 400
              },
              "meta-llama/llama-3.1-70b-instruct" => {
                max_tokens: 8192,
                context_length: 131_072,
                input_cost_per_1m: 600,
                output_cost_per_1m: 600
              },
              "anthropic/claude-3.5-sonnet" => {
                max_tokens: 8192,
                context_length: 200_000,
                input_cost_per_1m: 3000,
                output_cost_per_1m: 15_000
              }
            }
          end
        end

        Rubysmithing.log_agent_event(:info, "OpenRouter provider configured",
                                    models: %w[mistral-embed qwen-2.5-72b llama-3.1-70b claude-3.5-sonnet])
      end

      # Configure Hugging Face Inference
      def configure_huggingface_provider!
        hf_api_key = Rubysmithing.config.fetch(:hf_api_key)
        return if hf_api_key.empty?

        RubyLLM.configure do |config|
          config.huggingface do |hf|
            hf.api_key = hf_api_key
            hf.api_base = Rubysmithing.config.fetch(:hf_inference_api_base)

            # HF Inference models
            hf.models = {
              "mistralai/Mistral-7B-Instruct-v0.3" => {
                max_tokens: 4096,
                input_cost_per_1m: 0, # Free tier
                output_cost_per_1m: 0
              },
              "microsoft/DialoGPT-medium" => {
                max_tokens: 1024,
                input_cost_per_1m: 0,
                output_cost_per_1m: 0
              }
            }
          end
        end

        Rubysmithing.log_agent_event(:info, "Hugging Face provider configured",
                                    models: %w[Mistral-7B-Instruct DialoGPT-medium])
      end

      # Get provider and model for specific use case
      def provider_for_use_case(use_case)
        case use_case.to_sym
        when :reasoning
          {
            provider: Rubysmithing.config.fetch(:reasoning_provider),
            model: Rubysmithing.config.fetch(:reasoning_model)
          }
        when :coding
          {
            provider: Rubysmithing.config.fetch(:coding_provider),
            model: Rubysmithing.config.fetch(:coding_model)
          }
        when :lightweight
          {
            provider: Rubysmithing.config.fetch(:lightweight_provider),
            model: Rubysmithing.config.fetch(:lightweight_model)
          }
        when :embedding
          {
            provider: Rubysmithing.config.fetch(:embedding_provider),
            model: Rubysmithing.config.fetch(:embedding_model)
          }
        when :sfl_analysis
          {
            provider: Rubysmithing.config.fetch(:sfl_analysis_provider),
            model: Rubysmithing.config.fetch(:sfl_analysis_model)
          }
        when :experimental
          {
            provider: Rubysmithing.config.fetch(:experimental_provider),
            model: Rubysmithing.config.fetch(:experimental_model)
          }
        else
          # Default fallback
          {
            provider: :mistral,
            model: "mistral-small"
          }
        end
      end

      # Create RubyLLM client for specific use case
      def client_for_use_case(use_case, **options)
        config = provider_for_use_case(use_case)

        RubyLLM.client(
          provider: config[:provider],
          model: config[:model],
          **options
        )
      end

      # Test all configured providers
      def test_providers!
        providers_tested = []

        [:mistral, :openrouter, :huggingface].each do |provider|
          next unless provider_available?(provider)

          begin
            client = RubyLLM.client(provider: provider, model: default_model_for_provider(provider))

            # Simple test call
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
        end

        providers_tested
      end

      private

      def provider_available?(provider)
        case provider
        when :mistral
          !Rubysmithing.config.fetch(:mistral_api_key, "").empty?
        when :openrouter
          !Rubysmithing.config.fetch(:openrouter_api_key, "").empty?
        when :huggingface
          !Rubysmithing.config.fetch(:hf_api_key, "").empty?
        else
          false
        end
      end

      def default_model_for_provider(provider)
        case provider
        when :mistral then "mistral-small"
        when :openrouter then "qwen/qwen-2.5-72b-instruct"
        when :huggingface then "mistralai/Mistral-7B-Instruct-v0.3"
        end
      end
    end
  end
end