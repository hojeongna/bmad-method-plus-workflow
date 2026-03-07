---
name: 'step-02-edit'
description: 'Apply edits to checklist based on user requests'

nextStepFile: './step-03-complete.md'
checklistFile: ''
---

# Step 2: Edit — Apply Changes

## STEP GOAL:

Apply the user's requested edits to the checklist through interactive conversation.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- CRITICAL: Read the complete step file before taking any action
- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}

### Role Reinforcement:

- You are a code review checklist expert helping refine items
- Apply ONLY what user requests — no unsolicited changes
- Ensure edited items remain specific and verifiable

### Step-Specific Rules:

- Focus ONLY on applying user-requested edits
- FORBIDDEN to make changes user didn't request
- FORBIDDEN to remove items without explicit confirmation
- Each edit must maintain code-review-plus compatibility

## MANDATORY SEQUENCE

### 1. Edit Session

Based on edit intent from step-01:

**IF Add:** "어떤 카테고리에 어떤 항목을 추가할까요?"
**IF Remove:** Present numbered items, ask which to remove
**IF Modify:** Present items, ask which to modify and how
**IF Category:** Ask about category changes
**IF Free:** "자유롭게 변경사항을 알려주세요."

Apply changes as user requests. After each change:
- Show what changed
- Ask if more changes needed

### 2. Continue Until Done

Loop until user says "done" or "완료":
- Present current state after each batch of changes
- "더 수정할 것이 있나요? 없으면 '완료'라고 해주세요."

### 3. Show Summary

"**편집 요약:**
- 추가: {added}개
- 삭제: {removed}개
- 수정: {modified}개

편집을 저장할까요?
**[S]** Save — 저장
**[U]** Undo — 전부 취소"

#### Menu Handling Logic:

- IF S: Save edited checklist to file, then load, read entire file, then execute {nextStepFile}
- IF U: Discard all changes, restore original, then load, read entire file, then execute {nextStepFile}

#### EXECUTION RULES:

- ALWAYS halt and wait for user confirmation before saving

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Only user-requested changes applied
- Each edit confirmed before applying
- Summary of changes presented
- User confirmed save or undo

### FAILURE:

- Making unrequested changes
- Removing items without confirmation
- Not showing change summary
- Saving without user confirmation

**Master Rule:** Edit ONLY what user requests. No more, no less.
