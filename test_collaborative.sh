#!/bin/bash

echo "Testing Collaborative Mode"
echo "========================="
echo ""
echo "This test demonstrates collaborative mode where all agents"
echo "see all steps and coordinate their work."
echo ""

cd /Users/raivyn/intercoachai

# Create a simple test YAML
cat > /tmp/test_collaborative.yaml << 'EOF'
name: Collaborative Test
description: Test collaborative development

initial_prompt: |
  This is a test of collaborative mode.
  Multiple agents will work together on these tasks.

steps:
  - content: Analyze the project structure
    description: Understand the codebase organization
    
  - content: Identify improvement areas
    description: Find areas that need enhancement
    
  - content: Create a simple utility function
    description: Add a helpful utility to the project
    
  - content: Document your findings
    description: Create notes about what you discovered
EOF

echo "Running collaborative mode test..."
echo ""
echo "Command:"
echo "python3 /Users/raivyn/Builder/multi_claude.py -n 3 \\"
echo "  --prompt-file /tmp/test_collaborative.yaml \\"
echo "  --collaborative --debug"
echo ""
read -p "Press Enter to start..."

python3 /Users/raivyn/Builder/multi_claude.py -n 3 \
  --prompt-file /tmp/test_collaborative.yaml \
  --collaborative \
  --debug \
  --no-kill-on-exit

echo ""
echo "Test complete. Check:"
echo "- tmux session: tmux attach -t claude_agents"
echo "- Coordination files: ls -la /tmp/claude_coordination/"
echo ""
echo "To clean up: tmux kill-session -t claude_agents"