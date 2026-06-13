# Project 13 — Real-time dashboard lab

## Problem

Build a **TypeScript dashboard** that consumes live events from [P5](05-async-worker-stretch.md) / [P9](09-go-retrieval-worker-lab.md)—SSE or WebSocket—with reconnect, backpressure awareness, and readable ops UI (queue depth, job status, ingest progress).

## Career relevance

**Summary:** You ship **real-time full-stack** behavior—how SaaS ops and IoT dashboards actually update without polling spam.

### In depth

Real-time UIs fail on **reconnect storms**, **duplicate events**, and **unbounded client buffers**. This lab pairs with event-bus stretches in P9 and [P23](23-iot-edge-lab.md) telemetry feeds.

## Concept spotlight

**Pillars:** Full-Stack Platforms · IoT & Edge

| Concept | In this project you… | Pillars |
|---------|----------------------|---------|
| **SSE / WebSocket push** | Server pushes job/telemetry events; client handles disconnect | Full-Stack, IoT |
| **Reconnect + last-event-id** | Resume or dedupe after reconnect; document policy | Full-Stack, DevOps |
| **Backpressure awareness** | UI drops or batches high-rate events; no unbounded DOM growth | Full-Stack |

**Interview line:** *“The dashboard uses SSE with reconnect and last-event-id so ops see live queue health without polling the API every second.”*

## Code repo

_TBD — e.g. `realtime-dashboard-lab`._ Suggested folder: [`../career-projects/13-realtime-dashboard-lab`](../career-projects/13-realtime-dashboard-lab).

## Stack

- **TypeScript** — minimal UI (Vite/React or server-rendered + HTMX-style updates)
- Event source: P9 HTTP SSE endpoint, Redis stream, or NATS (document choice)
- [Handbook — WebSockets](../docs/handbook/servers-and-networking.md#websockets-and-long-polling)

## Success criteria

- [ ] Live updates when worker completes/fails jobs (wired to real or mocked P5/P9).
- [ ] Reconnect after server restart documented and tested.
- [ ] README diagram: event producer → bus/stream → dashboard.
- [ ] No API secrets in frontend bundle.

## Testing approach (lab)

Simulate event burst; assert UI stability or batching policy.

## Exploration scenarios

1. Server restart → client reconnects within N seconds.
2. Duplicate event id → UI does not double-count.
3. 1000 events/min → UI remains usable (batch/throttle).

## Stretch

- Share components with [P11](11-llm-web-app-lab.md) for query progress.
- Consume [P23](23-iot-edge-lab.md) MQTT-forwarded telemetry.

## Related

- [P9 Go lab stretches](09-go-retrieval-worker-lab.md#stretch)
- [Engineering pillars](../docs/paths/engineering-pillars.md)
