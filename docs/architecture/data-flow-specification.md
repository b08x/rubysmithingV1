# Data Flow Specification

## Pipeline Data Transformation Flow

```mermaid
sequenceDiagram
    participant Input as Raw Text Input
    participant Seg as Semantic Segmenter
    participant Clean as Token Cleaner
    participant Tag as Linguistic Tagger
    participant Embed as Vector Generator
    participant Cache as Redis Cache
    participant Store as PostgreSQL

    %% Stage 1: Segmentation
    Input->>Seg: Raw text document
    Seg->>Seg: Apply pragmatic_segmenter
    Seg->>Seg: Semantic coherence analysis
    Seg->>Seg: Recursive chunking (threshold < 0.3)
    Seg->>Cache: Store segmentation metadata
    
    %% Stage 2: Token Cleaning
    Seg->>Clean: Semantically coherent chunks
    Clean->>Clean: ruby-spacy morphological analysis
    Clean->>Clean: Normalize encoding & whitespace
    Clean->>Clean: Lemmatization & root forms
    Clean->>Cache: Store cleaned tokens
    
    %% Stage 3: Linguistic Analysis
    Clean->>Tag: Cleaned token sequences
    Tag->>Tag: POS tagging (ruby-spacy)
    Tag->>Tag: Named entity recognition
    Tag->>Tag: Dependency parsing
    Tag->>Tag: SFL metafunction mapping
    Tag->>Cache: Store linguistic annotations
    
    %% Stage 4: Embedding Generation
    Tag->>Embed: Linguistically annotated text
    Embed->>Embed: Generate 768-dim vectors (Mistral embed)
    Embed->>Embed: Cross-encoder reranking (informers)
    Embed->>Cache: Store embedding cache
    Embed->>Store: pgvector storage
    
    %% Stage 5-7: Persistence & Archival
    Cache->>Store: Archive session state
    Cache->>Store: JSONB linguistic metadata
    Cache->>Store: Vector embeddings
    Store->>Store: Index for semantic search
```

## Class Interaction Model

```mermaid
classDiagram
    %% Core Pipeline Classes
    class SemanticSegmenter {
        +segment(text: String): Array~Chunk~
        +apply_coherence_threshold(chunks: Array): Array
        +preserve_context_overlap(chunks: Array): Array
        -pragmatic_boundary_detection()
        -semantic_similarity_scoring()
    }
    
    class TokenCleaner {
        +clean(chunks: Array~Chunk~): Array~TokenSequence~
        +normalize_encoding(text: String): String
        +lemmatize_tokens(tokens: Array): Array
        -ruby_spacy_integration()
        -morphological_analysis()
    }
    
    class LinguisticTagger {
        +tag_pos(tokens: Array): Array~POSToken~
        +extract_entities(tokens: Array): Array~Entity~
        +parse_dependencies(tokens: Array): DependencyTree
        +map_sfl_metafunctions(tokens: Array): SFLAnalysis
        -process_type_identification()
        -modality_analysis()
    }
    
    class VectorGenerator {
        +generate_embeddings(text: String): Vector768
        +batch_embed(texts: Array): Array~Vector768~
        +rerank_results(query: String, docs: Array): Array
        -mistral_embed_integration()
        -informers_reranking()
    }

    %% Cache Models
    class ProcessingSession {
        +id: String
        +stage_progress: Hash
        +intermediate_results: Hash
        +metadata: Hash
        +created_at: Time
        +update_stage(stage: Symbol, data: Hash)
        +mark_complete()
    }
    
    class TokenCache {
        +session_id: String
        +cleaned_tokens: Array
        +lemmatization_map: Hash
        +expiry: Time
        +retrieve_by_session(id: String): TokenCache
    }
    
    class EmbeddingCache {
        +text_hash: String
        +vector: Array~Float~
        +model_version: String
        +created_at: Time
        +find_by_hash(hash: String): Vector
    }

    %% Persistent Models
    class Document {
        +id: UUID
        +original_text: Text
        +processing_status: String
        +metadata: JSONB
        +created_at: Time
        +embeddings: DocumentEmbedding[]
        +annotations: LinguisticAnnotation[]
    }
    
    class LinguisticAnnotation {
        +document_id: UUID
        +pos_tags: JSONB
        +entities: JSONB
        +dependencies: JSONB
        +sfl_analysis: JSONB
        +confidence_scores: JSONB
    }
    
    class DocumentEmbedding {
        +document_id: UUID
        +embedding: Vector(768)
        +model_version: String
        +chunk_index: Integer
        +similarity_search(query_vector: Vector): Array
    }

    %% Relationships
    SemanticSegmenter --> TokenCleaner : chunks
    TokenCleaner --> LinguisticTagger : tokens
    LinguisticTagger --> VectorGenerator : annotated_text
    VectorGenerator --> EmbeddingCache : vectors
    
    ProcessingSession --> TokenCache : session_data
    ProcessingSession --> EmbeddingCache : session_data
    
    TokenCache --> Document : archive
    EmbeddingCache --> DocumentEmbedding : persist
    LinguisticTagger --> LinguisticAnnotation : annotations
    
    Document ||--o{ DocumentEmbedding : contains
    Document ||--o{ LinguisticAnnotation : has
```

## Multi-Provider Routing State Machine

```mermaid
stateDiagram-v2
    [*] --> InputAnalysis
    
    InputAnalysis --> ComplexityScoring : Analyze text structure
    InputAnalysis --> SFLClassification : Analyze metafunctions
    
    ComplexityScoring --> Simple : Score ≤ 0.3
    ComplexityScoring --> Moderate : 0.3 < Score ≤ 0.6
    ComplexityScoring --> Complex : 0.6 < Score ≤ 0.8
    ComplexityScoring --> Expert : Score > 0.8
    
    SFLClassification --> Material : Process type identified
    SFLClassification --> Mental : Cognitive content
    SFLClassification --> Relational : Descriptive content
    SFLClassification --> Verbal : Communication content
    
    Simple --> MistralSmall : Use lightweight model
    Moderate --> MistralNemo : Use balanced model
    Complex --> QwenLarge : Use reasoning model
    Expert --> MistralMedium : Use expert model
    
    Material --> OpenRouter : Route to open models
    Mental --> MistralDirect : Route to native API
    Relational --> HuggingFace : Route to inference API
    Verbal --> MistralDirect : Route to native API
    
    MistralSmall --> DSPyPredict : Simple prediction
    MistralNemo --> DSPyChainOfThought : Reasoning chain
    QwenLarge --> DSPyReAct : Agent reasoning
    MistralMedium --> DSPyReAct : Expert reasoning
    
    DSPyPredict --> QualityGate : Validate output
    DSPyChainOfThought --> QualityGate
    DSPyReAct --> QualityGate
    
    QualityGate --> SFLFilter : Check consistency
    SFLFilter --> OutputValid : Pass threshold (≥0.85)
    SFLFilter --> Retry : Fail threshold (<0.85)
    
    Retry --> InputAnalysis : Retry with different route
    OutputValid --> [*] : Complete processing
```

## Cache Strategy & Performance Flow

```mermaid
graph TB
    %% Cache Hit/Miss Strategy
    subgraph "Cache Strategy"
        TokenRequest[Token Request] --> TokenCacheCheck{Cache Hit?}
        TokenCacheCheck --> |Hit| TokenReturn[Return Cached]
        TokenCacheCheck --> |Miss| TokenProcess[Process & Cache]
        
        EmbedRequest[Embedding Request] --> EmbedCacheCheck{Cache Hit?}
        EmbedCacheCheck --> |Hit| EmbedReturn[Return Cached Vector]
        EmbedCacheCheck --> |Miss| EmbedProcess[Generate & Cache]
        
        SFLRequest[SFL Analysis Request] --> SFLCacheCheck{Cache Hit?}
        SFLCacheCheck --> |Hit| SFLReturn[Return Analysis]
        SFLCacheCheck --> |Miss| SFLProcess[Analyze & Cache]
    end

    %% Performance Optimization
    subgraph "Performance Flow"
        BatchRequest[Batch Processing Request]
        ParallelTokens[Parallel Token Cleaning]
        ParallelEmbeds[Parallel Embedding Generation]
        ParallelSFL[Parallel SFL Analysis]
        
        BatchRequest --> ParallelTokens
        BatchRequest --> ParallelEmbeds
        BatchRequest --> ParallelSFL
    end

    %% Cache Expiry & Archival
    subgraph "Cache Lifecycle"
        CacheExpiry[Cache Expiry Check]
        SessionComplete[Session Complete]
        ArchiveDecision{Archive?}
        PostgreSQLArchive[Archive to PostgreSQL]
        CacheEvict[Evict from Redis]
        
        CacheExpiry --> SessionComplete
        SessionComplete --> ArchiveDecision
        ArchiveDecision --> |Yes| PostgreSQLArchive
        ArchiveDecision --> |No| CacheEvict
        PostgreSQLArchive --> CacheEvict
    end

    %% Integration points
    TokenProcess -.-> ParallelTokens
    EmbedProcess -.-> ParallelEmbeds
    SFLProcess -.-> ParallelSFL
    
    ParallelTokens -.-> CacheExpiry
    ParallelEmbeds -.-> CacheExpiry
    ParallelSFL -.-> CacheExpiry

    %% Styling
    classDef cache fill:#fce4ec
    classDef process fill:#e8f5e8
    classDef archive fill:#e1f5fe
    
    class TokenCacheCheck,EmbedCacheCheck,SFLCacheCheck,TokenReturn,EmbedReturn,SFLReturn cache
    class ParallelTokens,ParallelEmbeds,ParallelSFL,TokenProcess,EmbedProcess,SFLProcess process
    class CacheExpiry,PostgreSQLArchive,CacheEvict,ArchiveDecision archive
```

## Integration Testing Flow

```mermaid
graph LR
    %% Test Data Flow
    TestInput[Test Input Documents] --> StageTests
    
    subgraph "Stage-by-Stage Testing"
        StageTests[Individual Stage Tests]
        SegmentTest[Segmentation Test]
        CleanTest[Token Cleaning Test]
        TagTest[Tagging Test]
        EmbedTest[Embedding Test]
        CacheTest[Cache Integration Test]
        StorageTest[Storage Integration Test]
        
        StageTests --> SegmentTest
        SegmentTest --> CleanTest
        CleanTest --> TagTest
        TagTest --> EmbedTest
        EmbedTest --> CacheTest
        CacheTest --> StorageTest
    end

    %% End-to-End Testing
    subgraph "E2E Pipeline Testing"
        E2ETest[End-to-End Test]
        QualityMetrics[Quality Metrics]
        PerformanceMetrics[Performance Metrics]
        ConsistencyCheck[SFL Consistency Check]
        
        E2ETest --> QualityMetrics
        E2ETest --> PerformanceMetrics
        E2ETest --> ConsistencyCheck
    end

    %% Validation Gates
    subgraph "Validation Gates"
        SchemaValidation[Schema Validation]
        SFLValidation[SFL Validation]
        VectorValidation[Vector Validation]
        IntegrationValidation[Integration Validation]
    end

    StorageTest --> E2ETest
    QualityMetrics --> SchemaValidation
    PerformanceMetrics --> SFLValidation
    ConsistencyCheck --> VectorValidation
    VectorValidation --> IntegrationValidation

    %% Results
    IntegrationValidation --> TestResults[Test Results & Report]

    %% Styling
    classDef test fill:#e3f2fd
    classDef validation fill:#f3e5f5
    classDef results fill:#e8f5e8
    
    class SegmentTest,CleanTest,TagTest,EmbedTest,CacheTest,StorageTest,E2ETest test
    class SchemaValidation,SFLValidation,VectorValidation,IntegrationValidation validation
    class QualityMetrics,PerformanceMetrics,ConsistencyCheck,TestResults results
```