# frozen_string_literal: true

require_relative "routing/complexity_analyzer"
require_relative "routing/sfl_analyzer"
require_relative "routing/routing_decision"
require_relative "llm_providers"
require_relative "logging"

module Rubysmithing
  # Intelligent model routing based on task complexity and SFL analysis
  # Implements DSPy-style conditional routing with ruby-spacy integration
  class ModelRouter
    include Rubysmithing::Logging

    def initialize
      @complexity_analyzer = Routing::ComplexityAnalyzer.new
      @sfl_analyzer = Routing::SflAnalyzer.new
      @routing_decision = Routing::RoutingDecision.new
    end

    # Main routing method - selects optimal model for task
    def route_task(input_text, context: {})
      with_performance_logging("model_routing") do
        log_agent_operation(:info, "routing_task_start",
                          input_length: input_text.length,
                          context: context.keys)

        # Step 1: Analyze task complexity
        complexity_score = @complexity_analyzer.analyze(input_text, context)

        # Step 2: Classify content type using SFL
        content_type = @sfl_analyzer.classify_content_type(input_text)

        # Step 3: Apply routing logic
        routing_decision = @routing_decision.make_decision(complexity_score, content_type, context)

        log_agent_operation(:info, "routing_complete",
                          complexity_score: complexity_score,
                          content_type: content_type,
                          selected_provider: routing_decision[:provider],
                          selected_model: routing_decision[:model])

        routing_decision
      end
    rescue => error
      log_error(error, context: "model_routing")
      @routing_decision.fallback_routing
    end

    # Create DSPy-style conditional module based on routing decision
    def create_conditional_module(signature_class, input_text, context: {})
      routing = route_task(input_text, context: context)

      case routing[:complexity]
      when :simple
        # Use simple Predict for straightforward tasks
        DSPy::Predict.new(signature_class).tap do |predictor|
          configure_predictor(predictor, routing)
        end
      when :moderate
        # Use ChainOfThought for analysis tasks
        DSPy::ChainOfThought.new(signature_class).tap do |predictor|
          configure_predictor(predictor, routing)
        end
      when :complex, :expert
        # Use ReAct for complex multi-step reasoning
        available_tools = build_tools_for_context(context)
        DSPy::ReAct.new(signature_class, tools: available_tools).tap do |predictor|
          configure_predictor(predictor, routing)
        end
      end
    end

    private

    # Configure DSPy predictor with routing decision
    def configure_predictor(predictor, routing)
      # Set provider-specific configuration for RubyLLM integration
      predictor.instance_variable_set(:@provider, routing[:provider])
      predictor.instance_variable_set(:@model, routing[:model])
    end

    # Build tools for ReAct based on context
    def build_tools_for_context(context)
      tools = []

      tools << SearchTool.new if context[:needs_search]
      tools << CodeAnalysisTool.new if context[:code_analysis]
      tools << FileTool.new if context[:file_operations]

      tools
    end
  end
end