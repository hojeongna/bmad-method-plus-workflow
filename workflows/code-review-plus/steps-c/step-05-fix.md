---
name: 'step-05-fix'
description: 'Fix checklist violations using parallel agents, no deferral allowed'

nextStepFile: '~/.claude/workflows/code-review-plus/steps-c/step-06-complete.md'
parallelAgentsSkill: '~/.claude/skills/dispatching-parallel-agents/SKILL.md'
---

# Step 5: Fix — Resolve Checklist Violations (Parallel)

## STEP GOAL:

Fix checklist violations identified in the report using parallel agents (one agent per file). Filter findings by the fixScope selected in step-04, then fix ALL items in that scope without exception.

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
- 🛑 **NO DEFERRAL**: NEVER skip, defer, or reserve a fix for any reason
- 🛑 **NO EXCUSES**: "범위가 크다", "리팩토링 대상", "복잡한 변경" 등의 사유로 수정을 건너뛰는 것 절대 금지
- 🛑 선택된 fixScope 내의 모든 항목은 반드시 수정 완료해야 함

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Filter Findings by Scope

Apply the fixScope from step-04:

- **fixScope='ALL'**: Include ALL findings (HIGH + MEDIUM + LOW, SMALL + LARGE)
- **fixScope='SMALL'**: Include only SMALL scope findings (any priority)
- **fixScope='HIGH'**: Include only HIGH priority findings (any scope)

Group filtered findings by file.

Present fix plan:

"**수정 계획 (scope: {{fixScope}}):**
🔴 High: {{high_count}}건
🟡 Medium: {{med_count}}건
🟢 Low: {{low_count}}건
📁 대상 파일: {{file_count}}개
**병렬 수정을 시작합니다...**"

### 2. Load Parallel Agents Skill

- Use Read tool to load the FULL content of {parallelAgentsSkill}
- Read the skill completely — do not skim or skip sections
- Follow the skill's dispatch pattern for agent creation

"**Parallel agents skill loaded. Preparing fix agents...**"

### 3. Prepare Agent Prompts

For each file with filtered findings, prepare an agent prompt containing:

1. **File path:** The specific file this agent must fix
2. **Findings list:** ALL filtered findings for this file — checklist category, item, line number, description, how to fix
3. **Fix instruction:** "Read the file completely using the Read tool. Apply ALL fixes listed below. For each fix: (1) locate the violation, (2) apply the minimum change to resolve it, (3) verify the fix does not break surrounding code. Do NOT skip any fix. Do NOT defer any fix regardless of scope or complexity."
4. **Scope constraint:** "Fix ONLY the assigned file. Do NOT modify other files. Do NOT add improvements beyond what is listed."
5. **No-deferral rule:** "You MUST fix every item assigned to you. Reporting a fix as 'too complex' or 'requires refactoring' is FORBIDDEN. Apply the fix now."
6. **Expected output format:** "Return a list of fixes applied: (1) checklist item reference, (2) what was changed, (3) line numbers affected. If a fix truly cannot be applied (e.g., file deleted, syntax conflict), report the specific technical reason — but 'too large' or 'too complex' is NOT a valid reason."

### 4. Dispatch Agents

- Dispatch one agent per file using the Agent tool
- Each agent fixes its file independently and in isolation
- Do NOT batch multiple files into a single agent

"**{{agent_count}}개 수정 에이전트 디스패치 완료. 병렬 수정 진행 중...**"

### 5. Collect Results and Verify

When all agents return:

- Collect all fix results from every agent
- Verify each finding was addressed
- Flag any items reported as unfixed with their reason
- If any agent deferred a fix without valid technical reason: report as SYSTEM FAILURE

### 6. Report Fix Results

"**수정 완료**
- 수정됨: {{fixed_count}}건
- 수정 불가: {{unfixed_count}}건 (있으면 목록 + 사유)

**완료 단계로 진행합니다...**"

### 7. Auto-Proceed

Immediately load, read entire file, then execute {nextStepFile}

#### Menu Handling Logic:

- After fixes reported, immediately proceed to {nextStepFile} (step-06-complete)

#### EXECUTION RULES:

- This is an auto-proceed step — do not wait for user input
- Wait for ALL agents to complete before proceeding
- Do NOT proceed with partial results
- Proceed to completion step after reporting results

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Findings correctly filtered by fixScope
- Parallel agents skill loaded via Read tool
- One fix agent dispatched per file
- All agents completed their fixes
- ALL items in selected scope were fixed — zero deferrals
- Each fix corresponds to a specific checklist finding
- Fix results reported clearly
- Auto-proceeded to step-06-complete

### FAILURE:

- Fixing things not in the findings
- Over-engineering fixes beyond what is needed
- Adding features or refactoring during fixes
- Skipping or deferring ANY fix in the selected scope
- Reporting a fix as "too complex" or "too large" without a concrete technical blocker
- Not loading parallel agents skill
- Not dispatching agents in parallel
- Proceeding before all agents complete
- Not verifying fixes after applying

**Master Rule:** Fix ONLY checklist violations. Fix ALL of them in the selected scope. No deferral. No excuses. Any skipped fix is SYSTEM FAILURE.
