# Builder Integration Tests

> 15 nodes · cohesion 0.18

## Key Concepts

- **test-builder.rb** (6 connections) — `tests/test-builder.rb`
- **test-librarian.rb** (6 connections) — `tests/test-librarian.rb`
- **Local Ollama Configuration Pattern** (4 connections) — `tests/test-builder.rb`
- **migrate()** (4 connections) — `lib/rubysmithing/database.rb`
- **BlueprintLibrarian#archive** (3 connections) — `tests/test-builder.rb`
- **migrate-db.rb** (3 connections) — `tests/migrate-db.rb`
- **BlueprintLibrarian** (2 connections) — `tests/test-builder.rb`
- **BlueprintLibrarian#search** (2 connections) — `tests/test-librarian.rb`
- **Builder#ask** (2 connections) — `tests/test-builder.rb`
- **check-mcp-tools.rb** (2 connections) — `tests/check-mcp-tools.rb`
- **Context7 MCP Connectivity Test** (2 connections) — `tests/check-mcp-tools.rb`
- **database.rb** (2 connections) — `lib/rubysmithing/database.rb`
- **Rubysmithing::Agents::Builder** (1 connections) — `tests/test-builder.rb`
- **RubyLLM::MCP.client** (1 connections) — `tests/check-mcp-tools.rb`
- **test-pre-flight.rb** (1 connections) — `tests/test-pre-flight.rb`

## Relationships

- No strong cross-community connections detected

## Source Files

- `lib/rubysmithing/database.rb`
- `tests/check-mcp-tools.rb`
- `tests/migrate-db.rb`
- `tests/test-builder.rb`
- `tests/test-librarian.rb`
- `tests/test-pre-flight.rb`

## Audit Trail

- EXTRACTED: 27 (66%)
- INFERRED: 11 (27%)
- AMBIGUOUS: 3 (7%)

---

*Part of the graphify knowledge wiki. See [[index]] to navigate.*