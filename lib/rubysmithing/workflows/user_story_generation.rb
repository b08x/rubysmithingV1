# frozen_string_literal: true

require "dspy"

module Rubysmithing
  module Workflows
    # DSPy signature for generating user stories from SFL analysis
    # Transforms linguistic analysis into structured development artifacts
    class UserStoryGeneration < DSPy::Signature
      description "Generate structured user stories from SFL metafunction analysis"

      class StoryPriority < T::Enum
        enums do
          Critical = new('critical')
          High = new('high')
          Medium = new('medium')
          Low = new('low')
        end
      end

      class StoryComplexity < T::Enum
        enums do
          Simple = new('simple')       # 1-3 story points
          Moderate = new('moderate')   # 3-8 story points
          Complex = new('complex')     # 8-13 story points
          Epic = new('epic')          # 13+ story points, needs breakdown
        end
      end

      class AcceptanceCriterion < T::Struct
        const :given, String         # Given context
        const :when, String          # When action
        const :then, String          # Then expected outcome
        const :priority, StoryPriority
        const :testable, T::Boolean
      end

      class UserStory < T::Struct
        const :id, String
        const :title, String
        const :narrative, String         # As a... I want... So that...
        const :description, String
        const :priority, StoryPriority
        const :complexity, StoryComplexity
        const :acceptance_criteria, T::Array[AcceptanceCriterion]
        const :tags, T::Array[String]
        const :sfl_foundation, T::Hash[String, T.untyped]  # Links back to SFL analysis
        const :dependencies, T::Array[String]
        const :estimated_points, T.nilable(Integer)
      end

      class StoryGenerationMetadata < T::Struct
        const :total_stories, Integer
        const :priority_distribution, T::Hash[String, Integer]
        const :complexity_distribution, T::Hash[String, Integer]
        const :sfl_mapping_confidence, Float
        const :generated_at, Time
      end

      input do
        const :sfl_analysis, T::Hash[String, T.untyped], desc: "Complete SFL analysis result"
        const :domain_context, T.nilable(String), desc: "Domain-specific context for stories"
        const :story_template, String, default: "standard", enum: ["standard", "technical", "business", "epic"]
        const :max_stories, Integer, default: 10, desc: "Maximum number of stories to generate"
      end

      output do
        const :stories, T::Array[UserStory], desc: "Generated user stories"
        const :metadata, StoryGenerationMetadata, desc: "Generation statistics and metadata"
        const :mapping_notes, T::Array[String], desc: "How SFL elements mapped to stories"
        const :quality_score, Float, desc: "Overall quality assessment (0.0-1.0)"
        const :recommendations, T::Array[String], desc: "Suggestions for story improvement"
      end
    end
  end
end