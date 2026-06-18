# Project 14 — Shell automation lab

## Progress

| | |
|---|---|
| **Step** | 14 of 22 |
| **Previous** | [Project 13 — Real-time dashboard lab](13-realtime-dashboard-lab.md) |
| **Next** | [Project 15 — DevOps CLI / ops tool lab](15-devops-cli-lab.md) |

## What you will learn

- `set -euo pipefail`, quoting, and functions in production-shaped scripts
- Exit codes (0 success, 1 usage/error, 2 config) scriptable by continuous integration (CI) and cron
- Idempotent cron-safe scripts with explicit dry-run flags
- `curl` + `jq` for API probes against your real labs
- `shellcheck` in continuous integration (CI) and `bats-core` for testable shell logic
- When bash glue stops and a Go CLI ([Project 15](15-devops-cli-lab.md)) should take over

## Architecture pillars

| Pillar | How this project practices it |
|--------|-------------------------------|
| 5. Reliability, security, operations | CI smoke scripts, exit codes, deploy hooks, ops automation |

**Required ADR(s):** tag each ADR with pillar (e.g. Bash vs Go CLI — **Pillar 5**).

**Framework:** [Architecture framework](../docs/concepts/architecture-framework.md)

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
| `scripts/queue-depth.sh` | Redis/Amazon Simple Queue Service (SQS) depth with timeout; JSON stdout for piping |
| `scripts/logs-request-id.sh` | Grep structured logs by `request_id` ([Project 3](03-observability-lab.md)) |
| `scripts/preflight.sh` | Verify env vars, `docker`, health URLs before deploy (feeds [Project 16](16-cloud-deploy-lab.md)) |

## Career relevance

**Summary:** Backend and systems roles expect **bash literacy** for continuous integration (CI) glue, deploy hooks, and incident smoke tests—even when production command-line interfaces (CLIs) are Go or Rust.

### In depth

Employers distinguish engineers who write **fragile one-liners** from those who ship **strict-mode scripts** with exit codes, shellcheck-clean CI, and clear bash-vs-Go boundaries. This lab formalizes patterns you started in Projects 1–13 and precedes the Go ops CLI in [Project 15](15-devops-cli-lab.md).

**Why learning this moves the needle**

- **CI and cron:** Pipelines and scheduled jobs need scripts that **fail loudly** with predictable exit codes—not scripts that swallow errors and leave production in a half-deployed state.
- **Incident response:** Smoke tests against real labs (webhook, queue, logs) are how you prove “the stack is up” before paging the on-call engineer for a deeper issue.
- **Boundary discipline:** Knowing when bash stops and a typed CLI starts is a **staff-level** ops conversation; reimplementing subcommands in shell is a maintenance trap.

**Real-world situations this project mirrors**

- **Deploy preflight:** missing env vars or unhealthy dependencies caught **before** `docker compose up` or a cloud push—not after customers hit 502s.
- **Cron-safe queue checks:** a scheduled script reports Redis or Amazon Simple Queue Service (SQS) depth as JSON for alerting without re-running destructive logic on every tick.
- **Partner smoke tests:** signed POST to your webhook receiver after a deploy, with idempotency replay to prove the integration path still works.

### How to talk about this

Bash wraps your stack for smoke and deploy preflight; the Go CLI handles idempotent dead-letter queue (DLQ) replay at 3am—you do not reimplement subcommands in shell. When interviewers ask about script safety, explain strict mode (`set -euo pipefail`), documented exit codes (0 success, 1 runtime error, 2 missing config), and shellcheck in CI. When they ask about ops tooling boundaries, describe bash as glue that invokes a typed binary for anything with subcommands, config files, or long-lived maintenance workflows.

## Important concepts

### Strict mode

Enable `set -euo pipefail` on every script (or source `lib/common.sh` that does). Treat unset variables and pipeline failures as errors. Handle **expected** non-zero exits explicitly—e.g. `grep pattern file || true` when absence is normal—so strict mode does not false-positive.

### Scriptable exit codes

Document a small contract: **0** = success, **1** = runtime or usage error, **2** = missing configuration. CI, cron, and human operators can branch on these codes without parsing English stderr.

### Idempotent cron scripts

Design scripts safe to re-run: read current state, compare desired state, act only on diff. Destructive paths require an explicit `--dry-run` flag so reviewers and automation can preview changes.

### Bash vs Go CLI

Use bash for glue—env checks, invoking binaries, piping JSON with `jq`, wiring deploy hooks. Use Go (see [Project 15](15-devops-cli-lab.md)) for subcommands, structured config, DLQ semantics, and tools you maintain at 3am. Document the boundary in an architecture decision record (ADR) or README section.

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
