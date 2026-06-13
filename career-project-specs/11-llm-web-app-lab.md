# Project 11 — LLM-integrated web app lab

## Problem

Ship a **thin TypeScript web app** (server-rendered or minimal SPA) that talks to [P4](04-rag-llm-service.md) `POST /query`—streaming or polling UX, auth to your API, and **eval-aware** error states when retrieval or model fails.

## Career relevance

**Summary:** You show **LLM features in a product surface**, not only a Swagger UI—BFF patterns, streaming, and honest failure UX.

### In depth

“AI engineer” roles often mean **API + product boundary**: the UI must handle latency, partial streams, empty retrieval, and policy refusals. This lab keeps frontend scope **thin** (no Next.js curriculum)—one disciplined app proving TS + Python split.

## Concept spotlight

**Pillars:** AI & Automation · Full-Stack Platforms

| Concept | In this project you… | Pillars |
|---------|----------------------|---------|
| **BFF / API boundary** | TS server proxies to P4; no API keys in browser | Full-Stack, AI/Automation |
| **Streaming UX** | SSE or chunked response; cancel on navigation | Full-Stack |
| **Eval-aware errors** | Distinguish retrieval miss vs model error vs timeout in UI copy | AI/Automation |

**Interview line:** *“The browser never holds model keys—the BFF calls P4 and surfaces retrieval vs model failures differently for support.”*

## Code repo

_TBD — e.g. `llm-web-app-lab`._ Suggested folder: [`../career-projects/11-llm-web-app-lab`](../career-projects/11-llm-web-app-lab).

## Stack

- **TypeScript** — Vite + minimal SSR, or Express/Fastify BFF + static UI
- **Backend:** [P4](04-rag-llm-service.md) (required dependency)
- Optional: session auth stub for [P12](12-multi-tenant-auth-lab.md) prep

## Success criteria

- [ ] User can submit query; see answer with citations when P4 returns `cited_chunk_ids`.
- [ ] Loading, error, and empty-retrieval states documented in UI.
- [ ] `request_id` from P4 shown in dev/support panel or logs.
- [ ] README: sequence diagram browser → BFF → P4.

## Testing approach (lab)

E2E or integration: mock P4 failure modes; assert UI messages.

## Exploration scenarios

1. P4 timeout → user sees retry-safe message.
2. Empty retrieval → no hallucinated “success” UI.
3. Stream interrupted → client cleanup documented.

## Stretch

- Wire [P13](13-realtime-dashboard-lab.md) job-status events for long queries.
- Auth gate before query ([P12](12-multi-tenant-auth-lab.md)).

## Related

- [P4 RAG service](04-rag-llm-service.md)
- [P6 Node/TS lab](06-node-typescript-lab.md)
- [LLM feature ship checklist](../checklists/llm-feature-ship.md)
