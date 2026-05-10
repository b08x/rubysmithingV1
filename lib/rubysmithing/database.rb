# frozen_string_literal: true

require "sequel"
require "pgvector"

module Rubysmithing
  module Database
    def self.connect
      db_url = Rubysmithing.config.fetch(:database_url)
      begin
        db = Sequel.connect(db_url)
        
        # Load extensions
        db.run("CREATE EXTENSION IF NOT EXISTS vector") rescue nil
        db.run("CREATE EXTENSION IF NOT EXISTS \"pgcrypto\"") rescue nil
        db.run("CREATE EXTENSION IF NOT EXISTS pg_trgm") rescue nil
        
        db
      rescue => e
        nil
      end
    end

    def self.migrate(db)
      db.create_table?(:documents) do
        uuid :id, primary_key: true, default: Sequel.function(:gen_random_uuid)
        String :title, text: true, null: false
        column :metadata, :jsonb, default: "{}"
        DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
      end

      db.create_table?(:clauses) do
        uuid :id, primary_key: true, default: Sequel.function(:gen_random_uuid)
        foreign_key :document_id, :documents, type: :uuid, on_delete: :cascade
        Text :content, null: false
        column :embedding, "vector(768)" # Match Ollama embeddinggemma
        DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
        
        index :embedding, type: "hnsw", opclass: :vector_cosine_ops
      end

      db.create_table?(:blueprints) do
        uuid :id, primary_key: true, default: Sequel.function(:gen_random_uuid)
        String :name, null: false
        String :category, null: false
        Text :description, null: false
        Text :code, null: false
        column :embedding, "vector(768)"
        DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP

        index :embedding, type: "hnsw", opclass: :vector_cosine_ops
      end
    end
  end
end
