# Project 15 — DevOps CLI / ops tool lab

## Problem

Ship a **Go CLI** (Rust stretch) that operates your integration stack: replay DLQ messages, drain queue depth, health-check dependencies, or probe endpoints—with proper flags, exit codes, and structured output.

## Career relevance

**Summary:** DevOps credibility comes from **tools you run at 3am**—not only services you deploy.

### In depth

CLIs are the on-ramp to infra automation ([P16](16-cloud-deploy-lab.md)) and K8s controllers ([P17](17-k8s-controller-lab.md)). This formalizes patterns from [go-cli-http-probe](../../exploration-projects/go-cli-http-probe/) against real [P5](05-async-worker-stretch.md) queue/DLQ semantics.

## Concept spotlight

**Pillars:** DevOps & Cloud

| Concept | In this project you… | Pillars |
|---------|----------------------|---------|
| **CLI ergonomics** | Subcommands, `--help`, non-zero exit on failure, scriptable stdout | DevOps |
| **Safe replay** | DLQ replay requires explicit flags; idempotent re-drive documented | DevOps, AI/Automation |
| **Observability at the terminal** | JSON output mode with correlation ids for log pipeline | DevOps |

**Interview line:** *“Our ops CLI replays DLQ with a dry-run flag and idempotent keys so incident recovery doesn’t double-apply jobs.”*

## Code repo

_TBD — e.g. `devops-cli-lab`._ Suggested folder: [`../career-projects/15-devops-cli-lab`](../career-projects/15-devops-cli-lab).

## Stack

- **Go 1.22+** — `cobra` or stdlib `flag` (document choice)
- Reads same Redis/SQS/Postgres DLQ as [P5](05-async-worker-stretch.md)
- Optional Rust port after [P21](21-rust-hot-path-lab.md)

## Success criteria

- [ ] At least two subcommands (e.g. `dlq list`, `dlq replay --id`).
- [ ] `--dry-run` for destructive operations.
- [ ] Exit code 0/1/2 documented; JSON output flag optional.
- [ ] README links to queue topology from P5/P9 lab.

## Testing approach (lab)

Table-driven tests for parsing; integration test against docker-compose queue.

## Exploration scenarios

1. Replay same message twice → worker idempotency prevents double effect.
2. Invalid credentials → exit 1 with stderr message.
3. Empty DLQ → exit 0 with clear message.

## Stretch

- Prometheus textfile exporter subcommand.
- Wire to [P16](16-cloud-deploy-lab.md) deploy hooks.

## Related

- [go-cli-http-probe](../../exploration-projects/go-cli-http-probe/)
- [P5 Async worker](05-async-worker-stretch.md)
- [Command-line tooling handbook](../docs/handbook/command-line-tooling.md)
