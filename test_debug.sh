#!/bin/bash

echo "Testing Multi-Claude with Debug Output"
echo "====================================="
echo ""
echo "This test will:"
echo "1. Launch 2 agents with a simple prompt"
echo "2. Show debug output to verify prompt delivery"
echo "3. Automatically attach to tmux session"
echo ""
echo "To detach from tmux: Press Ctrl+B then D"
echo ""
read -p "Press Enter to start the test..."

cd /Users/raivyn/intercoachai

echo ""
echo "Starting multi_claude.py..."
echo ""

# Run in background and attach to tmux after a delay
python3 /Users/raivyn/Builder/multi_claude.py -n 2 \
  -p "Hello! Please respond with: 'Agent X received prompt successfully' where X is your agent ID." \
  --stagger 3 &

# Save the PID
MULTI_CLAUDE_PID=$!

# Wait a bit for agents to launch
echo "Waiting for agents to initialize..."
sleep 20

# Attach to tmux session
echo ""
echo "Attaching to tmux session..."
echo "You should see 2 Claude Code agents"
echo "Check if they received and are processing the prompts"
echo ""
tmux attach -t claude_agents

# When user detaches, offer to kill the process
echo ""
echo "Detached from tmux."
read -p "Kill multi_claude process? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    kill $MULTI_CLAUDE_PID 2>/dev/null
    echo "Process terminated."
fi