#!/bin/bash

echo "Multi-Claude Example: Simple Task"
echo "================================="
echo ""
echo "This example shows how to use multi_claude.py for a simple task"
echo ""

cd /Users/raivyn/intercoachai

# Example 1: Basic code analysis
echo "Example 1: Code Analysis (2 agents)"
echo "-----------------------------------"
cat << 'EOF'
python3 /Users/raivyn/Builder/multi_claude.py -n 2 \
  -p "Analyze the codebase structure and provide a summary of:
1. Main components and their purposes
2. Key dependencies
3. Overall architecture pattern
Each agent should focus on different aspects."
EOF

echo ""
echo "Example 2: Parallel Bug Fixing (4 agents)"
echo "-----------------------------------------"
cat << 'EOF'
python3 /Users/raivyn/Builder/multi_claude.py -n 4 \
  -p "Find and fix linting errors in the codebase. 
Before starting, check /tmp/claude_coordination/work_claims/ to avoid conflicts.
Claim the files you'll work on by creating a lock file.
Run the linter, fix issues in your claimed files, then test your changes."
EOF

echo ""
echo "Example 3: Feature Implementation with Steps (3 agents)"
echo "------------------------------------------------------"
cat << 'EOF'
python3 /Users/raivyn/Builder/multi_claude.py -n 3 \
  -p "Implement a logging system for the application" \
  --steps "Design the logging architecture" \
          "Implement core logging module" \
          "Add logging to existing components" \
          "Create configuration for log levels" \
          "Write tests for the logging system"
EOF

echo ""
echo "To run any example, copy and paste the command above."
echo "Use --debug flag if you encounter issues."