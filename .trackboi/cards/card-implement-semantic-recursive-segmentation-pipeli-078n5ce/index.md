---
id: "card-implement-semantic-recursive-segmentation-pipeli-078n5ce"
boardId: "default"
title: "Implement Semantic Recursive Segmentation Pipeline"
parentId: null
scope: {"kind":"project","ref":"global"}
trackId: null
column: "backlog"
rank: "j"
labels: []
assignee: null
fieldValues: {}
createdAt: "2026-05-12T21:59:54.451Z"
updatedAt: "2026-05-12T21:59:54.451Z"
createdBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
updatedBy: "agent_01KRBGG5HJT418GCKQJGAESFSQ"
---
**Priority**: HIGH - Foundation component for NLP pipeline

**Research Findings** (QMD search results):
- **Document chunking strategies**: Recursive chunking, semantic chunking, LLM-based chunking with Ruby implementations
- **pragmatic_segmenter**: Available Ruby gem for sentence boundary detection  
- **Semantic/Topic-Based Chunking**: Uses cosine similarity of sentence embeddings and topic overlap (noun chunks/WordNet)
- **SFL Integration**: Maps content to Process Types via Ideational Metafunction analysis

**Implementation Strategy** (from notebook research):
1. **Hierarchical segmentation**: Document → sections → paragraphs → sentences → tokens
2. **Semantic coherence**: Group sentences by topic using embedding similarity (threshold < 0.3, similarity < 0.5)
3. **Preserve context**: Configurable overlap buffer between chunks to maintain semantic relationships
4. **SFL structure preservation**: Map raw character boundaries to SFL graphological stratum

**Integration Points**:
- Input to token cleaning stage
- Foundation for embedding pipeline
- Critical for maintaining semantic coherence across pipeline stages

**Files to create**:
- `lib/rubysmithing/segmentation/semantic_segmenter.rb`
- `lib/rubysmithing/segmentation/recursive_chunker.rb`
- Integration with existing pipeline orchestrator