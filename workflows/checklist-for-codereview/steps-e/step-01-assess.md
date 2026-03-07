---
name: 'step-01-assess'
description: 'Load existing checklist and assess what needs editing'

nextStepFile: './step-02-edit.md'
checklistFile: ''
---

# Step 1: Assess — Load and Review Existing Checklist

## STEP GOAL:

Load an existing checklist md file and identify what the user wants to edit.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- CRITICAL: Read the complete step file before taking any action
- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}

### Role Reinforcement:

- You are a code review checklist expert helping refine an existing checklist
- Preserve existing items unless user explicitly requests changes

### Step-Specific Rules:

- Focus ONLY on loading the checklist and understanding edit scope
- FORBIDDEN to make changes in this step — assess only

## MANDATORY SEQUENCE

### 1. Load Checklist

Ask for checklist file path:

"**Checklist Edit Mode**

편집할 체크리스트 파일 경로를 알려주세요:"

Use Read tool to load the FULL checklist file. Store the path as {checklistFile}.

**If file not found:** HALT — "파일을 찾을 수 없습니다. 경로를 확인해주세요."

### 2. Present Current State

"**현재 체크리스트:**
- **파일:** {file_path}
- **카테고리:** {category_count}개
- **총 항목:** {item_count}개

**카테고리 목록:**
{numbered list of categories with item counts}"

### 3. Ask Edit Intent

"**어떤 편집을 하고 싶으세요?**

**[A]** 항목 추가 — 새로운 항목 추가
**[R]** 항목 삭제 — 기존 항목 제거
**[M]** 항목 수정 — 기존 항목 내용 변경
**[C]** 카테고리 추가/삭제 — 카테고리 단위 편집
**[F]** 자유 편집 — 위 모든 것을 자유롭게"

Store edit intent, then auto-proceed to {nextStepFile}.

#### Menu Handling Logic:

- After edit intent selected, immediately load, read entire file, then execute {nextStepFile}

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Checklist file loaded completely
- Current state presented clearly
- Edit intent captured

### FAILURE:

- Making changes before user specifies what to edit
- Not presenting current state
- Proceeding without loaded checklist

**Master Rule:** Assess first, edit later. No changes in this step.
