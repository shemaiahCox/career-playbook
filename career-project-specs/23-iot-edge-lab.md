# Project 23 — IoT / edge ingest + local inference lab (advanced)

## Problem

Build an **edge ingest path**: MQTT (or HTTP) telemetry from sensor simulator or Raspberry Pi → **idempotent** upsert into [P7](07-sql-performance-lab.md) Postgres → optional **local inference** call to [P4](04-rag-llm-service.md) or small model stub → events to [P13](13-realtime-dashboard-lab.md).

## Career relevance

**Summary:** IoT + AI edge is a **niche with demand**—you prove telemetry reliability (at-least-once, offline buffer) not only cloud CRUD.

### In depth

**Wave 3 — advanced.** Requires [P5](05-async-worker-stretch.md) queue/idempotency habits and [P7](07-sql-performance-lab.md) storage. Smart-home / sensor network scope stays **one load-bearing demo**, not a firmware degree.

## Concept spotlight

**Pillars:** IoT & Edge · AI & Automation

| Concept | In this project you… | Pillars |
|---------|----------------------|---------|
| **MQTT / at-least-once telemetry** | Subscribe with QoS; handle duplicate messages idempotently | IoT, AI/Automation |
| **Offline buffer + replay** | Edge stores batch when uplink down; replay without double-count | IoT |
| **Local inference boundary** | Optional call to P4 or edge model; document latency/privacy tradeoff | IoT, AI/Automation |

**Interview line:** *“Telemetry uses device id + sequence for idempotent upsert; edge buffers offline and replays without inflating readings.”*

## Code repo

_TBD — e.g. `iot-edge-lab`._ Suggested folder: [`../career-projects/23-iot-edge-lab`](../career-projects/23-iot-edge-lab).

## Stack

- **Ingest:** Go or Rust MQTT consumer (document choice)
- **Simulator:** Python or Mosquitto pub script; Pi optional
- **Store:** Postgres from P7 schema extension
- **UI hook:** [P13](13-realtime-dashboard-lab.md) SSE events

## Success criteria

- [ ] Ingest ≥1 sensor type; idempotent upsert on `(device_id, sequence)` or equivalent.
- [ ] Offline scenario documented: buffer then replay.
- [ ] Dashboard or log stream shows live reading ([P13](13-realtime-dashboard-lab.md) integration or mock).
- [ ] README diagram: device → edge → DB → dashboard/AI.

## Testing approach (lab)

Publish duplicate MQTT messages; assert single row. Simulate disconnect/reconnect.

## Exploration scenarios

1. Duplicate QoS1 delivery → one stored reading.
2. Broker down 5 min → buffer → replay without gaps/dupes per policy.
3. Optional P4 query on aggregated telemetry → citation or guardrail note.

## Stretch

- TLS to MQTT broker.
- [P21](21-rust-hot-path-lab.md) ingest consumer in Rust ADR.

## Related

- [P13 Real-time dashboard](13-realtime-dashboard-lab.md)
- [Engineering pillars — IoT](../docs/paths/engineering-pillars.md#pillar-5--iot--edge-rust--python--ts)
- [Integration-automation map](../docs/stacks/integration-automation.md)

**Wave:** 3 (advanced)
