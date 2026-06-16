# Project 15 — DevOps CLI / ops tool lab

## Progress

| | |
|---|---|
| **Step** | 15 of 22 |
| **Previous** | [Project 14 — Shell automation lab](14-shell-automation-lab.md) |
| **Next** | [Project 16 — Cloud deploy + infra automation lab](16-cloud-deploy-lab.md) |

## What you will learn

- CLI flags, exit codes, and operator UX
- DLQ replay and queue inspection
- Ops tooling in Go
- When a Go CLI replaces bash glue from [Project 14](14-shell-automation-lab.md)

## Before you start

- **Requires:** [Project 14](14-shell-automation-lab.md) shell toolkit patterns (strict mode, exit codes, `scripts/preflight.sh`)
- **Handbook:** [Command-line tooling](../docs/concepts/command-line-tooling.md) · [Bash](../docs/languages/bash.md)
- **Rust CLI depth:** [Project 19](19-rust-hot-path-lab.md) after Go path is green

## Problem

Ship a **Go CLI** (Rust stretch) that operates your integration stack: replay DLQ messages, drain queue depth, health-check dependencies, or probe endpoints—with proper flags, exit codes, and structured output. Bash from Project 14 wraps this binary for CI and deploy; the Go CLI owns subcommands and DLQ semantics.

## Career relevance

**Summary:** DevOps credibility comes from **tools you run at 3am**—not only services you deploy.

### In depth

CLIs are the on-ramp to infra automation ([Project 16](16-cloud-deploy-lab.md)) and K8s controllers ([Project 17](17-k8s-controller-lab.md)). This lab formalizes CLI flags, exit codes, and bounded HTTP against real [Project 6](06-async-worker-stretch.md) queue/DLQ semantics.

## Important concepts

### Concept spotlight

| **CLI ergonomics** | Subcommands, `--help`, non-zero exit on failure, scriptable stdout |
| **Safe replay** | DLQ replay requires explicit flags; idempotent re-drive documented |
| **Observability at the terminal** | JSON output mode with correlation ids for log pipeline |
| **Bash vs Go boundary** | `scripts/ops-wrap.sh` calls this binary; bash does not reimplement subcommands |

**Interview line:** *“Our ops CLI replays DLQ with a dry-run flag and idempotent keys so incident recovery doesn’t double-apply jobs.”*

## Code repo

_TBD — e.g. `devops-cli-lab`._ Suggested folder: [`../career-projects/15-devops-cli-lab`](../career-projects/15-devops-cli-lab).

## Stack

- **Go 1.22+** — `cobra` or stdlib `flag` (document choice)
- Reads same Redis/SQS/Postgres DLQ as [Project 6](06-async-worker-stretch.md)
- Optional Rust port after [Project 19](19-rust-hot-path-lab.md)

## Success criteria

- [ ] At least two subcommands (e.g. `dlq list`, `dlq replay --id`).
- [ ] `--dry-run` for destructive operations.
- [ ] Exit code 0/1/2 documented; JSON output flag optional.
- [ ] README links to queue topology from Project 6/Project 8 lab.

## Bash scripting milestone

Ship `scripts/ops-wrap.sh` that invokes the Go binary with documented env vars and forwards exit codes—demonstrates bash-vs-Go boundary from [Project 14](14-shell-automation-lab.md).

## Testing approach (lab)

Table-driven tests for parsing; integration test against docker-compose queue.

## Exploration scenarios

1. Replay same message twice → worker idempotency prevents double effect.
2. Invalid credentials → exit 1 with stderr message.
3. Empty DLQ → exit 0 with clear message.

## Stretch

- Prometheus textfile exporter subcommand.
- Wire to [Project 16](16-cloud-deploy-lab.md) deploy hooks via `ops-wrap.sh`.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — CLI → queue/DLQ/HTTP probe with exit-code mapping.
- [ ] **ADR** — flag naming and exit-code conventions (ops contract); bash wrap vs Go CLI.
- [ ] **Performance numbers** — DLQ replay duration for N messages.
- [ ] **Failure modes** — wrong exit code masking failure; unbounded replay without dry-run.
- [ ] **Observability evidence** — CLI stdout/stderr sample on success and failure paths.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 15)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 16 — Cloud deploy + infra automation lab](16-cloud-deploy-lab.md)
