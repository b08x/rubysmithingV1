# Segmentation & Chunking Strategies

## Overview

Comprehensive mapping of text segmentation and chunking approaches for the NLP pipeline, with Ruby implementations and SFL integration patterns.

## Segmentation Strategy Matrix

```mermaid
graph TB
    %% Input Document
    Document[Input Document] --> StructureAnalysis[Document Structure Analysis]
    
    %% Structure Detection
    subgraph "Document Structure Detection"
        StructureAnalysis --> HeaderDetection[Header Detection]
        StructureAnalysis --> ParagraphBoundaries[Paragraph Boundaries]
        StructureAnalysis --> SentenceBoundaries[Sentence Boundaries]
        StructureAnalysis --> ListDetection[List Detection]
        StructureAnalysis --> CodeBlockDetection[Code Block Detection]
    end

    %% Segmentation Approaches
    subgraph "Segmentation Approaches"
        HeaderDetection --> HierarchicalSeg[Hierarchical Segmentation]
        ParagraphBoundaries --> SemanticSeg[Semantic Segmentation]
        SentenceBoundaries --> SyntacticSeg[Syntactic Segmentation]
        ListDetection --> StructuralSeg[Structural Segmentation]
        CodeBlockDetection --> ContentTypeSeg[Content-Type Segmentation]
    end

    %% Chunking Strategies
    subgraph "Chunking Strategies"
        HierarchicalSeg --> RecursiveChunk[Recursive Chunking]
        SemanticSeg --> CoherenceChunk[Coherence-Based Chunking]
        SyntacticSeg --> SentenceChunk[Sentence-Level Chunking]
        StructuralSeg --> BlockChunk[Block-Level Chunking]
        ContentTypeSeg --> TypeAwareChunk[Type-Aware Chunking]
    end

    %% Ruby Implementations
    subgraph "Ruby Implementation Layer"
        RecursiveChunk --> PragmaticTokenizer[pragmatic_tokenizer]
        CoherenceChunk --> RubySpacyEmbeds[ruby-spacy + embeddings]
        SentenceChunk --> PragmaticSegmenter[pragmatic_segmenter]
        BlockChunk --> CustomParser[Custom Block Parser]
        TypeAwareChunk --> MimeTypeDetection[MIME Type Detection]
    end

    %% SFL Integration
    subgraph "SFL Metafunction Integration"
        PragmaticTokenizer --> IdeationalMapping[Ideational Metafunction]
        RubySpacyEmbeds --> InterpersonalMapping[Interpersonal Metafunction]
        PragmaticSegmenter --> TextualMapping[Textual Metafunction]
        CustomParser --> GraphologicalMapping[Graphological Stratum]
        MimeTypeDetection --> RegisterMapping[Register Analysis]
    end

    %% Styling
    classDef detection fill:#e1f5fe
    classDef approach fill:#f3e5f5
    classDef strategy fill:#e8f5e8
    classDef ruby fill:#fff3e0
    classDef sfl fill:#fce4ec
    
    class HeaderDetection,ParagraphBoundaries,SentenceBoundaries,ListDetection,CodeBlockDetection detection
    class HierarchicalSeg,SemanticSeg,SyntacticSeg,StructuralSeg,ContentTypeSeg approach
    class RecursiveChunk,CoherenceChunk,SentenceChunk,BlockChunk,TypeAwareChunk strategy
    class PragmaticTokenizer,RubySpacyEmbeds,PragmaticSegmenter,CustomParser,MimeTypeDetection ruby
    class IdeationalMapping,InterpersonalMapping,TextualMapping,GraphologicalMapping,RegisterMapping sfl
```

## Chunking Strategy Comparison

| Strategy | Use Case | Chunk Size | Overlap | Ruby Gem | SFL Integration |
|----------|----------|------------|---------|----------|-----------------|
| **Recursive** | Generic documents | 200-1000 chars | 10-20% | `pragmatic_tokenizer` | Process boundaries |
| **Semantic** | Coherent content | Variable | Context-aware | `ruby-spacy` + embeddings | Topic coherence |
| **Syntactic** | Linguistic analysis | Sentence-based | Minimal | `pragmatic_segmenter` | Clause boundaries |
| **Hierarchical** | Structured docs | Section-based | None | Custom parser | Discourse structure |
| **Fixed-size** | Performance critical | Fixed tokens | Fixed overlap | Built-in | Character boundaries |
| **Sliding Window** | Context preservation | Fixed with step | High overlap | Custom | Contextual flow |

## Recursive Chunking Implementation

```mermaid
graph TD
    %% Input Processing
    TextInput[Text Input] --> SeparatorHierarchy[Separator Hierarchy]
    
    %% Separator Hierarchy
    subgraph "Separator Priority"
        SeparatorHierarchy --> DoubleNewline["\n\n (Paragraphs)"]
        DoubleNewline --> SingleNewline["\n (Lines)"]
        SingleNewline --> Periods[". (Sentences)"]
        Periods --> Questions["? (Questions)"]
        Questions --> Exclamations["! (Exclamations)"]
        Exclamations --> Spaces[" (Words)"]
        Spaces --> Characters["chars (Fallback)"]
    end

    %% Chunking Logic
    subgraph "Recursive Chunking Logic"
        ChunkSize[Target Chunk Size: 200-1000]
        OverlapSize[Overlap Size: 20-200 chars]
        QualityCheck[Quality Check]
        
        DoubleNewline --> ChunkAttempt1[Chunk Attempt]
        ChunkAttempt1 --> SizeCheck1{Size OK?}
        SizeCheck1 --> |Yes| QualityCheck
        SizeCheck1 --> |Too Large| SingleNewline
        
        SingleNewline --> ChunkAttempt2[Chunk Attempt]
        ChunkAttempt2 --> SizeCheck2{Size OK?}
        SizeCheck2 --> |Yes| QualityCheck
        SizeCheck2 --> |Too Large| Periods
        
        Periods --> ChunkAttempt3[Final Chunk]
        ChunkAttempt3 --> QualityCheck
    end

    %% SFL Integration
    subgraph "SFL Process Mapping"
        QualityCheck --> ProcessAnalysis[Process Type Analysis]
        ProcessAnalysis --> MaterialProcess[Material Process Detection]
        ProcessAnalysis --> MentalProcess[Mental Process Detection]
        ProcessAnalysis --> RelationalProcess[Relational Process Detection]
        
        MaterialProcess --> ActionBoundary[Action Boundaries]
        MentalProcess --> CognitiveBoundary[Cognitive Boundaries]
        RelationalProcess --> StateBoundary[State Boundaries]
    end

    %% Output
    ActionBoundary --> ChunkOutput[Chunk Output]
    CognitiveBoundary --> ChunkOutput
    StateBoundary --> ChunkOutput

    %% Styling
    classDef separator fill:#e1f5fe
    classDef logic fill:#e8f5e8
    classDef sfl fill:#fce4ec
    classDef output fill:#f1f8e9
    
    class DoubleNewline,SingleNewline,Periods,Questions,Exclamations,Spaces,Characters separator
    class ChunkSize,OverlapSize,ChunkAttempt1,ChunkAttempt2,ChunkAttempt3,SizeCheck1,SizeCheck2,QualityCheck logic
    class ProcessAnalysis,MaterialProcess,MentalProcess,RelationalProcess,ActionBoundary,CognitiveBoundary,StateBoundary sfl
    class ChunkOutput output
```

## Semantic Coherence Chunking

```mermaid
graph TB
    %% Input Processing
    DocumentText[Document Text] --> SentenceSegmentation[Sentence Segmentation]
    
    %% Sentence Analysis
    subgraph "Sentence-Level Analysis"
        SentenceSegmentation --> EmbeddingGeneration[Embedding Generation]
        EmbeddingGeneration --> CosineSimilarity[Cosine Similarity Matrix]
        CosineSimilarity --> TopicOverlap[Topic Overlap Analysis]
        TopicOverlap --> EntityShifts[Entity Shift Detection]
    end

    %% Coherence Scoring
    subgraph "Coherence Scoring Algorithm"
        CosineSimilarity --> SimilarityThreshold{Similarity > 0.5?}
        TopicOverlap --> OverlapThreshold{Overlap > 0.3?}
        EntityShifts --> EntityThreshold{Entity Change?}
        
        SimilarityThreshold --> |Yes| HighCoherence[High Coherence]
        SimilarityThreshold --> |No| LowCoherence[Low Coherence]
        OverlapThreshold --> |Yes| TopicContinuity[Topic Continuity]
        OverlapThreshold --> |No| TopicShift[Topic Shift]
        EntityThreshold --> |No| EntityContinuity[Entity Continuity]
        EntityThreshold --> |Yes| EntityBoundary[Entity Boundary]
    end

    %% Chunk Boundary Detection
    subgraph "Boundary Detection"
        HighCoherence --> ContinueChunk[Continue Current Chunk]
        TopicContinuity --> ContinueChunk
        EntityContinuity --> ContinueChunk
        
        LowCoherence --> CreateBoundary[Create Chunk Boundary]
        TopicShift --> CreateBoundary
        EntityBoundary --> CreateBoundary
    end

    %% SFL Metafunction Integration
    subgraph "SFL Metafunction Analysis"
        CreateBoundary --> IdeationalShift[Ideational Shift Analysis]
        CreateBoundary --> InterpersonalShift[Interpersonal Shift Analysis]
        CreateBoundary --> TextualShift[Textual Shift Analysis]
        
        IdeationalShift --> ProcessTypeChange[Process Type Change]
        InterpersonalShift --> ModalityChange[Modality Change]
        TextualShift --> ThemeChange[Theme/Rheme Change]
    end

    %% Chunk Formation
    subgraph "Chunk Formation"
        ProcessTypeChange --> SemanticChunk[Semantic Chunk]
        ModalityChange --> SemanticChunk
        ThemeChange --> SemanticChunk
        ContinueChunk --> SemanticChunk
        
        SemanticChunk --> ContextPreservation[Context Preservation]
        ContextPreservation --> OverlapGeneration[Overlap Generation]
    end

    %% Styling
    classDef analysis fill:#e1f5fe
    classDef scoring fill:#f3e5f5
    classDef boundary fill:#e8f5e8
    classDef sfl fill:#fce4ec
    classDef output fill:#f1f8e9
    
    class SentenceSegmentation,EmbeddingGeneration,CosineSimilarity,TopicOverlap,EntityShifts analysis
    class SimilarityThreshold,OverlapThreshold,EntityThreshold,HighCoherence,LowCoherence,TopicContinuity,TopicShift,EntityContinuity,EntityBoundary scoring
    class ContinueChunk,CreateBoundary boundary
    class IdeationalShift,InterpersonalShift,TextualShift,ProcessTypeChange,ModalityChange,ThemeChange sfl
    class SemanticChunk,ContextPreservation,OverlapGeneration output
```

## Ruby Implementation Patterns

### 1. Recursive Chunking with pragmatic_tokenizer

```ruby
# lib/rubysmithing/segmentation/recursive_chunker.rb
class RecursiveChunker
  SEPARATORS = [
    "\n\n",    # Paragraphs
    "\n",      # Lines  
    ". ",      # Sentences
    "? ",      # Questions
    "! ",      # Exclamations
    " ",       # Words
    ""         # Characters
  ].freeze
  
  def initialize(chunk_size: 500, overlap_size: 50)
    @chunk_size = chunk_size
    @overlap_size = overlap_size
  end
  
  def chunk(text)
    _chunk_recursive(text, SEPARATORS, 0)
  end
  
  private
  
  def _chunk_recursive(text, separators, separator_index)
    return [text] if text.length <= @chunk_size
    
    separator = separators[separator_index]
    return [text] if separator_index >= separators.length - 1
    
    splits = text.split(separator)
    current_chunk = ""
    chunks = []
    
    splits.each do |split|
      if (current_chunk + separator + split).length <= @chunk_size
        current_chunk += separator + split unless current_chunk.empty?
        current_chunk = split if current_chunk.empty?
      else
        chunks << current_chunk unless current_chunk.empty?
        current_chunk = split
      end
    end
    
    chunks << current_chunk unless current_chunk.empty?
    
    # Apply overlap for context preservation
    apply_overlap(chunks)
  end
  
  def apply_overlap(chunks)
    return chunks if chunks.length <= 1
    
    overlapped_chunks = [chunks.first]
    
    (1...chunks.length).each do |i|
      overlap_text = chunks[i-1][-@overlap_size..-1] || chunks[i-1]
      overlapped_chunks << "#{overlap_text}#{chunks[i]}"
    end
    
    overlapped_chunks
  end
end
```

### 2. Semantic Coherence Chunking with ruby-spacy

```ruby
# lib/rubysmithing/segmentation/semantic_segmenter.rb
class SemanticSegmenter
  def initialize(similarity_threshold: 0.5, overlap_threshold: 0.3)
    @similarity_threshold = similarity_threshold
    @overlap_threshold = overlap_threshold
    @nlp = Spacy::Language.new('en_core_web_sm')
  end
  
  def segment(text)
    sentences = extract_sentences(text)
    embeddings = generate_embeddings(sentences)
    boundaries = detect_boundaries(sentences, embeddings)
    create_chunks(sentences, boundaries)
  end
  
  private
  
  def extract_sentences(text)
    doc = @nlp.call(text)
    doc.sents.map(&:text)
  end
  
  def generate_embeddings(sentences)
    sentences.map do |sentence|
      doc = @nlp.call(sentence)
      doc.vector
    end
  end
  
  def detect_boundaries(sentences, embeddings)
    boundaries = [0]
    
    (1...sentences.length).each do |i|
      similarity = cosine_similarity(embeddings[i-1], embeddings[i])
      topic_overlap = calculate_topic_overlap(sentences[i-1], sentences[i])
      entity_shift = detect_entity_shift(sentences[i-1], sentences[i])
      
      if similarity < @similarity_threshold || 
         topic_overlap < @overlap_threshold || 
         entity_shift
        boundaries << i
      end
    end
    
    boundaries << sentences.length
    boundaries.uniq
  end
  
  def cosine_similarity(vec1, vec2)
    dot_product = vec1.zip(vec2).sum { |a, b| a * b }
    magnitude1 = Math.sqrt(vec1.sum { |a| a * a })
    magnitude2 = Math.sqrt(vec2.sum { |a| a * a })
    
    return 0.0 if magnitude1 == 0 || magnitude2 == 0
    
    dot_product / (magnitude1 * magnitude2)
  end
  
  def calculate_topic_overlap(sent1, sent2)
    doc1 = @nlp.call(sent1)
    doc2 = @nlp.call(sent2)
    
    nouns1 = doc1.select { |token| token.pos == 'NOUN' }.map(&:lemma)
    nouns2 = doc2.select { |token| token.pos == 'NOUN' }.map(&:lemma)
    
    intersection = (nouns1 & nouns2).size
    union = (nouns1 | nouns2).size
    
    return 0.0 if union == 0
    intersection.to_f / union
  end
  
  def detect_entity_shift(sent1, sent2)
    doc1 = @nlp.call(sent1)
    doc2 = @nlp.call(sent2)
    
    entities1 = doc1.ents.map(&:label).to_set
    entities2 = doc2.ents.map(&:label).to_set
    
    # Significant entity shift if less than 50% overlap
    intersection = (entities1 & entities2).size
    union = (entities1 | entities2).size
    
    return false if union == 0
    (intersection.to_f / union) < 0.5
  end
  
  def create_chunks(sentences, boundaries)
    chunks = []
    
    (0...boundaries.length-1).each do |i|
      start_idx = boundaries[i]
      end_idx = boundaries[i+1]
      chunk_text = sentences[start_idx...end_idx].join(' ')
      chunks << chunk_text
    end
    
    chunks
  end
end
```

### 3. SFL-Aware Chunking

```ruby
# lib/rubysmithing/segmentation/sfl_chunker.rb
class SFLChunker
  def initialize
    @nlp = Spacy::Language.new('en_core_web_sm')
    @process_types = ProcessTypeClassifier.new
  end
  
  def chunk_by_metafunction(text)
    sentences = extract_sentences(text)
    metafunction_analysis = analyze_metafunctions(sentences)
    create_metafunction_chunks(sentences, metafunction_analysis)
  end
  
  private
  
  def analyze_metafunctions(sentences)
    sentences.map do |sentence|
      doc = @nlp.call(sentence)
      
      {
        ideational: analyze_ideational(doc),
        interpersonal: analyze_interpersonal(doc),
        textual: analyze_textual(doc)
      }
    end
  end
  
  def analyze_ideational(doc)
    # Process type analysis
    verbs = doc.select { |token| token.pos == 'VERB' }
    process_type = @process_types.classify(verbs.first&.lemma)
    
    # Participant roles
    participants = extract_participants(doc)
    
    # Circumstantial elements
    circumstances = extract_circumstances(doc)
    
    {
      process_type: process_type,
      participants: participants,
      circumstances: circumstances
    }
  end
  
  def analyze_interpersonal(doc)
    # Modality analysis
    modality = detect_modality(doc)
    
    # Speech function
    speech_function = classify_speech_function(doc)
    
    {
      modality: modality,
      speech_function: speech_function
    }
  end
  
  def analyze_textual(doc)
    # Theme/Rheme structure
    theme_rheme = analyze_theme_rheme(doc)
    
    # Cohesive devices
    cohesion = detect_cohesive_devices(doc)
    
    {
      theme_rheme: theme_rheme,
      cohesion: cohesion
    }
  end
  
  def create_metafunction_chunks(sentences, analyses)
    chunks = []
    current_chunk = []
    current_metafunction = nil
    
    sentences.zip(analyses).each do |sentence, analysis|
      metafunction_signature = create_metafunction_signature(analysis)
      
      if current_metafunction.nil? || 
         metafunction_similar?(current_metafunction, metafunction_signature)
        current_chunk << sentence
        current_metafunction = metafunction_signature
      else
        chunks << {
          text: current_chunk.join(' '),
          metafunction: current_metafunction
        }
        current_chunk = [sentence]
        current_metafunction = metafunction_signature
      end
    end
    
    chunks << {
      text: current_chunk.join(' '),
      metafunction: current_metafunction
    } unless current_chunk.empty?
    
    chunks
  end
  
  def create_metafunction_signature(analysis)
    {
      process_type: analysis[:ideational][:process_type],
      modality: analysis[:interpersonal][:modality],
      theme_type: analysis[:textual][:theme_rheme][:theme_type]
    }
  end
  
  def metafunction_similar?(sig1, sig2)
    sig1[:process_type] == sig2[:process_type] &&
    sig1[:modality] == sig2[:modality]
    # Allow theme variation within same chunk for now
  end
end
```

## Performance Optimization Patterns

```mermaid
graph LR
    %% Performance Considerations
    subgraph "Performance Optimization"
        TextInput[Large Text Input] --> SizeCheck{Size > 10MB?}
        
        SizeCheck --> |No| StandardChunking[Standard Chunking]
        SizeCheck --> |Yes| StreamChunking[Streaming Chunking]
        
        StandardChunking --> MemoryChunking[In-Memory Processing]
        StreamChunking --> DiskChunking[Disk-Based Processing]
        
        MemoryChunking --> ParallelProcessing[Parallel Processing]
        DiskChunking --> BatchProcessing[Batch Processing]
    end

    %% Caching Strategy
    subgraph "Caching Strategy"
        ParallelProcessing --> EmbeddingCache[Embedding Cache]
        BatchProcessing --> EmbeddingCache
        
        EmbeddingCache --> RedisCache[Redis Cache]
        RedisCache --> CacheHit{Cache Hit?}
        
        CacheHit --> |Yes| FastReturn[Fast Return]
        CacheHit --> |No| ComputeAndCache[Compute & Cache]
    end

    %% Quality Gates
    subgraph "Quality Assurance"
        FastReturn --> QualityCheck[Quality Check]
        ComputeAndCache --> QualityCheck
        
        QualityCheck --> ChunkValidation[Chunk Validation]
        ChunkValidation --> SFLValidation[SFL Validation]
        SFLValidation --> OutputChunks[Output Chunks]
    end

    %% Styling
    classDef performance fill:#e1f5fe
    classDef cache fill:#f3e5f5
    classDef quality fill:#e8f5e8
    
    class SizeCheck,StandardChunking,StreamChunking,MemoryChunking,DiskChunking,ParallelProcessing,BatchProcessing performance
    class EmbeddingCache,RedisCache,CacheHit,FastReturn,ComputeAndCache cache
    class QualityCheck,ChunkValidation,SFLValidation,OutputChunks quality
```

## Implementation Priority & Integration

1. **Phase 1**: Basic recursive chunking with pragmatic_tokenizer
2. **Phase 2**: Semantic coherence with ruby-spacy embeddings  
3. **Phase 3**: SFL metafunction-aware chunking
4. **Phase 4**: Performance optimization and caching
5. **Phase 5**: Quality validation and monitoring