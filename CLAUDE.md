# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Builder is an autonomous build orchestration system that manages multiple Claude Code sessions to execute complex, multi-step build processes. It has two main components:

1. **Builder** - The main orchestration system with async architecture, SQLite session management, and YAML prompt support
2. **Multi-Claude** - A simplified tool for running multiple Claude Code agents in parallel for collaborative problem-solving

## Key Commands

### Installation
```bash
# Install Builder (from project root)
pip install -e .

# Install with development dependencies
pip install -e ".[dev]"
```

### Builder Commands
```bash
# Initialize Builder
builder init

# Start a build session
builder start                    # Interactive prompt selection
builder start my_prompt.yaml     # Use specific prompt
builder start --speed fast       # Fast mode

# Monitor and manage sessions
builder status                   # Check current status
builder attach <session-id>      # Attach to running session
builder list                     # List all sessions
builder kill <session-id>        # Kill a running session

# Prompt management
builder prompt list              # List available prompts
builder prompt validate <file>   # Validate a prompt file
builder prompt convert <in> <out> # Convert between formats
```

### Multi-Claude Commands
```bash
# Run multiple agents
python multi_claude.py -n 5 -p "Fix all TypeScript errors"

# Use prompt file
python multi_claude.py -n 4 --prompt-file example_prompts/fix_typescript_errors.txt

# Collaborative mode
python multi_claude.py -n 4 --prompt-file dashboard.yaml --collaborative
```

### Development Commands
```bash
# Run tests
pytest

# Format code
black builder/

# Type checking
mypy builder/

# Linting
flake8 builder/
```

## Architecture

### Builder Components

- **CLI** (`builder/cli.py`) - Main command-line interface using Click
- **Config** (`builder/config.py`) - Configuration management with speed profiles
- **Orchestrator** (`builder/orchestrator.py`) - Async orchestration engine for Claude sessions
- **SessionManager** (`builder/session_manager.py`) - SQLite-based session tracking
- **PromptManager** (`builder/prompt_manager.py`) - Handles YAML and text prompt formats
- **Monitor** (`builder/monitor.py`) - Session monitoring capabilities
- **ClaudeInterface** (`builder/claude_interface.py`) - Interface to Claude CLI

### Multi-Claude

- Single file (`multi_claude.py`) managing multiple Claude agents via tmux
- File-based coordination system in `/tmp/claude_coordination/`
- Supports sequential, collaborative, and bundled step modes

### Key Patterns

1. **Async Architecture**: Builder uses Python's asyncio for concurrent operations
2. **SQLite Storage**: Sessions tracked in `~/.builder/builder.db`
3. **YAML Prompts**: Structured format with metadata, steps, and time estimates
4. **Speed Profiles**: Fast (5s wait), Normal (30s wait), Careful (60s wait)
5. **Tmux Integration**: Both systems use tmux for session management

### Configuration

Builder config stored in `~/.builder/config.yaml` with settings for:
- Speed profiles and default profile
- Directory paths (prompts, sessions)
- Claude CLI settings
- Feature flags (tmux, auto-continue, archiving)

## Important Notes

- Always run from the project root directory
- The `--dangerously-skip-permissions` flag is used to avoid interactive prompts
- Session data persists in SQLite database
- Coordination files for multi-agent runs are in `/tmp/claude_coordination/`
- Both systems support resuming interrupted sessions