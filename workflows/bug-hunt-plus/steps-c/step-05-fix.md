---
name: 'step-05-fix'
description: 'Implement the root cause fix, verify with DevTools, loop back if verification fails'

nextStepFile: './step-06-wrapup.md'
loopBackFiles:
  level-1: './step-02-code-analysis.md'
  level-2: './step-03-debug-logs.md'
  level-3: './step-04-web-search.md'
stateFile: '{output_folder}/bug-hunt-{date}.state.md'
parallel_agents_skill: '~/.claude/skills/dispatching-parallel-agents/SKILL.md'
advancedElicitationTask: '{project-root}/_bmad/core/workflows/advanced-elicitation/workflow.xml'
partyModeWorkflow: '{project-root}/_bmad/core/workflows/party-mode/workflow.md'
---

# Step 5: Fix Implementation

## STEP GOAL:

To implement the root cause fix based on the confirmed hypothesis, verify the fix works in the actual application using Chrome DevTools, and loop back if verification fails.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 🔄 CRITICAL: When loading next step with 'C', ensure entire file is read
- 📋 YOU ARE A FACILITATOR, not a content generator
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`
- ⚙️ TOOL/SUBPROCESS FALLBACK: If any instruction references a subprocess, subagent, or tool you do not have access to, you MUST still achieve the outcome in your main context thread

### Role Reinforcement:

- ✅ You are a systematic debugging partner implementing the confirmed fix
- ✅ The root cause is identified - now implement correctly
- ✅ Fix the ROOT CAUSE, not the symptom
- ✅ Verify in the ACTUAL application, not just in theory

### Step-Specific Rules:

- 🎯 Implement the fix for the CONFIRMED root cause only
- 🚫 FORBIDDEN to fix things "while you're at it" - ONE fix only
- 🚫 FORBIDDEN to bundle refactoring with the fix
- 🔧 For large fixes: use Sub-Processes for parallel FE/BE changes (Pattern 4)
- 💬 Sub-processes return structured results, not full file contents
- ⚙️ If sub-processes unavailable, implement changes sequentially
- 📋 Verify with Chrome DevTools that the fix ACTUALLY works

## EXECUTION PROTOCOLS:

- 🎯 Implement single fix addressing root cause
- 💾 Update state file with fix details
- 📖 Verify with DevTools in actual application
- 🚫 If verification fails, loop back to last escalation level

## CONTEXT BOUNDARIES:

- Hypothesis confirmed in previous step (02, 03, or 04)
- Root cause identified with evidence
- lastEscalationLevel in state tells us where to loop back if verification fails
- Debug logs may still be in code (tracked in state)

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly.

### 1. Load Context

Read `{stateFile}` to get:
- Confirmed hypothesis and evidence
- Root cause details
- lastEscalationLevel (for potential loop back)
- Current debug logs in code

### 2. Plan the Fix

"**수정 계획:**

**근본 원인:** [확인된 근본 원인]
**수정 방법:** [어떻게 고칠 건지]
**변경 파일:**
- [파일 1] - [변경 내용]
- [파일 2] - [변경 내용]

**변경하지 않을 것:**
- 리팩토링 없음
- '개선' 없음
- 이 버그와 무관한 변경 없음

이 수정 계획에 동의하세요?"

**Wait for user input.**

### 3. Assess Fix Scope

**If multiple files across FE and BE, or large-scale frontend changes:**

Load `{parallel_agents_skill}` and use Sub-Processes:
- Launch parallel agents for independent file changes
- Each agent returns: `{file, changesMade, verification}`
- Aggregate results

**If single file or small change:**
- Implement directly in main thread

### 4. Implement the Fix

- Address the ROOT CAUSE identified
- ONE change at a time
- No "while I'm here" improvements
- No bundled refactoring

"**수정 구현 완료:**

**변경 사항:**
| 파일 | 변경 내용 |
|------|----------|
| [파일] | [구체적 변경] |"

### 5. Verify with Chrome DevTools

**For frontend bugs:**

Use Chrome DevTools MCP to verify:

**a. Take screenshot** - Does the UI look correct now?
**b. Check console** - No new errors? [BUG-HUNT] logs show correct values?
**c. Test the original reproduction steps** - Does the bug still occur?
**d. Check for side effects** - Other functionality still working?

**For backend bugs:**
- Test the API endpoint
- Check server logs
- Verify data integrity

"**검증 결과:**

**기대 동작:** [원래 기대했던 것]
**실제 결과:** [수정 후 결과]
**버그 재현:** [재현 시도 → 성공/실패]
**사이드 이펙트:** [다른 기능 확인 결과]"

### 6. Evaluate Verification Result

**If fix VERIFIED successfully:**
→ Proceed to wrapup

**If fix FAILED verification:**

"**수정이 실제 환경에서 동작하지 않아요!**

**실패 원인:** [뭐가 안 되는지]
**이전 에스컬레이션 레벨:** Level [lastEscalationLevel]

해당 레벨로 돌아가서 추가 조사가 필요해요."

### 7. Update State File

Update `{stateFile}`:

**If verified:**
```yaml
fixImplemented: true
fixVerified: true
fixDetails:
  method: '[수정 방법]'
  files: ['파일 목록']
  changes: '[변경 내용 요약]'
```

**If failed:**
Add failed verification to hypotheses with details.

Update `stepsCompleted`.
Append to Investigation Log.

### 8. Present MENU OPTIONS

**If fix VERIFIED:**

Display: "**수정 완료 및 검증 성공! 마무리로 넘어갈까요?**

**Select:** [A] Advanced Elicitation [P] Party Mode [C] Continue to Wrapup"

**If fix FAILED verification:**

Display: "**수정 검증 실패. Level [N]으로 돌아가서 재조사합니다.**

**Select:** [A] Advanced Elicitation [P] Party Mode [C] Loop back to Level [N]"

#### EXECUTION RULES:

- ALWAYS halt and wait for user input after presenting menu
- Loop back target is determined by lastEscalationLevel in state

#### Menu Handling Logic:

- IF A: Execute {advancedElicitationTask}, and when finished redisplay the menu
- IF P: Execute {partyModeWorkflow}, and when finished redisplay the menu
- IF C (verified): Update state file, then load, read entire file, then execute {nextStepFile}
- IF C (failed): Update state file, then load, read entire file, then execute the appropriate file from {loopBackFiles} based on lastEscalationLevel
- IF Any other: help user, then redisplay menu

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- Fix addresses ROOT CAUSE (not symptom)
- Single focused change (no extras)
- Verified in actual application with DevTools
- Sub-Processes used for large changes
- State file updated with fix details
- Loop back works correctly on verification failure

### ❌ SYSTEM FAILURE:

- Fixing symptoms instead of root cause
- Bundling refactoring with fix
- Not verifying with DevTools
- Claiming success without actual verification
- Not looping back on verification failure

**Master Rule:** A fix that works in theory but fails in practice is NOT a fix. Verify in the real application.
