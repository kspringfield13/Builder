<div align="center">

**Orchestrate AI Agents. Build Complex Applications. Autonomously.**

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](https://github.com/yourusername/builder)
[![Python](https://img.shields.io/badge/python-3.8+-green.svg)](https://www.python.org/downloads/)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](LICENSE)
[![Status](https://img.shields.io/badge/status-beta-orange.svg)]()
[![Claude](https://img.shields.io/badge/powered%20by-Claude-yellow.svg)](https://claude.ai)

<img src="https://raw.githubusercontent.com/kspringfield13/builder/main/assets/builder-hero.png" alt="Builder Hero" width="800"/>

[**Quick Start**](#-quick-start) • [**Features**](#-features) • [**Installation**](#-installation) • [**Usage**](#-usage) • [**Examples**](#-examples) • [**Docs**](docs/)

</div>

---

## 📚 Table of Contents

<table>
<tr>
<td width="33%" valign="top">

### 🎯 Getting Started
- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [First Build](#your-first-build)

</td>
<td width="33%" valign="top">

### 🛠️ Core Features
- [Builder Orchestrator](#builder-orchestrator)
- [Multi-Claude Agents](#multi-claude-agents)
- [Speed Profiles](#speed-profiles)

</td>
<td width="33%" valign="top">

### 📖 Resources
- [Examples](#-examples)
- [Advanced Usage](#-advanced-usage)
- [Contributing](#-contributing)

</td>
</tr>
</table>

---

## 🎉 What is Builder?

Builder is a powerful orchestration system that manages autonomous Claude AI sessions to build complex applications. It combines two complementary tools:

1. **Builder** - Sequential orchestration of Claude sessions with smart idle detection, session recovery, and SQLite-powered state management
2. **Multi-Claude** - Parallel execution of multiple Claude agents for collaborative development and faster completion

Whether you're building a full-stack application, refactoring a codebase, or implementing complex features, Builder handles the orchestration while you focus on the vision.

---

## ⚡ Quick Start

Get up and running in under 2 minutes:

```bash
# Clone the repository
git clone https://github.com/yourusername/builder.git
cd builder

# Install Builder
pip install -e .

# Initialize Builder
builder init

# Start your first build
builder start
```

That's it! Builder will guide you through selecting a prompt and begin orchestrating your AI agents.

---

## ✨ Features

### 🏗️ Builder Orchestrator

- **🔄 Async Architecture** - Built on Python's asyncio for efficient concurrent operations
- **💾 SQLite Session Management** - Robust tracking of all sessions, steps, and events
- **📝 YAML Prompt Support** - Clean, structured prompts with metadata and time estimates
- **🔍 Smart Idle Detection** - Automatically continues when Claude is waiting
- **⏸️ Session Recovery** - Resume interrupted builds exactly where they left off
- **📊 Rich CLI Interface** - Beautiful terminal output with progress tracking

### 🤖 Multi-Claude Agents

- **⚡ Parallel Execution** - Run 1-20 Claude agents simultaneously
- **🎯 Flexible Task Distribution** - Sequential, collaborative, or bundled step modes
- **📁 File-Based Coordination** - Agents coordinate to avoid conflicts
- **🖥️ Tmux Integration** - Monitor all agents in real-time
- **🛡️ Graceful Shutdown** - Ctrl+C cleanly stops all agents

### 🎨 Modern Development Experience

- **🚀 Speed Profiles** - Fast (5min), Normal (10min), or Careful (20min) modes
- **📋 Multiple Prompt Formats** - Support for YAML and text prompts
- **🔧 Extensible Architecture** - Easy to add new features and integrations
- **📈 Progress Monitoring** - Real-time status updates and session tracking
- **🎯 Smart Defaults** - Works out of the box with sensible configurations

---

## 📦 Installation

### Prerequisites

- Python 3.8 or higher
- tmux (for Multi-Claude)
- Claude CLI installed and configured

### Install Builder

```bash
# Clone the repository
git clone https://github.com/yourusername/builder.git
cd builder

# Install in development mode
pip install -e .

# Or install with all extras
pip install -e ".[dev,web]"
```

### Verify Installation

```bash
# Check Builder
builder --version

# Check Multi-Claude
python multi_claude.py --help

# Verify Claude CLI
claude --version
```

---

## 🚀 Usage

### Builder Orchestrator

#### Your First Build

```bash
# Interactive prompt selection
builder start

# Use a specific prompt
builder start prompts/my-app.yaml

# Fast mode for quick iterations
builder start --speed fast
```

#### Managing Sessions

```bash
# Check current status
builder status

# List all sessions
builder list

# Attach to a running session
builder attach <session-id>

# Resume an interrupted session
builder start --resume <session-id>
```

#### Working with Prompts

```bash
# List available prompts
builder prompt list

# Convert text prompt to YAML
builder prompt convert old.txt new.yaml

# Validate a prompt
builder prompt validate my-prompt.yaml
```

### Multi-Claude Agents

#### Basic Parallel Execution

```bash
# Run 5 agents with a simple task
python multi_claude.py -n 5 -p "Fix all TypeScript errors in the codebase"
```

#### Step-Based Distribution

```bash
# Distribute steps across agents
python multi_claude.py -n 3 -p "Build a dashboard" \
  --steps "Design layout" \
          "Implement components" \
          "Add interactions"
```

#### Collaborative Mode

```bash
# All agents work together
python multi_claude.py -n 4 --prompt-file dashboard.yaml --collaborative
```

---

## 📘 Examples

### Building a Full-Stack Application

```yaml
# prompts/fullstack-app.yaml
name: Modern SaaS Application
description: Build a complete SaaS platform with authentication and payments

initial_prompt: |
  You are building a modern SaaS application using Next.js, TypeScript, and Supabase.
  The app needs user authentication, subscription management, and a beautiful UI.

steps:
  - content: Initialize Next.js project with TypeScript
    estimated_time: 10
  
  - content: Set up Supabase authentication
    estimated_time: 20
    
  - content: Implement subscription management with Stripe
    estimated_time: 30
    
  - content: Create responsive dashboard UI
    estimated_time: 25
    
  - content: Add API endpoints and database schema
    estimated_time: 20
```

Run it:
```bash
# Single orchestrated build
builder start prompts/fullstack-app.yaml

# Or parallel development
python multi_claude.py -n 5 --prompt-file prompts/fullstack-app.yaml --collaborative
```

### Refactoring Legacy Code

```bash
# Parallel refactoring across multiple files
python multi_claude.py -n 8 -p "Refactor JavaScript codebase to TypeScript. Each agent should claim different directories to avoid conflicts."
```

### Implementing Complex Features

```bash
# Bundle related steps for cohesive development
python multi_claude.py -n 3 --prompt-file implement_feature.yaml --bundle-steps 2
```

---

## 🔧 Advanced Usage

### Speed Profiles

Builder offers three speed profiles to match your workflow:

| Profile | Step Interval | Min Duration | Use Case |
|---------|--------------|--------------|----------|
| **Fast** | 5 minutes | 4 minutes | Quick iterations, simple tasks |
| **Normal** | 10 minutes | 8 minutes | Standard development |
| **Careful** | 20 minutes | 15 minutes | Complex builds, careful review |

```bash
# Set speed for a single session
builder start --speed fast

# Or configure default in ~/.builder/config.yaml
default_profile: fast
```

### Session Recovery

Builder automatically saves session state, allowing you to resume interrupted builds:

```bash
# Resume the last interrupted session
builder start --resume

# Resume a specific session
builder start --resume abc123

# View session history
builder list --all
```

### Coordination Modes

Multi-Claude supports three coordination modes:

1. **Sequential** (Default) - Each agent gets the next available step
2. **Collaborative** - All agents see all steps and self-organize
3. **Bundled** - Group related steps together

```bash
# Sequential mode
python multi_claude.py -n 4 --prompt-file build.yaml

# Collaborative mode  
python multi_claude.py -n 4 --prompt-file build.yaml --collaborative

# Bundled mode (2 steps per agent)
python multi_claude.py -n 3 --prompt-file build.yaml --bundle-steps 2
```

### Configuration

Customize Builder behavior in `~/.builder/config.yaml`:

```yaml
# Speed profiles
default_profile: normal

# Paths
prompts_dir: ~/my-prompts
sessions_dir: ~/builder-sessions

# Claude settings
claude_command: claude
claude_args: [--dangerously-skip-permissions]

# Features
auto_continue: true
wait_for_todo: true
archive_completed: true

# Monitoring
enable_web_monitor: false
monitor_port: 8080
```

---

## 🤝 Contributing

We welcome contributions! Here's how to get started:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests (`pytest`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Setup

```bash
# Install development dependencies
pip install -e ".[dev]"

# Run tests
pytest

# Format code
black builder/

# Type checking
mypy builder/
```

## 📄 License

Builder is released under the MIT License. See [LICENSE](LICENSE) for details.

---

<div align="center">

[⬆ Back to Top](#-builder)

</div>
