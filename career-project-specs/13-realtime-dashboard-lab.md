# Project 13 — Real-time dashboard lab

## Progress

| | |
|---|---|
| **Step** | 13 of 22 |
| **Previous** | [Project 12 — Multi-tenant auth + SaaS slice lab](12-multi-tenant-auth-lab.md) |
| **Next** | [Project 14 — Shell automation lab](14-shell-automation-lab.md) |

## What you will learn

- SSE/WebSocket push with reconnect
- Backpressure and stale UI handling
- Live updates from worker events

## Before you start

- **Requires:** [Project 6](06-async-worker-stretch.md) or [Project 8](08-go-retrieval-worker-lab.md) event vocabulary
- **Handbook:** [Memory and performance — client retention](../docs/concepts/memory-and-performance.md#memory-patterns)

## Problem

Build a **TypeScript dashboard** that consumes live events from [Project 6](06-async-worker-stretch.md) / [Project 8](08-go-retrieval-worker-lab.md)—SSE or WebSocket—with reconnect, backpressure awareness, and readable ops UI (queue depth, job status, ingest progress).

## Career relevance

**Summary:** You ship **real-time full-stack** behavior—how SaaS ops and IoT dashboards actually update without polling spam.

### In depth

Real-time UIs fail on **reconnect storms**, **duplicate events**, and **unbounded client buffers**. This lab pairs with event-bus stretches in Project 8 and [Project 21](21-iot-edge-lab.md) telemetry feeds.

## Important concepts

### Concept spotlight

| **SSE / WebSocket push** | Server pushes job/telemetry events; client handles disconnect |
| **Reconnect + last-event-id** | Resume or dedupe after reconnect; document policy |
| **Backpressure awareness** | UI drops or batches high-rate events; no unbounded DOM growth |

**Interview line:** *“The dashboard uses SSE with reconnect and last-event-id so ops see live queue health without polling the API every second.”*


**Interview line:** *“The dashboard uses SSE with reconnect and last-event-id so ops see live queue health without polling the API every second.”*

## Code repo

_TBD — e.g. `realtime-dashboard-lab`._ Suggested folder: [`../career-projects/13-realtime-dashboard-lab`](../career-projects/13-realtime-dashboard-lab).

## Stack

- **TypeScript** — minimal UI (Vite/React or server-rendered + HTMX-style updates)
- Event source: Project 8 HTTP SSE endpoint, Redis stream, or NATS (document choice)
- [Handbook — WebSockets](../docs/concepts/servers-and-networking.md#websockets-and-long-polling)

## Success criteria

- [ ] Live updates when worker completes/fails jobs (wired to real or mocked Project 6/Project 8).
- [ ] Reconnect after server restart documented and tested.
- [ ] README diagram: event producer → bus/stream → dashboard.
- [ ] No API secrets in frontend bundle.

## Bash scripting milestone

Ship `scripts/smoke.sh` — minimal happy path (start stack or hit SSE endpoint); strict mode; exit 0/1 for CI.

## Testing approach (lab)

Simulate event burst; assert UI stability or batching policy.

## Exploration scenarios

1. Server restart → client reconnects within N seconds.
2. Duplicate event id → UI does not double-count.
3. 1000 events/min → UI remains usable (batch/throttle).

## Stretch

- Share components with [Project 11](11-llm-web-app-lab.md) for query progress.
- Consume [Project 21](21-iot-edge-lab.md) MQTT-forwarded telemetry.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — event source → SSE/WS → client reconnect and buffer policy.
- [ ] **ADR** — SSE vs WebSocket for this dashboard; duplicate event handling.
- [ ] **Performance numbers** — reconnect storm or client buffer limit note.
- [ ] **Failure modes** — unbounded client buffer; duplicate events after reconnect; stale UI state.
- [ ] **Observability evidence** — dashboard + log showing live event with correlation id.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 13)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 14 — Shell automation lab](14-shell-automation-lab.md)
