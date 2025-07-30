#!/bin/bash

echo "Testing Multi-Claude with Debug Mode"
echo "===================================="
echo ""
echo "This test will:"
echo "1. Run 2 agents with debug output enabled"
echo "2. Use a simple test prompt"
echo "3. Show what's happening at each step"
echo ""
echo "Watch the console output for debug information"
echo ""
read -p "Press Enter to start..."

cd /Users/raivyn/intercoachai

echo ""
echo "Starting multi_claude.py with --debug flag..."
echo ""

python3 /Users/raivyn/Builder/multi_claude.py -n 2 \
  -p "Test prompt. Please respond with: 'Hello from Agent X' where X is your agent ID. Then calculate 2+2." \
  --stagger 3 \
  --debug \
  --no-kill-on-exit

echo ""
echo "Test complete. Check tmux session with: tmux attach -t claude_agents"
echo "Kill session with: tmux kill-session -t claude_agents"