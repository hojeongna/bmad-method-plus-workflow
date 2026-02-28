---
name: 'step-05-fix'
description: 'Fix checklist violations in code, ordered by priority'

nextStepFile: '~/.claude/workflows/code-review-plus/steps-c/step-06-complete.md'
---

# Step 5: Fix — Resolve Checklist Violations

## STEP GOAL:

Fix all checklist violations identified in the report, starting from highest priority, then auto-proceed to completion.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step, ensure entire file is read
- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}

### Role Reinforcement:

- You are a code review agent performing checklist-based fixes
- You fix ONLY what the checklist flagged — nothing more
- Every fix MUST correspond to a specific finding from the report

### Step-Specific Rules:

- Fix ONLY what the checklist flagged — no extra "improvements"
- FORBIDDEN to refactor or change code beyond the violation fix
- FORBIDDEN to add features or make "improvements" not in findings
- FORBIDDEN to re-organize code that was not flagged

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Plan Fixes

- Order violations by priority: HIGH first, then MEDIUM, then LOW
- Group fixes by file to minimize file I/O

Present fix plan:

"**수정 계획:**
🔴 High: {{high_count}}건
🟡 Medium: {{med_count}}건
🟢 Low: {{low_count}}건
**수정을 시작합니다...**"

### 2. Execute Fixes

For each file (ordered by priority of its highest violation):

- Read the file using Read tool
- Apply fixes for ALL violations in this file
- Verify each fix addresses the specific checklist item
- Move to the next file

### 3. Verify Fixes

- After all fixes applied, do a quick re-check of each modified file
- Confirm violations are resolved
- If any fix could not be applied: note it with reason

### 4. Report Fix Results

"**수정 완료**
- 수정됨: {{fixed_count}}건
- 수정 불가: {{unfixed_count}}건 (있으면 목록)

**완료 단계로 진행합니다...**"

### 5. Auto-Proceed

Immediately load, read entire file, then execute {nextStepFile}

#### Menu Handling Logic:

- After fixes reported, immediately proceed to {nextStepFile} (step-06-complete)

#### EXECUTION RULES:

- This is an auto-proceed step — do not wait for user input
- Proceed to completion step after reporting results

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Fix plan presented with correct counts
- All fixable violations corrected
- Fixes applied in priority order (HIGH > MEDIUM > LOW)
- Each fix corresponds to a specific checklist finding
- Fix results reported clearly
- Auto-proceeded to step-06-complete

### FAILURE:

- Fixing things not in the findings
- Over-engineering fixes beyond what is needed
- Adding features or refactoring during fixes
- Skipping HIGH priority fixes
- Not verifying fixes after applying

**Master Rule:** Fix ONLY checklist violations. Nothing more. Any change not tied to a finding is SYSTEM FAILURE.
