---
name: 'step-04-report'
description: 'Aggregate review results, assign priorities, and present code review report'

fixStepFile: '~/.claude/workflows/code-review-plus/steps-c/step-05-fix.md'
completeStepFile: '~/.claude/workflows/code-review-plus/steps-c/step-06-complete.md'
---

# Step 4: Report — Aggregate Results and Present Findings

## STEP GOAL:

Aggregate all review results from parallel agents, assign priorities to each finding, present a clear report, and ask the user whether to fix violations or skip.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step, ensure entire file is read
- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}

### Role Reinforcement:

- You are a code review agent performing checklist-based reviews
- You follow the checklist EXACTLY — no subjective opinions allowed
- Every finding MUST reference a specific checklist item

### Step-Specific Rules:

- Focus ONLY on aggregation, prioritization, and report presentation
- FORBIDDEN to add findings not backed by a checklist item
- FORBIDDEN to include subjective opinions or stylistic preferences
- FORBIDDEN to fix any code in this step — report only

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Aggregate Results

- Collect all findings from parallel review agents
- Group findings by file
- Remove duplicate findings (same checklist item, same location)
- Retain the checklist category and item reference for each finding

### 2. Assign Priority

For each finding, assign one priority level:

- **HIGH**: Incorrect behavior, wrong patterns, violations that could cause bugs (e.g., wrong data flow, cache reference violations)
- **MEDIUM**: Naming violations, structural issues, wrong file organization (e.g., type in wrong location, constants inside component)
- **LOW**: Style issues, minor naming inconsistencies

### 3. Present Report

"**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**
**Code Review Report**

**총 파일:** {{file_count}}개
**위반 발견:** {{violation_count}}건 (🔴 High: {{high}}, 🟡 Medium: {{med}}, 🟢 Low: {{low}})

---

**파일별 결과:**

For each file:
**📄 {{file_path}}** — {{status: PASS or FAIL}}
- 🔴/🟡/🟢 [체크리스트 카테고리] 항목: 설명 (라인 {{line}})

**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**"

### 4. Handle No Violations

If zero violations found:

"**All Clear! 모든 파일이 체크리스트를 통과했습니다.**"

Auto-proceed: immediately load, read entire file, then execute {completeStepFile}

### 5. Ask About Fixes (only if violations exist)

"**위반 항목을 수정할까요?**
**[F]** Fix — 위반 항목 자동 수정 진행
**[S]** Skip — 수정 없이 완료"

#### Menu Handling Logic:

- **IF F:** Load, read entire file, then execute {fixStepFile}
- **IF S:** Load, read entire file, then execute {completeStepFile}

#### EXECUTION RULES:

- ALWAYS halt and wait for user input after presenting menu
- Only proceed based on user selection
- Do NOT default to either option

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- All findings collected from parallel agents
- Findings grouped by file with duplicates removed
- Priority (HIGH/MEDIUM/LOW) assigned to every finding
- Clear report presented with checklist item references
- User prompted for fix/skip decision (or auto-proceeded if no violations)

### FAILURE:

- Missing files in report
- No priorities assigned to findings
- Subjective findings included without checklist backing
- Proceeding without user input when violations exist
- Findings without checklist item references

**Master Rule:** Every finding in the report MUST reference a specific checklist item. No exceptions.
