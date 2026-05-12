# NLP Pipeline Architecture

## Overview

7-stage semantic NLP pipeline with SFL filtering, multi-provider LLM routing, and hybrid storage architecture.

## System Architecture Diagram

```mermaid
graph TB
    %% Input Layer
    Input[Raw Text Input] --> Segmenter

    %% Stage 1: Semantic Segmentation
    subgraph "Stage 1: Semantic Recursive Segmentation"
        Segmenter[Semantic Segmenter]
        PragmaticSeg[pragmatic_segmenter]
        ChunkStrat[Chunking Strategies]
        
        Segmenter --> PragmaticSeg
        Segmenter --> ChunkStrat
    end

    %% Stage 2: Token Cleaning
    subgraph "Stage 2: Token Cleaning & Preprocessing"
        TokenCleaner[Token Cleaner]
        RubySpacy1[ruby-spacy Integration]
        Normalizer[Linguistic Normalizer]
        
        TokenCleaner --> RubySpacy1
        TokenCleaner --> Normalizer
    end

    %% Stage 3: Linguistic Analysis
    subgraph "Stage 3: Tagging & Linguistic Analysis"
        POSTagger[POS Tagger]
        NERExtractor[NER Extractor]
        DepParser[Dependency Parser]
        SFLMapper[SFL Mapper]
        RubySpacy2[ruby-spacy Core]
        
        POSTagger --> RubySpacy2
        NERExtractor --> RubySpacy2
        DepParser --> RubySpacy2
        SFLMapper --> RubySpacy2
    end

    %% Stage 4: Embedding Generation
    subgraph "Stage 4: Embedding Pipeline"
        VectorGen[Vector Generator]
        PgVectorStore[pgvector Store]
        Reranker[Cross-Encoder Reranker]
        InformersGem[informers Gem]
        
        VectorGen --> PgVectorStore
        Reranker --> InformersGem
    end

    %% Stage 5: Cache Layer
    subgraph "Stage 5: Redis Ohm Cache"
        ProcessingSession[Processing Session]
        TokenCache[Token Cache]
        EmbeddingCache[Embedding Cache]
        SFLCache[SFL Cache]
        
        ProcessingSession -.-> TokenCache
        ProcessingSession -.-> EmbeddingCache
        ProcessingSession -.-> SFLCache
    end

    %% Stage 6 & 7: Persistent Storage
    subgraph "Stage 6-7: Sequel ORM Storage"
        DocumentModel[Document Model]
        LinguisticAnnotation[Linguistic Annotation]
        DocumentEmbedding[Document Embedding]
        ProcessingSessionModel[Processing Session Model]
        PostgreSQL[(PostgreSQL + pgvector)]
        
        DocumentModel --> PostgreSQL
        LinguisticAnnotation --> PostgreSQL
        DocumentEmbedding --> PostgreSQL
        ProcessingSessionModel --> PostgreSQL
    end

    %% Data Flow
    Segmenter --> TokenCleaner
    TokenCleaner --> POSTagger
    POSTagger --> VectorGen
    VectorGen --> ProcessingSession
    ProcessingSession --> DocumentModel

    %% Cross-stage interactions
    POSTagger -.-> TokenCache
    VectorGen -.-> EmbeddingCache
    SFLMapper -.-> SFLCache
    
    ProcessingSession -.-> DocumentModel
    EmbeddingCache -.-> DocumentEmbedding
    SFLCache -.-> LinguisticAnnotation

    %% Styling
    classDef stage1 fill:#e1f5fe
    classDef stage2 fill:#f3e5f5
    classDef stage3 fill:#e8f5e8
    classDef stage4 fill:#fff3e0
    classDef stage5 fill:#fce4ec
    classDef stage6 fill:#f1f8e9
    classDef storage fill:#263238,color:#ffffff
    
    class Segmenter,PragmaticSeg,ChunkStrat stage1
    class TokenCleaner,RubySpacy1,Normalizer stage2
    class POSTagger,NERExtractor,DepParser,SFLMapper,RubySpacy2 stage3
    class VectorGen,PgVectorStore,Reranker,InformersGem stage4
    class ProcessingSession,TokenCache,EmbeddingCache,SFLCache stage5
    class DocumentModel,LinguisticAnnotation,DocumentEmbedding,ProcessingSessionModel stage6
    class PostgreSQL storage
```

## Multi-Provider LLM Routing Architecture

```mermaid
graph LR
    %% Input Analysis
    InputText[Input Text] --> ComplexityAnalyzer
    InputText --> SFLAnalyzer
    
    %% Analysis Components
    subgraph "Routing Analysis"
        ComplexityAnalyzer[Complexity Analyzer]
        SFLAnalyzer[SFL Content Analyzer]
        RoutingDecision[Routing Decision Engine]
        
        ComplexityAnalyzer --> RoutingDecision
        SFLAnalyzer --> RoutingDecision
    end

    %% Provider Ecosystem
    subgraph "LLM Provider Ecosystem"
        MistralDirect[Mistral Direct]
        OpenRouter[OpenRouter]
        HuggingFace[Hugging Face Inference]
        
        subgraph "Mistral Models"
            MediumModel[mistral-medium-3.5]
            CodestralModel[codestral]
            SmallModel[mistral-small]
            NemoModel[mistral-nemo]
        end
        
        subgraph "OpenRouter Models"
            MistralEmbed[mistral-embed]
            QwenModel[qwen-2.5-72b]
            LlamaModel[llama-3.1-70b]
        end
        
        subgraph "HF Models"
            MistralHF[Mistral-7B-Instruct]
            DialoGPT[DialoGPT-medium]
        end
    end

    %% DSPy Integration
    subgraph "DSPy Integration Layer"
        SimplePredict[DSPy Predict]
        ChainOfThought[DSPy ChainOfThought]
        ReActAgent[DSPy ReAct]
    end

    %% Routing Logic
    RoutingDecision --> |Simple Tasks| SimplePredict
    RoutingDecision --> |Analysis Tasks| ChainOfThought
    RoutingDecision --> |Complex Reasoning| ReActAgent

    %% Provider Selection
    SimplePredict --> MistralDirect
    ChainOfThought --> OpenRouter
    ReActAgent --> HuggingFace

    MistralDirect --> SmallModel
    OpenRouter --> QwenModel
    HuggingFace --> MistralHF

    %% Styling
    classDef analysis fill:#e3f2fd
    classDef providers fill:#f3e5f5
    classDef dspy fill:#e8f5e8
    classDef models fill:#fff3e0
    
    class ComplexityAnalyzer,SFLAnalyzer,RoutingDecision analysis
    class MistralDirect,OpenRouter,HuggingFace providers
    class SimplePredict,ChainOfThought,ReActAgent dspy
    class MediumModel,CodestralModel,SmallModel,NemoModel,MistralEmbed,QwenModel,LlamaModel,MistralHF,DialoGPT models
```

## Data Flow & State Management

```mermaid
graph TB
    %% Input Processing
    RawText[Raw Text Input] --> |1| SemanticSeg[Semantic Segmentation]
    
    %% Linear Pipeline Flow
    SemanticSeg --> |2| TokenClean[Token Cleaning]
    TokenClean --> |3| LinguisticTag[Linguistic Tagging]
    LinguisticTag --> |4| EmbedGen[Embedding Generation]
    
    %% Cache Integration
    subgraph "Redis Cache Layer"
        SessionState[Processing Session State]
        TokenCacheStore[Token Cache]
        EmbedCacheStore[Embedding Cache]
        SFLCacheStore[SFL Analysis Cache]
    end
    
    %% Persistent Storage
    subgraph "PostgreSQL Storage"
        DocTable[Documents Table]
        LinguisticTable[Linguistic Annotations<br/>JSONB]
        EmbedTable[Embeddings<br/>pgvector]
        SessionTable[Session Archive]
    end

    %% Stage-specific caching
    TokenClean -.-> |Cache| TokenCacheStore
    LinguisticTag -.-> |Cache| SFLCacheStore
    EmbedGen -.-> |Cache| EmbedCacheStore
    
    %% Session management
    SemanticSeg --> SessionState
    TokenClean --> SessionState
    LinguisticTag --> SessionState
    EmbedGen --> SessionState

    %% Archival process
    SessionState --> |Complete Session| SessionTable
    TokenCacheStore --> |Archive| LinguisticTable
    EmbedCacheStore --> |Archive| EmbedTable
    SFLCacheStore --> |Archive| LinguisticTable

    %% Direct persistence
    EmbedGen --> |Vectors| EmbedTable
    LinguisticTag --> |SFL Data| LinguisticTable
    SemanticSeg --> |Text + Metadata| DocTable

    %% Styling
    classDef pipeline fill:#e1f5fe
    classDef cache fill:#fce4ec
    classDef storage fill:#e8f5e8
    classDef flow fill:#fff3e0
    
    class SemanticSeg,TokenClean,LinguisticTag,EmbedGen pipeline
    class SessionState,TokenCacheStore,EmbedCacheStore,SFLCacheStore cache
    class DocTable,LinguisticTable,EmbedTable,SessionTable storage
    class RawText flow
```

## SFL Metafunction Integration

```mermaid
graph LR
    %% Input Classification
    TextInput[Text Input] --> SFLAnalysis[SFL Content Analysis]
    
    %% Metafunction Analysis
    subgraph "SFL Metafunctions"
        Ideational[Ideational<br/>Process Types<br/>Participant Roles]
        Interpersonal[Interpersonal<br/>Modality<br/>Speech Functions]
        Textual[Textual<br/>Theme/Rheme<br/>Cohesion]
    end
    
    SFLAnalysis --> Ideational
    SFLAnalysis --> Interpersonal  
    SFLAnalysis --> Textual

    %% Routing Influence
    subgraph "Routing Impact"
        ComplexityScore[Complexity Scoring]
        ProviderSelection[Provider Selection]
        ModelSelection[Model Selection]
    end

    %% Process Type Mapping
    subgraph "Process Types"
        Material[Material<br/>Doing/Happening]
        Mental[Mental<br/>Sensing/Thinking]
        Relational[Relational<br/>Being/Having]
        Verbal[Verbal<br/>Saying]
    end

    %% Influence paths
    Ideational --> Material
    Ideational --> Mental
    Ideational --> Relational
    Ideational --> Verbal
    
    Material --> ComplexityScore
    Mental --> ComplexityScore
    Relational --> ComplexityScore
    Verbal --> ComplexityScore
    
    ComplexityScore --> ProviderSelection
    Interpersonal --> ProviderSelection
    Textual --> ModelSelection

    %% Filter Application
    subgraph "SFL Filtering"
        ConsistencyCheck[Consistency Check<br/>Threshold: 0.85]
        QualityGate[Quality Gate]
        OutputFilter[Output Filtering]
    end

    ProviderSelection --> ConsistencyCheck
    ModelSelection --> ConsistencyCheck
    ConsistencyCheck --> QualityGate
    QualityGate --> OutputFilter

    %% Styling
    classDef sfl fill:#e8f5e8
    classDef process fill:#f3e5f5
    classDef routing fill:#e1f5fe
    classDef filter fill:#fff3e0
    
    class Ideational,Interpersonal,Textual sfl
    class Material,Mental,Relational,Verbal process
    class ComplexityScore,ProviderSelection,ModelSelection routing
    class ConsistencyCheck,QualityGate,OutputFilter filter
```

## Component Dependencies

```mermaid
graph TB
    %% Core Dependencies
    subgraph "Ruby Ecosystem"
        RubySpacy[ruby-spacy<br/>NLP Core]
        PragmaticSeg[pragmatic_segmenter<br/>Sentence Boundary]
        Informers[informers<br/>Reranking Models]
        RubyLLM[ruby-llm<br/>Provider Abstraction]
        DSPy[dspy.rb<br/>Workflow Signatures]
        Ohm[ohm<br/>Redis ORM]
        Sequel[sequel<br/>SQL ORM]
    end

    %% External Services
    subgraph "External Dependencies"
        PostgreSQL[PostgreSQL<br/>+ pgvector]
        Redis[Redis<br/>Cache Store]
        MistralAPI[Mistral API]
        OpenRouterAPI[OpenRouter API]
        HFAPI[Hugging Face API]
    end

    %% Infrastructure
    subgraph "Infrastructure"
        Docker[Docker<br/>Containerization]
        Systemd[systemd<br/>Service Management]
        Journald[journald<br/>Structured Logging]
    end

    %% Dependency relationships
    RubySpacy --> PragmaticSeg
    Informers --> RubyLLM
    DSPy --> RubyLLM
    Ohm --> Redis
    Sequel --> PostgreSQL

    RubyLLM --> MistralAPI
    RubyLLM --> OpenRouterAPI
    RubyLLM --> HFAPI

    Docker --> PostgreSQL
    Docker --> Redis
    Systemd --> Journald

    %% Styling
    classDef ruby fill:#cc0000,color:#ffffff
    classDef external fill:#1976d2,color:#ffffff
    classDef infra fill:#388e3c,color:#ffffff
    
    class RubySpacy,PragmaticSeg,Informers,RubyLLM,DSPy,Ohm,Sequel ruby
    class PostgreSQL,Redis,MistralAPI,OpenRouterAPI,HFAPI external
    class Docker,Systemd,Journald infra
```
