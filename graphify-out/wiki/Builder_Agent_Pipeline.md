# Builder Agent Pipeline

> 17 nodes · cohesion 0.17

## Key Concepts

- **Rubysmithing Module** (7 connections) — `lib/rubysmithing.rb`
- **Blueprint Librarian** (6 connections) — `lib/rubysmithing/discovery/blueprint_librarian.rb`
- **Builder Agent** (4 connections) — `lib/rubysmithing/agents/builder.rb`
- **Gem Curator** (4 connections) — `lib/rubysmithing/discovery/gem_curator.rb`
- **RAG Retriever** (4 connections) — `lib/rubysmithing/rag/retriever.rb`
- **Database Module** (3 connections) — `lib/rubysmithing/database.rb`
- **RAG Ingester** (3 connections) — `lib/rubysmithing/rag/ingester.rb`
- **Blueprint Search Tool** (2 connections) — `lib/rubysmithing/agents/builder.rb`
- **Context7 Service** (2 connections) — `lib/rubysmithing/discovery/context7_service.rb`
- **Gem Verifier** (2 connections) — `lib/rubysmithing/gem_verifier.rb`
- **RAG Clause Model** (2 connections) — `lib/rubysmithing/rag/clause.rb`
- **Cucumber Test Environment** (2 connections) — `features/support/env.rb`
- **Blueprint-First Code Generation** (1 connections) — `lib/rubysmithing/agents/builder.rb`
- **Dual Embedding Strategy** (1 connections) — `lib/rubysmithing.rb`
- **Blueprint Schema** (1 connections) — `lib/rubysmithing/discovery/blueprint_schema.rb`
- **Version Constraint** (1 connections) — `lib/rubysmithing/gem_verifier.rb`
- **RAG Document Model** (1 connections) — `lib/rubysmithing/rag/document.rb`

## Relationships

- No strong cross-community connections detected

## Source Files

- `features/support/env.rb`
- `lib/rubysmithing.rb`
- `lib/rubysmithing/agents/builder.rb`
- `lib/rubysmithing/database.rb`
- `lib/rubysmithing/discovery/blueprint_librarian.rb`
- `lib/rubysmithing/discovery/blueprint_schema.rb`
- `lib/rubysmithing/discovery/context7_service.rb`
- `lib/rubysmithing/discovery/gem_curator.rb`
- `lib/rubysmithing/gem_verifier.rb`
- `lib/rubysmithing/rag/clause.rb`
- `lib/rubysmithing/rag/document.rb`
- `lib/rubysmithing/rag/ingester.rb`
- `lib/rubysmithing/rag/retriever.rb`

## Audit Trail

- EXTRACTED: 27 (60%)
- INFERRED: 16 (36%)
- AMBIGUOUS: 2 (4%)

---

*Part of the graphify knowledge wiki. See [[index]] to navigate.*