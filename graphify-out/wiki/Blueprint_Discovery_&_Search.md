# Blueprint Discovery & Search

> 31 nodes · cohesion 0.11

## Key Concepts

- **.fetch()** (12 connections) — `scripts/context_cache.rb`
- **rubysmithing.rb** (9 connections) — `lib/rubysmithing.rb`
- **config()** (6 connections) — `lib/rubysmithing.rb`
- **connect()** (6 connections) — `lib/rubysmithing/database.rb`
- **BlueprintLibrarian** (5 connections) — `lib/rubysmithing/discovery/blueprint_librarian.rb`
- **.generate_embedding()** (5 connections) — `lib/rubysmithing/discovery/blueprint_librarian.rb`
- **logger()** (5 connections) — `lib/rubysmithing.rb`
- **Retriever** (5 connections) — `lib/rubysmithing/rag/retriever.rb`
- **.generate_embedding()** (5 connections) — `lib/rubysmithing/rag/retriever.rb`
- **.search()** (4 connections) — `lib/rubysmithing/discovery/blueprint_librarian.rb`
- **boot!()** (4 connections) — `lib/rubysmithing.rb`
- **configure_llm!()** (4 connections) — `lib/rubysmithing.rb`
- **.execute()** (3 connections) — `lib/rubysmithing/agents/builder.rb`
- **.archive()** (3 connections) — `lib/rubysmithing/discovery/blueprint_librarian.rb`
- **.initialize()** (3 connections) — `lib/rubysmithing/discovery/gem_curator.rb`
- **ensure_directories!()** (3 connections) — `lib/rubysmithing.rb`
- **.retrieve()** (3 connections) — `lib/rubysmithing/rag/retriever.rb`
- **BlueprintSearchTool** (2 connections) — `lib/rubysmithing/agents/builder.rb`
- **resolve()** (2 connections) — `assets/skeleton/lib/app_name/components/keyboard.rb`
- **.initialize()** (2 connections) — `lib/rubysmithing/discovery/blueprint_librarian.rb`
- **builder.rb** (2 connections) — `lib/rubysmithing/agents/builder.rb`
- **configure()** (2 connections) — `lib/rubysmithing.rb`
- **db()** (2 connections) — `lib/rubysmithing.rb`
- **.fake_vector()** (2 connections) — `lib/rubysmithing/rag/retriever.rb`
- **Builder** (1 connections) — `lib/rubysmithing/agents/builder.rb`
- *... and 6 more nodes in this community*

## Relationships

- No strong cross-community connections detected

## Source Files

- `assets/skeleton/lib/app_name/components/keyboard.rb`
- `lib/rubysmithing.rb`
- `lib/rubysmithing/agents/builder.rb`
- `lib/rubysmithing/database.rb`
- `lib/rubysmithing/discovery/blueprint_librarian.rb`
- `lib/rubysmithing/discovery/gem_curator.rb`
- `lib/rubysmithing/rag/retriever.rb`
- `scripts/context_cache.rb`

## Audit Trail

- EXTRACTED: 65 (61%)
- INFERRED: 41 (39%)
- AMBIGUOUS: 0 (0%)

---

*Part of the graphify knowledge wiki. See [[index]] to navigate.*