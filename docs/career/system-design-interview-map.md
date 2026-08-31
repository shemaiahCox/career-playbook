# System design interview map — classic problems ↔ playbook

**Use this:** Prepare for **Google/Meta system design rounds** by mapping classic problems to labs you ship and gaps you study. Companion to [Big Tech benchmark](big-tech-benchmark.md).

**Not the learning path** — follow the [README roadmap](../../README.md#roadmap). Older v1 names below live in [archive/v1-22-step](../../archive/v1-22-step/README.md).

---

## How to practice a system design problem

Use this 45–60 minute structure (say aloud or whiteboard):

1. **Requirements** (5 min) — functional + non-functional (scale, latency, consistency).
2. **Capacity estimate** (5 min) — users, Queries Per Second (QPS), storage (order-of-magnitude OK).
3. **API design** (5 min) — key endpoints, idempotency where needed.
4. **Data model** (10 min) — tables, keys, indexes; read vs write path.
5. **High-level diagram** (10 min) — clients, Load Balancer (LB), services, cache, queue, database.
6. **Deep dive** (15 min) — one hot path (fan-out, sharding, or consistency).
7. **Failure modes** (5 min) — partial outage, duplicate delivery, cache stampede.

**Handbook refs:** [Database design](../concepts/database-design.md) · [Messaging and RPC](../concepts/messaging-and-rpc.md) · [Software engineering](../concepts/software-engineering.md) · [Servers and networking](../concepts/servers-and-networking.md)

---

## Classic problems matrix

| Classic SD problem | What your playbook proves | Gap to study | Required lab |
|--------------------|----------------------------|--------------|--------------|
| **URL shortener** | [P1](../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md) idempotency; [P4](../../archive/v1-22-step/career-project-specs/04-sql-performance-lab.md) indexes | Base62 encoding, read-heavy cache, sharding by hash | — |
| **News feed / timeline** | [P6](../../archive/v1-22-step/career-project-specs/06-async-worker-stretch.md) queue; [P8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md) worker | Fan-out on write vs read, ranking, celebrity problem | — |
| **Chat / messaging** | [P13](../../archive/v1-22-step/career-project-specs/13-realtime-dashboard-lab.md) SSE/WS | WebSocket scale, presence, message ordering | — |
| **Notifications** | Phase 5 + 5.4 DLQ | Multi-channel fan-out | **[5.3](../../career-project-specs/05-3-notification-fanout.md)** |
| **Rate limiter** | Phase 5 bounded workers | Token bucket, sliding window | **[5.2](../../career-project-specs/05-2-rate-limiter.md)** |
| **Search / autocomplete** | 6.1 + trie in [algorithms handbook](../concepts/algorithms-and-data-structures.md#trie-prefix-tree) | Inverted index, ranking | **[6.1](../../career-project-specs/06-1-search-autocomplete.md)** |
| **Pastebin / file store** | [P5](../../archive/v1-22-step/career-project-specs/05-contract-first-api.md) contracts | Blob storage (S3/GCS), CDN, multipart upload | — |
| **Distributed cache** | Redis in P6/P8 | Eviction (LRU), consistency, thundering herd | P23 overlap |
| **Video / image upload** | P6 async worker | Chunked upload, transcoding queue, progress API | — |
| **Payment / webhook system** | **P1** (core story) | Ledger idempotency, reconciliation, exactly-once illusion | Shipped lab |
| **RAG / LLM serving** | [P2](../../archive/v1-22-step/career-project-specs/02-rag-llm-service.md), [P11](../../archive/v1-22-step/career-project-specs/11-llm-web-app-lab.md) | Embedding cache, guardrails, cost/latency SLO | Shipped lab |
| **Distributed job scheduler** | P6/P8 workers | Cron at scale, lease/visibility, priority queues | P24 overlap |
| **API gateway / BFF** | [P7](../../archive/v1-22-step/career-project-specs/07-node-typescript-lab.md), [P11](../../archive/v1-22-step/career-project-specs/11-llm-web-app-lab.md) | Auth termination, routing, aggregation | P23 overlap |
| **Multi-tenant SaaS** | [P12](../../archive/v1-22-step/career-project-specs/12-multi-tenant-auth-lab.md) | Row-level security, noisy neighbor, per-tenant rate limits | — |
| **Metrics / observability platform** | [P3](../../archive/v1-22-step/career-project-specs/03-observability-lab.md), P8 `/metrics` | Time-series DB, cardinality, sampling | — |
| **IoT telemetry ingest** | [P21](../../archive/v1-22-step/career-project-specs/21-iot-edge-lab.md) | MQTT Quality of Service (QoS), edge buffer, time-series write path | — |

---

## Deep dives by problem

### URL shortener

A URL shortener must create short URLs, redirect on lookup, and optionally track analytics. Your playbook proof comes from idempotent `POST /shorten` with a client key ([P1](../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md)) and indexed lookup ([P4](../../archive/v1-22-step/career-project-specs/04-sql-performance-lab.md)).

Study gaps include Base62 versus hash collision handling, read:write ratio (cache hot URLs in a Content Delivery Network (CDN) or Redis), sharding by `short_code` hash with consistent hashing vocabulary, and redirect **301 vs 302** for analytics.

**How to explain this in an interview:** Shorten is write-light and redirect is read-heavy — you would cache the mapping and use a database unique index on the short code so lookups stay fast under read traffic.

---

### News feed / timeline

Users post content; followers see a personalized feed. Your proof is async fan-out via queue ([P6](../../archive/v1-22-step/career-project-specs/06-async-worker-stretch.md)) and a worker pool ([P8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md)).

Study gaps include **fan-out on write** (push to follower feeds) versus **fan-out on read** (merge at read time), the celebrity user hybrid approach, feed ranking as async enrichment, and caching user feed snapshots.

**How to explain this in an interview:** Enqueue fan-out jobs with idempotent `(post_id, follower_id)` keys — the same duplicate-delivery semantics you already practice in a webhook worker.

---

### Rate limiter

A rate limiter must limit requests per user, IP, or API key — globally or per endpoint. Your proof is bounded concurrency and backpressure ([P8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md)) and proxy timeouts ([P18](../../archive/v1-22-step/career-project-specs/18-proxy-load-balancer-lab.md)).

Study gaps include **token bucket** versus **sliding window** versus fixed window, Redis `INCR` + Time To Live (TTL) versus a dedicated rate-limit service, **distributed** consistency and races on counters (Lua scripts), and returning HTTP 429 + `Retry-After`.

**Build:** [Phase 5.2](../../career-project-specs/05-2-rate-limiter.md) (v1 notes: [P23](../../archive/v1-22-step/career-project-specs/23-rate-limiter-gateway-lab.md))

---

### Notification system

A notification system sends email/push/SMS on events with user preferences and retries. Your proof is at-least-once delivery with idempotent handlers ([P1](../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md), [P6](../../archive/v1-22-step/career-project-specs/06-async-worker-stretch.md)) and DLQ with replay ([P15](../../archive/v1-22-step/career-project-specs/15-devops-cli-lab.md)).

Study gaps include **fan-out** from one event to N devices, priority queues (urgent vs digest), provider webhooks for delivery status (tie to P1), and a template service with idempotent `notification_id`.

**Build:** [Phase 5.3](../../career-project-specs/05-3-notification-fanout.md) (v1 notes: [P24](../../archive/v1-22-step/career-project-specs/24-notification-fanout-lab.md))

---

### Search / autocomplete

Typeahead suggestions and full-text search. Your proof is SQL indexes plus vectors ([P4](../../archive/v1-22-step/career-project-specs/04-sql-performance-lab.md)) and trie theory ([algorithms handbook](../concepts/algorithms-and-data-structures.md#trie-prefix-tree)).

Study gaps include **trie** in memory for prefix matching, inverted index for full search, ranking (Term Frequency-Inverse Document Frequency (TF-IDF), Best Matching 25 (BM25) — vocabulary level), and caching top prefixes with client debounce.

**Build:** [Phase 6.1](../../career-project-specs/06-1-search-autocomplete.md) (v1 notes: [P25](../../archive/v1-22-step/career-project-specs/25-search-autocomplete-lab.md))

---

### RAG / LLM serving

Answer questions with retrieval at low latency with safe failures. Your proof is [P2](../../archive/v1-22-step/career-project-specs/02-rag-llm-service.md) eval JSONL, [P11](../../archive/v1-22-step/career-project-specs/11-llm-web-app-lab.md) BFF, and [P8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md) retrieval gateway.

Study gaps include embedding cache (chunk hash → vector), **guardrails** for injection and Personally Identifiable Information (PII) filter before model, cost SLO with token budget per request, and degrade path (retrieval-only when model is down).

**How to explain this in an interview:** Regression-test RAG (Retrieval-Augmented Generation) with eval JSONL; run retrieval in Go with timeouts so model slowness does not wedge the gateway.

---

### Distributed cache

Low-latency key-value with TTL and eviction. Your proof is Redis in P6/P8 and idempotency keys as cache-like lookups.

Study gaps include Least Recently Used (LRU)/Least Frequently Used (LFU) eviction, **cache aside** versus read-through versus write-through, thundering herd (singleflight / request coalescing), and invalidation on write — name it as a hard problem.

---

## Playbook → system design talking points

| Lab | SD themes to cite |
|-----|-------------------|
| [P1](../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md) | Idempotency, HMAC trust, fast ack, DLQ |
| [P6](../../archive/v1-22-step/career-project-specs/06-async-worker-stretch.md) | At-least-once, visibility timeout, horizontal scale |
| [P8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md) | Backpressure, timeouts, metrics, Python↔Go boundary |
| [P4](../../archive/v1-22-step/career-project-specs/04-sql-performance-lab.md) | Index tradeoffs, plan evidence, pagination |
| [P12](../../archive/v1-22-step/career-project-specs/12-multi-tenant-auth-lab.md) | Tenant isolation, authZ on every path |
| [P14](../../archive/v1-22-step/career-project-specs/14-shell-automation-lab.md) | Smoke scripts, deploy preflight, ops glue |
| [P16](../../archive/v1-22-step/career-project-specs/16-cloud-deploy-lab.md) | Health checks, secrets, rollback |
| [P19](../../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md) | Measured performance ADR |
| [P22](../../archive/v1-22-step/career-project-specs/22-integrated-platform-capstone.md) | End-to-end platform, cross-service tracing |

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
| 10M Daily Active Users (DAU), 10 actions/day | ~10M × 10 / 86400 ≈ **1.2k QPS** average (×10 for peak) |
| 1 KB per record, 1B records | **~1 TB** storage |
| 100 ms per request budget | p99 drives architecture more than average |

Document one estimate in your [P22](../../archive/v1-22-step/career-project-specs/22-integrated-platform-capstone.md) portfolio `architecture.md`.

---

## See also

- [Big Tech benchmark](big-tech-benchmark.md) — hiring loops and dual-track roadmap
- [DSA interview track](dsa-interview-track.md) — coding screen prep
- [Messaging and RPC](../concepts/messaging-and-rpc.md) — Kafka vs Redis lines
- [Database design — CAP, replication](../concepts/database-design.md#consistency-and-availability)
