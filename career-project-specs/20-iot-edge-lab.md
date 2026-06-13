# Project 20 — IoT / edge ingest + local inference lab (advanced)

## Progress

| | |
|---|---|
| **Step** | 20 of 21 |
| **Previous** | [Project 19 — WASM / secure network component lab](19-wasm-secure-component-lab.md) |
| **Next** | — |

## What you will learn

- MQTT ingest with idempotent telemetry
- Offline buffers and edge inference hooks
- Dashboard integration via Project 13 patterns

## Before you start

- **Requires:** [Project 6](06-async-worker-stretch.md) + [Project 4](04-sql-performance-lab.md)
- **Deep dive (optional):** [Systems integration architect](../docs/concepts/systems-integration-architect.md)

## Problem

Build an **edge ingest path**: MQTT (or HTTP) telemetry from sensor simulator or Raspberry Pi → **idempotent** upsert into [Project 4](04-sql-performance-lab.md) Postgres → optional **local inference** call to [Project 2](02-rag-llm-service.md) or small model stub → events to [Project 13](13-realtime-dashboard-lab.md).

## Career relevance

**Summary:** IoT + AI edge is a **niche with demand**—you prove telemetry reliability (at-least-once, offline buffer) not only cloud CRUD.

### In depth

**Wave 3 — advanced.** Requires [Project 6](06-async-worker-stretch.md) queue/idempotency habits and [Project 4](04-sql-performance-lab.md) storage. Smart-home / sensor network scope stays **one load-bearing demo**, not a firmware degree.

## Important concepts

### Concept spotlight

| **MQTT / at-least-once telemetry** | Subscribe with QoS; handle duplicate messages idempotently |
| **Offline buffer + replay** | Edge stores batch when uplink down; replay without double-count |
| **Local inference boundary** | Optional call to Project 2 or edge model; document latency/privacy tradeoff |

**Interview line:** *“Telemetry uses device id + sequence for idempotent upsert; edge buffers offline and replays without inflating readings.”*


**Interview line:** *“Telemetry uses device id + sequence for idempotent upsert; edge buffers offline and replays without inflating readings.”*

## Code repo

_TBD — e.g. `iot-edge-lab`._ Suggested folder: [`../career-projects/20-iot-edge-lab`](../career-projects/20-iot-edge-lab).

## Stack

- **Ingest:** Go or Rust MQTT consumer (document choice)
- **Simulator:** Python or Mosquitto pub script; Pi optional
- **Store:** Postgres from Project 4 schema extension
- **UI hook:** [Project 13](13-realtime-dashboard-lab.md) SSE events

## Success criteria

- [ ] Ingest ≥1 sensor type; idempotent upsert on `(device_id, sequence)` or equivalent.
- [ ] Offline scenario documented: buffer then replay.
- [ ] Dashboard or log stream shows live reading ([Project 13](13-realtime-dashboard-lab.md) integration or mock).
- [ ] README diagram: device → edge → DB → dashboard/AI.

## Testing approach (lab)

Publish duplicate MQTT messages; assert single row. Simulate disconnect/reconnect.

## Exploration scenarios

1. Duplicate QoS1 delivery → one stored reading.
2. Broker down 5 min → buffer → replay without gaps/dupes per policy.
3. Optional Project 2 query on aggregated telemetry → citation or guardrail note.

## Stretch

- TLS to MQTT broker.
- [Project 18](18-rust-hot-path-lab.md) ingest consumer in Rust ADR.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — MQTT/HTTP ingest → queue/worker → Postgres → optional Project 2 query → Project 13 dashboard hook.
- [ ] **ADR** — QoS level, offline buffer strategy, edge vs cloud inference boundary.
- [ ] **Performance numbers** — ingest throughput or duplicate-delivery handling latency; N/A only with reason.
- [ ] **Failure modes** — duplicate QoS1 delivery, broker offline buffer overflow, cross-tenant telemetry leak.
- [ ] **Observability evidence** — live reading on dashboard or structured log with device id + sequence.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 20) · [Integration hardening](../checklists/integration-hardening.md) when HTTP/MQTT ingress applies
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 21 — Integrated platform capstone](21-integrated-platform-capstone.md)
