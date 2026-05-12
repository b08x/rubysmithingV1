# frozen_string_literal: true

require "digest"

module Rubysmithing
  module Routing
    # Analyzes task complexity using multiple signals for model routing decisions
    class ComplexityAnalyzer
      # Task complexity thresholds for routing decisions
      COMPLEXITY_THRESHOLDS = {
        simple: 0.3,      # Simple extraction, formatting
        moderate: 0.6,    # Analysis, reasoning
        complex: 0.8,     # Multi-step reasoning, code generation
        expert: 1.0       # Complex reasoning, architecture
      }.freeze

      def initialize
        @complexity_cache = {}
      end

      # Analyze task complexity using multiple signals
      def analyze(input_text, context = {})
        # Check cache first
        cache_key = Digest::SHA256.hexdigest("#{input_text}#{context}")
        return @complexity_cache[cache_key] if @complexity_cache.key?(cache_key)

        complexity_signals = []

        # Signal 1: Text length and structure
        complexity_signals << text_structure_complexity(input_text)

        # Signal 2: Context complexity
        complexity_signals << context_complexity(context)

        # Signal 3: Domain-specific patterns
        complexity_signals << domain_pattern_complexity(input_text)

        # Weighted average of complexity signals
        final_score = complexity_signals.sum / complexity_signals.size

        # Cache the result
        @complexity_cache[cache_key] = final_score
        final_score
      end

      # Convert complexity score to category
      def score_to_category(complexity_score)
        case complexity_score
        when 0..COMPLEXITY_THRESHOLDS[:simple] then :simple
        when COMPLEXITY_THRESHOLDS[:simple]..COMPLEXITY_THRESHOLDS[:moderate] then :moderate
        when COMPLEXITY_THRESHOLDS[:moderate]..COMPLEXITY_THRESHOLDS[:complex] then :complex
        else :expert
        end
      end

      private

      # Analyze text structure for complexity indicators
      def text_structure_complexity(text)
        complexity = 0.0

        # Length indicators
        complexity += 0.1 if text.length > 1000
        complexity += 0.2 if text.length > 5000

        # Structural complexity indicators
        complexity += 0.15 if text.include?("```") # Code blocks
        complexity += 0.1 if text.scan(/\n\s*\d+\./).size > 3 # Numbered lists
        complexity += 0.1 if text.scan(/\n#+\s/).size > 2 # Multiple headers
        complexity += 0.15 if text.scan(/\b(?:implement|design|architect|analyze)\b/i).any?

        # Question complexity
        complexity += 0.2 if text.scan(/\?/).size > 2 # Multiple questions
        complexity += 0.15 if text.match?(/\bhow\s+(?:to|do|can)\b/i) # How-to questions

        # Technical keywords that indicate complexity
        complexity += 0.1 if text.match?(/\b(?:algorithm|optimization|performance)\b/i)
        complexity += 0.15 if text.match?(/\b(?:integration|architecture|scalability)\b/i)

        [complexity, 1.0].min
      end

      # Context-based complexity scoring
      def context_complexity(context)
        complexity = 0.0

        # Use case complexity
        case context[:use_case]&.to_sym
        when :embedding then complexity += 0.1
        when :lightweight then complexity += 0.2
        when :coding then complexity += 0.6
        when :reasoning then complexity += 0.8
        when :experimental then complexity += 1.0
        end

        # Multi-step indicator
        complexity += 0.3 if context[:multi_step]

        # Agent coordination complexity
        complexity += 0.2 if context[:agent_handoff]

        # Workflow stage complexity
        case context[:workflow_stage]&.to_sym
        when :survey then complexity += 0.2
        when :resolve then complexity += 0.4
        when :dispatch then complexity += 0.6
        when :audit then complexity += 0.3
        end

        [complexity, 1.0].min
      end

      # Domain-specific pattern complexity
      def domain_pattern_complexity(text)
        complexity = 0.0

        # Code-related complexity
        complexity += 0.4 if text.match?(/\b(?:class|function|method|module)\b/i)
        complexity += 0.5 if text.match?(/\b(?:architecture|design pattern)\b/i)
        complexity += 0.6 if text.match?(/\b(?:distributed|microservice|scalability)\b/i)

        # SFL/linguistic complexity
        complexity += 0.5 if text.match?(/\b(?:metafunction|ideational|interpersonal)\b/i)

        # System design complexity
        complexity += 0.7 if text.match?(/\b(?:system design|infrastructure|deployment)\b/i)

        # Data processing complexity
        complexity += 0.4 if text.match?(/\b(?:pipeline|etl|data processing)\b/i)
        complexity += 0.5 if text.match?(/\b(?:machine learning|neural network|ai)\b/i)

        # Ruby/programming complexity
        complexity += 0.3 if text.match?(/\b(?:gem|bundler|rails|sinatra)\b/i)
        complexity += 0.4 if text.match?(/\b(?:metaprogramming|dsl|reflection)\b/i)

        [complexity, 1.0].min
      end
    end
  end
end