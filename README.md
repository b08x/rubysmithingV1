# rubysmithingV1

> **AI-Powered Ruby Development Orchestration System**

A comprehensive multi-agent framework for convention-aware Ruby code generation, verification, and maintenance. Built on the **Sovereign Agent** architecture with **Blueprint-First** code generation and **Zero-Hallucination** API verification.

---

## 📊 Project Overview

**rubysmithingV1** is a next-generation Ruby development assistant that combines:

- **Sovereign Agent Architecture** - 4-layer execution model (Survey → Resolve → Dispatch → Audit)
- **Multi-Agent Orchestration** - Hub-and-spoke pattern with specialized agents
- **Blueprint-First Development** - Reusable architectural patterns with semantic search
- **Retrieval-Augmented Generation (RAG)** - Embedding-based documentation and code retrieval
- **Zero-Hallucination API Verification** - Multi-layer fallback for gem API accuracy

The system uses **graphify** for knowledge graph analysis to understand codebase structure, track dependencies, and enable intelligent decision-making across all workflows.

---

## 🎯 Core Value Propositions

### 1. **Architectural Consistency**
Every artifact follows Ruby conventions: `# frozen_string_literal: true`, Zeitwerk-compliant naming, RuboCop standards. No hallucinated patterns.

### 2. **API Certainty**
Before any gem API call is generated, the system verifies its existence through:
- RubyGems.org API → Context7 MCP → ContextCache → Suggestions
- Zero-hallucination guarantee for external dependencies

### 3. **Blueprint-First Code Generation**
Builders MUST query the Librarian for known-good patterns before generating new architectural components. Ensures consistency and reuses proven solutions.

### 4. **Quality Gates**
SIFT Protocol audits with Do-and-Judge loops. If the Auditor fails an artifact, it's remediated until it passes.

### 5. **Graph-Based Intelligence**
Knowledge graph tracks all relationships: code → gems → patterns → conventions. Enables cross-file reasoning and impact analysis.

---

## 🏗️ Architecture Diagrams

The following interactive architecture diagrams are available in [`docs/architecture/`](docs/architecture/):

| Diagram | Purpose | Key Components |
|---------|---------|---------------|
| [Sovereign Agent Flow](docs/architecture/sovereign-agent-flow.html) | 4-layer execution model | Survey, Resolve, Dispatch, Audit |
| [Agent Orchestration](docs/architecture/agent-orchestration.html) | Hub-and-spoke pattern | Sovereign, Researcher, Builder, Auditor, Tester |
| [Workflow Commands](docs/architecture/workflow-commands-flow.html) | Command execution patterns | /flow, /schema, /translate, /vibe, /audit, /diagnose |
| [Blueprint Discovery](docs/architecture/blueprint-discovery-flow.html) | Pattern retrieval system | Builder, BlueprintSearchTool, Librarian, Database |
| [RAG Pipeline](docs/architecture/rag-pipeline-flow.html) | Document ingestion & retrieval | Ingester, Segmenter, Embedding, Clause, Retriever |
| [Gem Verification](docs/architecture/gem-verification-flow.html) | Zero-hallucination API checking | Integrator, GemVerifier, ContextCache, Fallback |

### Quick View

```
┌─────────────────────────────────────────────────────────────┐
│                      SOVEREIGN AGENT                           │
│              Layers 1-4 Execution Model                       │
├──────────────┬──────────────┬──────────────┬──────────────┤
│  Layer 1:    │  Layer 2:    │  Layer 3:    │  Layer 4:    │
│  Survey      │  Resolve     │  Dispatch    │  Audit       │
│  (Detect)    │  (Verify)    │  (Delegate)  │  (Quality)   │
└──────────────┴──────────────┴──────────────┴──────────────┘
                              │
                    ┌─────────┼─────────┐
                    ▼         ▼         ▼
              ┌─────────┐ ┌─────────┐ ┌─────────┐
              │Researcher│ │ Builder │ │ Auditor │
              │ (API)    │ │(Generate)│ │ (SIFT)  │
              └─────────┘ └─────────┘ └─────────┘
                    ▲         ▲         ▲
                    │         │         │
                    └─────────┴─────────┘
                          Tested
```

---

## 🚀 Getting Started

### Prerequisites

- Ruby 3.2+
- PostgreSQL with pgvector extension
- Node.js (for dependencies)
- Git

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd rubysmithingV1

# Install Ruby dependencies
bundle install

# Setup database
bundle exec rake db:create db:migrate

# Copy configuration
cp .env.example .env
# Edit .env with your API keys and settings

# Install Node dependencies (for PragmaticSegmenter)
npm install
```

### Configuration

Create `~/.config/rubysmithing/rubysmithing.yml`:

```yaml
:database_url: postgres:///rubysmithing_rag
:gem_db_dir: ~/.config/rubysmithing/db
:log_level: INFO
:ollama_api_base: http://localhost:11434/v1
:blueprint_embedding_provider: :ollama
:blueprint_embedding_model: embeddinggemma:latest
:rag_embedding_provider: :openrouter
:rag_embedding_model: mistralai/mistral-embed
:builder_model: google/gemini-2.0-flash-lite-001
```

Or use environment variables (prefixed with `RUBYSMITHING_`):

```bash
export RUBYSMITHING_DATABASE_URL=postgres:///rubysmithing_rag
export RUBYSMITHING_GEM_DB_DIR=~/.config/rubysmithing/db
export RUBYSMITHING_LOG_LEVEL=INFO
```

---

## 🎭 Agent Architecture

### Sovereign Agent (Orchestrator)

The **Sovereign** is the central authority that governs all operations through a **4-layer execution model**:

#### Layer 1: Survey - Context-Aware Detection
Ground truth establishment before any action:
- **Convention Detection**: Scans for `.rubocop.yml`, `standard` in Gemfile, or `.rubysmith`
- **Dependency Mapping**: Identifies non-stdlib gems
- **Architecture Mapping**: Detects Zeitwerk vs. classic loading, RSpec vs. Minitest

#### Layer 2: Resolve - Epistemic Verification
Zero-hallucination API verification:
- Uses `Integrator.verify(gem_name)` via Context7 MCP
- Goal: Zero-hallucination API calls
- If resolution fails, annotates output with `[WARNING: Unverified API Syntax]`
- Fallback chain: RubyGems.org API → Context7 MCP → ContextCache → Suggestions

#### Layer 3: Dispatch - Strategic Delegation
Intelligent task distribution:
- **Parallel Dispatch**: For independent sub-tasks
- **Sequential Dispatch**: For dependent chains
- **Executor Agents**: researcher, builder, auditor

#### Layer 4: Audit - Quality Gates
Consolidated quality assurance:
- **SIFT Protocol**: 8-section assessment
- **Do-and-Judge Loop**: Sovereign sets rubric → Auditor evaluates → Builder remediates
- **Mandatory Gates**: Scaffolding verification, Database connection tests
- **Final Checks**: Coverage → Consistency → Integrity

### Specialized Agents

| Agent | Role | Responsibility | Color |
|-------|------|----------------|-------|
| `rubysmithing-sovereign` | Orchestrator | 4-layer execution, final decisions | Purple |
| `rubysmithing-researcher` | Epistemic | Gem API verification, codebase surveys | Orange |
| `rubysmithing-builder` | Executor | Code generation, blueprint adaptation | Blue |
| `rubysmithing-auditor` | Judge | SIFT audits, quality assessment | Red |
| `rubysmithing-tester` | Validator | Integration tests, convention tests | Green |

---

## ⚙️ Workflow Commands

### Command Structure

All commands follow a **3-step pattern** (except /vibe which has 5 steps):

```
User Request → [Step 1: Context] → [Step 2: Action] → [Step 3: Verification] → Output
```

### Available Commands

#### `/flow` - Feature Implementation
Implement a feature end-to-end with gem verification and quality gate.

**Steps:**
1. **Gem Context Verification** - `researcher` verifies gem APIs via Context7
2. **Feature Implementation** - `builder` generates code with blueprint-first approach
3. **Implementation Verification** - `auditor` runs SIFT protocol quality assessment

**Example:**
```bash
/flow "Implement user authentication with JWT"
```

#### `/schema` - Data Infrastructure
Design and implement AI data infrastructure: PostgreSQL/pgvector, chunking pipelines, embedding strategies.

**Steps:**
1. **Gem Context Verification** - `researcher` verifies gem APIs for data infrastructure
2. **Schema Design & Implementation** - `builder` designs migrations, models, pipeline files
3. **Verification** - `auditor` validates design and implementation

**Example:**
```bash
/schema "PostgreSQL schema with pgvector for RAG system"
```

#### `/translate` - Foreign Codebase Translation
Translate code from other languages to idiomatic Ruby with verified API calls.

**Steps:**
1. **Deconstruct Foreign Codebase** - `researcher` analyzes source code structure
2. **Verify Gem APIs** - `researcher` ensures Ruby equivalents exist
3. **Ruby Implementation** - `builder` generates idiomatic Ruby translation

**Example:**
```bash
/translate "Convert this Python FastAPI endpoint to Ruby Sinatra"
```

#### `/vibe` - Project Creation
Full project creation workflow from requirements gathering to first task implementation.

**Steps:**
1. **Tree of Thoughts Exploration** - `researcher` explores problem space comprehensively
2. **User Stories** - `researcher` defines user requirements and acceptance criteria
3. **Prioritized Backlog** - `builder` creates structured backlog with priorities
4. **Project Scaffold** - `builder` generates project structure and initial files
5. **First Task Implementation** - `builder` implements highest priority task

**Example:**
```bash
/vibe "Create a Rails-based e-commerce platform with Stripe integration"
```

#### `/audit` - Code Review
Comprehensive SIFT Protocol audit with 8-section assessment.

**Steps:**
1. **SIFT Assessment** - `auditor` performs comprehensive code analysis
2. **Evaluation Rubric** - `auditor` applies standardized quality metrics
3. **Rubric Evaluation** - `auditor` generates final report with scores and recommendations

**Example:**
```bash
/audit "Review the User model for Rails conventions and security issues"
```

#### `/diagnose` - Root Cause Analysis
Identify and resolve issues through systematic root cause analysis.

**Steps:**
1. **Root Cause Analysis** - `researcher` traces issue to source using Five Whys
2. **Targeted Refactor** - `builder` applies minimal, focused changes

**Example:**
```bash
/diagnose "Why is the UserRegistrationService timing out under load?"
```

#### `/context` - Context Gathering
Gather contextual information about gems, libraries, or code patterns.

**Example:**
```bash
/context "What are the best practices for implementing a Circuit Breaker pattern in Ruby?"
```

#### `/document` - Documentation Generation
Generate comprehensive documentation for code, APIs, or patterns.

**Example:**
```bash
/document "Generate YARD documentation for the User model"
```

---

## 🏗️ Blueprint Discovery System

### Blueprint-First Code Generation

**CRITICAL DIRECTIVE:** Before generating any new architectural component, class, or pattern, the Builder Agent MUST use the `BlueprintSearchTool` to query the Librarian for a "known-good" blueprint.

**Flow:**
```
Builder receives task
    ↓
Builder MUST query BlueprintSearchTool
    ↓
BlueprintSearchTool searches BlueprintLibrarian
    ↓
BlueprintLibrarian queries PostgreSQL with pgvector
    ↓
[If found] Return closest matching blueprint
    ↓
Builder reads blueprint description and code
    ↓
Builder adapts exact structure, conventions, and logic
    ↓
[If not found] Generate idiomatic Ruby natively
```

### Blueprint Schema

```ruby
# lib/rubysmithing/discovery/blueprint_schema.rb
BlueprintSchema = {
  name: String,           # e.g., "Circuit Breaker Pattern"
  category: String,       # e.g., "Resilience", "Performance"
  description: String,    # Natural language description
  code: String,           # Complete code snippet
  tags: Array[String],    # Searchable tags
  created_at: Time,
  updated_at: Time
}
```

### Database Schema

```sql
CREATE TABLE blueprints (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT,
  description TEXT NOT NULL,
  code TEXT NOT NULL,
  embedding vector(384) NOT NULL,  -- pgvector for semantic search
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Index for fast cosine similarity search
CREATE INDEX idx_blueprints_embedding 
  ON blueprints USING ivfflat (embedding vector_l2_ops) 
  WITH (lists = 100);
```

### Code Implementation

```ruby
# lib/rubysmithing/agents/builder.rb
class BlueprintSearchTool < RubyLLM::Tool
  description "Searches the Librarian database for known-good architectural blueprints"
  param :query, type: :string, desc: "A semantic natural language search query"

  def execute(query:)
    librarian = Rubysmithing::Discovery::BlueprintLibrarian.new
    results = librarian.search(query, limit: 1)
    
    if results.any?
      blueprint = results.first
      "Found Blueprint: #{blueprint[:name]}\n\nDescription: #{blueprint[:description]}\n\nCode:\n#{blueprint[:code]}"
    else
      "No matching blueprint found. Proceed with standard idiomatic Ruby generation."
    end
  end
end
```

---

## 🔍 RAG (Retrieval-Augmented Generation) Pipeline

The RAG system enables semantic search across Ruby documentation, code patterns, and project knowledge.

### Architecture

```
Document (title, text, metadata)
    ↓
Ingester.ingest()
    ↓
PragmaticSegmenter → Segments (semantic chunks)
    ↓
RubyLLM.embed() → Vector embeddings
    ↓
Clause.create(content, embedding, document_id)
    ↓
PostgreSQL + pgvector storage
```

**Retrieval:**
```
Query → RubyLLM.embed() → Vector similarity search
    ↓
Retriever.search() → Top-k closest Clauses
    ↓
Return: content + similarity score + source metadata
```

### Database Schema

```sql
-- Documents table
CREATE TABLE documents (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Clauses table (segmented chunks)
CREATE TABLE clauses (
  id SERIAL PRIMARY KEY,
  document_id INTEGER NOT NULL REFERENCES documents(id),
  content TEXT NOT NULL,
  embedding vector(384) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_clauses_embedding ON clauses USING ivfflat (embedding vector_l2_ops) WITH (lists = 100);
CREATE INDEX idx_clauses_document_id ON clauses(document_id);
```

### Code Implementation

```ruby
# lib/rubysmithing/rag/ingester.rb
class Ingester
  def ingest(title:, text:, metadata: {})
    document = Document.create(title: title, metadata: metadata.to_json)
    
    segments = PragmaticSegmenter::Segmenter.new(text: text).segment
    
    @db.transaction do
      segments.each do |segment|
        embedding = generate_embedding(segment)
        Clause.create(
          document_id: document.id,
          content: segment,
          embedding: embedding
        )
      end
    end
    
    document
  end
end

# lib/rubysmithing/rag/retriever.rb
class Retriever
  def search(query, limit: 5)
    query_embedding = generate_embedding(query)
    
    clauses = db[:clauses]
      .join(:documents, id: :document_id)
      .select(:id, :content, :document_id, :title, :metadata)
      .select_append { (Sequel.lit("1 - (embedding <=> ?)", "[#{query_embedding.join(',')}]")).as(:similarity) }
      .order(Sequel.lit("embedding <=> ?", "[#{query_embedding.join(',')}]"))
      .limit(limit)
      .all
    
    clauses.map do |row|
      {
        id: row[:id],
        content: row[:content],
        similarity: row[:similarity],
        source: row[:title],
        metadata: JSON.parse(row[:metadata])
      }
    end
  end
end
```

---

## ✅ Gem Verification System

### Zero-Hallucination API Verification

Before any gem API call is generated, the system MUST verify its existence through a multi-layer fallback strategy:

```
Integrator.verify(gem_name)
    ↓
Try: GemVerifier → RubyGems.org API
    ↓
[If DegradedError / API unavailable]
    ↓
Fallback: ContextCache.fetch_stale(gem_name)
    ↓
[If no cache entry]
    ↓
Fallback: Generate suggestions from RubyGems.org search
    ↓
Return: VerificationResult with status
```

### VerificationResult States

| Status | Description | Color |
|--------|-------------|-------|
| `:verified` | Gem exists, API accessible | Green |
| `:stale_fallback` | Using cached data with warning | Orange |
| `:not_found` | Gem doesn't exist on RubyGems.org | Red |
| `:unverified` | Cannot verify (API + cache unavailable) | Red |

### Error Types

```ruby
# lib/rubysmithing/gem_verifier.rb
class GemNotFound < StandardError; end
class GemVersionNotFound < StandardError; end
class RubyGemsAPIError < StandardError; end
class DegradedError < StandardError; end  # RubyGems.org unavailable
```

### Code Implementation

```ruby
# lib/rubysmithing/verification/integrator.rb
class Integrator
  VerificationResult = Struct.new(
    :status,
    :gem_info,
    :error,
    :suggestions,
    :staleness_warning,
    keyword_init: true
  )

  def verify(gem_name, version_constraint = nil)
    # Step 1: Try RubyGems.org API first
    begin
      if version_constraint
        verified_with_constraint(gem_name, version_constraint)
      else
        verified_without_constraint(gem_name)
      end
    rescue GemVerifier::DegradedError => e
      # Step 2: API unavailable — fall back to stale cache
      fallback_to_stale_cache(gem_name)
    rescue GemVerifier::GemNotFound
      # Step 3: Gem doesn't exist — generate suggestions
      suggestions = fetch_suggestions(gem_name)
      VerificationResult.new(
        status: :not_found,
        error: "Gem '#{gem_name}' not found on RubyGems.org.",
        suggestions: suggestions
      )
    end
  end
end
```

---

## 📊 Knowledge Graph Analysis

This project uses **graphify** to maintain a knowledge graph of all code, documentation, and relationships.

### Graph Statistics (Current)

From `graphify-out/GRAPH_REPORT.md`:
- **399 nodes** · **549 edges** · **61 communities**
- Extraction: 75% EXTRACTED · 24% INFERRED · 1% AMBIGUOUS
- Token cost: 35,000 input · 19,500 output

### Key Communities

1. **Design Patterns & Conventions** - Zeitwerk, frozen_string_literal, Circuit Breaker
2. **Gem Verification API** - GemVerifier, VersionConstraint, Integrator
3. **Blueprint Discovery & Search** - BlueprintLibrarian, BlueprintSearchTool, Builder
4. **TUI Component Styling** - Dashboard, Styles, Components
5. **Agent Definitions & Issues** - Sovereign, Researcher, Builder, Auditor, Tester
6. **RAG Pipeline** - Document, Clause, Ingester, Retriever

### God Nodes (Most Connected)

1. `rubysmithing-builder` - 15 edges
2. `Vibe Step 4b: Data Foundation` - 14 edges
3. `GemVerifier` - 13 edges
4. `Flow Step 2: Feature Implementation` - 11 edges
5. `Schema Step 2: Data Infrastructure Design` - 11 edges

### Surprising Connections

- `Semantic Color Tokens` ↔ `Update/View/Model TUI Pattern` (semantically_similar)
- `Convention Detection Cascade` ↔ `SIFT Protocol` (semantically_similar)
- `Zeitwerk Compliance` → `app.rb (Entry Point)` (rationale_for)

### How to Update the Graph

```bash
# Full analysis
/graphify .

# Incremental update (after adding/modifying files)
/graphify --update

# Query the graph
/graphify query "What is the relationship between Builder and BlueprintLibrarian?"

# Find path between concepts
/graphify path "BlueprintSearchTool" "Builder"

# Explain a node
/graphify explain "Sovereign Agent"
```

For more information, see: [graphify skill documentation](https://github.com/safishamsi/graphify)

---

## 🛠️ Development Workflow

### Adding a New Blueprint

```ruby
# Create and archive a new blueprint
librarian = Rubysmithing::Discovery::BlueprintLibrarian.new

librarian.archive({
  name: "Circuit Breaker Pattern",
  category: "Resilience",
  description: "Implements the circuit breaker pattern for external API calls",
  code: File.read("path/to/circuit_breaker_example.rb")
})
```

### Ingesting Documentation

```ruby
# Ingest Ruby documentation
ingester = Rubysmithing::RAG::Ingester.new(db)

ingester.ingest(
  title: "Rails ActiveRecord Documentation",
  text: File.read("rails_activerecord.md"),
  metadata: {
    source: "Rails Documentation",
    version: "7.1.3",
    tags: ["rails", "activerecord", "orm"]
  }
)
```

### Running Verification

```ruby
# Verify a gem before using it
integrator = Rubysmithing::Verification::Integrator.new
result = integrator.verify("pgvector")

case result.status
when :verified
  puts "Gem verified: #{result.gem_info[:version]}"
when :stale_fallback
  puts "Using cached data: #{result.staleness_warning}"
when :not_found
  puts "Gem not found. Suggestions: #{result.suggestions.join(', ')}"
end
```

---

## 🧪 Testing

### Run the test suite

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/lib/rubysmithing/verification/integrator_spec.rb

# Run with coverage
bundle exec rspec --format documentation --color
```

### Test Structure

```
spec/
├── lib/
│   └── rubysmithing/
│       ├── agents/
│       │   ├── builder_spec.rb
│       │   ├── researcher_spec.rb
│       │   └── auditor_spec.rb
│       ├── discovery/
│       │   └── blueprint_librarian_spec.rb
│       ├── rag/
│       │   ├── ingester_spec.rb
│       │   └── retriever_spec.rb
│       └── verification/
│           └── integrator_spec.rb
└── features/
    ├── flow.feature
    ├── schema.feature
    ├── translate.feature
    └── step_definitions/
        └── *.rb
```

---

## 📚 Documentation

- **[Architecture Diagrams](docs/architecture/)** - Interactive SVG diagrams of all process flows
- **[Graph Report](graphify-out/GRAPH_REPORT.md)** - Knowledge graph analysis and insights
- **[AGENTS.md](AGENTS.md)** - Context7 library references for documentation
- **[backlog.md](backlog.md)** - Current development priorities

---

## 🌐 Integration

### Git Hooks

```bash
# Install post-commit hook for automatic graph updates
$(cat graphify-out/.graphify_python) -m graphify hook install
```

### MCP Server

```bash
# Start MCP server for agent access
$(cat graphify-out/.graphify_python) -m graphify.serve graphify-out/graph.json
```

### CLAUDE.md Integration

```bash
# Configure CLAUDE.md for always-on graphify
$(cat graphify-out/.graphify_python) -m graphify claude install
```

---

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | `postgres:///rubysmithing_rag` |
| `RUBY_GEM_DB_DIR` | Gem database directory | `~/.config/rubysmithing/db` |
| `LOG_LEVEL` | Logging verbosity | `INFO` |
| `OLLAMA_API_BASE` | Ollama API endpoint | `http://localhost:11434/v1` |
| `BLUEPRINT_EMBEDDING_PROVIDER` | Embedding provider | `:ollama` |
| `BLUEPRINT_EMBEDDING_MODEL` | Embedding model | `embeddinggemma:latest` |
| `RAG_EMBEDDING_PROVIDER` | RAG embedding provider | `:openrouter` |
| `RAG_EMBEDDING_MODEL` | RAG embedding model | `mistralai/mistral-embed` |
| `BUILDER_MODEL` | Builder agent model | `google/gemini-2.0-flash-lite-001` |

### Configuration File

Create `~/.config/rubysmithing/rubysmithing.yml`:

```yaml
:database_url: postgres:///rubysmithing_rag
:gem_db_dir: ~/.config/rubysmithing/db
:log_level: INFO
:ollama_api_base: http://localhost:11434/v1
:blueprint_embedding_provider: :ollama
:blueprint_embedding_model: embeddinggemma:latest
:rag_embedding_provider: :openrouter
:rag_embedding_model: mistralai/mistral-embed
:builder_model: google/gemini-2.0-flash-lite-001
```

---

## 📦 Dependencies

### Ruby Gems

- `ruby_llm` - LLM integration for Ruby
- `sequel` - Database ORM
- `pg` - PostgreSQL adapter
- `pgvector` - Vector search for PostgreSQL
- `pragmatic_segmenter` - Text segmentation
- `tty-config` - Configuration management
- `journald-logger` - Structured logging
- `zeitwerk` - Autoloading

### External Services

- **RubyGems.org API** - Gem metadata and verification
- **Context7 MCP** - Library documentation lookup
- **OpenRouter** - Embedding API (configurable)
- **Ollama** - Local LLM inference (configurable)

---

## 🎓 Philosophy

### Core Principles

1. **Convention Over Configuration** - Follow established Ruby conventions by default
2. **Zero Hallucination** - Never generate code with unverified API calls
3. **Blueprint-First** - Reuse proven patterns before inventing new ones
4. **Quality Gates** - Every artifact must pass SIFT assessment
5. **Graph Intelligence** - Leverage knowledge graph for context-aware decisions

### Design Patterns

- **Hub-and-Spoke** - Sovereign orchestrates specialized agents
- **Layered Architecture** - 4-layer execution model
- **Circuit Breaker** - Resilient external API calls
- **Repository Pattern** - Database abstraction
- **Strategy Pattern** - Interchangeable embedding providers

---

## 🚀 Roadmap

### Near Term

- [ ] Complete Builder Agent Tool Registration fix (backlog.md)
- [ ] Fix Invalid Gemfile Failure in gem_verification.feature
- [ ] Migrate environment validation steps to use Rubysmithing.config
- [ ] Add more blueprints to the Librarian database
- [ ] Implement full test coverage for all workflows

### Long Term

- [ ] Add support for more Ruby versions
- [ ] Expand SIFT Protocol with custom rubrics
- [ ] Add visual graph exploration interface
- [ ] Implement incremental learning from code reviews
- [ ] Add support for Rails-specific conventions

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Run tests (`bundle exec rspec`)
4. Update documentation
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Commit Message Format

```
type(scope): subject

body

footer
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Andrej Karpathy** - /raw folder workflow inspiration
- **Safi Shamsi** - graphify knowledge graph system
- **Ruby Community** - Convention standards and best practices
- **LLM.rb** - Ruby LLM integration framework
- **Sequel** - Flexible database ORM
- **pgvector** - Vector search capabilities

---

## 🔗 Links

- [Repository](https://github.com/b08x/rubysmithingV1)
- [Issues](https://github.com/b08x/rubysmithingV1/issues)
- [graphify Skill](https://github.com/safishamsi/graphify)
- [RubyLLM](https://github.com/crmne/ruby_llm)
- [Sequel](https://github.com/jeremyevans/sequel)
- [pgvector](https://github.com/ankane/pgvector)

---

**Built with ❤️ using Ruby, LLM intelligence, and knowledge graphs.**

*Generated using graphify knowledge graph analysis of the rubysmithingV1 codebase.*
