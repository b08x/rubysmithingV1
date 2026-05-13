# Builder & Discovery

> 11 nodes · cohesion 0.22

## Key Concepts

- **Blueprint Librarian** (5 connections) — `lib/rubysmithing/discovery/blueprint_librarian.rb`
- **Builder Agent** (3 connections) — `lib/rubysmithing/agents/builder.rb`
- **RAG Ingester** (3 connections) — `lib/rubysmithing/rag/ingester.rb`
- **RAG Retriever** (3 connections) — `lib/rubysmithing/rag/retriever.rb`
- **Blueprint Search Tool** (2 connections) — `lib/rubysmithing/agents/builder.rb`
- **Database Module** (2 connections) — `lib/rubysmithing/database.rb`
- **RAG Clause Model** (2 connections) — `lib/rubysmithing/rag/clause.rb`
- **Blueprint-First Code Generation** (1 connections) — `lib/rubysmithing/agents/builder.rb`
- **Blueprint Schema** (1 connections) — `lib/rubysmithing/discovery/blueprint_schema.rb`
- **RAG Document Model** (1 connections) — `lib/rubysmithing/rag/document.rb`
- **Cucumber Test Environment** (1 connections) — `features/support/env.rb`

## Relationships

- No strong cross-community connections detected

## Source Files

- `features/support/env.rb`
- `lib/rubysmithing/agents/builder.rb`
- `lib/rubysmithing/database.rb`
- `lib/rubysmithing/discovery/blueprint_librarian.rb`
- `lib/rubysmithing/discovery/blueprint_schema.rb`
- `lib/rubysmithing/rag/clause.rb`
- `lib/rubysmithing/rag/document.rb`
- `lib/rubysmithing/rag/ingester.rb`
- `lib/rubysmithing/rag/retriever.rb`

## Audit Trail

- EXTRACTED: 10 (42%)
- INFERRED: 14 (58%)
- AMBIGUOUS: 0 (0%)

---

*Part of the graphify knowledge wiki. See [[index]] to navigate.*