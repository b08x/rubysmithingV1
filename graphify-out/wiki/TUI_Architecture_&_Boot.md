# TUI Architecture & Boot

> 13 nodes · cohesion 0.19

## Key Concepts

- **AppName::App** (6 connections) — `assets/skeleton/lib/app_name/app.rb`
- **config/boot.rb** (4 connections) — `config/boot.rb`
- **Update/View/Model TUI Pattern** (3 connections) — `agents/rubysmithing-builder.md`
- **AppName::Styles** (3 connections) — `assets/skeleton/lib/app_name/styles.rb`
- **AppName::Components::Base** (3 connections) — `assets/skeleton/lib/app_name/components/base.rb`
- **Four-Layer Keyboard Architecture** (2 connections) — `assets/skeleton/lib/app_name/components/keyboard.rb`
- **Semantic Color Tokens** (2 connections) — `assets/skeleton/lib/app_name/styles.rb`
- **app.rb (Entry Point)** (2 connections) — `assets/skeleton/app.rb`
- **AppName::Components::Keyboard** (2 connections) — `assets/skeleton/lib/app_name/components/keyboard.rb`
- **AppName::Screens::Main** (2 connections) — `assets/skeleton/lib/app_name/screens/main.rb`
- **Environment Validation Steps Migration Issue** (1 connections) — `backlog.md`
- **bin/console** (1 connections) — `bin/console`
- **bin/setup** (1 connections) — `bin/setup`

## Relationships

- No strong cross-community connections detected

## Source Files

- `agents/rubysmithing-builder.md`
- `assets/skeleton/app.rb`
- `assets/skeleton/lib/app_name/app.rb`
- `assets/skeleton/lib/app_name/components/base.rb`
- `assets/skeleton/lib/app_name/components/keyboard.rb`
- `assets/skeleton/lib/app_name/screens/main.rb`
- `assets/skeleton/lib/app_name/styles.rb`
- `backlog.md`
- `bin/console`
- `bin/setup`
- `config/boot.rb`

## Audit Trail

- EXTRACTED: 20 (62%)
- INFERRED: 12 (38%)
- AMBIGUOUS: 0 (0%)

---

*Part of the graphify knowledge wiki. See [[index]] to navigate.*