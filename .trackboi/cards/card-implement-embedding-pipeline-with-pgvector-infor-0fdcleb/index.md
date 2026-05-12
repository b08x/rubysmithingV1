---
id: "card-implement-embedding-pipeline-with-pgvector-infor-0fdcleb"
boardId: "default"
title: "Implement Embedding Pipeline with pgvector & informers"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: null
column: "backlog"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-12T22:00:32.349Z"
updatedAt: "2026-05-12T22:00:32.349Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
**Priority**: HIGH - Stage 4 of 7-stage NLP pipeline

**Research Findings** (QMD search results):
- **informers gem**: "The informers gem in Ruby can be used to run highly effective open-source reranking models locally"
- **pgvector integration**: "Stores in `embedding` column (pgvector type)" with 768-dimensional float arrays  
- **Multi-provider embedding**: Mistral embed model via OpenRouter for cost-effective vector generation
- **Cross-encoder reranking**: "Cross-encoder takes both the query and a candidate document as input and outputs a direct relevance score"

**Embedding Architecture** (from research):
1. **Bi-encoder embeddings**: Independent vectors for queries and documents using embedding models
2. **pgvector storage**: PostgreSQL extension for efficient vector operations and similarity search
3. **Reranking layer**: Cross-encoder models for nuanced relevance scoring
4. **Multi-provider support**: Mistral embed via OpenRouter, fallback to other providers

**Implementation Strategy**:
- **Text to vectors**: Convert processed tokens to dense embeddings
- **Vector storage**: pgvector PostgreSQL extension for similarity search
- **Batch processing**: Efficient embedding generation for large document sets
- **Similarity search**: Cosine similarity, L2 distance for semantic retrieval
- **Reranking**: informers gem for cross-encoder relevance scoring

**Integration Points**:
- Input: Cleaned and tagged tokens from previous pipeline stages
- Output: Vector representations ready for semantic search
- Storage: pgvector columns in PostgreSQL with efficient indexing
- Retrieval: Semantic similarity search for RAG applications

**Files to create**:
- `lib/rubysmithing/embedding/vector_generator.rb`
- `lib/rubysmithing/embedding/pgvector_store.rb`
- `lib/rubysmithing/embedding/reranker.rb`
- Integration with existing LLM provider routing