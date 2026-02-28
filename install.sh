#!/bin/bash
# install.sh - Install BMAD plus workflows, skills, and commands globally for Claude Code

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "=== BMAD Method Plus Workflows Installer ==="
echo ""

# 1. Install skills
echo "[1/3] Installing global skills..."
mkdir -p "$CLAUDE_DIR/skills/test-driven-development"
mkdir -p "$CLAUDE_DIR/skills/systematic-debugging"
mkdir -p "$CLAUDE_DIR/skills/dispatching-parallel-agents"

cp "$SCRIPT_DIR/skills/test-driven-development/"* "$CLAUDE_DIR/skills/test-driven-development/"
cp "$SCRIPT_DIR/skills/systematic-debugging/"* "$CLAUDE_DIR/skills/systematic-debugging/"
cp "$SCRIPT_DIR/skills/dispatching-parallel-agents/"* "$CLAUDE_DIR/skills/dispatching-parallel-agents/"
echo "  - test-driven-development (SKILL.md + testing-anti-patterns.md)"
echo "  - systematic-debugging (SKILL.md + 3 reference files)"
echo "  - dispatching-parallel-agents (SKILL.md)"

# 2. Install workflows
echo "[2/3] Installing workflows..."

# dev-story-plus
mkdir -p "$CLAUDE_DIR/workflows/dev-story-plus/steps-c"
mkdir -p "$CLAUDE_DIR/workflows/dev-story-plus/data"
cp "$SCRIPT_DIR/workflows/dev-story-plus/workflow.md" "$CLAUDE_DIR/workflows/dev-story-plus/"
cp "$SCRIPT_DIR/workflows/dev-story-plus/steps-c/"* "$CLAUDE_DIR/workflows/dev-story-plus/steps-c/"
cp "$SCRIPT_DIR/workflows/dev-story-plus/data/"* "$CLAUDE_DIR/workflows/dev-story-plus/data/"
echo "  - dev-story-plus (workflow.md + 8 step files + checklist)"

# code-review-plus
mkdir -p "$CLAUDE_DIR/workflows/code-review-plus/steps-c"
cp "$SCRIPT_DIR/workflows/code-review-plus/workflow.md" "$CLAUDE_DIR/workflows/code-review-plus/"
cp "$SCRIPT_DIR/workflows/code-review-plus/steps-c/"* "$CLAUDE_DIR/workflows/code-review-plus/steps-c/"
echo "  - code-review-plus (workflow.md + 6 step files)"

# 3. Install commands
echo "[3/3] Installing global commands..."
mkdir -p "$CLAUDE_DIR/commands"
cp "$SCRIPT_DIR/commands/bmad-bmm-dev-story-plus.md" "$CLAUDE_DIR/commands/"
cp "$SCRIPT_DIR/commands/bmad-bmm-code-review-plus.md" "$CLAUDE_DIR/commands/"
echo "  - /bmad-bmm-dev-story-plus command"
echo "  - /bmad-bmm-code-review-plus command"

echo ""
echo "=== Installation Complete! ==="
echo ""
echo "Available commands in any BMAD BMM project:"
echo "  /bmad-bmm-dev-story-plus    - TDD + parallel agent story implementation"
echo "  /bmad-bmm-code-review-plus  - Checklist-based code review"
echo ""
echo "Requirement: Project must have _bmad/bmm/config.yaml (BMAD BMM installed)"
