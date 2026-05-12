---
id: "card-implement-sequel-orm-models-for-persistent-nlp-s-1x87l6q"
boardId: "default"
title: "Implement Sequel ORM Models for Persistent NLP Storage"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: null
column: "backlog"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-12T22:01:08.097Z"
updatedAt: "2026-05-12T22:01:08.097Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
**Priority**: HIGH - Stage 6 & 7 of 7-stage NLP pipeline (persistent storage)

**Research Findings** (QMD search results):
- **Sequel ORM integration**: "Archive with PostgreSQL, Sequel models, Gush pipeline for processing"
- **JSONB + pgvector**: "PostgreSQL enhanced with JSONB and pgvector extensions" for structured + vector data
- **SFL metadata storage**: "JSONB columns for SFL metafunction data" with linguistic annotations
- **Pipeline archival**: "Messages flushed from Redis to PostgreSQL, processed by ruby-spacy and informers to generate vectors and SFL tags"

**Sequel Architecture** (from research):
1. **Document storage**: Primary text documents with metadata and processing history
2. **Linguistic annotations**: JSONB columns for POS, NER, dependencies, SFL metafunctions  
3. **Vector storage**: pgvector columns for embeddings and similarity search
4. **Session archival**: Persistent storage of completed processing sessions
5. **Audit trails**: Track processing pipeline stages and transformations

**Implementation Strategy**:
- **Document models**: Store original text, processing metadata, quality metrics
- **Linguistic models**: POS tags, NER entities, dependency graphs in JSONB
- **Embedding models**: Vector representations with pgvector for similarity search
- **Session models**: Archive completed Redis session data with full context
- **Pipeline tracking**: Monitor processing stages, errors, and performance metrics

**Model Architecture**:
- **Document**: Original text + metadata + processing status
- **LinguisticAnnotation**: POS, NER, dependencies, SFL analysis (JSONB)
- **DocumentEmbedding**: Vector representations (pgvector) + similarity indexes
- **ProcessingSession**: Archived session state + pipeline stage results  
- **PipelineMetric**: Performance tracking and quality assessment

**Integration Points**:
- **Input**: Completed pipeline results from Redis cache
- **Storage**: PostgreSQL with JSONB + pgvector extensions
- **Retrieval**: Semantic search, linguistic querying, session reconstruction
- **Analytics**: Pipeline performance monitoring and optimization insights

**Files to create**:
- `lib/rubysmithing/models/document.rb`
- `lib/rubysmithing/models/linguistic_annotation.rb`
- `lib/rubysmithing/models/document_embedding.rb`
- `lib/rubysmithing/models/processing_session.rb`
- Migration files for schema setup