---
name: 'step-06-complete'
description: 'Update story status if applicable, ask for story if unknown, and present completion summary'
---

# Step 6: Complete — Final Summary and Status Update

## STEP GOAL:

Update story/sprint status if known, ask user for story document if not provided, then present a clear completion summary.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- CRITICAL: Read the complete step file before taking any action
- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}

### Role Reinforcement:

- You are a code review agent finalizing the review workflow
- If a story document is known, the status update is MANDATORY
- If no story document was provided, you MUST ask the user

### Step-Specific Rules:

- Focus ONLY on status updates and completion summary
- FORBIDDEN to make any code changes in this step
- FORBIDDEN to skip story status update when story_file is known

## EXECUTION PROTOCOLS:

- Follow the MANDATORY SEQUENCE exactly
- HALT and wait for user response when asking about story document
- Do NOT assume user's answer — wait for explicit Y/N
- Only modify story file and sprint-status.yaml — no code changes

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Story Status Update

**IF review_source == "story" (story_file already known):**

- Load the story file using Read tool
- Update story Status from "review" to "done"
- IF {sprint_status} file exists:
  - Load the FULL sprint-status.yaml using Read tool
  - Find the story key
  - Update status from "review" to "done"
  - Save file, preserving ALL comments and structure

"**스토리 상태 업데이트 완료:** review → done"

**IF review_source != "story" (diff or manual):**

Ask the user:

"**리뷰 완료! 혹시 이 리뷰와 관련된 스토리 문서가 있나요?**

**[Y]** 있어요 — 스토리 파일 경로를 알려주세요
**[N]** 없어요 — 바로 완료할게요"

#### Menu Handling Logic:

- IF Y: Ask for story file path, load story file, update Status from "review" to "done". IF {sprint_status} exists, update sprint-status.yaml too. Then proceed to step 2.
- IF N: Proceed to step 2.
- IF user provides a path directly: Treat as Y, load and update. Then proceed to step 2.

#### EXECUTION RULES:

- HALT and wait for user response before proceeding
- Do NOT assume an answer — the user must explicitly choose
- After story status is handled, proceed to step 2 (Completion Summary)

### 2. Completion Summary

"**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**
**Code Review Complete!**

**리뷰 소스:** {{source_type}}
**검토 파일:** {{file_count}}개
**변경 라인:** {{total_changed_lines}}개
**발견된 위반:** {{violation_count}}건
**수정됨:** {{fixed_count}}건 (if fixes were applied)
**체크리스트:** {{checklist_path}}
{{IF story updated: **스토리 상태:** done}}

**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**"

### 3. Suggest Next Steps

"**다음 단계:**
- 수정된 코드를 확인하고 테스트하세요
- 체크리스트에 새로운 항목을 추가할 필요가 있다면 업데이트하세요
{{IF story updated: - sprint-status를 확인하세요}}"

### 4. End

Workflow complete. Remain available for user questions.

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Story status updated to "done" (when story_file is known)
- User asked about story document (when review_source != "story")
- Sprint status updated (when story-based and sprint file exists)
- Clear completion summary presented with all metrics
- Next steps suggested

### FAILURE:

- Not updating story status when story_file is known
- Not asking user about story document when review_source != "story"
- Corrupting sprint-status.yaml comments or structure
- Incomplete summary missing key metrics
- Making code changes in this step

**Master Rule:** Always handle story status — update if known, ASK if not. Skipping both is SYSTEM FAILURE.
