# Project 11 — LLM-integrated web app lab

## Progress

| | |
|---|---|
| **Step** | 11 of 20 |
| **Previous** | [Project 10 — Automation bot / workflow connector lab](10-automation-bot-lab.md) |
| **Next** | [Project 12 — Multi-tenant auth + SaaS slice lab](12-multi-tenant-auth-lab.md) |

## What you will learn

- Thin BFF in TypeScript over Python RAG
- Streaming UX and eval-aware error handling
- Product boundary for AI features

## Before you start

- **Requires:** [Project 2](02-rag-llm-service.md) and [Project 7](07-node-typescript-lab.md) habits

## Problem

Ship a **thin TypeScript web app** (server-rendered or minimal SPA) that talks to [Project 5](02-rag-llm-service.md) `POST /query`—streaming or polling UX, auth to your API, and **eval-aware** error states when retrieval or model fails.

## Career relevance

**Summary:** You show **LLM features in a product surface**, not only a Swagger UI—BFF patterns, streaming, and honest failure UX.

### In depth

“AI engineer” roles often mean **API + product boundary**: the UI must handle latency, partial streams, empty retrieval, and policy refusals. This lab keeps frontend scope **thin** (no Next.js curriculum)—one disciplined app proving TS + Python split.

## Important concepts

### Concept spotlight

| **BFF / API boundary** | TS server proxies to Project 2; no API keys in browser |
| **Streaming UX** | SSE or chunked response; cancel on navigation |
| **Eval-aware errors** | Distinguish retrieval miss vs model error vs timeout in UI copy |

**Interview line:** *“The browser never holds model keys—the BFF calls Project 2 and surfaces retrieval vs model failures differently for support.”*


**Interview line:** *“The browser never holds model keys—the BFF calls Project 5 and surfaces retrieval vs model failures differently for support.”*

## Code repo

_TBD — e.g. `llm-web-app-lab`._ Suggested folder: [`../career-projects/11-llm-web-app-lab`](../career-projects/11-llm-web-app-lab).

## Stack

- **TypeScript** — Vite + minimal SSR, or Express/Fastify BFF + static UI
- **Backend:** [Project 5](02-rag-llm-service.md) (required dependency)
- Optional: session auth stub for [Project 12](12-multi-tenant-auth-lab.md) prep

## Success criteria

- [ ] User can submit query; see answer with citations when Project 5 returns `cited_chunk_ids`.
- [ ] Loading, error, and empty-retrieval states documented in UI.
- [ ] `request_id` from Project 5 shown in dev/support panel or logs.
- [ ] README: sequence diagram browser → BFF → Project 5.

## Testing approach (lab)

E2E or integration: mock Project 5 failure modes; assert UI messages.

## Exploration scenarios

1. Project 5 timeout → user sees retry-safe message.
2. Empty retrieval → no hallucinated “success” UI.
3. Stream interrupted → client cleanup documented.

## Stretch

- Wire [Project 13](13-realtime-dashboard-lab.md) job-status events for long queries.
- Auth gate before query ([Project 12](12-multi-tenant-auth-lab.md)).

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [LLM feature ship checklist](../checklists/llm-feature-ship.md)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 12 — Multi-tenant auth + SaaS slice lab](12-multi-tenant-auth-lab.md)
