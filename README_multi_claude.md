# Multi-Agent Claude Code Orchestrator

A simplified tool to run multiple Claude Code sessions in parallel for collaborative problem-solving. This tool is inspired by `claude_code_agent_farm` but designed to be minimal and easy to use.

## Features

- **Parallel Execution**: Run 1-20 Claude Code agents simultaneously using tmux
- **Flexible Prompting**: Support for single prompts, step-based workflows, and prompt files
- **Simple Coordination**: Basic file-based locking to prevent agents from conflicting
- **Clean Architecture**: Single Python file with no external dependencies (except tmux)
- **Graceful Shutdown**: Ctrl+C cleanly stops all agents and cleans up

## Installation

1. Ensure you have the required tools:
   ```bash
   # Check for Python 3.6+
   python3 --version
   
   # Check for tmux
   tmux -V
   
   # Check for Claude Code CLI
   claude --version
   ```

   **Note**: The tool launches Claude with `--dangerously-skip-permissions` to avoid interactive prompts during automated startup.

2. Clone or download `multi_claude.py`:
   ```bash
   chmod +x multi_claude.py
   ```

## Usage

### Basic Usage

Run multiple agents with a single prompt:
```bash
python multi_claude.py -n 5 -p "Fix all TypeScript errors in the codebase"
```

### Step-Based Workflow

Distribute steps across agents:
```bash
python multi_claude.py -n 3 -p "Build user authentication" \
  --steps "Design database schema" \
          "Implement API endpoints" \
          "Create frontend components"
```

### From Prompt Files

Use a text prompt file:
```bash
python multi_claude.py -n 4 --prompt-file example_prompts/fix_typescript_errors.txt
```

Use a YAML prompt file with steps:
```bash
python multi_claude.py -n 6 --prompt-file example_prompts/implement_feature.yaml
```

### Command Line Options

```
Required:
  -n, --agents NUM          Number of agents to run (1-20)
  
Prompt (one required):
  -p, --prompt TEXT         Direct prompt for all agents
  --prompt-file PATH        Path to prompt file (.txt or .yaml)
  
Optional:
  --steps STEP1 STEP2 ...   Steps to distribute across agents
  -s, --session NAME        tmux session name (default: claude_agents)
  --stagger SECONDS         Delay between launches (default: 5.0)
  --wait-after-launch SEC   Wait before sending prompts (default: 15.0)
  --no-kill-on-exit        Keep tmux session after exit
  --no-cleanup             Keep coordination files after exit
  --debug                  Enable debug output for troubleshooting
  
Collaboration Options:
  --collaborative          Enable collaborative mode (all agents see all steps)
  --bundle-steps N         Bundle N related steps together per agent
```

## Prompt File Formats

### Text Format
```
Initial instructions for all agents...

1. First step description
2. Second step description
3. Third step description
```

### YAML Format
```yaml
name: Task Name
description: Task description

initial_prompt: |
  Initial instructions for all agents...
  Can be multiple lines.

steps:
  - content: First step description
    description: Optional detailed description
  - content: Second step 
  - content: Third step
```

## Coordination System

When multiple agents run, they use a simple file-based coordination system:

```
/tmp/claude_coordination/
├── active_agents.json      # Currently running agents
├── work_claims/           # Lock files for claimed work
└── completed_work.log     # Log of finished tasks
```

Agents can claim files or features before working on them to avoid conflicts.

## Working Modes

### Sequential Mode (Default)
Each step is assigned to the next available agent:
```bash
python multi_claude.py -n 3 --prompt-file dashboard.yaml
```
- Agent 0 gets Step 1
- Agent 1 gets Step 2
- Agent 2 gets Step 3
- As agents finish, they get the next unassigned step

### Collaborative Mode
All agents see all steps and self-organize:
```bash
python multi_claude.py -n 4 --prompt-file dashboard.yaml --collaborative
```
- All agents receive the complete project overview
- Agents coordinate through the file locking system
- Better for interdependent tasks like dashboard development

### Bundled Steps Mode
Group related steps together:
```bash
python multi_claude.py -n 3 --prompt-file dashboard.yaml --bundle-steps 2
```
- Agent 0 gets Steps 1-2
- Agent 1 gets Steps 3-4
- Agent 2 gets Steps 5-6

## Examples

### Dashboard Development (Collaborative)
```bash
python multi_claude.py -n 4 --prompt-file example_prompts/dashboard_collaborative.yaml --collaborative
```

### Fix Linting Errors
```bash
python multi_claude.py -n 5 -p "Find and fix all ESLint errors. Each agent should claim different files to avoid conflicts."
```

### Component-Based Development
```bash
python multi_claude.py -n 3 --prompt-file example_prompts/dashboard_components.yaml --bundle-steps 2
```

### Feature Implementation
```bash
python multi_claude.py -n 6 --prompt-file example_prompts/implement_feature.yaml
```

### Quick Parallel Task
```bash
python multi_claude.py -n 3 -p "Add JSDoc comments to all functions in the codebase"
```

## Monitoring

While agents are running:
- View all agents: `tmux attach -t claude_agents`
- View specific agent: `tmux attach -t claude_agents` then navigate panes with Ctrl+B followed by arrow keys
- Detach from tmux: Ctrl+B then D

## Tips

1. **Start Small**: Test with 2-3 agents before scaling up
2. **Clear Instructions**: Include coordination hints in prompts for multi-agent tasks
3. **Resource Usage**: Each Claude agent uses ~500MB RAM
4. **Stagger Time**: Increase `--stagger` if you see initialization issues
5. **Project Directory**: Run from your project root directory

## Troubleshooting

**Agents not receiving prompts**:
- Use `--debug` flag to see what's being captured from Claude
- The tool now uses simpler detection and trusts timing
- Prompts are sent after a 10-second initialization period
- Check tmux with: `tmux attach -t claude_agents`

**Agents not starting**: 
- The tool now continues even if ready detection fails
- Check if `claude --dangerously-skip-permissions` works manually
- Try running with `--debug` to see initialization output
- The tool uses the `--dangerously-skip-permissions` flag to avoid prompts

**tmux errors**:
- Ensure tmux is installed: `sudo apt install tmux` or `brew install tmux`
- Check for existing sessions: `tmux ls` and kill if needed: `tmux kill-session -t claude_agents`

**Coordination issues**:
- Check `/tmp/claude_coordination/` for lock files
- Use `--no-cleanup` to preserve coordination files for debugging

**Debug mode**:
```bash
python multi_claude.py -n 2 -p "Test prompt" --debug
```
This shows:
- What text is captured from Claude Code
- Whether agents are detected as ready
- Prompt delivery confirmation

## Differences from claude_code_agent_farm

This tool is a simplified version focusing on ease of use:
- Single Python file (vs. complex package structure)
- No configuration files needed
- No monitoring dashboard
- No auto-restart or error recovery
- Basic coordination only
- Minimal dependencies

Choose this tool for quick parallel tasks. Use claude_code_agent_farm for production workloads requiring robustness.