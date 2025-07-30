#!/bin/bash

echo "Testing Multi-Claude with a simple prompt"
echo "========================================="
echo ""
echo "This will launch 2 agents with a test prompt."
echo "Watch the tmux session to see if prompts are sent correctly."
echo ""
echo "To view: tmux attach -t claude_agents"
echo "To exit tmux view: Ctrl+B then D"
echo ""
read -p "Press Enter to continue..."

cd /Users/raivyn/intercoachai

python3 /Users/raivyn/Builder/multi_claude.py -n 2 \
  -p "Test prompt. Please respond with 'Hello, I am agent X and I received your prompt successfully.'" \
  --stagger 3