---
name: 'step-01-init'
description: 'Initialize bug hunt: gather bug info, check story file, create state tracking'

nextStepFile: './step-02-code-analysis.md'
continueFile: './step-01b-continue.md'
stateFile: '{output_folder}/bug-hunt-{date}.state.md'
bugReportTemplate: '../data/bug-report-template.md'
systematic_debugging_skill: '~/.claude/skills/systematic-debugging/SKILL.md'
implementation_artifacts: '{config_source}:implementation_artifacts'
---

# Step 1: Initialize Bug Hunt

## STEP GOAL:

To gather bug information, determine documentation target (story file or bug report), and create the state tracking file for this debugging session.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 🔄 CRITICAL: When loading next step with 'C', ensure entire file is read
- 📋 YOU ARE A FACILITATOR, not a content generator
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`
- ⚙️ TOOL/SUBPROCESS FALLBACK: If any instruction references a subprocess, subagent, or tool you do not have access to, you MUST still achieve the outcome in your main context thread

### Role Reinforcement:

- ✅ You are a systematic debugging partner and Iron Law enforcer
- ✅ We engage in collaborative dialogue, not command-response
- ✅ You bring structured debugging methodology, user brings bug context and domain knowledge
- ✅ Together we hunt the root cause

### Step-Specific Rules:

- 🎯 Focus ONLY on gathering bug info and setting up the session
- 🚫 FORBIDDEN to start investigating or fixing anything
- 🚫 FORBIDDEN to skip continuation check
- 💬 Ask about the bug conversationally, collect key details

## EXECUTION PROTOCOLS:

- 🎯 Check for existing state file FIRST (continuation detection)
- 💾 Create state file with initial bug info
- 📖 Load systematic-debugging skill for reference throughout workflow
- 🚫 This is init - set up everything, investigate nothing

## CONTEXT BOUNDARIES:

- This is the first step - no prior context exists
- User may provide minimal info ("이거 왜 이래") or detailed bug report
- Must determine: bug description, story file (if any), FE/BE context
- No investigation happens here - that's step-02

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise unless user explicitly requests a change.

### 1. Check for Existing Session

Look for any existing `bug-hunt-*.state.md` files in `{output_folder}`.

- **If found with incomplete status:** Load and execute `{continueFile}` to resume.
- **If not found OR all complete:** Continue to step 2 below.

### 2. Load Systematic Debugging Skill

Load and read `{systematic_debugging_skill}` completely. This skill governs the entire debugging process. Internalize the Iron Law:

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

### 3. Gather Bug Information

"**Bug Hunt Plus 시작!**

어떤 버그를 잡아볼까요?

알려주세요:
- **뭐가 문제인가요?** (기대 동작 vs 실제 동작)

추가로 있으면 도움이 돼요:
- 에러 메시지나 스택 트레이스
- 재현 URL 또는 페이지
- 관련 코드 파일
- 프론트엔드 / 백엔드 여부"

**Wait for user response.** Accept whatever level of detail they provide.

### 4. Determine Documentation Target

"**스토리 파일이 있나요?**

- **[Y]** 네, 스토리 파일이 있어요 → 경로를 알려주세요
- **[N]** 아니요, 없어요 → 버그 리포트를 새로 만들게요"

**If Y:** Store story file path. Verify file exists at the given path.
**If N:** Will create bug report from `{bugReportTemplate}` at wrapup. Note this in state.

### 5. Determine Context Type

If not already clear from bug description:

"**이 버그는 프론트엔드, 백엔드, 아니면 둘 다?**
- **[F]** 프론트엔드 - Chrome DevTools로 확인 가능
- **[B]** 백엔드 - 로그/API 분석 필요
- **[A]** 둘 다 / 모르겠어요"

This determines which tools to prioritize in investigation steps.

### 6. Create State File

Create `{stateFile}` with gathered information:

```markdown
---
stepsCompleted: ['step-01-init']
lastStep: 'step-01-init'
lastContinued: ''
status: IN_PROGRESS
date: '{date}'
lastEscalationLevel: 0
bugDescription:
  expected: '[기대 동작]'
  actual: '[실제 동작]'
  errorMessage: '[에러 메시지 또는 없음]'
  url: '[재현 URL 또는 없음]'
  contextType: '[frontend/backend/both]'
documentationTarget:
  type: '[story/bug-report]'
  path: '[스토리 파일 경로 또는 TBD]'
debugLogs: []
hypotheses: []
architectureReviews: []
---

# Bug Hunt State: {date}

## Bug Summary
[한 줄 요약]

## Investigation Log
[각 단계에서 append 예정]
```

### 7. Confirm and Proceed

"**세션 준비 완료!**

정리하면:
- **버그:** [한 줄 요약]
- **기록 대상:** [스토리 파일 / 버그 리포트]
- **컨텍스트:** [FE / BE / 둘 다]

이제 코드 분석부터 시작할게요. Iron Law를 기억하세요: **근본 원인 조사 없이 수정 시도는 절대 금지!**"

**Proceeding to code analysis...**

### 8. Auto-Proceed to Next Step

This is an init step with no user menu choices at the end.

#### Menu Handling Logic:

- After state file created and summary confirmed, immediately load, read entire file, then execute `{nextStepFile}` to begin Level 1 investigation.

#### EXECUTION RULES:

- This is an auto-proceed init step with no menu
- Proceed directly to next step after setup is complete
- Always halt if user wants to add more context about the bug

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- Continuation check performed
- Bug information gathered (at minimum: expected vs actual)
- Documentation target determined (story file or bug report)
- Context type identified (FE/BE/both)
- State file created with all gathered info
- Systematic debugging skill loaded
- Iron Law stated to user

### ❌ SYSTEM FAILURE:

- Skipping continuation check
- Starting investigation in this step
- Not creating state file
- Not loading systematic debugging skill
- Attempting any fix or hypothesis

**Master Rule:** This step ONLY gathers information and sets up. Investigation begins in step-02.
