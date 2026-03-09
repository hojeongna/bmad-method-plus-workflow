# BMAD Method Plus Workflows

Extended workflow collection for BMAD BMM — adds TDD enforcement, parallel agent dispatching, checklist-based code review, and automated checklist generation to your Claude Code projects.

## Included Workflows

### 1. dev-story-plus

Story implementation workflow with TDD enforcement and parallel agent dispatching.

- **TDD Skill Enforcement**: Loads `test-driven-development` skill before implementation — RED-GREEN-REFACTOR is mandatory
- **Parallel Agent Dispatching**: Automatically dispatches parallel agents when 2+ independent tasks are detected
- **Multi-Session Support**: Resume previous sessions via step-01b-continue
- **Systematic Debugging**: Loads debugging skill on test failures

### 2. code-review-plus

Checklist-based code review — zero subjective judgment allowed.

- **Checklist Required**: Must provide a checklist `.md` file — workflow HALTs without one
- **No Subjective Opinions**: If it's not in the checklist, it's not a finding
- **Parallel File Review**: Each file reviewed by an independent agent in parallel
- **Scope-Based Fix Options**: Choose fix scope after review:
  - `[F]` Full — fix ALL findings, no exceptions
  - `[S]` Small — fix small-scope items only
  - `[H]` High — fix HIGH priority items only
  - `[X]` Skip — complete without fixes
- **Parallel Fix Execution**: Fix agents dispatched per-file in parallel (mirrors review pattern)
- **No Deferral Policy**: Selected scope items are fixed unconditionally — "too complex" or "needs refactoring" is never an excuse
- **Priority Classification**: HIGH / MEDIUM / LOW for every finding
- **Scope Classification**: SMALL / LARGE for every finding
- **3 Review Sources**: Story document / git diff / manual file list

### 3. checklist-for-codereview

Generate, edit, or validate code review checklists for use with `code-review-plus`.

- **3 Modes**: Create / Edit / Validate
- **4 Generation Sources** (combinable):
  - Project analysis — scan codebase for patterns and conventions
  - GitHub PR review mining — extract patterns from past PR reviews
  - Interactive Q&A — collaborative checklist building with user input
  - Universal best practices — common code quality patterns
- **Parallel Execution**: Automatic modes (project analysis, PR mining, universal) run as parallel agents
- **Direct Compatibility**: Output is structured for immediate use by `code-review-plus`
- **Tri-Modal Architecture**: Separate step folders for create (`steps-c/`), edit (`steps-e/`), and validate (`steps-v/`)

## Included Skills

Sourced from [obra/superpowers](https://github.com/obra/superpowers):

| Skill | Description |
|-------|-------------|
| `test-driven-development` | RED-GREEN-REFACTOR TDD process + testing anti-patterns guide |
| `systematic-debugging` | 4-phase systematic debugging + root cause tracing + defensive validation |
| `dispatching-parallel-agents` | Parallel agent dispatch patterns for independent tasks |

## Installation

### Automatic

```bash
git clone https://github.com/hojeongna/bmad-method-plus-workflow.git
cd bmad-method-plus-workflow
bash install.sh
```

### Manual

```bash
# Copy skills
cp -r skills/* ~/.claude/skills/

# Copy workflows
mkdir -p ~/.claude/workflows
cp -r workflows/* ~/.claude/workflows/

# Copy commands
cp commands/* ~/.claude/commands/
```

### Update

Re-run `install.sh` to update all installed files:

```bash
bash install.sh
```

## Installed File Structure

```
~/.claude/
├── commands/
│   ├── bmad-bmm-dev-story-plus.md
│   ├── bmad-bmm-code-review-plus.md
│   └── bmad-bmm-checklist-for-codereview.md
├── workflows/
│   ├── dev-story-plus/
│   │   ├── workflow.md
│   │   ├── steps-c/ (8 step files)
│   │   └── data/checklist.md
│   ├── code-review-plus/
│   │   ├── workflow.md
│   │   └── steps-c/ (6 step files)
│   └── checklist-for-codereview/
│       ├── workflow.md
│       ├── steps-c/ (5 step files)
│       ├── steps-e/ (3 step files)
│       ├── steps-v/ (2 step files)
│       └── data/ (analysis-categories.md, checklist-template.md)
└── skills/
    ├── test-driven-development/
    │   ├── SKILL.md
    │   └── testing-anti-patterns.md
    ├── systematic-debugging/
    │   ├── SKILL.md
    │   ├── root-cause-tracing.md
    │   ├── defense-in-depth.md
    │   └── condition-based-waiting.md
    └── dispatching-parallel-agents/
        └── SKILL.md
```

## Usage

In any project with BMAD BMM installed:

```
# Story implementation (TDD + parallel agents)
/bmad-bmm-dev-story-plus

# Checklist-based code review
/bmad-bmm-code-review-plus

# Generate/edit/validate code review checklists
/bmad-bmm-checklist-for-codereview
```

## Requirements

- [Claude Code](https://claude.com/claude-code) CLI
- [BMAD Method](https://github.com/bmadcode/BMAD-METHOD) BMM module installed in your project (`_bmad/bmm/config.yaml` required)

## Workflow Flows

### dev-story-plus

```
step-01-init (or step-01b-continue)
    ↓
step-02-setup
    ↓
step-03-analyze ← ─ ─ ─ ─ ─ ─ ─ ┐
    ↓ (parallel or sequential)    │ (loop if tasks remain)
step-04-implement                 │
    ↓                             │
step-05-validate ─ ─ ─ ─ ─ ─ ─ ─ ┘
    ↓ (all tasks done)
step-06-completion
    ↓
step-07-communicate (END)
```

### code-review-plus

```
step-01-init
    │ Load checklist (HALT if none)
    │ Select source: [S] Story / [D] Git diff / [M] Manual
    ↓
step-02-collect
    │ Collect files by source type
    ↓
step-03-review
    │ Parallel agent dispatch (one per file)
    │ Each agent: review against full checklist only
    ↓
step-04-report
    │ Aggregate results
    │ Assign priority (HIGH/MEDIUM/LOW)
    │ Assign scope (SMALL/LARGE)
    │ Present report
    │   [F] Full fix    → step-05
    │   [S] Small only  → step-05
    │   [H] High only   → step-05
    │   [X] Skip        → step-06
    ↓
step-05-fix (parallel)
    │ Filter findings by selected scope
    │ Parallel agent dispatch (one per file)
    │ No deferral — all items in scope MUST be fixed
    ↓
step-06-complete (END)
    │ Update story status (if story-based)
    │ Completion summary
```

### checklist-for-codereview

**Create mode:**

```
step-01-init
    │ Select generation modes (combinable)
    ↓
step-02-execute
    │ Run selected modes as parallel agents
    │ (project analysis, PR mining, universal)
    ↓
step-03-interactive
    │ Interactive Q&A with user
    ↓
step-04-integrate
    │ Merge all sources into unified checklist
    ↓
step-05-finalize (END)
    │ Output checklist md file
```

**Edit mode:** `step-01-assess` → `step-02-edit` → `step-03-complete`

**Validate mode:** `step-01-validate` → `step-02-report`
