---
name: 'step-02-report'
description: 'Present validation findings and offer to fix via edit mode'

editStep: '../steps-e/step-01-assess.md'
---

# Step 2: Report — Validation Results

## STEP GOAL:

Present validation findings as a clear report and offer to fix issues via edit mode.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}

### Step-Specific Rules:

- Present findings clearly with priorities
- FORBIDDEN to auto-fix — offer edit mode instead

## MANDATORY SEQUENCE

### 1. Present Report

"**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**
**Checklist Validation Report**

**파일:** {file_path}
**총 항목:** {item_count}개
**발견된 이슈:** {issue_count}건 (🔴 High: {high}, 🟡 Medium: {med}, 🟢 Low: {low})

---

For each finding:
🔴/🟡/🟢 **[Check Name]** — {description}
  항목: {specific item or location}
  제안: {suggested fix}

---

**점수:** {pass_count}/{total_checks} 통과
**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**"

### 2. Handle Results

**IF zero issues:**

"**All Clear! 체크리스트가 모든 검증을 통과했습니다.**"

Workflow complete.

**IF issues found:**

"**이슈를 수정할까요?**
**[E]** Edit — 편집 모드로 이슈 수정
**[D]** Done — 수정 없이 완료 (리포트만 확인)"

#### Menu Handling Logic:

- IF E: Load, read entire file, then execute {editStep} with validation findings as context
- IF D: Workflow complete.

#### EXECUTION RULES:

- ALWAYS halt and wait for user input when issues exist
- Auto-complete only when zero issues found

### 3. End

Workflow complete.

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Clear report with severity levels
- All findings presented with specific references
- Edit mode offered when issues exist
- Auto-complete when all checks pass

### FAILURE:

- Unclear or unstructured report
- Auto-fixing without user consent
- Not offering edit mode when issues found

**Master Rule:** Report clearly, offer to fix, never auto-fix.
