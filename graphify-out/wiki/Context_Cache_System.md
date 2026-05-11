# Context Cache System

> 14 nodes · cohesion 0.16

## Key Concepts

- **ContextCache** (10 connections) — `scripts/context_cache.rb`
- **.deserialize()** (4 connections) — `scripts/context_cache.rb`
- **.staleness_warning()** (4 connections) — `scripts/context_cache.rb`
- **.fetch_stale()** (3 connections) — `scripts/context_cache.rb`
- **format_result()** (3 connections) — `scripts/verify_gem.rb`
- **verify_gem.rb** (3 connections) — `scripts/verify_gem.rb`
- **.initialize()** (2 connections) — `scripts/context_cache.rb`
- **.migrate!()** (2 connections) — `scripts/context_cache.rb`
- **.evict()** (1 connections) — `scripts/context_cache.rb`
- **.list()** (1 connections) — `scripts/context_cache.rb`
- **.store()** (1 connections) — `scripts/context_cache.rb`
- **context_cache.rb** (1 connections) — `scripts/context_cache.rb`
- **exit_code_for_status()** (1 connections) — `scripts/verify_gem.rb`
- **usage()** (1 connections) — `scripts/verify_gem.rb`

## Relationships

- No strong cross-community connections detected

## Source Files

- `scripts/context_cache.rb`
- `scripts/verify_gem.rb`

## Audit Trail

- EXTRACTED: 31 (84%)
- INFERRED: 6 (16%)
- AMBIGUOUS: 0 (0%)

---

*Part of the graphify knowledge wiki. See [[index]] to navigate.*