# BMAD Method Plus Workflows

BMAD BMM의 워크플로우를 확장한 Plus 버전 모음. 외부 스킬을 직접 참조하여 TDD, 병렬 에이전트 디스패치, 체크리스트 기반 코드 리뷰를 지원합니다.

## 포함된 워크플로우

### 1. dev-story-plus

스토리 구현 워크플로우 — TDD 강제 + 병렬 에이전트 디스패치

- **TDD 스킬 강제 로드**: 구현 전 `~/.claude/skills/test-driven-development/SKILL.md`를 Read로 로드
- **병렬 에이전트 디스패치**: 독립적인 태스크 2개 이상 시 자동으로 병렬 에이전트 디스패치
- **멀티 세션 지원**: step-01b-continue로 이전 세션 이어서 작업 가능

### 2. code-review-plus

체크리스트 기반 코드 리뷰 워크플로우 — 주관적 판단 완전 금지

- **체크리스트 필수 입력**: 체크리스트 md 파일 없으면 HALT (절대 진행 불가)
- **주관적 판단 금지**: 체크리스트에 없는 항목은 finding이 아님
- **파일별 병렬 검토**: 각 파일을 독립 에이전트로 병렬 검토
- **우선순위 리포트**: HIGH/MEDIUM/LOW 우선순위 분류
- **코드 수정**: 사용자 요청 시 위반 항목 자동 수정
- **리뷰 소스 3가지**: 스토리 문서 / git diff / 직접 지정

## 포함된 스킬 (from [obra/superpowers](https://github.com/obra/superpowers))

| 스킬 | 설명 |
|------|------|
| `test-driven-development` | RED-GREEN-REFACTOR TDD 프로세스 + 테스트 안티패턴 가이드 |
| `systematic-debugging` | 4단계 체계적 디버깅 + 근본 원인 추적 + 방어적 검증 |
| `dispatching-parallel-agents` | 독립 태스크의 병렬 에이전트 디스패치 패턴 |

## 설치

### 자동 설치

```bash
git clone https://github.com/hojeongna/bmad-method-plus-workflow.git
cd bmad-method-plus-workflow
bash install.sh
```

### 수동 설치

```bash
# 스킬 복사
cp -r skills/* ~/.claude/skills/

# 워크플로우 복사
mkdir -p ~/.claude/workflows
cp -r workflows/* ~/.claude/workflows/

# 커맨드 복사
cp commands/* ~/.claude/commands/
```

## 설치 결과 구조

```
~/.claude/
├── commands/
│   ├── bmad-bmm-dev-story-plus.md
│   └── bmad-bmm-code-review-plus.md
├── workflows/
│   ├── dev-story-plus/
│   │   ├── workflow.md
│   │   ├── steps-c/ (8 step files)
│   │   └── data/checklist.md
│   └── code-review-plus/
│       ├── workflow.md
│       └── steps-c/ (6 step files)
└── skills/
    ├── test-driven-development/
    │   ├── SKILL.md
    │   └── testing-anti-patterns.md
    ├── systematic-debugging/
    │   ├── SKILL.md
    │   ├── root-cause-tracing.md
    │   ├── defense-in-depth.md
    │   └── condition-based-waiting.md
    └── dispatching-parallel-agents/
        └── SKILL.md
```

## 사용법

BMAD BMM이 설치된 프로젝트에서:

```
# 스토리 구현 (TDD + 병렬 에이전트)
/bmad-bmm-dev-story-plus

# 체크리스트 기반 코드 리뷰
/bmad-bmm-code-review-plus
```

## 요구사항

- [Claude Code](https://claude.com/claude-code) CLI
- [BMAD Method](https://github.com/bmadcode/BMAD-METHOD) BMM 모듈이 프로젝트에 설치되어 있어야 함 (`_bmad/bmm/config.yaml` 필요)

## 워크플로우 흐름

### dev-story-plus

```
step-01-init (또는 step-01b-continue)
    ↓
step-02-setup
    ↓
step-03-analyze ← ─ ─ ─ ─ ─ ─ ─ ┐
    ↓ (병렬 or 순차)              │ (남은 태스크 있으면 루프)
step-04-implement                 │
    ↓                             │
step-05-validate ─ ─ ─ ─ ─ ─ ─ ─ ┘
    ↓ (전부 완료)
step-06-completion
    ↓
step-07-communicate (END)
```

### code-review-plus

```
step-01-init
    │ 체크리스트 로드 (없으면 HALT)
    │ 리뷰 소스 선택: [S] 스토리 / [D] git diff / [M] 직접 지정
    ↓
step-02-collect
    │ 소스별 파일 수집
    ↓
step-03-review
    │ 병렬 에이전트 디스패치 (파일별)
    │ 각 에이전트: 체크리스트 기준으로만 검토
    ↓
step-04-report
    │ 결과 취합 + 우선순위 (HIGH/MEDIUM/LOW)
    │ 리포트 출력
    │   [F] 수정 진행 → step-05
    │   [S] 수정 없이 완료 → step-06
    ↓
step-05-fix (optional)
    │ 위반 항목 코드 수정
    ↓
step-06-complete (END)
    │ 스토리 기반이면 review → done
    │ 완료 요약
```
