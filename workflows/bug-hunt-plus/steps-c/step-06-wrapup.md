---
name: 'step-06-wrapup'
description: 'Final step: remove all debug logs, update story file or create bug report, verify cleanup'

stateFile: '{output_folder}/bug-hunt-{date}.state.md'
bugReportTemplate: '../data/bug-report-template.md'
implementation_artifacts: '{config_source}:implementation_artifacts'
---

# Step 6: Wrapup

## STEP GOAL:

To clean up ALL debug logs from the code, document the fix in the story file or create a bug report, verify cleanup with DevTools, and close out the bug hunt session.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 🔄 CRITICAL: When loading next step with 'C', ensure entire file is read
- 📋 YOU ARE A FACILITATOR, not a content generator
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`
- ⚙️ TOOL/SUBPROCESS FALLBACK: If any instruction references a subprocess, subagent, or tool you do not have access to, you MUST still achieve the outcome in your main context thread

### Role Reinforcement:

- ✅ You are a systematic debugging partner completing the hunt
- ✅ Debug log cleanup is NON-NEGOTIABLE
- ✅ Documentation ensures the work is preserved
- ✅ Leave the codebase cleaner than you found it

### Step-Specific Rules:

- 🎯 Three tasks: cleanup debug logs, document, verify
- 🚫 FORBIDDEN to skip debug log removal
- 🚫 FORBIDDEN to close without documentation
- 📋 Use debugLogs array from state file - remove EVERY tracked log
- 🔧 Use Chrome DevTools to verify no [BUG-HUNT] logs remain in console

## EXECUTION PROTOCOLS:

- 🎯 Remove ALL debug logs tracked in state file
- 💾 Write documentation to story file or create bug report
- 📖 Verify cleanup with DevTools
- 🚫 This is the FINAL step - no nextStepFile

## CONTEXT BOUNDARIES:

- Fix is implemented and verified (from step-05)
- Debug logs tracked in state file debugLogs array
- Documentation target known (story file or bug report)
- All investigation history available in state file

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly.

### 1. Load State

Read `{stateFile}` completely. Extract:
- `debugLogs` array (CRITICAL - every log must be removed)
- `documentationTarget` (story or bug report)
- `fixDetails` (what was fixed)
- `hypotheses` (debugging journey)
- `architectureReviews` (if any)
- `bugDescription` (original bug)

### 2. Remove ALL Debug Logs

**This is NON-NEGOTIABLE.**

For EACH entry in `debugLogs`:
1. Open the file at the tracked path
2. Find and remove the tracked debug log content
3. Verify the removal doesn't break the code
4. Mark as removed

"**디버그 로그 제거 중...**

| # | 파일 | 상태 |
|---|------|------|
| 1 | [파일 경로] | ✅ 제거 완료 |
| 2 | [파일 경로] | ✅ 제거 완료 |
| 3 | [파일 경로] | ✅ 제거 완료 |

**총 [N]개 디버그 로그 제거 완료!**"

**If debugLogs is empty:** "디버그 로그가 없어요 (Level 1에서 해결됨). 건너뛸게요!"

### 3. Verify Cleanup with DevTools

**For frontend bugs:**

Use Chrome DevTools MCP:
- **Check console** - No more `[BUG-HUNT]` messages
- **Take screenshot** - Application still works correctly after cleanup
- **Quick functional test** - Original bug still fixed after log removal

"**클린업 검증:**
- [BUG-HUNT] 로그 잔여: [없음 ✅ / 발견 ❌]
- 애플리케이션 정상 동작: [확인 ✅]
- 버그 수정 유지: [확인 ✅]"

**If any [BUG-HUNT] logs found:** Grep codebase for `[BUG-HUNT]` and remove missed logs.

### 4. Document: Story File Update OR Bug Report

**Branch A: Story file exists (documentationTarget.type = 'story')**

Append to the story file at `documentationTarget.path`:

```markdown
## 버그 수정 [{date}]

### 증상
- 기대 동작: [{bugDescription.expected}]
- 실제 동작: [{bugDescription.actual}]

### 근본 원인
- 원인 요약: [{fixDetails에서 추출}]
- 원인 위치: [{관련 파일/함수}]
- 왜 발생했는지: [{분석 결과}]

### 수정 사항
- 수정 방법: [{fixDetails.method}]
- 변경 내용: [{fixDetails.changes}]

### 관련 파일
| 파일 | 변경 유형 | 설명 |
|------|----------|------|
[fixDetails.files 기반으로 생성]

### 디버깅 과정
- 에스컬레이션 레벨: [{최종 레벨}]
- 시도한 가설: [{hypotheses 요약}]
```

**Branch B: No story file (documentationTarget.type = 'bug-report')**

Load `{bugReportTemplate}` and create bug report at `{implementation_artifacts}/bug-report-{date}.md`:

Fill in all template fields from state file data:
- 증상: from bugDescription
- 근본 원인: from fixDetails
- 수정 사항: from fixDetails
- 관련 파일: from fixDetails.files
- 디버깅 과정: from hypotheses
- 아키텍처 재검토: from architectureReviews (if any)
- 미해결 시 다음 단계: N/A (resolved)

Set frontmatter status to `resolved`.

### 5. Update State File (Final)

Update `{stateFile}`:
```yaml
status: COMPLETED
debugLogs: []  # All removed
stepsCompleted: [..., 'step-06-wrapup']
```

### 6. Final Summary

"**Bug Hunt 완료! 🎉**

**요약:**
- **버그:** [{한 줄 요약}]
- **근본 원인:** [{한 줄 원인}]
- **수정:** [{한 줄 수정 내용}]
- **에스컬레이션:** Level [{최종 레벨}]
- **기록:** [{스토리 파일 경로 or 버그 리포트 경로}]
- **디버그 로그:** 모두 제거 ✅

Iron Law를 지켰습니다: 근본 원인 조사 → 증거 기반 가설 → 검증된 수정!

수고하셨어요! 💪"

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- ALL debug logs removed from code (zero remaining)
- DevTools confirms no [BUG-HUNT] logs in console
- Application still works after cleanup
- Documentation written to story file OR bug report created
- State file marked COMPLETED
- User receives clear summary

### ❌ SYSTEM FAILURE:

- Debug logs left in code (ANY remaining = failure)
- Skipping DevTools cleanup verification
- Not documenting in story/bug report
- Closing without summary
- Not marking state as COMPLETED

**Master Rule:** Debug logs in production is UNACCEPTABLE. Remove EVERY single one. Verify with DevTools. Document EVERYTHING.
