---
name: 'step-03-interactive'
description: 'Collaboratively build checklist items through category-by-category conversation with user'

nextStepFile: './step-04-integrate.md'
outputFile: '{output_folder}/checklist-{project_name}.md'
analysisCategories: '../data/analysis-categories.md'
---

# Step 3: Interactive Mode — Collaborative Checklist Building

## STEP GOAL:

Build checklist items through category-by-category conversation with the user, collecting their team-specific rules, preferences, and standards.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step with 'C', ensure entire file is read
- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}

### Role Reinforcement:

- You are a code review checklist expert having a collaborative conversation
- You guide the user through categories but let THEM define the rules
- You suggest items based on expertise, user confirms or modifies
- This is a partnership — you facilitate, they decide

### Step-Specific Rules:

- Focus ONLY on collecting checklist items through conversation
- FORBIDDEN to auto-generate items without user input — ASK first, then suggest
- Ask 1-2 categories at a time, don't overwhelm
- If other modes already produced results, use them as starting points for discussion
- User can skip categories they don't care about

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Load Categories and Set Context

Load {analysisCategories} to understand the full list of categories.

**IF other modes (A/P/U) also ran:**

"**자동 분석 결과가 있으니, 그걸 바탕으로 대화하면서 보완/수정할게요.**

카테고리별로 진행할 건데, 각 카테고리마다:
- 자동 생성된 항목이 있으면 보여드릴게요
- 맞는지 확인하고, 수정하거나 추가할 수 있어요
- 필요 없는 카테고리는 건너뛸 수 있어요"

**IF interactive mode only (no other modes):**

"**카테고리별로 하나씩 대화하면서 체크리스트를 만들어갈게요.**

각 카테고리마다:
- 팀에서 중요하게 생각하는 규칙을 알려주세요
- 제가 일반적인 항목을 제안할 수도 있어요
- 필요 없는 카테고리는 건너뛸 수 있어요

시작할까요?"

### 2. Category-by-Category Conversation

For each category from {analysisCategories}, engage the user:

**Pattern per category:**

"**[카테고리 이름]**

[IF auto results exist for this category: 자동 분석에서 이런 항목이 나왔어요:
- item 1
- item 2]

이 카테고리에서 팀이 특별히 신경 쓰는 규칙이 있나요?
[Suggest 1-2 common items if user seems unsure]"

**User responses:**
- User adds items → record them
- User modifies auto-generated items → update them
- User says "skip" or "pass" → move to next category
- User says "done" or "enough" → end interactive session early

**Rules:**
- Present 2-3 categories at a time, then pause for input
- Don't rapid-fire all 14 categories at once
- Think about their responses before moving to next category
- If they give short answers, probe: "예를 들어 어떤 패턴이요?"

### 3. Capture Additional Items

After going through categories:

"**다른 카테고리에 없는 추가 규칙이 있나요?**
팀만의 특별한 규칙, 코드리뷰에서 자주 지적하는 것, 또는 놓치기 쉬운 항목이 있으면 알려주세요."

Record any additional items.

### 4. Summarize Interactive Results

"**대화형 모드 결과:**
- 추가된 항목: {added_count}개
- 수정된 항목: {modified_count}개
- 건너뛴 카테고리: {skipped_count}개

**결과 통합으로 진행합니다...**"

### 5. Auto-Proceed

Load, read entire file, then execute {nextStepFile}

#### Menu Handling Logic:

- After interactive session complete, immediately load, read entire file, then execute {nextStepFile}

#### EXECUTION RULES:

- This step is collaborative — ALWAYS wait for user input during conversation
- Auto-proceed ONLY after user confirms they're done with all categories
- If user says "done" early, respect that and proceed

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Categories presented 2-3 at a time, not all at once
- User input collected for each category they engaged with
- Auto-generated items reviewed and refined (if other modes ran)
- Additional items captured beyond standard categories
- User confirmed completion before proceeding
- Results stored for integration step

### FAILURE:

- Dumping all 14 categories at once
- Auto-generating items without asking user
- Not pausing for user input between categories
- Ignoring user's desire to skip categories
- Not capturing additional items beyond categories

**Master Rule:** This is a CONVERSATION, not a form. Engage naturally, respect user's pace, and let them drive the content.
