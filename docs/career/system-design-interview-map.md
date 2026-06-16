# System design interview map — classic problems ↔ playbook

**Use this:** Prepare for **Google/Meta system design rounds** by mapping classic problems to labs you ship and gaps you study. Companion to [Big Tech benchmark](big-tech-benchmark.md).

**Not the learning path** — follow [Project 1 → 22](../../README.md#progression-step-1--22) for hands-on depth. Use this doc for **weekend reading** and **mock SD practice** (2×/week per [big-tech-benchmark](big-tech-benchmark.md)).

---

## How to practice a system design problem

45–60 minute structure (say aloud or whiteboard):

1. **Requirements** (5 min) — functional + non-functional (scale, latency, consistency).
2. **Capacity estimate** (5 min) — users, QPS, storage (order-of-magnitude OK).
3. **API design** (5 min) — key endpoints, idempotency where needed.
4. **Data model** (10 min) — tables, keys, indexes; read vs write path.
5. **High-level diagram** (10 min) — clients, LB, services, cache, queue, DB.
6. **Deep dive** (15 min) — one hot path (fan-out, sharding, or consistency).
7. **Failure modes** (5 min) — partial outage, duplicate delivery, cache stampede.

**Handbook refs:** [Database design](../concepts/database-design.md) · [Messaging and RPC](../concepts/messaging-and-rpc.md) · [Software engineering](../concepts/software-engineering.md) · [Servers and networking](../concepts/servers-and-networking.md)

---

## Classic problems matrix

| Classic SD problem | What your playbook proves | Gap to study | Optional lab |
|--------------------|----------------------------|--------------|--------------|
| **URL shortener** | [P1](../../career-project-specs/01-integration-webhook-receiver.md) idempotency; [P4](../../career-project-specs/04-sql-performance-lab.md) indexes | Base62 encoding, read-heavy cache, sharding by hash | — |
| **News feed / timeline** | [P6](../../career-project-specs/06-async-worker-stretch.md) queue; [P8](../../career-project-specs/08-go-retrieval-worker-lab.md) worker | Fan-out on write vs read, ranking, celebrity problem | — |
| **Chat / messaging** | [P13](../../career-project-specs/13-realtime-dashboard-lab.md) SSE/WS | WebSocket scale, presence, message ordering | — |
| **Notifications** | P1/P6 idempotency + DLQ | Multi-channel fan-out, priority, delivery guarantees | **[P24](../../career-project-specs/24-notification-fanout-lab.md)** |
| **Rate limiter** | P8 bounded concurrency | Token bucket, sliding window, Redis cluster, global vs per-user | **[P23](../../career-project-specs/23-rate-limiter-gateway-lab.md)** |
| **Search / autocomplete** | P4 vectors; trie in [algorithms handbook](../concepts/algorithms-and-data-structures.md#trie-prefix-tree) | Inverted index, ranking, prefix cache | **[P25](../../career-project-specs/25-search-autocomplete-lab.md)** |
| **Pastebin / file store** | [P5](../../career-project-specs/05-contract-first-api.md) contracts | Blob storage (S3/GCS), CDN, multipart upload | — |
| **Distributed cache** | Redis in P6/P8 | Eviction (LRU), consistency, thundering herd | P23 overlap |
| **Video / image upload** | P6 async worker | Chunked upload, transcoding queue, progress API | — |
| **Payment / webhook system** | **P1** (core story) | Ledger idempotency, reconciliation, exactly-once illusion | Shipped lab |
| **RAG / LLM serving** | [P2](../../career-project-specs/02-rag-llm-service.md), [P11](../../career-project-specs/11-llm-web-app-lab.md) | Embedding cache, guardrails, cost/latency SLO | Shipped lab |
| **Distributed job scheduler** | P6/P8 workers | Cron at scale, lease/visibility, priority queues | P24 overlap |
| **API gateway / BFF** | [P7](../../career-project-specs/07-node-typescript-lab.md), [P11](../../career-project-specs/11-llm-web-app-lab.md) | Auth termination, routing, aggregation | P23 overlap |
| **Multi-tenant SaaS** | [P12](../../career-project-specs/12-multi-tenant-auth-lab.md) | Row-level security, noisy neighbor, per-tenant rate limits | — |
| **Metrics / observability platform** | [P3](../../career-project-specs/03-observability-lab.md), P8 `/metrics` | Time-series DB, cardinality, sampling | — |
| **IoT telemetry ingest** | [P21](../../career-project-specs/21-iot-edge-lab.md) | MQTT QoS, edge buffer, time-series write path | — |

---

## Deep dives by problem

### URL shortener

**Functional:** Create short URL, redirect, optional analytics.

**Your proof:** Idempotent `POST /shorten` with client key ([P1](../../career-project-specs/01-integration-webhook-receiver.md)); indexed lookup ([P4](../../career-project-specs/04-sql-performance-lab.md)).

**Study gaps:**

- Base62 vs hash collision handling
- **Read:write ratio** — cache hot URLs (CDN or Redis)
- Shard by `short_code` hash; consistent hashing vocabulary
- Redirect **301 vs 302** for analytics

**Interview line:** *"Shorten is write-light, redirect is read-heavy — I'd cache the mapping and use a DB unique index on the code."*

---

### News feed / timeline

**Functional:** Users post; followers see personalized feed.

**Your proof:** Async fan-out via queue ([P6](../../career-project-specs/06-async-worker-stretch.md)); worker pool ([P8](../../career-project-specs/08-go-retrieval-worker-lab.md)).

**Study gaps:**

- **Fan-out on write** (push to follower feeds) vs **fan-out on read** (merge at read time)
- Celebrity user — hybrid approach
- Feed ranking (ML) as async enrichment
- Cache user feed snapshots

**Interview line:** *"I'd enqueue fan-out jobs with idempotent `(post_id, follower_id)` keys — same duplicate semantics as my webhook worker."*

---

### Rate limiter

**Functional:** Limit requests per user/IP/API key globally or per endpoint.

**Your proof:** Bounded concurrency and backpressure ([P8](../../career-project-specs/08-go-retrieval-worker-lab.md)); proxy timeouts ([P17](../../career-project-specs/17-proxy-load-balancer-lab.md)).

**Study gaps:**

- **Token bucket** vs **sliding window** vs fixed window
- Redis `INCR` + TTL vs dedicated rate-limit service
- **Distributed** consistency — race on counter; Lua scripts
- Return `429` + `Retry-After`

**Build:** [Project 23 — optional](../../career-project-specs/23-rate-limiter-gateway-lab.md)

---

### Notification system

**Functional:** Send email/push/SMS on events; preferences; retries.

**Your proof:** At-least-once + idempotent delivery ([P1](../../career-project-specs/01-integration-webhook-receiver.md), [P6](../../career-project-specs/06-async-worker-stretch.md)); DLQ ([P15](../../career-project-specs/15-devops-cli-lab.md) replay).

**Study gaps:**

- **Fan-out** from one event to N devices
- Priority queues (urgent vs digest)
- Provider webhooks (delivery status) — tie to P1
- Template service + idempotent `notification_id`

**Build:** [Project 24 — optional](../../career-project-specs/24-notification-fanout-lab.md) — **highest ROI optional lab**

---

### Search / autocomplete

**Functional:** Typeahead suggestions; full-text search.

**Your proof:** SQL indexes + vectors ([P4](../../career-project-specs/04-sql-performance-lab.md)); trie theory ([algorithms handbook](../concepts/algorithms-and-data-structures.md#trie-prefix-tree)).

**Study gaps:**

- **Trie** in memory for prefix; inverted index for full search
- Ranking (TF-IDF, BM25 — vocabulary level)
- Cache top prefixes; debounce client

**Build:** [Project 25 — optional](../../career-project-specs/25-search-autocomplete-lab.md)

---

### RAG / LLM serving

**Functional:** Answer questions with retrieval; low latency; safe failures.

**Your proof:** [P2](../../career-project-specs/02-rag-llm-service.md) eval JSONL; [P11](../../career-project-specs/11-llm-web-app-lab.md) BFF; [P8](../../career-project-specs/08-go-retrieval-worker-lab.md) retrieval gateway.

**Study gaps:**

- Embedding cache (chunk hash → vector)
- **Guardrails** — injection, PII filter before model
- Cost SLO — token budget per request
- Degrade path: retrieval-only when model down

**Interview line:** *"We regression-test RAG with eval JSONL; retrieval runs in Go with timeouts so model slowness doesn't wedge the gateway."*

---

### Distributed cache

**Functional:** Low-latency key-value; TTL; eviction.

**Your proof:** Redis in P6/P8; idempotency keys as cache-like lookups.

**Study gaps:**

- LRU/LFU eviction
- **Cache aside** vs read-through vs write-through
- Thundering herd — singleflight / request coalescing
- Invalidation on write (hard problem — name it)

---

## Playbook → system design talking points

| Lab | SD themes to cite |
|-----|-------------------|
| [P1](../../career-project-specs/01-integration-webhook-receiver.md) | Idempotency, HMAC trust, fast ack, DLQ |
| [P6](../../career-project-specs/06-async-worker-stretch.md) | At-least-once, visibility timeout, horizontal scale |
| [P8](../../career-project-specs/08-go-retrieval-worker-lab.md) | Backpressure, timeouts, metrics, Python↔Go boundary |
| [P4](../../career-project-specs/04-sql-performance-lab.md) | Index tradeoffs, plan evidence, pagination |
| [P12](../../career-project-specs/12-multi-tenant-auth-lab.md) | Tenant isolation, authZ on every path |
| [P14](../../career-project-specs/14-shell-automation-lab.md) | Smoke scripts, deploy preflight, ops glue |
| [P16](../../career-project-specs/16-cloud-deploy-lab.md) | Health checks, secrets, rollback |
| [P19](../../career-project-specs/19-rust-hot-path-lab.md) | Measured performance ADR |
| [P22](../../career-project-specs/22-integrated-platform-capstone.md) | End-to-end platform, cross-service tracing |

---

## 8-week SD reading plan

| Week | Focus problems | Playbook tie-in |
|------|----------------|-----------------|
| 1 | URL shortener, paste | P1, P4 |
| 2 | Rate limiter, API gateway | P8, P18, P23 |
| 3 | News feed, notification | P6, P8, P24 |
| 4 | Chat, real-time | P13 |
| 5 | Search, autocomplete | P4, P25 |
| 6 | Distributed cache, CDN | P6/P8 Redis |
| 7 | RAG / LLM serving | P2, P11 |
| 8 | Capstone review — design your P22 platform cold | P22 |

Each week: 1 problem on paper + 1 aloud mock (peer or record yourself).

---

## Capacity estimation cheat sheet

Order-of-magnitude is enough in interviews:

| Assumption | Typical calc |
|------------|--------------|
| 10M DAU, 10 actions/day | ~10M × 10 / 86400 ≈ **1.2k QPS** average (×10 for peak) |
| 1 KB per record, 1B records | **~1 TB** storage |
| 100 ms per request budget | p99 drives architecture more than average |

Document one estimate in your [P22](../../career-project-specs/22-integrated-platform-capstone.md) portfolio `architecture.md`.

---

## See also

- [Big Tech benchmark](big-tech-benchmark.md) — hiring loops and dual-track roadmap
- [DSA interview track](dsa-interview-track.md) — coding screen prep
- [Messaging and RPC](../concepts/messaging-and-rpc.md) — Kafka vs Redis lines
- [Database design — CAP, replication](../concepts/database-design.md#consistency-and-availability)
