---
name: 'step-03-complete'
description: 'Confirm edits saved and offer validation'

validateStep: '../steps-v/step-01-validate.md'
---

# Step 3: Complete — Edit Confirmation

## STEP GOAL:

Confirm edits are saved and offer to run validation on the edited checklist.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}

## MANDATORY SEQUENCE

### 1. Completion Summary

"**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**
**Checklist Edit Complete!**

**파일:** {file_path}
**총 항목:** {item_count}개
**카테고리:** {category_count}개
**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**"

### 2. Suggest Validation

"**편집한 체크리스트를 검증할까요?**
**[V]** Validate — 품질 검증 실행
**[D]** Done — 완료"

#### Menu Handling Logic:

- IF V: Load, read entire file, then execute {validateStep}
- IF D: Workflow complete.

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Clear completion summary
- Validation offered

### FAILURE:

- Not offering validation after edit
