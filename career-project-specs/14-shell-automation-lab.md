# Project 14 — Shell automation lab

## Progress

| | |
|---|---|
| **Step** | 14 of 22 |
| **Previous** | [Project 13 — Real-time dashboard lab](13-realtime-dashboard-lab.md) |
| **Next** | [Project 15 — DevOps CLI / ops tool lab](15-devops-cli-lab.md) |

## What you will learn

- `set -euo pipefail`, quoting, and functions in production-shaped scripts
- Exit codes (0 success, 1 usage/error, 2 config) scriptable by CI and cron
- Idempotent cron-safe scripts with explicit dry-run flags
- `curl` + `jq` for API probes against your real labs
- `shellcheck` in CI and `bats-core` for testable shell logic
- When bash glue stops and a Go CLI ([Project 15](15-devops-cli-lab.md)) should take over

## Before you start

- **Requires:** At least one runnable lab from Projects 1, 3, 6, or 8 (webhook, logs, or queue)
- **Handbook:** [Command-line tooling — Bash scripting](../docs/concepts/command-line-tooling.md#bash-scripting-patterns-and-safety)
- **Stack map:** [Bash / shell automation](../docs/languages/bash.md)
- **Prior milestones:** Per-project `scripts/` from Projects 1–13 (health checks, smoke, fixtures)

## Problem

Ship a **`scripts/` toolkit** that operates on your real playbook labs—not toy echo scripts. Scripts must be safe to run from CI, cron, and a reviewer's laptop with documented env vars and exit codes.

Minimum deliverables:

| Script | Purpose |
|--------|---------|
| `lib/common.sh` | Shared logging, `die()`, strict-mode helpers |
| `scripts/webhook-smoke.sh` | Signed POST to [Project 1](01-integration-webhook-receiver.md) receiver; assert 2xx; optional idempotency replay |
| `scripts/queue-depth.sh` | Redis/SQS depth with timeout; JSON stdout for piping |
| `scripts/logs-request-id.sh` | Grep structured logs by `request_id` ([Project 3](03-observability-lab.md)) |
| `scripts/preflight.sh` | Verify env vars, `docker`, health URLs before deploy (feeds [Project 16](16-cloud-deploy-lab.md)) |

## Career relevance

**Summary:** Backend and systems roles expect **bash literacy** for CI glue, deploy hooks, and incident smoke tests—even when production CLIs are Go or Rust.

### In depth

Employers distinguish engineers who write **fragile one-liners** from those who ship **strict-mode scripts** with exit codes, shellcheck-clean CI, and clear bash-vs-Go boundaries. This lab formalizes patterns you started in Projects 1–13 and precedes the Go ops CLI in [Project 15](15-devops-cli-lab.md).

**Interview line:** *“Bash wraps our stack for smoke and deploy preflight; the Go CLI handles idempotent DLQ replay at 3am—we don't reimplement subcommands in shell.”*

## Important concepts

### Concept spotlight

| **Strict mode** | `set -euo pipefail`; handle expected non-zero (`grep \|\| true`) |
| **Scriptable exit codes** | 0 = success, 1 = runtime/usage error, 2 = missing config |
| **Idempotent cron scripts** | Safe to re-run; dry-run flag for destructive paths |
| **Bash vs Go CLI** | Bash for glue; Go for subcommands, config, and long-lived ops tools |

## Code repo

_TBD — e.g. `shell-automation-lab`._ Suggested folder: [`../career-projects/14-shell-automation-lab`](../career-projects/14-shell-automation-lab).

## Stack

- **Bash 5+** — `#!/usr/bin/env bash` with strict mode on every script
- **shellcheck** — CI gate; zero warnings on `scripts/` and `lib/`
- **bats-core** — unit tests for parsing, exit codes, and helpers
- **jq**, **curl** — API probes and JSON stdout
- Optional: **shfmt** for consistent formatting

## Success criteria

- [ ] At least four scripts under `scripts/` plus shared `lib/common.sh`.
- [ ] Every script uses `set -euo pipefail` (or sources `lib/common.sh` that enables it).
- [ ] Exit codes 0/1/2 documented in README; JSON output mode on at least one script.
- [ ] `shellcheck` passes in CI (GitHub Actions or documented local command).
- [ ] At least one `*.bats` test file with passing tests.
- [ ] README lists reviewer **run order** (which env vars, which lab must be up).
- [ ] ADR or README section: when this repo uses bash vs when [Project 15](15-devops-cli-lab.md) Go CLI is appropriate.

## Bash scripting milestone

This project **is** the spine bash lab. Earlier per-project milestones (Projects 1–13) feed into this toolkit; [Project 15](15-devops-cli-lab.md) adds `scripts/ops-wrap.sh` calling the Go binary.

## Testing approach (lab)

- **bats:** Table-driven tests for argument parsing, exit codes, and `lib/common.sh` helpers—no live stack required.
- **Integration:** One script (e.g. `webhook-smoke.sh` or `preflight.sh`) run against docker-compose stack; document required services.
- **CI:** `shellcheck scripts/*.sh lib/*.sh` and `bats test/` on every PR.

## Exploration scenarios

1. Missing `WEBHOOK_SECRET` → exit 2 with stderr message (config error).
2. Webhook returns 401 → exit 1; stdout/stderr suitable for CI log.
3. `shellcheck` flags unquoted variable → fix before merge.
4. Run `preflight.sh` twice → idempotent (second run same exit 0 if env unchanged).

## Stretch

- Wire `preflight.sh` into [Project 16](16-cloud-deploy-lab.md) deploy README.
- Cron example in README (`*/5 * * * *` queue-depth check with log append).
- Prometheus textfile exporter subcommand pattern (bash writes `.prom` file).

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — reviewer laptop / CI → scripts → labs (webhook, queue, logs).
- [ ] **ADR** — bash vs Go CLI boundary; strict mode and exit-code policy.
- [ ] **Performance numbers** — N/A or smoke-script wall-clock against local stack.
- [ ] **Failure modes** — unquoted vars, missing `pipefail`, secrets in argv, silent `curl` failures.
- [ ] **Observability evidence** — script log line with timestamp and exit code from CI run.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 14)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 15 — DevOps CLI / ops tool lab](15-devops-cli-lab.md)
