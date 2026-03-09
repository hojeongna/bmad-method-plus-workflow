#!/bin/bash
# uninstall.sh - Remove BMAD plus workflows, skills, and commands from Claude Code

set -e

CLAUDE_DIR="$HOME/.claude"

echo "=== BMAD Method Plus Workflows Uninstaller ==="
echo ""
echo "This will remove the following from $CLAUDE_DIR:"
echo "  - Skills: test-driven-development, systematic-debugging, dispatching-parallel-agents"
echo "  - Workflows: dev-story-plus, code-review-plus, checklist-for-codereview"
echo "  - Commands: bmad-bmm-dev-story-plus, bmad-bmm-code-review-plus, bmad-bmm-checklist-for-codereview"
echo ""
read -p "Are you sure? (y/N): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Cancelled."
  exit 0
fi

echo ""

# 1. Remove skills
echo "[1/3] Removing skills..."
rm -rf "$CLAUDE_DIR/skills/test-driven-development"
rm -rf "$CLAUDE_DIR/skills/systematic-debugging"
rm -rf "$CLAUDE_DIR/skills/dispatching-parallel-agents"
echo "  - test-driven-development removed"
echo "  - systematic-debugging removed"
echo "  - dispatching-parallel-agents removed"

# 2. Remove workflows
echo "[2/3] Removing workflows..."
rm -rf "$CLAUDE_DIR/workflows/dev-story-plus"
rm -rf "$CLAUDE_DIR/workflows/code-review-plus"
rm -rf "$CLAUDE_DIR/workflows/checklist-for-codereview"
echo "  - dev-story-plus removed"
echo "  - code-review-plus removed"
echo "  - checklist-for-codereview removed"

# 3. Remove commands
echo "[3/3] Removing commands..."
rm -f "$CLAUDE_DIR/commands/bmad-bmm-dev-story-plus.md"
rm -f "$CLAUDE_DIR/commands/bmad-bmm-code-review-plus.md"
rm -f "$CLAUDE_DIR/commands/bmad-bmm-checklist-for-codereview.md"
echo "  - bmad-bmm-dev-story-plus command removed"
echo "  - bmad-bmm-code-review-plus command removed"
echo "  - bmad-bmm-checklist-for-codereview command removed"

echo ""
echo "=== Uninstall Complete ==="
echo ""
echo "BMAD Method Plus Workflows have been removed."
echo "To reinstall, run: bash install.sh"
