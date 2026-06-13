# Project 14 — DevOps CLI / ops tool lab

## Progress

| | |
|---|---|
| **Step** | 14 of 21 |
| **Previous** | [Project 13 — Real-time dashboard lab](13-realtime-dashboard-lab.md) |
| **Next** | [Project 15 — Cloud deploy + infra automation lab](15-cloud-deploy-lab.md) |

## What you will learn

- CLI flags, exit codes, and operator UX
- DLQ replay and queue inspection
- Ops tooling in Go

## Before you start

- **Handbook:** [Command-line tooling](../docs/concepts/command-line-tooling.md)

## Problem

Ship a **Go CLI** (Rust stretch) that operates your integration stack: replay DLQ messages, drain queue depth, health-check dependencies, or probe endpoints—with proper flags, exit codes, and structured output.

## Career relevance

**Summary:** DevOps credibility comes from **tools you run at 3am**—not only services you deploy.

### In depth

CLIs are the on-ramp to infra automation ([Project 15](15-cloud-deploy-lab.md)) and K8s controllers ([Project 16](16-k8s-controller-lab.md)). This lab formalizes CLI flags, exit codes, and bounded HTTP against real [Project 6](06-async-worker-stretch.md) queue/DLQ semantics.

## Important concepts

### Concept spotlight

| **CLI ergonomics** | Subcommands, `--help`, non-zero exit on failure, scriptable stdout |
| **Safe replay** | DLQ replay requires explicit flags; idempotent re-drive documented |
| **Observability at the terminal** | JSON output mode with correlation ids for log pipeline |

**Interview line:** *“Our ops CLI replays DLQ with a dry-run flag and idempotent keys so incident recovery doesn’t double-apply jobs.”*


**Interview line:** *“Our ops CLI replays DLQ with a dry-run flag and idempotent keys so incident recovery doesn’t double-apply jobs.”*

## Code repo

_TBD — e.g. `devops-cli-lab`._ Suggested folder: [`../career-projects/14-devops-cli-lab`](../career-projects/14-devops-cli-lab).

## Stack

- **Go 1.22+** — `cobra` or stdlib `flag` (document choice)
- Reads same Redis/SQS/Postgres DLQ as [Project 6](06-async-worker-stretch.md)
- Optional Rust port after [Project 18](18-rust-hot-path-lab.md)

## Success criteria

- [ ] At least two subcommands (e.g. `dlq list`, `dlq replay --id`).
- [ ] `--dry-run` for destructive operations.
- [ ] Exit code 0/1/2 documented; JSON output flag optional.
- [ ] README links to queue topology from Project 6/Project 8 lab.

## Testing approach (lab)

Table-driven tests for parsing; integration test against docker-compose queue.

## Exploration scenarios

1. Replay same message twice → worker idempotency prevents double effect.
2. Invalid credentials → exit 1 with stderr message.
3. Empty DLQ → exit 0 with clear message.

## Stretch

- Prometheus textfile exporter subcommand.
- Wire to [Project 15](15-cloud-deploy-lab.md) deploy hooks.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — CLI → queue/DLQ/HTTP probe with exit-code mapping.
- [ ] **ADR** — flag naming and exit-code conventions (ops contract).
- [ ] **Performance numbers** — DLQ replay duration for N messages.
- [ ] **Failure modes** — wrong exit code masking failure; unbounded replay without dry-run.
- [ ] **Observability evidence** — CLI stdout/stderr sample on success and failure paths.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 14)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 15 — Cloud deploy + infra automation lab](15-cloud-deploy-lab.md)
