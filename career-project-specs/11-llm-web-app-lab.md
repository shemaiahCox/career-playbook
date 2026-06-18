# Project 11 — LLM-integrated web app lab

## Progress

| | |
|---|---|
| **Step** | 11 of 22 |
| **Previous** | [Project 10 — Automation bot / workflow connector lab](10-automation-bot-lab.md) |
| **Next** | [Project 12 — Multi-tenant auth + SaaS slice lab](12-multi-tenant-auth-lab.md) |

## What you will learn

- Thin BFF (backend-for-frontend) in TypeScript over Python RAG
- Streaming UX and eval-aware error handling
- Product boundary for AI features

## Architecture pillars

| Pillar | How this project practices it |
|--------|-------------------------------|
| 1. System shape | BFF in TypeScript; Python RAG behind server boundary |
| 2. Integration & messaging | Server-side `/query` proxy; no keys in browser (secondary) |
| 5. Reliability, security, operations | Streaming UX, eval-aware errors, failure modes |

**Required ADR(s):** tag each ADR with pillar (e.g. streaming vs polling — **Pillar 1**).

**Framework:** [Architecture framework](../docs/concepts/architecture-framework.md)

## Before you start

- **Requires:** [Project 2](02-rag-llm-service.md) and [Project 7](07-node-typescript-lab.md) habits

## Problem

Ship a **thin TypeScript web app** (server-rendered or minimal SPA) that talks to [Project 2](02-rag-llm-service.md) `POST /query`—streaming or polling UX, auth to your API, and **eval-aware** error states when retrieval or model fails.

## Career relevance

**Summary:** You show **LLM features in a product surface**, not only a Swagger UI—BFF patterns, streaming, and honest failure UX.

### In depth

“AI engineer” roles often mean **API + product boundary**: the UI must handle latency, partial streams, empty retrieval, and policy refusals. This lab keeps frontend scope **thin** (no Next.js curriculum)—one disciplined app proving TS + Python split.

### How to talk about this

The browser never holds model keys—the BFF calls Project 2 and surfaces retrieval versus model failures differently for support. Describe server-side proxying to `POST /query`, streaming or polling UX with cancel on navigation, and eval-aware error copy when retrieval is empty versus the model times out.

## Important concepts

### BFF and API boundary

The TypeScript server proxies to Project 2; no API keys in the browser bundle. Secrets and rate limits stay server-side; the UI talks only to your BFF.

### Streaming UX

Use SSE (Server-Sent Events) or chunked responses; cancel in-flight requests on navigation. Partial streams need cleanup so clients do not leak listeners or show stale tokens after the user leaves the page.

### Eval-aware errors

Distinguish retrieval miss versus model error versus timeout in UI copy and logs. Support should grep `request_id` from Project 2 and know whether to fix the index, the prompt, or the provider—not treat every failure as “the AI broke.”

## Code repo

_TBD — e.g. `llm-web-app-lab`._ Suggested folder: [`../career-projects/11-llm-web-app-lab`](../career-projects/11-llm-web-app-lab).

## Stack

- **TypeScript** — Vite + minimal SSR, or Express/Fastify BFF + static UI
- **Backend:** [Project 2](02-rag-llm-service.md) (required dependency)
- Optional: session auth stub for [Project 12](12-multi-tenant-auth-lab.md) prep

## Success criteria

- [ ] User can submit query; see answer with citations when Project 2 returns `cited_chunk_ids`.
- [ ] Loading, error, and empty-retrieval states documented in UI.
- [ ] `request_id` from Project 2 shown in dev/support panel or logs.
- [ ] README: sequence diagram browser → BFF → Project 2.

## Testing approach (lab)

E2E or integration: mock Project 2 failure modes; assert UI messages.

## Exploration scenarios

1. Project 2 timeout → user sees retry-safe message.
2. Empty retrieval → no hallucinated “success” UI.
3. Stream interrupted → client cleanup documented.

## Stretch

- Wire [Project 13](13-realtime-dashboard-lab.md) job-status events for long queries.
- Auth gate before query ([Project 12](12-multi-tenant-auth-lab.md)).

## Bash scripting milestone

Ship `scripts/smoke.sh` — minimal happy path (health + one API call); strict mode for reviewers.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — browser → BFF → Project 2 `POST /query` (no keys in browser).
- [ ] **ADR** — streaming vs polling UX; error surface for retrieval vs model failures.
- [ ] **Performance numbers** — time-to-first-token or query round-trip p95.
- [ ] **Failure modes** — API keys in frontend; generic 500 hiding retrieval vs model errors.
- [ ] **Observability evidence** — UI dev panel or log showing `request_id` from Project 2.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 11)
- Checklist: [LLM feature ship checklist](../checklists/llm-feature-ship.md)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 12 — Multi-tenant auth + SaaS slice lab](12-multi-tenant-auth-lab.md)
