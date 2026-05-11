# Graph Report - .  (2026-05-11)

## Corpus Check
- 120 files · ~53,746 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 399 nodes · 549 edges · 61 communities (44 shown, 17 thin omitted)
- Extraction: 75% EXTRACTED · 24% INFERRED · 1% AMBIGUOUS · INFERRED: 133 edges (avg confidence: 0.8)
- Token cost: 35,000 input · 19,500 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Design Patterns & Conventions|Design Patterns & Conventions]]
- [[_COMMUNITY_Gem Verification API|Gem Verification API]]
- [[_COMMUNITY_Blueprint Discovery & Search|Blueprint Discovery & Search]]
- [[_COMMUNITY_TUI Component Styling|TUI Component Styling]]
- [[_COMMUNITY_Agent Definitions & Issues|Agent Definitions & Issues]]
- [[_COMMUNITY_Builder Agent Pipeline|Builder Agent Pipeline]]
- [[_COMMUNITY_Builder Integration Tests|Builder Integration Tests]]
- [[_COMMUNITY_Context Cache System|Context Cache System]]
- [[_COMMUNITY_Reference Documentation|Reference Documentation]]
- [[_COMMUNITY_Refactor & Scaffold Skills|Refactor & Scaffold Skills]]
- [[_COMMUNITY_TUI Architecture & Boot|TUI Architecture & Boot]]
- [[_COMMUNITY_Gem Verification & Docs|Gem Verification & Docs]]
- [[_COMMUNITY_Scratchpad Sweeper|Scratchpad Sweeper]]
- [[_COMMUNITY_Gem Error Types|Gem Error Types]]
- [[_COMMUNITY_Bundle Tester|Bundle Tester]]
- [[_COMMUNITY_Convention & Error Analysis|Convention & Error Analysis]]
- [[_COMMUNITY_TUI App Entry Point|TUI App Entry Point]]
- [[_COMMUNITY_TUI Design Patterns|TUI Design Patterns]]
- [[_COMMUNITY_Gem Curator Service|Gem Curator Service]]
- [[_COMMUNITY_Context7 MCP Service|Context7 MCP Service]]
- [[_COMMUNITY_RAG Ingester|RAG Ingester]]
- [[_COMMUNITY_TUI Main Screen|TUI Main Screen]]
- [[_COMMUNITY_Curator Integration Tests|Curator Integration Tests]]
- [[_COMMUNITY_Model Validation|Model Validation]]
- [[_COMMUNITY_Search Results Message|Search Results Message]]
- [[_COMMUNITY_Kaizen Analysis Methods|Kaizen Analysis Methods]]
- [[_COMMUNITY_RAG Clause|RAG Clause]]
- [[_COMMUNITY_Blueprint Schema|Blueprint Schema]]
- [[_COMMUNITY_Refactor Circuit Breaker & Async|Refactor: Circuit Breaker & Async]]
- [[_COMMUNITY_Refactor Hash Validation & Nesting|Refactor: Hash Validation & Nesting]]
- [[_COMMUNITY_Bundle Tester Concept|Bundle Tester Concept]]
- [[_COMMUNITY_Project Backlog|Project Backlog]]
- [[_COMMUNITY_Scratchpad Sweeper Concept|Scratchpad Sweeper Concept]]
- [[_COMMUNITY_Refactor Hardcoded Config|Refactor: Hardcoded Config]]

## God Nodes (most connected - your core abstractions)
1. `rubysmithing-builder` - 15 edges
2. `Vibe Step 4b: Data Foundation` - 14 edges
3. `GemVerifier` - 13 edges
4. `Flow Step 2: Feature Implementation` - 11 edges
5. `Schema Step 2: Data Infrastructure Design` - 11 edges
6. `ContextCache` - 10 edges
7. `Integrator` - 10 edges
8. `Zeitwerk Compliance` - 10 edges
9. `Schema Step 3: Implementation Verification` - 10 edges
10. `Translate Step 3: Ruby Implementation` - 10 edges

## Surprising Connections (you probably didn't know these)
- `Semantic Color Tokens` --semantically_similar_to--> `Update/View/Model TUI Pattern`  [INFERRED] [semantically similar]
  assets/skeleton/lib/app_name/styles.rb → agents/rubysmithing-builder.md
- `Convention Detection Cascade` --semantically_similar_to--> `SIFT Protocol`  [INFERRED] [semantically similar]
  skills/refactor/SKILL.md → agents/rubysmithing-auditor.md
- `Zeitwerk Compliance` --rationale_for--> `app.rb (Entry Point)`  [EXTRACTED]
  agents/rubysmithing-builder.md → assets/skeleton/app.rb
- `YARDoc Command` --conceptually_related_to--> `GemVerifier (RubyGems API Client)`  [INFERRED]
  skills/yardoc/commands/yardoc.md → spec/lib/rubysmithing/gem_verifier_spec.rb
- `Environment Validation Steps Migration Issue` --references--> `config/boot.rb`  [INFERRED]
  backlog.md → config/boot.rb

## Hyperedges (group relationships)
- **Sovereign Execution Loop** — agents_rubysmithing_sovereign, agents_rubysmithing_researcher, agents_rubysmithing_builder, agents_rubysmithing_tester, agents_rubysmithing_auditor [EXTRACTED 1.00]
- **TUI App Architecture** — skeleton_appname_app, skeleton_appname_styles, skeleton_components_base, skeleton_components_keyboard, skeleton_screens_main [INFERRED 0.90]
- **Research-Verify-Implement Quality Flow** — concept_gem_verification_gate, concept_degradation_protocol, concept_convention_hardening, concept_sift_protocol [INFERRED 0.80]
- **RAG Ingest-Store-Retrieve Pipeline** — rag_document_Document, rag_clause_Clause, rag_ingester_Ingester, rag_retriever_Retriever [INFERRED 0.90]
- **Agent Blueprint-First Tool Chain** — agents_builder_Builder, agents_builder_BlueprintSearchTool, discovery_blueprint_librarian_BlueprintLibrarian [INFERRED 0.95]
- **Knowledge Discovery Subsystem** — discovery_blueprint_librarian_BlueprintLibrarian, discovery_gem_curator_GemCurator, discovery_context7_service_Context7Service [INFERRED 0.80]
- **TUI Rendering Pipeline (Dashboard → Components → Styles)** — tui_dashboard, tui_components_base, tui_styles [EXTRACTED 0.95]
- **Neuro-Symbolic SFL Annotation Pipeline (Symbolic NLP + LLM Schema + Storage)** — skills_dataengineer_skill, references_genaipatterns, neuro_symbolic_annotation [INFERRED 0.80]
- **Convention Detection Flow (Plan Hub → Detection Cascade → Fallback Conventions)** — skills_plan_skill, skills_plan_references_conventiondetection, skills_plan_references_conventions [INFERRED 0.80]
- **Three-Step Audit Pipeline (SIFT → Rubric → Evaluation)** — tasks_audit_step1, tasks_audit_step2, tasks_audit_step3 [EXTRACTED 0.95]
- **SIFT-Refactor-Analyse Quality Loop** — skills_sift_skill, skills_refactor_skill, skills_test_skill [INFERRED 0.80]
- **Scaffold → Convention Pass → Sub-Skill Chain** — skills_scaffold_skill, skills_refactor_skill, skills_tui_skill [INFERRED 0.75]
- **Verify-Implement-Verify Workflow Pattern** — flow_step1_context, flow_step2_implement, flow_step3_verify, schema_step1_context, schema_step2_design, schema_step3_verify, translate_step1_deconstruct, translate_step2_context, translate_step3_implement [INFERRED 0.90]
- **Standard Mode Convention Bundle** — concept_standard_mode, concept_frozen_string_literal, concept_zeitwerk_compliance, concept_circuit_breaker [INFERRED 0.90]
- **SFL Data Infrastructure Stack** — concept_sfl_framework, concept_embedding_dimension_lock, concept_content_hash_idempotency, concept_hnsw_index, concept_gin_index, concept_transactional_outbox [INFERRED 0.85]
- **Discovery Agent Ecosystem Test Flow** — test_builder, test_curator, test_librarian, blueprint_librarian, gem_curator, builder_agent [INFERRED 0.85]
- **OpenRouter Model Validation Pipeline** — check_models, validate_model, rubyllm_models_by_provider, model_selection_strategy [INFERRED 0.80]
- **Database Bootstrap and Migration Sequence** — test_pre_flight, migrate_db, rubysmithing_database_migrate, test_librarian [INFERRED 0.70]

## Communities (61 total, 17 thin omitted)

### Community 0 - "Design Patterns & Conventions"
Cohesion: 0.08
Nodes (52): Three-Step Audit Pipeline, Circuit Breaker Pattern, Content Hash Idempotency (SHA256), Convention Detection Cascade, Convention Target Detection, Embedding Dimension Locking, Frozen String Literal Pragma, GIN JSONB Index Strategy (+44 more)

### Community 1 - "Gem Verification API"
Cohesion: 0.12
Nodes (3): GemVerifier, VersionConstraint, Integrator

### Community 2 - "Blueprint Discovery & Search"
Cohesion: 0.11
Nodes (13): BlueprintSearchTool, Builder, resolve(), BlueprintLibrarian, boot!(), config(), configure(), configure_llm!() (+5 more)

### Community 3 - "TUI Component Styling"
Cohesion: 0.11
Nodes (9): error(), header(), join_horizontal(), join_vertical(), metadata(), panel(), title(), Document (+1 more)

### Community 4 - "Agent Definitions & Issues"
Cohesion: 0.13
Nodes (23): rubysmithing-auditor, rubysmithing-builder, rubysmithing-researcher, rubysmithing-sovereign, rubysmithing-tester, Builder Agent Tool Registration Issue, Invalid Gemfile Failure Issue, /audit Command (+15 more)

### Community 5 - "Builder Agent Pipeline"
Cohesion: 0.17
Nodes (17): Blueprint Search Tool, Builder Agent, Blueprint-First Code Generation, Dual Embedding Strategy, Database Module, Blueprint Librarian, Blueprint Schema, Context7 Service (+9 more)

### Community 6 - "Builder Integration Tests"
Cohesion: 0.18
Nodes (9): BlueprintLibrarian, BlueprintLibrarian#archive, BlueprintLibrarian#search, Rubysmithing::Agents::Builder, Builder#ask, Context7 MCP Connectivity Test, Local Ollama Configuration Pattern, RubyLLM::MCP.client (+1 more)

### Community 8 - "Reference Documentation"
Cohesion: 0.23
Nodes (14): Neuro-Symbolic SFL Annotation (IdeationalSchema), Cache CLI Reference, Gem Registry — Context7 IDs × Architectural Roles, GenAI Patterns Reference, PostgreSQL Setup for Rubysmithing, Reciprocal Rank Fusion (RRF), ContextCache, verify_gem.rb CLI (+6 more)

### Community 9 - "Refactor & Scaffold Skills"
Cohesion: 0.21
Nodes (14): Refactor Command, Refactor Patterns Catalog, Refactor Skill, Scaffold Command, Scaffold Patterns Reference, Scaffold Skill, SIFT Report Command, SIFT Protocol V1.0 (+6 more)

### Community 10 - "TUI Architecture & Boot"
Cohesion: 0.19
Nodes (13): Environment Validation Steps Migration Issue, bin/console, bin/setup, Four-Layer Keyboard Architecture, Semantic Color Tokens, Update/View/Model TUI Pattern, config/boot.rb, app.rb (Entry Point) (+5 more)

### Community 11 - "Gem Verification & Docs"
Cohesion: 0.2
Nodes (11): GemVerifier (RubyGems API Client), Stale Cache Fallback Strategy, VerificationResult Status Object, VersionConstraint DSL, YARDoc Command, YARD Documentation Patterns, YARDoc Skill, Invalid Gemfile Fixture (+3 more)

### Community 13 - "Gem Error Types"
Cohesion: 0.2
Nodes (4): DegradedError, GemNotFound, GemVersionNotFound, RubyGemsAPIError

### Community 14 - "Bundle Tester"
Cohesion: 0.31
Nodes (5): BundleTester, BundleTestError, copy_gemfile_to_tmpdir(), run_bundle_install(), validate_gemfile!()

### Community 15 - "Convention & Error Analysis"
Cohesion: 0.28
Nodes (9): Convention Detection Cascade, Agent Error Contract (ErrorContext Schema), Analyse Command, Analyse Methods Reference, Analyse Skill, Convention Detection Reference, Ruby Conventions Reference, Error Contract Reference (+1 more)

### Community 17 - "TUI Design Patterns"
Cohesion: 0.46
Nodes (8): Elm Architecture (Model/Update/View), TUI Design Patterns Reference, TUI Patterns (Context7-Verified), Semantic Color System (3-Layer Token Hierarchy), TUI::Components::Base, TUI::Dashboard, TUI::SearchResultsMessage, TUI::Styles

### Community 22 - "Curator Integration Tests"
Cohesion: 0.6
Nodes (3): GemCurator, GemCurator#find_gems, GemCurator#generate_cheatsheet

### Community 26 - "Kaizen Analysis Methods"
Cohesion: 1.0
Nodes (3): Gemba Walk Analysis Method, Muda (Waste) Analysis, Root Cause Analysis

## Ambiguous Edges - Review These
- `Context7 Service` → `Gem Curator`  [AMBIGUOUS]
  lib/rubysmithing/discovery/gem_curator.rb · relation: shares_data_with
- `GemVerifier (RubyGems API Client)` → `Stale Cache Fallback Strategy`  [AMBIGUOUS]
  spec/lib/rubysmithing/verification/integrator_spec.rb · relation: conceptually_related_to
- `Context7 MCP Connectivity Test` → `Local Ollama Configuration Pattern`  [AMBIGUOUS]
  tests/test-builder.rb · relation: conceptually_related_to
- `Free/Cheap Model Selection with Tool Support` → `Local Ollama Configuration Pattern`  [AMBIGUOUS]
  tests/validate-model.rb · relation: conceptually_related_to

## Knowledge Gaps
- **54 isolated node(s):** `Clause`, `BlueprintSchema`, `Builder`, `Rubysmithing Backlog`, `Builder Agent Tool Registration Issue` (+49 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **17 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What is the exact relationship between `Context7 Service` and `Gem Curator`?**
  _Edge tagged AMBIGUOUS (relation: shares_data_with) - confidence is low._
- **What is the exact relationship between `GemVerifier (RubyGems API Client)` and `Stale Cache Fallback Strategy`?**
  _Edge tagged AMBIGUOUS (relation: conceptually_related_to) - confidence is low._
- **What is the exact relationship between `Context7 MCP Connectivity Test` and `Local Ollama Configuration Pattern`?**
  _Edge tagged AMBIGUOUS (relation: conceptually_related_to) - confidence is low._
- **What is the exact relationship between `Free/Cheap Model Selection with Tool Support` and `Local Ollama Configuration Pattern`?**
  _Edge tagged AMBIGUOUS (relation: conceptually_related_to) - confidence is low._
- **Why does `format_result()` connect `Context Cache System` to `TUI Component Styling`?**
  _High betweenness centrality (0.032) - this node is a cross-community bridge._
- **Why does `connect()` connect `Blueprint Discovery & Search` to `Scratchpad Sweeper`, `Builder Integration Tests`?**
  _High betweenness centrality (0.032) - this node is a cross-community bridge._
- **Why does `migrate()` connect `Builder Integration Tests` to `Blueprint Discovery & Search`?**
  _High betweenness centrality (0.030) - this node is a cross-community bridge._