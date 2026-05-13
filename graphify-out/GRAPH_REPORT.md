# Graph Report - .  (2026-05-13)

## Corpus Check
- 140 files · ~78,804 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 550 nodes · 733 edges · 68 communities (40 shown, 28 thin omitted)
- Extraction: 80% EXTRACTED · 20% INFERRED · 0% AMBIGUOUS · INFERRED: 143 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Core Runtime & Config|Core Runtime & Config]]
- [[_COMMUNITY_Agent Methodology|Agent Methodology]]
- [[_COMMUNITY_Gem Verification|Gem Verification]]
- [[_COMMUNITY_TUI & RAG Components|TUI & RAG Components]]
- [[_COMMUNITY_NLP Pipeline & LLM Routing|NLP Pipeline & LLM Routing]]
- [[_COMMUNITY_Dependencies & Environment|Dependencies & Environment]]
- [[_COMMUNITY_Agent & Model Routing|Agent & Model Routing]]
- [[_COMMUNITY_Chunking & SFL Algorithms|Chunking & SFL Algorithms]]
- [[_COMMUNITY_CLI Commands & Skeleton|CLI Commands & Skeleton]]
- [[_COMMUNITY_Scripts Cache & Verify|Scripts: Cache & Verify]]
- [[_COMMUNITY_Builder & Discovery|Builder & Discovery]]
- [[_COMMUNITY_Scratchpad Maintenance|Scratchpad Maintenance]]
- [[_COMMUNITY_Bundle Testing|Bundle Testing]]
- [[_COMMUNITY_Blueprint Search|Blueprint Search]]
- [[_COMMUNITY_SFL Analysis Workflow|SFL Analysis Workflow]]
- [[_COMMUNITY_Test Execution Workflow|Test Execution Workflow]]
- [[_COMMUNITY_Cache Strategy|Cache Strategy]]
- [[_COMMUNITY_App Entry Point|App Entry Point]]
- [[_COMMUNITY_Gherkin Generation|Gherkin Generation]]
- [[_COMMUNITY_Complexity Analysis|Complexity Analysis]]
- [[_COMMUNITY_TUI Design Patterns|TUI Design Patterns]]
- [[_COMMUNITY_References & Verification|References & Verification]]
- [[_COMMUNITY_Context7 Integration|Context7 Integration]]
- [[_COMMUNITY_User Story Generation|User Story Generation]]
- [[_COMMUNITY_SFL BDD Orchestrator|SFL BDD Orchestrator]]
- [[_COMMUNITY_Refactor & Audit Skills|Refactor & Audit Skills]]
- [[_COMMUNITY_RAG Ingester|RAG Ingester]]
- [[_COMMUNITY_Main Screen|Main Screen]]
- [[_COMMUNITY_Linguistic Processing|Linguistic Processing]]
- [[_COMMUNITY_Workflow Schema|Workflow Schema]]
- [[_COMMUNITY_Natural Language Input|Natural Language Input]]
- [[_COMMUNITY_Discovery Services|Discovery Services]]
- [[_COMMUNITY_Search Results|Search Results]]
- [[_COMMUNITY_Convention Detection|Convention Detection]]
- [[_COMMUNITY_RAG Clause|RAG Clause]]
- [[_COMMUNITY_Blueprint Schema|Blueprint Schema]]
- [[_COMMUNITY_Analyse Skill|Analyse Skill]]
- [[_COMMUNITY_Error Handling|Error Handling]]
- [[_COMMUNITY_Circuit Breaker|Circuit Breaker]]
- [[_COMMUNITY_Ad Hoc Patterns|Ad Hoc Patterns]]
- [[_COMMUNITY_Bundle Tester Class|Bundle Tester Class]]
- [[_COMMUNITY_Sweep Scratchpads|Sweep Scratchpads]]
- [[_COMMUNITY_Context Command|Context Command]]
- [[_COMMUNITY_Hardcoded Config Pattern|Hardcoded Config Pattern]]
- [[_COMMUNITY_Zeitwerk Mismatch Pattern|Zeitwerk Mismatch Pattern]]
- [[_COMMUNITY_Scaffold Skill|Scaffold Skill]]
- [[_COMMUNITY_Scaffold Patterns|Scaffold Patterns]]
- [[_COMMUNITY_SIFT Templates|SIFT Templates]]
- [[_COMMUNITY_Yardoc Skill|Yardoc Skill]]
- [[_COMMUNITY_Yardoc Patterns|Yardoc Patterns]]
- [[_COMMUNITY_Qwen Model|Qwen Model]]
- [[_COMMUNITY_Llama Model|Llama Model]]
- [[_COMMUNITY_Routing State Machine|Routing State Machine]]

## God Nodes (most connected - your core abstractions)
1. `Vibe Step 4b: Data Foundation` - 14 edges
2. `GemVerifier` - 13 edges
3. `Multi-Provider LLM Routing` - 13 edges
4. `config()` - 12 edges
5. `rubysmithing-builder` - 12 edges
6. `Schema Step 2: Data Infrastructure Design` - 11 edges
7. `Semantic Coherence Chunking` - 11 edges
8. `ContextCache` - 10 edges
9. `Integrator` - 10 edges
10. `Flow Step 2: Feature Implementation` - 10 edges

## Surprising Connections (you probably didn't know these)
- `Semantic Color Tokens` --semantically_similar_to--> `Update/View/Model TUI Pattern`  [INFERRED] [semantically similar]
  assets/skeleton/lib/app_name/styles.rb → agents/rubysmithing-builder.md
- `Zeitwerk Compliance` --rationale_for--> `app.rb (Entry Point)`  [EXTRACTED]
  agents/rubysmithing-builder.md → assets/skeleton/app.rb
- `lib/rubysmithing` --implements--> `rubysmithingV1`  [INFERRED]
  config/boot.rb → README.md
- `Update/View/Model TUI Pattern` --conceptually_related_to--> `Four-Layer Keyboard Architecture`  [INFERRED]
  agents/rubysmithing-builder.md → assets/skeleton/lib/app_name/components/keyboard.rb
- `Gem Registry — Context7 IDs × Architectural Roles` --references--> `ContextCache`  [INFERRED]
  references/gem-registry.md → scripts/context_cache.rb

## Hyperedges (group relationships)
- **TUI App Architecture** — skeleton_appname_app, skeleton_appname_styles, skeleton_components_base, skeleton_components_keyboard, skeleton_screens_main [INFERRED 0.90]
- **RAG Ingest-Store-Retrieve Pipeline** — rag_document_Document, rag_clause_Clause, rag_ingester_Ingester, rag_retriever_Retriever [INFERRED 0.90]
- **TUI Rendering Pipeline (Dashboard → Components → Styles)** — tui_dashboard, tui_components_base, tui_styles [EXTRACTED 0.95]
- **Knowledge Discovery Subsystem** — discovery_blueprint_librarian_BlueprintLibrarian, discovery_gem_curator_GemCurator, discovery_context7_service_Context7Service [INFERRED 0.80]
- **Agent Blueprint-First Tool Chain** — agents_builder_Builder, agents_builder_BlueprintSearchTool, discovery_blueprint_librarian_BlueprintLibrarian [INFERRED 0.95]
- **Sovereign Execution Loop** — agents_rubysmithing_sovereign, agents_rubysmithing_researcher, agents_rubysmithing_builder, agents_rubysmithing_tester, agents_rubysmithing_auditor [EXTRACTED 1.00]
- **Three-Step Audit Pipeline (SIFT → Rubric → Evaluation)** — tasks_audit_step1, tasks_audit_step2, tasks_audit_step3 [EXTRACTED 0.95]
- **Verify-Implement-Verify Workflow Pattern** — flow_step1_context, flow_step2_implement, flow_step3_verify, schema_step1_context, schema_step2_design, schema_step3_verify, translate_step1_deconstruct, translate_step2_context, translate_step3_implement [INFERRED 0.90]
- **Standard Mode Convention Bundle** — concept_standard_mode, concept_frozen_string_literal, concept_zeitwerk_compliance, concept_circuit_breaker [INFERRED 0.90]
- **SFL Data Infrastructure Stack** — concept_sfl_framework, concept_embedding_dimension_lock, concept_content_hash_idempotency, concept_hnsw_index, concept_gin_index, concept_transactional_outbox [INFERRED 0.85]
- **LLM Integration Stack** — ruby_llm, ruby_llm_mcp, ruby_llm_schema [EXTRACTED 1.00]
- **Database Stack** — pg_gem, pgvector, sequel, sqlite3 [EXTRACTED 1.00]
- **CLI Development Tools** — tty_config, lipgloss, bubbletea, rake [EXTRACTED 1.00]
- **Application Boot Initialization** — config_boot_rb, dotenv, lib_rubysmithing, dotenv_overload [EXTRACTED 1.00]
- **7-Stage Pipeline Execution Flow** — semantic_segmentation, token_cleaning, linguistic_analysis, embedding_generation, redis_cache_layer, persistent_storage [EXTRACTED 1.00]
- **Complete SFL Metafunction Analysis** — ideational_metafunction, interpersonal_metafunction, textual_metafunction, process_types [EXTRACTED 1.00]
- **LLM Provider Ecosystem** — mistral_provider, openrouter_provider, huggingface_provider, dspy_predict, dspy_chain_of_thought, dspy_react [EXTRACTED 1.00]
- **Ruby NLP Ecosystem Stack** — ruby_spacy, pragmatic_segmenter, informers_gem, ruby_llm, dspy_rb, ohm_redis, sequel_orm [EXTRACTED 1.00]
- **Chunking Algorithms Collection** — recursive_chunker, semantic_coherence_chunking, exponential_decay_chunker, hierarchical_agglomerative_chunker, sfl_guided_chunker [EXTRACTED 1.00]
- **Mathematical Foundations for Chunking** — cosine_similarity, jaccard_index, exponential_decay_weight, sfl_compatibility_score [EXTRACTED 1.00]
- **Data Flow Through Cache to Storage** — processing_session, token_cache, embedding_cache, sfl_cache, document_model, linguistic_annotation, document_embedding [EXTRACTED 1.00]
- **Architecture Visualizations Collection** — visual_index, visual_nlp_pipeline, visual_llm_routing, visual_data_flow, visual_segmentation, visual_chunking_algorithms [EXTRACTED 1.00]
- **Routing Decision Components** — complexity_analyzer, sfl_analyzer, routing_decision_engine, sfl_consistency_check, quality_gate [EXTRACTED 1.00]

## Communities (68 total, 28 thin omitted)

### Community 0 - "Core Runtime & Config"
Cohesion: 0.06
Nodes (28): resolve(), GemCurator, config(), configure(), db(), loader(), boot!(), configure_llm_providers!() (+20 more)

### Community 1 - "Agent Methodology"
Cohesion: 0.09
Nodes (46): Three-Step Audit Pipeline, Circuit Breaker Pattern, Content Hash Idempotency (SHA256), Convention Target Detection, Embedding Dimension Locking, Frozen String Literal Pragma, Gemba Walk Analysis Method, GIN JSONB Index Strategy (+38 more)

### Community 2 - "Gem Verification"
Cohesion: 0.08
Nodes (7): DegradedError, GemNotFound, GemVerifier, GemVersionNotFound, RubyGemsAPIError, VersionConstraint, Integrator

### Community 3 - "TUI & RAG Components"
Cohesion: 0.07
Nodes (11): error(), header(), join_horizontal(), join_vertical(), metadata(), panel(), title(), Document (+3 more)

### Community 4 - "NLP Pipeline & LLM Routing"
Cohesion: 0.07
Nodes (32): 768-dimensional Vectors, Complexity Analyzer, DSPy ChainOfThought, DSPy Predict, dspy.rb, DSPy ReAct, Stage 4: Embedding Pipeline, Hugging Face Inference (+24 more)

### Community 5 - "Dependencies & Environment"
Cohesion: 0.07
Nodes (30): Bubbletea Gem, config/boot.rb, CONTEXT7_API_KEY, Context7 MCP, DATABASE_URL, dotenv Gem, Dotenv.overload, dry-struct Gem (+22 more)

### Community 6 - "Agent & Model Routing"
Cohesion: 0.15
Nodes (12): ExampleSovereignAgent, agent_logger(), log_agent_operation(), log_coordination(), log_error(), log_hub_event(), log_performance(), log_spoke_event() (+4 more)

### Community 7 - "Chunking & SFL Algorithms"
Cohesion: 0.11
Nodes (28): Chunk Size 200-1000 characters, Cosine Similarity, Exponential Decay Chunking Algorithm, Exponential Decay Weight Formula, Hierarchical Agglomerative Chunking, Ideational Metafunction, Interpersonal Metafunction, Jaccard Index (+20 more)

### Community 8 - "CLI Commands & Skeleton"
Cohesion: 0.1
Nodes (25): rubysmithing-auditor, rubysmithing-builder, rubysmithing-tester, bin/console, bin/setup, /audit Command, /diagnose Command, /document Command (+17 more)

### Community 10 - "Builder & Discovery"
Cohesion: 0.22
Nodes (11): Blueprint Search Tool, Builder Agent, Blueprint-First Code Generation, Database Module, Blueprint Librarian, Blueprint Schema, RAG Clause Model, RAG Document Model (+3 more)

### Community 12 - "Bundle Testing"
Cohesion: 0.31
Nodes (5): BundleTester, BundleTestError, copy_gemfile_to_tmpdir(), run_bundle_install(), validate_gemfile!()

### Community 13 - "Blueprint Search"
Cohesion: 0.28
Nodes (3): BlueprintSearchTool, Builder, BlueprintLibrarian

### Community 14 - "SFL Analysis Workflow"
Cohesion: 0.22
Nodes (8): IdeationalFunction, InterpersonalFunction, ModalityType, ProcessType, SflAnalysis, SflAnalysisResult, TextualFunction, ThemePattern

### Community 15 - "Test Execution Workflow"
Cohesion: 0.22
Nodes (8): ExecutionEnvironment, ExecutionMetrics, FeatureResult, QualityAssessment, ScenarioResult, StepResult, TestExecution, TestStatus

### Community 16 - "Cache Strategy"
Cohesion: 0.28
Nodes (9): Cache Hit Rate >80%, Cache Strategy & Performance Flow, Document Embedding, Document Model, Embedding Cache, Processing Session, SFL Cache, Token Cache (+1 more)

### Community 18 - "Gherkin Generation"
Cohesion: 0.25
Nodes (7): GenerationMetadata, GherkinFeature, GherkinGeneration, GherkinScenario, GherkinStep, ScenarioType, StepType

### Community 20 - "TUI Design Patterns"
Cohesion: 0.46
Nodes (8): Elm Architecture (Model/Update/View), TUI Design Patterns Reference, TUI Patterns (Context7-Verified), Semantic Color System (3-Layer Token Hierarchy), TUI::Components::Base, TUI::Dashboard, TUI::SearchResultsMessage, TUI::Styles

### Community 21 - "References & Verification"
Cohesion: 0.25
Nodes (8): Cache CLI Reference, Gem Registry — Context7 IDs × Architectural Roles, GenAI Patterns Reference, PostgreSQL Setup for Rubysmithing, ContextCache, verify_gem.rb CLI, Verification::Integrator, VerificationResult

### Community 23 - "User Story Generation"
Cohesion: 0.29
Nodes (6): AcceptanceCriterion, StoryComplexity, StoryGenerationMetadata, StoryPriority, UserStory, UserStoryGeneration

### Community 24 - "SFL BDD Orchestrator"
Cohesion: 0.29
Nodes (6): ComprehensiveResult, PipelineConfiguration, PipelineStage, PipelineStatus, SflBddOrchestrator, StageResult

### Community 25 - "Refactor & Audit Skills"
Cohesion: 0.38
Nodes (7): Refactor Command, Refactor Patterns Catalog, SIFT Report Command, SIFT Protocol V1.0, Audit Step 1: SIFT Assessment, Audit Step 2: Evaluation Rubric, Audit Step 3: Rubric Evaluation

### Community 28 - "Linguistic Processing"
Cohesion: 0.4
Nodes (5): Linguistic Annotation, LinguisticTagger Class, SemanticSegmenter Class, TokenCleaner Class, VectorGenerator Class

### Community 30 - "Natural Language Input"
Cohesion: 0.5
Nodes (3): InputSource, NaturalLanguageInput, ProcessingMetadata

### Community 31 - "Discovery Services"
Cohesion: 0.67
Nodes (4): Context7 Service, Gem Curator, Gem Verifier, Version Constraint

### Community 34 - "Convention Detection"
Cohesion: 0.67
Nodes (3): Convention Detection Cascade, Convention Detection Reference, Ruby Conventions Reference

## Ambiguous Edges - Review These
- `Gem Curator` → `Context7 Service`  [AMBIGUOUS]
  lib/rubysmithing/discovery/gem_curator.rb · relation: shares_data_with

## Knowledge Gaps
- **127 isolated node(s):** `DependencyError`, `LlmProviders`, `Clause`, `BlueprintSchema`, `Builder` (+122 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **28 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What is the exact relationship between `Gem Curator` and `Context7 Service`?**
  _Edge tagged AMBIGUOUS (relation: shares_data_with) - confidence is low._
- **Why does `format_result()` connect `Scripts: Cache & Verify` to `TUI & RAG Components`?**
  _High betweenness centrality (0.022) - this node is a cross-community bridge._
- **Why does `error()` connect `TUI & RAG Components` to `Scripts: Cache & Verify`?**
  _High betweenness centrality (0.018) - this node is a cross-community bridge._
- **Why does `Multi-Provider LLM Routing` connect `NLP Pipeline & LLM Routing` to `Chunking & SFL Algorithms`?**
  _High betweenness centrality (0.018) - this node is a cross-community bridge._
- **Are the 7 inferred relationships involving `Vibe Step 4b: Data Foundation` (e.g. with `Transactional Outbox Pattern` and `Circuit Breaker Pattern`) actually correct?**
  _`Vibe Step 4b: Data Foundation` has 7 INFERRED edges - model-reasoned connections that need verification._
- **Are the 11 inferred relationships involving `config()` (e.g. with `build()` and `connect()`) actually correct?**
  _`config()` has 11 INFERRED edges - model-reasoned connections that need verification._
- **What connects `DependencyError`, `LlmProviders`, `Clause` to the rest of the system?**
  _127 weakly-connected nodes found - possible documentation gaps or missing edges._