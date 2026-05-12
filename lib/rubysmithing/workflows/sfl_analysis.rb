# frozen_string_literal: true

require "dspy"

module Rubysmithing
  module Workflows
    # DSPy signature for SFL metafunction analysis
    # Core linguistic analysis stage of the SFL-BDD pipeline
    class SflAnalysis < DSPy::Signature
      description "Perform Systemic Functional Linguistics metafunction analysis on natural language text"

      class ProcessType < T::Enum
        enums do
          Material = new('material')      # doing, happening
          Mental = new('mental')          # sensing, thinking, feeling
          Relational = new('relational')  # being, having
          Verbal = new('verbal')          # saying, meaning
          Behavioral = new('behavioral')  # behaving
          Existential = new('existential') # existing
        end
      end

      class ModalityType < T::Enum
        enums do
          High = new('high')        # must, always, definitely
          Medium = new('medium')    # should, usually, probably
          Low = new('low')          # may, sometimes, possibly
        end
      end

      class ThemePattern < T::Enum
        enums do
          Simple = new('simple')           # single theme
          Multiple = new('multiple')       # multiple themes
          Marked = new('marked')           # marked theme
          Predicated = new('predicated')   # predicated theme
        end
      end

      class IdeationalFunction < T::Struct
        const :processes, T::Array[ProcessType]
        const :participants, T::Array[String]
        const :circumstances, T::Array[String]
        const :process_density, Float
      end

      class InterpersonalFunction < T::Struct
        const :speech_function, String      # statement, question, command, offer
        const :modality, ModalityType
        const :polarity, String             # positive, negative
        const :certainty_level, Float       # 0.0-1.0
      end

      class TextualFunction < T::Struct
        const :theme_pattern, ThemePattern
        const :theme_elements, T::Array[String]
        const :cohesive_devices, T::Array[String]
        const :information_flow, String
      end

      class SflAnalysisResult < T::Struct
        const :ideational, IdeationalFunction
        const :interpersonal, InterpersonalFunction
        const :textual, TextualFunction
        const :confidence_score, Float
        const :complexity_rating, String    # simple, moderate, complex
        const :linguistic_features, T::Array[String]
      end

      input do
        const :cleaned_text, String, desc: "Preprocessed natural language text"
        const :analysis_depth, String, default: "standard", enum: ["basic", "standard", "detailed"]
        const :focus_metafunctions, T::Array[String], default: ["ideational", "interpersonal", "textual"]
      end

      output do
        const :analysis, SflAnalysisResult, desc: "Complete SFL metafunction analysis"
        const :processing_notes, T::Array[String], desc: "Analysis methodology notes"
        const :ambiguity_flags, T::Array[String], desc: "Areas of linguistic ambiguity"
        const :confidence_breakdown, T::Hash[String, Float], desc: "Per-metafunction confidence scores"
      end
    end
  end
end