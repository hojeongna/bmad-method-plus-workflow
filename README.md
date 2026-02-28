# BMAD dev-story-plus Workflow

BMAD BMM의 `dev-story` 워크플로우를 확장한 버전으로, 외부 스킬을 직접 참조하여 TDD와 병렬 에이전트 디스패치를 강제합니다.

## 주요 특징

- **TDD 스킬 강제 로드**: 구현 전 `~/.claude/skills/test-driven-development/SKILL.md`를 Read로 로드하고 Iron Law를 따름
- **병렬 에이전트 디스패치**: 독립적인 태스크 2개 이상 시 자동으로 병렬 에이전트 디스패치
- **멀티 세션 지원**: step-01b-continue로 이전 세션 이어서 작업 가능
- **스킬 기반 아키텍처**: 워크플로우 내 인라인이 아닌 외부 스킬 파일 직접 참조

## 포함된 파일

### Skills (from [obra/superpowers](https://github.com/obra/superpowers))
| 스킬 | 설명 |
|------|------|
| `test-driven-development` | RED-GREEN-REFACTOR TDD 프로세스 + 테스트 안티패턴 가이드 |
| `systematic-debugging` | 4단계 체계적 디버깅 + 근본 원인 추적 + 방어적 검증 |
| `dispatching-parallel-agents` | 독립 태스크의 병렬 에이전트 디스패치 패턴 |

### Workflow
| 파일 | 역할 |
|------|------|
| `workflow.md` | 메인 워크플로우 정의 (스킬 경로, 로딩 프로토콜) |
| `step-01-init.md` | 스토리 탐색 + TDD 스킬 로드 |
| `step-01b-continue.md` | 멀티 세션 재개 |
| `step-02-setup.md` | sprint-status 업데이트 |
| `step-03-analyze.md` | 태스크 독립성 분석 + 병렬/순차 분기 |
| `step-04-implement.md` | TDD RED-GREEN-REFACTOR 또는 병렬 디스패치 |
| `step-05-validate.md` | 5개 검증 게이트 + 태스크 루프 |
| `step-06-completion.md` | DoD 체크리스트 + 스토리 완료 |
| `step-07-communicate.md` | 완료 요약 + 다음 단계 제안 |

### Command
| 파일 | 설명 |
|------|------|
| `bmad-bmm-dev-story-plus.md` | `/bmad-bmm-dev-story-plus` 슬래시 커맨드 |

## 설치

### 자동 설치

```bash
git clone https://github.com/hojeongna/bmad-mathod-dev-plus-workflow.git
cd bmad-mathod-dev-plus-workflow
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
│   └── bmad-bmm-dev-story-plus.md
├── workflows/
│   └── dev-story-plus/
│       ├── workflow.md
│       ├── steps-c/ (8 step files)
│       └── data/checklist.md
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
/bmad-bmm-dev-story-plus
```

또는 특정 스토리 파일 지정:

```
/bmad-bmm-dev-story-plus 이 스토리 구현해줘 [story-file-path]
```

## 요구사항

- [Claude Code](https://claude.com/claude-code) CLI
- [BMAD Method](https://github.com/bmadcode/BMAD-METHOD) BMM 모듈이 프로젝트에 설치되어 있어야 함 (`_bmad/bmm/config.yaml` 필요)

## 워크플로우 흐름

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
