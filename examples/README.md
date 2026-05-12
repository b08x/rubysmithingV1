# Rubysmithing Examples

This directory contains example code demonstrating various features of the Rubysmithing framework.

## Examples

### Enhanced Logging Demo
**File**: `enhanced_logging_demo.rb`  
**Purpose**: Demonstrates structured journald logging for agent coordination

Shows how to:
- Use correlation IDs for tracking agent handoffs
- Log hub-and-spoke coordination events
- Measure and log performance metrics
- Structure logs for systemd/journald integration

**Run**:
```bash
cd examples
ruby enhanced_logging_demo.rb
```

**Monitor logs**:
```bash
# Watch all rubysmithing logs
journalctl -f -t rubysmithing

# Watch with JSON formatting
journalctl -f -t rubysmithing --output=json-pretty

# Filter by specific fields
journalctl -f CORRELATION_ID=<id>
journalctl -f WORKFLOW_STAGE=survey
journalctl -f EVENT_TYPE=coordination
```

### Agent Coordination
**File**: `agents/example_sovereign_agent.rb`  
**Purpose**: Example implementation of hub-and-spoke agent coordination

Demonstrates:
- Survey → Resolve → Dispatch → Audit workflow
- Agent delegation and coordination
- Structured error handling
- Performance measurement

### DSPy Workflow Pipeline  
**File**: `workflows/example_usage.rb`  
**Purpose**: Example usage of SFL-BDD DSPy workflow signatures

Shows:
- Type-safe LLM workflow contracts
- Natural language → User stories → Gherkin pipeline
- Structured validation and quality metrics

## Architecture Context

These examples are designed for:
- **Immutable Fedora deployment** - uses journald for system integration
- **Hub-and-spoke agent coordination** - "CrewAI but for Ruby"
- **Systemd service integration** - structured logging for operational visibility

## Usage Notes

- Examples use relative requires to the main library
- Run from the examples directory for correct paths
- Monitor journald logs to see structured output
- Use journalctl filtering for debugging specific operations