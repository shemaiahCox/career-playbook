# Project 21 — IoT / edge ingest + local inference lab (advanced)

## Progress

| | |
|---|---|
| **Step** | 21 of 22 |
| **Track** | **Go-first default** — use Go for MQTT ingest unless you completed [Project 19](19-rust-hot-path-lab.md). |
| **Previous** | [Project 20 — WASM / secure network component lab](20-wasm-secure-component-lab.md) (or [Project 18](18-proxy-load-balancer-lab.md) if steps 19–20 deferred) |
| **Next** | [Project 22 — Integrated platform capstone](22-integrated-platform-capstone.md) |

## What you will learn

- MQTT ingest with idempotent telemetry
- Offline buffers and edge inference hooks
- Dashboard integration via Project 13 patterns

## Architecture pillars

| Pillar | How this project practices it |
|--------|-------------------------------|
| 1. System shape | Edge ingest → queue/worker → cloud; offline buffer shape |
| 2. Integration & messaging | MQTT QoS, idempotent telemetry, at-least-once ingest |
| 3. Data architecture | Time-series write path (secondary) |
| 4. Performance & language boundaries | Edge vs cloud inference placement (secondary) |
| 5. Reliability, security, operations | Offline buffer, duplicate telemetry, failure modes |

**Required ADR(s):** tag each ADR with pillar (e.g. QoS level — **Pillar 2**; edge vs cloud inference — **Pillar 4**).

**Framework:** [Architecture framework](../docs/concepts/architecture-framework.md)

## Before you start

- **Requires:** [Project 6](06-async-worker-stretch.md) + [Project 4](04-sql-performance-lab.md)
- **Go-first path:** After [Project 18](18-proxy-load-balancer-lab.md), open this spec directly if steps 19–20 are deferred. Log the skip in [PROGRESS.md](../PROGRESS.md).
- **Deep dive (optional):** [Architecture framework](../docs/concepts/architecture-framework.md) · [Pillar 1 — Systems integration architect](../docs/concepts/systems-integration-architect.md)

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

_TBD — e.g. `iot-edge-lab`._ Suggested folder: [`../career-projects/21-iot-edge-lab`](../career-projects/21-iot-edge-lab).

## Stack

- **Ingest:** **Go** MQTT consumer (default on Go-first track); Rust optional after [Project 19](19-rust-hot-path-lab.md)
- **Simulator:** Python or Mosquitto pub script; Pi optional
- **Store:** Postgres from Project 4 schema extension
- **UI hook:** [Project 13](13-realtime-dashboard-lab.md) SSE events

## Success criteria

- [ ] Ingest ≥1 sensor type; idempotent upsert on `(device_id, sequence)` or equivalent.
- [ ] Offline scenario documented: buffer then replay.
- [ ] Dashboard or log stream shows live reading ([Project 13](13-realtime-dashboard-lab.md) integration or mock).
- [ ] README diagram: device → edge → DB → dashboard/AI.

## Bash scripting milestone

Ship `scripts/mqtt-publish-fixture.sh` — publish test telemetry with documented env vars; strict mode; exit non-zero on broker unreachable.

## Testing approach (lab)

Publish duplicate MQTT messages; assert single row. Simulate disconnect/reconnect.

## Exploration scenarios

1. Duplicate QoS1 delivery → one stored reading.
2. Broker down 5 min → buffer → replay without gaps/dupes per policy.
3. Optional Project 2 query on aggregated telemetry → citation or guardrail note.

## Stretch

- TLS to MQTT broker.
- [Project 19](19-rust-hot-path-lab.md) ingest consumer in Rust ADR.

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
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 21) · [Integration hardening](../checklists/integration-hardening.md) when HTTP/MQTT ingress applies
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 22 — Integrated platform capstone](22-integrated-platform-capstone.md)
