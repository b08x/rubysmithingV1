# frozen_string_literal: true

require "dspy"

module Rubysmithing
  module Workflows
    # DSPy signature for validating and structuring natural language input
    # First stage of the SFL-BDD pipeline
    class NaturalLanguageInput < DSPy::Signature
      description "Validate and structure natural language input for SFL metafunction analysis"

      class InputSource < T::Enum
        enums do
          UserInput = new('user_input')
          FileUpload = new('file_upload')
          ApiRequest = new('api_request')
          BatchImport = new('batch_import')
        end
      end

      class ProcessingMetadata < T::Struct
        const :timestamp, Time
        const :session_id, String
        const :user_id, T.nilable(String)
        const :word_count, Integer
        const :character_count, Integer
        const :estimated_tokens, Integer
      end

      input do
        const :raw_input, String, desc: "Raw natural language text"
        const :source, InputSource, desc: "Source of the input"
        const :context, T.nilable(String), desc: "Additional context if available"
      end

      output do
        const :is_valid, T::Boolean, desc: "Whether input meets SFL analysis requirements"
        const :cleaned_text, String, desc: "Preprocessed text ready for SFL analysis"
        const :validation_errors, T::Array[String], desc: "List of validation issues"
        const :metadata, ProcessingMetadata, desc: "Processing statistics and metadata"
        const :suggested_improvements, T::Array[String], desc: "Suggestions to improve input quality"
      end
    end
  end
end