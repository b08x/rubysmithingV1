# trackboi Integration Design

**Date:** 2026-05-12  
**Status:** Approved  
**Scope:** rubysmithing completion tracking and future project scaffolding

## Summary

Integrate trackboi as a simple Kanban task management system for rubysmithing project completion and future scaffolded projects.

## Architecture

### Phase 1: Immediate - rubysmithing Completion Tracking
- Create `rubysmithing-completion` track in existing trackboi
- Organize completion tasks using existing board columns (To Do, Doing, Done, Backlog)
- Track key tasks from backlog.md

### Phase 2: Future - Scaffolding Integration  
- Add basic `.trackboi/` template to rubysmithing project scaffolding
- Include simple `project.json` and default board configuration
- Static template approach (no complex blueprint integration)

## Components

### trackboi Track Setup
- **Track ID:** `rubysmithing-completion`
- **Title:** "rubysmithing Project Completion"
- **Purpose:** Organize remaining development tasks for rubysmithing framework

### Key Completion Tasks
- Fix Builder Agent Tool Registration bug
- Fix Invalid Gemfile Failure in gem_verification.feature  
- Migrate environment validation steps to use Rubysmithing.config
- Add more blueprints to Librarian database
- Implement full test coverage for all workflows

### Future Scaffolding Template
```
.trackboi/
├── project.json          # Basic project metadata
├── boards/
│   └── default.json     # Simple To Do/Doing/Done board
└── tracks/              # Empty initially
```

## Test Coverage

Create Cucumber feature test for trackboi integration:
- Verify track creation and task organization
- Test basic workflow: To Do → Doing → Done
- Validate trackboi MCP integration

## Success Criteria

1. **Immediate:** rubysmithing completion tasks are organized and trackable via trackboi
2. **Future:** New rubysmithing-scaffolded projects include basic trackboi setup
3. **Quality:** Integration is covered by BDD tests

## Risk Assessment

- **Low risk:** Simple integration using existing trackboi functionality
- **No breaking changes:** Pure additive functionality
- **Minimal dependencies:** Leverages existing MCP tools