---
name: 'step-04b-architecture'
description: 'Architecture review after 3+ hypothesis failures - document findings and reset approach'

restartStepFile: './step-02-code-analysis.md'
stateFile: '{output_folder}/bug-hunt-{date}.state.md'
---

# Step 4b: Architecture Review

## STEP GOAL:

To critically review whether the architectural approach is fundamentally flawed, document all findings and failed attempts, establish a new direction, and restart the investigation with fresh perspective.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 🔄 CRITICAL: When loading next step with 'C', ensure entire file is read
- 📋 YOU ARE A FACILITATOR, not a content generator
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`
- ⚙️ TOOL/SUBPROCESS FALLBACK: If any instruction references a subprocess, subagent, or tool you do not have access to, you MUST still achieve the outcome in your main context thread

### Role Reinforcement:

- ✅ You are a systematic debugging partner questioning fundamentals
- ✅ 3+ fixes failed - this is NOT a failed hypothesis, it's a wrong architecture
- ✅ Be honest: is this pattern fundamentally sound?
- ✅ This is a collaborative discussion, not a unilateral decision

### Step-Specific Rules:

- 🎯 Focus on questioning ARCHITECTURE, not finding another fix
- 🚫 FORBIDDEN to propose "just one more fix attempt"
- 💬 Document everything before resetting
- 📝 This documentation is critical for the record

## EXECUTION PROTOCOLS:

- 🎯 Review all failed attempts systematically
- 💾 Document architecture review in state file AND story/bug report
- 📖 Reset escalation level for fresh restart
- 🚫 Must document before proceeding

## CONTEXT BOUNDARIES:

- 3+ hypotheses have failed across all escalation levels
- All previous evidence is in state file
- User must be involved in architecture discussion
- Documentation goes to story file or bug report (not just state)

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly.

### 1. Load All Evidence

Read `{stateFile}` completely. Gather:
- All failed hypotheses with their evidence
- All escalation levels tried
- All findings from code analysis, debug logs, web search
- Debug logs currently in code

### 2. Present Failed Attempts Summary

"**아키텍처 재검토가 필요합니다.**

**시도한 가설들:**
1. [Level 1] [가설] → 실패: [이유]
2. [Level 2] [가설] → 실패: [이유]
3. [Level 3] [가설] → 실패: [이유]

**패턴 분석:**
- 매번 다른 곳에서 새로운 문제가 나타나나요?
- 수정할수록 더 복잡해지나요?
- '대규모 리팩토링'이 필요해 보이나요?"

### 3. Question Architecture (Collaborative)

"**근본적인 질문들:**

1. **이 패턴이 근본적으로 올바른가요?**
   [분석]

2. **관성으로 이 접근을 유지하고 있진 않나요?**
   [솔직한 평가]

3. **리팩토링 vs 계속 수정 - 어느 쪽이 더 효율적인가요?**
   [비교]

4. **완전히 다른 접근법이 있나요?**
   [대안 제시]

호정님 생각은 어떠세요?"

**Wait for user input. This is a critical discussion point.**

### 4. Establish New Direction

Based on discussion:

"**새로운 방향:**
- [합의된 접근법]
- [구체적으로 뭘 다르게 할 건지]
- [이전 시도에서 배운 것]"

**Wait for user confirmation.**

### 5. Document Architecture Review

**Write to story file or bug report** (from documentationTarget in state):

```markdown
## 아키텍처 재검토 [{date}]

### 실패한 가설들
1. [Level 1] [가설] → [결과, 이유]
2. [Level 2] [가설] → [결과, 이유]
3. [Level 3] [가설] → [결과, 이유]

### 발견된 아키텍처 문제
[문제 설명]

### 재설정 방향
[새로운 접근법]

### 이전 시도에서 배운 것
[교훈]
```

### 6. Update State File

Update `{stateFile}`:
```yaml
lastEscalationLevel: 0  # Reset for fresh start
```

Add to `architectureReviews`:
```yaml
- date: '{date}'
  failedHypotheses: [목록]
  architectureIssue: '[발견된 문제]'
  newDirection: '[새로운 방향]'
```

Update `stepsCompleted` to include `step-04b-architecture`.

Append to Investigation Log.

### 7. Present MENU OPTIONS

Display: "**아키텍처 재검토 완료! 문서화했어요. Level 1 (코드 분석)부터 새로운 방향으로 재시작할게요.**

**Select:** [C] Continue - Step 02로 재시작"

#### EXECUTION RULES:

- ALWAYS halt and wait for user input after presenting menu
- C restarts the investigation from Level 1 with new direction

#### Menu Handling Logic:

- IF C: Update state file, then load, read entire file, then execute {restartStepFile}
- IF Any other: help user, then redisplay menu

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- All failed attempts reviewed and summarized
- Architecture questioned honestly
- New direction established collaboratively
- DOCUMENTED in story file or bug report (not just state!)
- Escalation level reset
- Ready for fresh investigation

### ❌ SYSTEM FAILURE:

- Proposing "just one more fix" instead of reviewing architecture
- Not documenting in story/bug report
- Skipping the collaborative discussion
- Not resetting escalation level

**Master Rule:** 3+ failures means architecture problem. Document, reset, restart. Do NOT try fix #4 without this step.
