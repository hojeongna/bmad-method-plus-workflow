---
name: 'step-01b-continue'
description: 'Handle bug hunt continuation from previous session'

stateFile: '{output_folder}/bug-hunt-{date}.state.md'
workflowFile: '../workflow.md'
systematic_debugging_skill: '~/.claude/skills/systematic-debugging/SKILL.md'
nextStepOptions:
  step-02-code-analysis: './step-02-code-analysis.md'
  step-03-debug-logs: './step-03-debug-logs.md'
  step-04-web-search: './step-04-web-search.md'
  step-04b-architecture: './step-04b-architecture.md'
  step-05-fix: './step-05-fix.md'
  step-06-wrapup: './step-06-wrapup.md'
---

# Step 1b: Continue Bug Hunt

## STEP GOAL:

To resume a bug hunt from a previous session, restoring all state including debug log tracking, hypotheses, and escalation level.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 🔄 CRITICAL: When loading next step with 'C', ensure entire file is read
- 📋 YOU ARE A FACILITATOR, not a content generator
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`
- ⚙️ TOOL/SUBPROCESS FALLBACK: If any instruction references a subprocess, subagent, or tool you do not have access to, you MUST still achieve the outcome in your main context thread

### Role Reinforcement:

- ✅ You are a systematic debugging partner resuming a hunt
- ✅ Restore full context before proceeding
- ✅ User may have new insights from time away

### Step-Specific Rules:

- 🎯 Focus ONLY on restoring context and routing to correct step
- 🚫 FORBIDDEN to start investigating without restoring state
- 🚫 FORBIDDEN to skip debug log restoration
- 💬 Welcome user back, summarize where they left off

## EXECUTION PROTOCOLS:

- 🎯 Read state file completely to restore context
- 💾 Update lastContinued in state file
- 📖 Load systematic debugging skill
- 🚫 Route to correct next step based on stepsCompleted

## CONTEXT BOUNDARIES:

- User ran this workflow before and is resuming
- State file has stepsCompleted, debugLogs, hypotheses
- Must restore debug log awareness (these are still in the code!)
- Route to the correct next step

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly.

### 1. Load State File

Read `{stateFile}` completely. Extract:
- `stepsCompleted` array
- `lastStep`
- `lastEscalationLevel`
- `debugLogs` (CRITICAL: these logs are still in the user's code!)
- `hypotheses` (what's been tried)
- `bugDescription` (the original bug)
- `documentationTarget` (story file or bug report)
- `architectureReviews` (if any)

### 2. Load Systematic Debugging Skill

Load and read `{systematic_debugging_skill}` completely. Reinternalize the Iron Law.

### 3. Welcome Back

"**Bug Hunt 재개!**

이전 세션 정보:
- **버그:** [bugDescription 요약]
- **진행 상태:** [lastStep] 완료
- **에스컬레이션 레벨:** [lastEscalationLevel]
- **시도한 가설:** [hypotheses 요약]"

**If debugLogs is not empty:**
"⚠️ **주의: 코드에 디버그 로그가 남아있어요!**
[debugLogs 목록 표시]
이 로그들은 디버깅 완료 시 반드시 제거됩니다."

### 4. Check for New Context

"**새로운 정보가 있나요?**

시간이 지나면서 새로 알게 된 것, 생각난 것, 다른 사람한테 들은 것이 있으면 알려주세요.
없으면 바로 이어서 진행할게요!"

**Wait for user response.** If new info provided, note it in state file.

### 5. Update State File

Update `{stateFile}`:
```yaml
lastContinued: '{date}'
```

Append to Investigation Log:
```markdown
## Session Resumed: {date}
[새로운 정보 있으면 기록]
```

### 6. Determine Next Step

From `stepsCompleted`, find the last completed step and determine the next step to load from `{nextStepOptions}`.

**Routing Logic:**
- Last completed = `step-01-init` → load `step-02-code-analysis`
- Last completed = `step-02-code-analysis` → load `step-03-debug-logs`
- Last completed = `step-03-debug-logs` → load `step-04-web-search`
- Last completed = `step-04-web-search` → load `step-04b-architecture` or `step-05-fix`
- Last completed = `step-04b-architecture` → load `step-02-code-analysis` (restart)
- Last completed = `step-05-fix` → check if fix succeeded or looped back

"**[다음 스텝 이름]부터 이어서 진행할게요!**"

### 7. Route to Next Step

Load, read entire file, then execute the determined next step file.

#### Menu Handling Logic:

- After context restored and next step determined, immediately load and execute the next step
- IF user wants to discuss before proceeding: continue conversation, then route when ready

#### EXECUTION RULES:

- This is an auto-proceed continuation step
- Proceed directly to determined next step after context is restored

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- State file loaded and all context restored
- Debug logs awareness restored (user warned about logs in code)
- User welcomed back with clear summary
- New context gathered (if any)
- Correctly routed to next step
- Systematic debugging skill reloaded

### ❌ SYSTEM FAILURE:

- Not loading state file
- Forgetting about existing debug logs in code
- Routing to wrong step
- Starting investigation without restoring context
- Not reloading systematic debugging skill

**Master Rule:** Restore EVERYTHING before proceeding. Debug logs in code are especially critical - losing track of them means leftover debug code in production.
