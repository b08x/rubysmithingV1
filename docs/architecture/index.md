# RubysmithingV1 Architecture Diagrams

This directory contains interactive architecture diagrams that visualize the rubysmithing process flows, state machines, and component relationships.

## Available Diagrams

### Core Architecture

1. **[Sovereign Agent Layer 1-4 Execution Model](soverign-agent-flow.html)**
   - Visual representation of the 4-layer execution model
   - Survey (Context-Aware Detection)
   - Resolve (Epistemic Verification)
   - Dispatch (Strategic Delegation)
   - Audit (Quality Gates)

2. **[Agent Orchestration - Hub-and-Spoke Pattern](agent-orchestration.html)**
   - Central Sovereign agent coordinating all operations
   - Researcher, Builder, Auditor, Tester agents as spokes
   - Communication flows and dispatch patterns

### Workflow Diagrams

3. **[Workflow Commands Flow](workflow-commands-flow.html)**
   - /flow command: Feature Implementation
   - /schema command: Data Infrastructure
   - /translate command: Foreign Codebase Translation
   - /vibe command: Project Creation (5-step)
   - /audit command: Code Review (SIFT Protocol)
   - /diagnose command: Root Cause Analysis

### Component-Specific Diagrams

4. **[Blueprint Discovery Flow](blueprint-discovery-flow.html)**
   - Blueprint-First Code Generation pattern
   - Builder → BlueprintSearchTool → BlueprintLibrarian → Database
   - Mandatory blueprint search before code generation

5. **[RAG Pipeline Flow](rag-pipeline-flow.html)**
   - Retrieval-Augmented Generation for Ruby documentation
   - Ingester → Segmenter → Embedding → Clause Storage
   - Vector similarity search with pgvector

6. **[Gem Verification Flow](gem-verification-flow.html)**
   - Zero-hallucination API verification
   - Multi-layer fallback strategy
   - RubyGems.org API → Context7 MCP → ContextCache → Suggestions

## How to Use

Each diagram is a standalone HTML file with:
- Interactive SVG graphics
- Dark theme optimized for coding environments
- Embedded code examples
- Detailed explanations
- Cross-references to source code

Simply open any `.html` file in a web browser to view the diagram.

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
