# Project 15 — DevOps CLI / ops tool lab

## Progress

| | |
|---|---|
| **Step** | 15 of 22 |
| **Previous** | [Project 14 — Shell automation lab](14-shell-automation-lab.md) |
| **Next** | [Project 16 — Cloud deploy + infra automation lab](16-cloud-deploy-lab.md) |

## What you will learn

- CLI flags, exit codes, and operator user experience (UX)
- Dead-letter queue (DLQ) replay and queue inspection
- Ops tooling in Go
- When a Go CLI replaces bash glue from [Project 14](14-shell-automation-lab.md)

## Architecture pillars

| Pillar | How this project practices it |
|--------|-------------------------------|
| 2. Integration & messaging | DLQ replay, queue inspection as operator workflows |
| 5. Reliability, security, operations | CLI exit codes, ops flags, structured output for incidents |

**Required ADR(s):** tag each ADR with pillar (e.g. flag/exit conventions — **Pillar 5**).

**Framework:** [Architecture framework](../docs/concepts/architecture-framework.md)

## Before you start

- **Requires:** [Project 14](14-shell-automation-lab.md) shell toolkit patterns (strict mode, exit codes, `scripts/preflight.sh`)
- **Handbook:** [Command-line tooling](../docs/concepts/command-line-tooling.md) · [Bash](../docs/languages/bash.md)
- **Rust CLI depth:** [Project 19](19-rust-hot-path-lab.md) after Go path is green

## Problem

Ship a **Go CLI** (Rust stretch) that operates your integration stack: replay DLQ messages, drain queue depth, health-check dependencies, or probe endpoints—with proper flags, exit codes, and structured output. Bash from Project 14 wraps this binary for CI and deploy; the Go CLI owns subcommands and DLQ semantics.

## Career relevance

**Summary:** DevOps credibility comes from **tools you run at 3am**—not only services you deploy.

### In depth

CLIs are the on-ramp to infra automation ([Project 16](16-cloud-deploy-lab.md)) and Kubernetes (K8s) controllers ([Project 17](17-k8s-controller-lab.md)). This lab formalizes CLI flags, exit codes, and bounded HTTP against real [Project 6](06-async-worker-stretch.md) queue/DLQ semantics.

**Why learning this moves the needle**

- **Incident recovery:** Replaying dead-letter messages safely is a common on-call task; a CLI with `--dry-run` and idempotent keys beats ad-hoc SQL or manual queue pokes.
- **Scriptability:** Operators and CI invoke the same binary; stdout must be parseable and exit codes must mean something stable.
- **Career signal:** “We have an ops CLI” plus a clear bash wrap shows you understand **where glue ends and productized tooling begins**.

**Real-world situations this project mirrors**

- **Queue inspection at 2am:** list DLQ depth, inspect one poison message, replay after a fix—without SSH hacks.
- **Deploy hooks:** `scripts/ops-wrap.sh` from [Project 14](14-shell-automation-lab.md) calls your binary with documented env vars and forwards exit codes to CI.
- **Structured incident logs:** JSON output mode emits correlation ids that match [Project 3](03-observability-lab.md) log fields.

### How to talk about this

Your ops CLI replays DLQ with a dry-run flag and idempotent keys so incident recovery does not double-apply jobs. When interviewers ask about CLI design, mention subcommands, `--help`, non-zero exit on failure, and optional JSON stdout for log pipelines. When they ask about bash vs Go, point to `scripts/ops-wrap.sh` as glue that invokes the binary—bash does not reimplement subcommands.

## Important concepts

### CLI ergonomics

Ship subcommands with clear `--help`, stable flag names, and non-zero exit codes on failure. Stdout should be scriptable: human-readable by default, JSON when `--json` (or equivalent) is set.

### Safe replay

DLQ replay requires explicit flags—especially `--dry-run` for destructive re-drive. Document idempotency: replaying the same message twice must not double-apply side effects if the worker honors `job_id` or business keys from [Project 6](06-async-worker-stretch.md).

### Observability at the terminal

JSON output mode should include correlation ids (`request_id`, `job_id`) so terminal output joins the same log pipeline as your services. Errors belong on stderr; success payloads on stdout.

### Bash vs Go boundary

`scripts/ops-wrap.sh` calls this binary with documented env vars and forwards exit codes. Bash from [Project 14](14-shell-automation-lab.md) handles preflight and CI wiring; Go owns subcommands, parsing, and DLQ semantics.

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
