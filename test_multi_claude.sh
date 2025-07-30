#!/bin/bash

echo "Testing Multi-Agent Claude Code Orchestrator"
echo "==========================================="

# Test 1: Basic help
echo -e "\n[Test 1] Showing help:"
python3 multi_claude.py -h

# Test 2: Simple prompt with 2 agents (dry run - won't actually launch)
echo -e "\n[Test 2] Would run: 2 agents with simple prompt"
echo "Command: python3 multi_claude.py -n 2 -p 'Test prompt' --stagger 2"

# Test 3: Step-based workflow
echo -e "\n[Test 3] Would run: 3 agents with steps"
echo "Command: python3 multi_claude.py -n 3 -p 'Build feature' --steps 'Step 1' 'Step 2' 'Step 3'"

# Test 4: From prompt file
echo -e "\n[Test 4] Would run: 4 agents from prompt file"
echo "Command: python3 multi_claude.py -n 4 --prompt-file example_prompts/fix_typescript_errors.txt"

echo -e "\n[Info] To actually run agents, remove the echo and run the commands directly"
echo "[Info] Make sure you're in a project directory when running"