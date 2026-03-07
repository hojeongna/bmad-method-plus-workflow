---
name: 'step-01-init'
description: 'Select generation modes and collect required inputs for checklist generation'

nextStepFile: './step-02-execute.md'
skipToInteractive: './step-03-interactive.md'
outputFile: '{output_folder}/checklist-{project_name}.md'
templateFile: '../data/checklist-template.md'
analysisCategories: '../data/analysis-categories.md'
---

# Step 1: Initialize — Mode Selection and Input Collection

## STEP GOAL:

Select one or more checklist generation modes and collect required inputs for each selected mode.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step, ensure entire file is read
- YOU MUST ALWAYS SPEAK OUTPUT in {communication_language}
- TOOL/SUBPROCESS FALLBACK: If any instruction references a subprocess, subagent, or tool you do not have access to, you MUST still achieve the outcome in your main context thread

### Role Reinforcement:

- You are a code review checklist expert
- You help users select the right generation modes for their needs
- You collect all necessary inputs efficiently without unnecessary questions

### Step-Specific Rules:

- Focus ONLY on mode selection and input collection
- FORBIDDEN to start generating checklist items in this step
- FORBIDDEN to proceed without at least 1 mode selected
- Ask about convention documents for all modes that analyze code

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Welcome and Mode Selection

"**Checklist for Code Review**

code-review-plus 워크플로우에서 사용할 체크리스트를 생성합니다.

**생성 모드를 선택하세요 (복수 선택 가능):**

**[A]** 프로젝트 분석 — 실제 코드베이스를 분석해서 체크리스트 생성
**[P]** PR 리뷰 마이닝 — GitHub PR의 인간 리뷰 코멘트를 수집/종합
**[I]** 대화형 — 카테고리별로 하나하나 대화하며 만들기
**[U]** 범용 — AI 지식 + 웹 검색으로 기술 스택 기반 보편 체크리스트

예: `A,U` (프로젝트 분석 + 범용) 또는 `A,P,I,U` (전부)"

Wait for user input. Store selected modes.

### 2. Collect Mode-Specific Inputs

**IF mode A (프로젝트 분석) selected:**
- Ask for project root path (default: current directory)
- "프로젝트 루트 경로를 알려주세요. (기본값: 현재 디렉토리)"

**IF mode P (PR 리뷰 마이닝) selected:**
- Ask for GitHub repo info: "GitHub 레포 정보를 알려주세요 (예: owner/repo)"
- Ask for PR range: "PR을 어디까지 볼까요? (예: 최근 20개, 최근 3개월)"

**IF mode U (범용) selected:**
- Ask for tech stack: "기술 스택을 알려주세요 (예: React, TypeScript, Next.js, Tailwind)"

**IF mode I (대화형) selected:**
- No input needed here — will be handled in step-03

### 3. Convention Document Discovery

**IF mode A or U selected:**

"**컨벤션 문서가 있나요?**

**[D]** 직접 입력 — 경로를 알려주세요
**[S]** 자동 탐색 — 프로젝트에서 자동으로 찾아볼게요
**[N]** 없음 — 컨벤션 문서 없이 진행"

**IF D:** Ask for path, use Read tool to load the document
**IF S:** Search for common convention files:
- `CONVENTIONS.md`, `CONTRIBUTING.md`, `.eslintrc*`, `.prettierrc*`, `tsconfig.json`, `STYLEGUIDE.md`, `CODING_STANDARDS.md`
- Present found files: "이런 파일들을 찾았어요: [list]. 어떤 걸 사용할까요?"
**IF N:** Skip convention loading

**IF convention document found, ask:**

"**컨벤션 문서를 기준으로 체크리스트를 만들까요, 실제 코드를 분석할까요?**

**[C]** 컨벤션 문서 기준 — 문서에 정의된 규칙으로 체크리스트 생성
**[R]** 실제 코드 기준 — 코드에서 실제로 사용하는 패턴으로 생성
**[B]** 둘 다 — 컨벤션 문서 + 실제 코드 패턴 모두 반영"

### 4. Create Output File

- Copy {templateFile} to {outputFile}
- Fill in frontmatter: project name, tech stack, date, selected modes

### 5. Summarize and Auto-Proceed

"**설정 완료:**
- 선택 모드: [selected modes]
- [mode-specific inputs summary]
- 컨벤션 문서: [status]

**체크리스트 생성을 시작합니다...**"

#### Menu Handling Logic:

- IF any automatic mode (A/P/U) selected: load, read entire file, then execute {nextStepFile} (step-02-execute)
- IF only interactive mode (I) selected: skip step-02, load, read entire file, then execute {skipToInteractive} (step-03-interactive)

#### EXECUTION RULES:

- This is an auto-proceed step after all inputs are collected
- Route based on selected modes: automatic modes → step-02, interactive-only → step-03
- HALT only if user cannot provide required inputs for selected modes
- HALT if no modes are selected

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- At least 1 mode selected
- All required inputs for selected modes collected
- Convention document handled (found/skipped/loaded)
- Output file created from template
- Auto-proceeded to step-02

### FAILURE:

- Proceeding without any mode selected
- Starting checklist generation in this step
- Not asking about convention documents
- Missing required inputs for selected modes

**Master Rule:** All inputs must be collected before proceeding. No mode selected = HALT.
