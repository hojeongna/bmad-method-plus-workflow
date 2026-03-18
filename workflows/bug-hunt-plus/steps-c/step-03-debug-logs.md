---
name: 'step-03-debug-logs'
description: 'Level 2 investigation: add debug logs, use Chrome DevTools to gather evidence, form and test hypothesis'

nextStepFile: './step-04-web-search.md'
skipToFixFile: './step-05-fix.md'
stateFile: '{output_folder}/bug-hunt-{date}.state.md'
systematic_debugging_skill: '~/.claude/skills/systematic-debugging/SKILL.md'
advancedElicitationTask: '{project-root}/_bmad/core/workflows/advanced-elicitation/workflow.xml'
partyModeWorkflow: '{project-root}/_bmad/core/workflows/party-mode/workflow.md'
---

# Step 3: Debug Logs + Chrome DevTools (Level 2)

## STEP GOAL:

To escalate investigation by inserting targeted debug logs into the code, using Chrome DevTools MCP to observe runtime behavior, gather concrete evidence, and form a stronger hypothesis.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 🔄 CRITICAL: When loading next step with 'C', ensure entire file is read
- 📋 YOU ARE A FACILITATOR, not a content generator
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`
- ⚙️ TOOL/SUBPROCESS FALLBACK: If any instruction references a subprocess, subagent, or tool you do not have access to, you MUST still achieve the outcome in your main context thread

### Role Reinforcement:

- ✅ You are a systematic debugging partner executing Level 2 investigation
- ✅ Level 1 (code analysis) was insufficient - now we instrument the code
- ✅ Chrome DevTools MCP is your primary evidence-gathering tool
- ✅ Iron Law still active: evidence before fixes

### Step-Specific Rules:

- 🎯 Level 2: Debug logs + Chrome DevTools - active instrumentation
- 🚫 FORBIDDEN to attempt fixes before gathering DevTools evidence
- 🚫 FORBIDDEN to use web search (that's Level 3)
- 📋 TRACK every debug log added (file path + content) - they MUST be removed later
- 🔧 Use Chrome DevTools MCP for: screenshots, console messages, network requests, DOM inspection
- 💬 For backend bugs: use server logs instead of DevTools

## EXECUTION PROTOCOLS:

- 🎯 Insert debug logs strategically, not randomly
- 💾 Track ALL debug logs in state file debugLogs array
- 📖 Use DevTools to observe actual runtime behavior
- 🚫 Every log added must be tracked for later removal

## CONTEXT BOUNDARIES:

- Level 1 code analysis findings are in state file
- Previous hypothesis failed - need runtime evidence
- Chrome DevTools MCP available for frontend bugs
- Backend bugs: use server-side logging
- All debug logs MUST be tracked for cleanup

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly.

### 1. Load Context

Read `{stateFile}` to get:
- Bug description and context type (FE/BE/both)
- Level 1 findings and failed hypothesis
- Any existing debug logs from previous sessions

### 2. Plan Debug Log Placement

Based on Level 1 findings, identify strategic insertion points:

"**Level 1에서 의심되는 영역을 기반으로 디버그 로그를 추가할게요:**

**삽입 계획:**
1. [파일:위치] - [뭘 확인하려는지]
2. [파일:위치] - [뭘 확인하려는지]
3. [파일:위치] - [뭘 확인하려는지]

이 위치들이 맞을까요? 추가하거나 변경할 곳이 있으면 말씀해주세요!"

**Wait for user input.**

### 3. Insert Debug Logs

For each approved insertion point:

**a. Add targeted console.log/console.warn statements:**
- Use distinctive prefix: `[BUG-HUNT]` for easy identification
- Log relevant variable values, state, and data flow
- Example: `console.log('[BUG-HUNT] componentName:', { props, state, computedValue });`

**b. Track EVERY log in state file:**
```yaml
debugLogs:
  - file: '[파일 경로]'
    line: [라인 번호]
    content: "console.log('[BUG-HUNT] ...')"
  - file: '[파일 경로]'
    line: [라인 번호]
    content: "console.log('[BUG-HUNT] ...')"
```

**For backend bugs:**
- Use appropriate logging (console.log for Node, print for Python, etc.)
- Same `[BUG-HUNT]` prefix for identification

### 4. Gather Evidence with Chrome DevTools

**For frontend bugs (contextType = frontend or both):**

Use Chrome DevTools MCP tools:

**a. Take screenshot** - Visual state of the bug
**b. Check console messages** - Look for [BUG-HUNT] logs and any errors
**c. Inspect network requests** - API responses matching expectations?
**d. Evaluate DOM state** - Actual rendered state vs expected

"**DevTools 증거:**

**콘솔 로그 ([BUG-HUNT]):**
[수집된 로그 출력]

**콘솔 에러:**
[에러가 있으면 표시]

**네트워크 요청:**
[관련 API 요청/응답]

**화면 상태:**
[스크린샷 기반 관찰]"

**For backend bugs (contextType = backend):**
- Check server logs for [BUG-HUNT] entries
- Inspect API response data
- Check database state if relevant (가이드: Supabase MCP 등 활용 가능)

### 5. Analyze Evidence

"**증거 분석 결과:**

**데이터 흐름 추적:**
[A] → [B] → [여기서 문제 발생] → [C]

**Level 1 가설과 비교:**
[이전 가설이 틀렸던 이유 / 새로운 발견]

**새로운 발견:**
[디버그 로그와 DevTools에서 알게 된 것]"

### 6. Form New Hypothesis (Collaborative)

"**새로운 가설:**

런타임 증거를 바탕으로:
- **가설:** [구체적 근본 원인]
- **근거:** [DevTools/로그에서 확인한 증거]
- **테스트 방법:** [최소 변경으로 어떻게 확인할지]

이 가설에 동의하세요?"

**Wait for user input.**

### 7. Test Hypothesis (Minimal Change)

- Make the SMALLEST possible change to test
- ONE variable at a time
- Use DevTools to verify the test result

"**테스트 결과:**
- **가설:** [가설 내용]
- **결과:** [성공 / 실패]
- **DevTools 확인:** [뭘 관찰했는지]"

### 8. Update State File

Update `{stateFile}`:
```yaml
lastEscalationLevel: 2
```

Add to `hypotheses`:
```yaml
- hypothesis: '[가설 내용]'
  result: '[success/failure]'
  evidence: '[DevTools/로그 증거]'
  level: 2
```

Update `stepsCompleted` to include `step-03-debug-logs`.

Append to Investigation Log.

### 9. Present MENU OPTIONS

**If hypothesis SUCCEEDED:**

Display: "**Level 2에서 근본 원인 발견! 수정으로 넘어갈까요?**

**Select:** [A] Advanced Elicitation [P] Party Mode [S] Skip to Fix [C] Continue to Level 3 anyway"

**If hypothesis FAILED:**

Display: "**Level 2에서도 해결 못했어요. Level 3 (웹 검색)으로 에스컬레이션할게요.**

**Select:** [A] Advanced Elicitation [P] Party Mode [C] Continue to Level 3"

#### EXECUTION RULES:

- ALWAYS halt and wait for user input after presenting menu
- S option only available when hypothesis succeeded
- ONLY proceed when user selects C or S

#### Menu Handling Logic:

- IF A: Execute {advancedElicitationTask}, and when finished redisplay the menu
- IF P: Execute {partyModeWorkflow}, and when finished redisplay the menu
- IF S (success only): Update state file, then load, read entire file, then execute {skipToFixFile}
- IF C: Update state file, then load, read entire file, then execute {nextStepFile}
- IF Any other: help user, then redisplay menu

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- Debug logs strategically placed (not random)
- ALL debug logs tracked in state file debugLogs array
- Chrome DevTools evidence gathered systematically
- Runtime behavior observed and documented
- New hypothesis formed with concrete evidence
- Hypothesis tested with minimal change
- State file updated

### ❌ SYSTEM FAILURE:

- Adding debug logs without tracking them
- Random log placement without strategy
- Not using Chrome DevTools for frontend bugs
- Attempting fixes before gathering evidence
- Using web search (that's Level 3!)
- Forgetting to track debug logs for later cleanup

**Master Rule:** Track EVERY debug log. They MUST be removed later. Lost tracking = debug code in production.
