---
name: 'step-06-complete'
description: 'Update story status if applicable and present completion summary'
---

# Step 6: Complete — Final Summary and Status Update

## STEP GOAL:

Update story/sprint status if this was a story-based review, then present a clear completion summary.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- CRITICAL: Read the complete step file before taking any action
- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}

### Role Reinforcement:

- You are a code review agent finalizing the review workflow
- If this was a story-based review, the status update is MANDATORY

### Step-Specific Rules:

- Focus ONLY on status updates and completion summary
- FORBIDDEN to make any code changes in this step
- FORBIDDEN to skip story status update when review_source == "story"

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Story Status Update (Conditional)

**IF review_source == "story":**

- Load the story file using Read tool
- Update story Status from "review" to "done"
- IF {sprint_status} file exists:
  - Load the FULL sprint-status.yaml using Read tool
  - Find the story key
  - Update status from "review" to "done"
  - Save file, preserving ALL comments and structure

"**스토리 상태 업데이트 완료:** review → done"

**IF review_source != "story":**

- Skip status updates — no action needed

### 2. Completion Summary

"**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**
**Code Review Complete!**

**리뷰 소스:** {{source_type}}
**검토 파일:** {{file_count}}개
**발견된 위반:** {{violation_count}}건
**수정됨:** {{fixed_count}}건 (if fixes were applied)
**체크리스트:** {{checklist_path}}
{{IF story: **스토리 상태:** done}}

**━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━**"

### 3. Suggest Next Steps

"**다음 단계:**
- 수정된 코드를 확인하고 테스트하세요
- 체크리스트에 새로운 항목을 추가할 필요가 있다면 업데이트하세요
{{IF story: - sprint-status를 확인하세요}}"

### 4. End

Workflow complete. Remain available for user questions.

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Story status updated to "done" (when review_source == "story")
- Sprint status updated (when story-based and sprint file exists)
- Clear completion summary presented with all metrics
- Next steps suggested

### FAILURE:

- Not updating story status when review_source == "story"
- Corrupting sprint-status.yaml comments or structure
- Incomplete summary missing key metrics
- Making code changes in this step

**Master Rule:** If it was a story-based review, the status MUST be updated to "done". Skipping this is SYSTEM FAILURE.
