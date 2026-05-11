# RubysmithingV1 Architecture Diagrams

This directory contains interactive architecture diagrams that visualize the rubysmithing process flows, state machines, and component relationships.

## Design System

The diagrams feature a **warm cream aesthetic** with a carefully curated color palette designed for clarity and visual hierarchy:

| Color | Hex | Usage |
|-------|-----|-------|
| Cream | `#DEDCCB` | Primary background |
| Ruby Red | `#971716` | Primary actions, Sovereign agent |
| Azure | `#1B4A86` | Information, Researcher agent |
| Forest | `#1A5C24` | Success states, Builder agent |
| Walnut | `#59310A` | Warnings, Auditor agent |
| Charcoal | `#111111` | Primary text, Tester agent |

**Design Approach:** Modern, warm, and professional — optimized for readability in well-lit environments while maintaining strong visual distinction between components and flows.

## Available Diagrams

All diagrams use a **warm cream aesthetic** (`#DEDCCB` background) with semantic color coding:
- Ruby Red `#971716` — Sovereign agent, primary actions
- Azure `#1B4A86` — Researcher agent, information
- Forest `#1A5C24` — Builder agent, success states
- Walnut `#59310A` — Auditor agent, warnings
- Charcoal `#111111` — Tester agent, primary text

### Core Architecture

1. **[Sovereign Agent Layer 1-4 Execution Model](sovereign-agent-flow.html)** ✓
   - Visual representation of the 4-layer execution model
   - Survey (Context-Aware Detection)
   - Resolve (Epistemic Verification)
   - Dispatch (Strategic Delegation)
   - Audit (Quality Gates)

2. **[Agent Orchestration - Hub-and-Spoke Pattern](agent-orchestration.html)** ✓
   - Central Sovereign agent coordinating all operations
   - Researcher, Builder, Auditor, Tester agents as spokes
   - Communication flows and dispatch patterns

### Workflow Diagrams

3. **[Workflow Commands Flow](workflow-commands-flow.html)** ✓
   - /flow command: Feature Implementation
   - /schema command: Data Infrastructure
   - /translate command: Foreign Codebase Translation
   - /vibe command: Project Creation (5-step)
   - /audit command: Code Review (SIFT Protocol)
   - /diagnose command: Root Cause Analysis

### Component-Specific Diagrams

4. **[Blueprint Discovery Flow](blueprint-discovery-flow.html)** ✓
   - Blueprint-First Code Generation pattern
   - Builder → BlueprintSearchTool → BlueprintLibrarian → Database
   - Mandatory blueprint search before code generation

5. **[RAG Pipeline Flow](rag-pipeline-flow.html)** ✓
   - Retrieval-Augmented Generation for Ruby documentation
   - Ingester → Segmenter → Embedding → Clause Storage
   - Vector similarity search with pgvector

6. **[Gem Verification Flow](gem-verification-flow.html)** ✓
   - Zero-hallucination API verification
   - Multi-layer fallback strategy
   - RubyGems.org API → Context7 MCP → ContextCache → Suggestions

## How to Use

Each diagram is a standalone HTML file with:
- Interactive SVG graphics with warm cream background
- Color-coded components using the design system palette
- Embedded code examples
- Detailed explanations
- Cross-references to source code

Simply open any `.html` file in a web browser to view the diagram. The warm cream theme provides excellent readability in both light and dark environments.

## Source Files

The diagrams are based on analysis of the rubysmithingV1 codebase, particularly:
- `agents/rubysmithing-sovereign.md` - Layer 1-4 model
- `commands/*.md` - Workflow command definitions
- `lib/rubysmithing/agents/builder.rb` - BlueprintSearchTool
- `lib/rubysmithing/discovery/blueprint_librarian.rb` - Blueprint management
- `lib/rubysmithing/rag/ingester.rb` - RAG ingestion
- `lib/rubysmithing/verification/integrator.rb` - Gem verification

## Graph Analysis

These diagrams were created using the /graphify skill to analyze the codebase and understand:
- Agent relationships and orchestration patterns
- Workflow execution flows
- Component dependencies
- State transitions

For the latest analysis, see: `../graphify-out/GRAPH_REPORT.md`

## Contributing

To update diagrams:
1. Run `/graphify` on the project to regenerate the knowledge graph
2. Review `graphify-out/GRAPH_REPORT.md` for insights
3. Update diagrams based on new analysis
4. Test diagrams in a browser to ensure proper rendering

---

Generated using [graphify](https://github.com/safishamsi/graphify) skill for knowledge graph analysis.
