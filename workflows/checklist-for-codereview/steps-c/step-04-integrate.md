---
name: 'step-04-integrate'
description: 'Merge all mode results into a single unified checklist, resolving duplicates and conflicts'

nextStepFile: './step-05-finalize.md'
outputFile: '{output_folder}/checklist-{project_name}.md'
analysisCategories: '../data/analysis-categories.md'
advancedElicitationTask: '{project-root}/_bmad/core/workflows/advanced-elicitation/workflow.xml'
partyModeWorkflow: '{project-root}/_bmad/core/workflows/party-mode/workflow.md'
---

# Step 4: Integrate — Merge All Results

## STEP GOAL:

Merge checklist items from all executed modes into a single, unified checklist. Remove duplicates, resolve conflicts, and organize by category.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step with 'C', ensure entire file is read
- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}

### Role Reinforcement:

- You are a code review checklist expert performing systematic integration
- You merge results objectively — no adding your own items
- Every item in the final checklist must trace back to a mode result

### Step-Specific Rules:

- Focus ONLY on merging, deduplicating, and organizing
- FORBIDDEN to add new items not from any mode result
- FORBIDDEN to remove items without user confirmation
- When items conflict, present both and let user decide
- Prescriptive approach: follow integration rules exactly

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Collect All Results

Gather checklist items from all executed modes:
- Mode A (Project Analysis) results — if executed
- Mode P (PR Review Mining) results — if executed
- Mode U (Universal) results — if executed
- Mode I (Interactive) results — if executed

"**통합 시작. 모드별 결과:**
- [Mode A]: {count_a}개 항목
- [Mode P]: {count_p}개 항목
- [Mode U]: {count_u}개 항목
- [Mode I]: {count_i}개 항목
- **총 합계:** {total}개 항목"

### 2. Deduplicate

Compare items across all modes:

**Exact duplicates:** Remove, keep one copy
**Near duplicates (same intent, different wording):** Merge into the most specific/clear version
**Overlapping items:** Combine into a single comprehensive item

"**중복 제거 결과:**
- 정확한 중복: {exact}개 제거
- 유사 항목 병합: {near}개 → {merged}개
- **중복 제거 후:** {after_dedup}개 항목"

### 3. Resolve Conflicts

Identify items that contradict each other across modes:

**Example conflicts:**
- Mode A found: "Components use default exports"
- Mode U suggests: "Components should use named exports"

For each conflict:

"**충돌 발견:**

항목 1 (프로젝트 분석): [item from mode A]
항목 2 (범용): [item from mode U]

어떤 걸 채택할까요?
**[1]** 항목 1 유지
**[2]** 항목 2 유지
**[B]** 둘 다 유지 (상황별 적용)
**[N]** 둘 다 제거"

Wait for user input on each conflict.

### 4. Organize by Category

Group all surviving items by category:
- Use categories from {analysisCategories} as primary structure
- Items that don't fit existing categories → create new category or "기타"
- Order categories logically
- Order items within each category by importance (critical → nice-to-have)

### 5. Present Integrated Checklist Preview

"**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**
**통합 체크리스트 미리보기**

**총 항목:** {final_count}개
**카테고리:** {category_count}개
**출처:** [list of modes used]

---

For each category:
**## [Category Name]** ({item_count}개)
- [ ] [item 1]
- [ ] [item 2]
...

**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**"

### 6. Present MENU OPTIONS

Display: **통합 결과를 검토하세요:**
**[A]** Advanced Elicitation — 더 깊이 분석
**[P]** Party Mode
**[C]** Continue — 최종 검토로 진행

#### EXECUTION RULES:

- ALWAYS halt and wait for user input after presenting menu
- ONLY proceed to next step when user selects 'C'
- User can request changes before proceeding

#### Menu Handling Logic:

- IF A: Execute {advancedElicitationTask}, and when finished redisplay the menu
- IF P: Execute {partyModeWorkflow}, and when finished redisplay the menu
- IF C: Save integrated checklist, then load, read entire file, then execute {nextStepFile}
- IF user requests changes: Apply changes, re-present preview, then redisplay menu

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- All mode results collected and counted
- Exact and near duplicates identified and removed
- Conflicts presented to user with clear options
- Items organized by category logically
- Integrated preview presented clearly
- User confirmed before proceeding

### FAILURE:

- Adding items not from any mode result
- Removing items without user confirmation
- Not detecting duplicates across modes
- Silently resolving conflicts without asking user
- Presenting unorganized/uncategorized list

**Master Rule:** Integration is mechanical and transparent. Every merge, dedup, and conflict resolution must be visible to the user.
