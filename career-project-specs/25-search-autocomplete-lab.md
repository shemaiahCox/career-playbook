# Project 25 — Search / autocomplete microservice (optional)

## Progress

| | |
|---|---|
| **Step** | Optional — after [Project 8](08-go-retrieval-worker-lab.md) and [Project 4](04-sql-performance-lab.md) |
| **Previous** | [Project 24 — Notification fan-out](24-notification-fanout-lab.md) (optional) or [Project 22](22-integrated-platform-capstone.md) |
| **Next** | — (optional branch) |

**Not in the linear spine.** One active project rule still applies.

## What you will learn

- Prefix trie for autocomplete typeahead
- Inverted index basics for full-text search (Postgres `tsvector` or in-memory)
- Ranking, caching hot prefixes, and debounced client contract

## Architecture pillars

| Pillar | How this project practices it |
|--------|-------------------------------|
| 2. Integration & messaging | Search API contract, cache invalidation (secondary) |
| 3. Data architecture | Trie vs DB prefix index; Postgres FTS vs external engine |
| 4. Performance & language boundaries | Autocomplete p95, index build time |
| 5. Reliability, security, operations | Cache stampede, stale index failure modes (secondary) |

**Required ADR(s):** tag each ADR with pillar (e.g. trie in-memory vs DB — **Pillar 3 + 4**).

**Framework:** [Architecture framework](../docs/concepts/architecture-framework.md)

## Before you start

- **Requires:** [Project 4](04-sql-performance-lab.md) indexing; [Project 8](08-go-retrieval-worker-lab.md) HTTP service patterns
- **Theory:** [Trie](../docs/concepts/algorithms-and-data-structures.md#trie-prefix-tree) · [DSA track week 10](../docs/career/dsa-interview-track.md)
- **Career context:** [System design interview map](../docs/career/system-design-interview-map.md#search--autocomplete)

## Problem

Build a **search microservice** with:

1. `GET /suggest?q=pre` — autocomplete top K prefixes (trie or DB-backed).
2. `GET /search?q=phrase` — full-text results with simple ranking.

Complements your RAG story ([Project 2](02-rag-llm-service.md)) with **classic search SD** vocabulary.

## Career relevance

**Summary:** Search and autocomplete appear in system design loops alongside news feed and notifications. This lab connects trie theory to a shippable HTTP service.

### In depth

Keyword search complements your RAG story ([Project 2](02-rag-llm-service.md)): retrieval-augmented generation handles semantic match; inverted indexes handle exact and prefix keyword match. Optional Go-first performance depth after [Project 4](04-sql-performance-lab.md) and [Project 8](08-go-retrieval-worker-lab.md)—pick this **or** [Project 23](23-rate-limiter-gateway-lab.md).

**Why learning this moves the needle**

- **Classic system design:** typeahead and full-text search (FTS) appear in loops at major tech companies; trie plus inverted index vocabulary transfers across employers.
- **Latency budgets:** autocomplete p95 under 50ms locally forces index and cache choices you can defend in interviews.
- **Contrast with RAG:** explaining when keyword search wins vs vector retrieval shows architectural maturity.

**Real-world situations this project mirrors**

- **Typeahead UI:** wire suggest to [Project 11](11-llm-web-app-lab.md) with debounced client contract.
- **Re-ingest:** same `doc_id` updates index idempotently after content changes.
- **Viral prefix:** hot prefix cache with TTL; document cache stampede mitigation.

### How to talk about this

Autocomplete uses a trie for O(L) prefix lookup where L is query length; full search uses an inverted index with BM25-style ranking vocabulary—RAG retrieval is a different path for semantic match. When interviewers ask about data structures, contrast in-memory trie vs database-backed prefix indexes. When interviewers ask about ranking, explain term frequency–inverse document frequency (TF-IDF) or BM25 intuition and exact-match boosts.

## Important concepts

### Trie (prefix tree)

Shared prefixes collapse storage; lookup cost scales with query length O(L), not corpus size. Strong fit for in-memory autocomplete on moderate corpora.

### Inverted index

Maps terms to document IDs—the core of full-text search. Postgres `tsvector` with generalized inverted index (GIN) is acceptable for lab scale; external engines are an ADR comparison.

### Ranking

TF-IDF or best matching 25 (BM25) intuition plus boosts for exact matches. Document ranking choices in README with example queries.

### Cache

Store hot prefixes in Redis with TTL on the suggest path. Log cache hits; document stampede behavior when a prefix goes viral.

## Code repo

_TBD — create sibling repo (e.g. `search-autocomplete-lab`)._

Suggested local folder: [`../career-projects/25-search-autocomplete-lab`](../career-projects/25-search-autocomplete-lab).

## Stack

- **Go 1.22+** — default on Go-first track
- **Postgres** — documents table + `tsvector` GIN index (or sqlite for minimal local)
- **Redis** (optional) — hot prefix cache
- Seed corpus: 10k+ titles/descriptions (generate or public dataset)

**Go-first track:** Optional performance depth after [Project 4](04-sql-performance-lab.md) + [Project 8](08-go-retrieval-worker-lab.md). Pick **this** or [Project 23](23-rate-limiter-gateway-lab.md) — not both required. Replaces Rust P19 search/index interview angle.

## Success criteria

- [ ] `GET /suggest?q=…` returns ≤K suggestions in <50ms p95 locally (document corpus size).
- [ ] `GET /search?q=…` returns ranked hits; explain ranking in README.
- [ ] **Index build** script or worker — ingest documents idempotently by `doc_id`.
- [ ] Integration test: suggest "pre" includes "prefix" if in corpus.
- [ ] README contrasts **keyword search** vs **vector/RAG** ([Project 2](02-rag-llm-service.md)).
- [ ] Structured logs: `q`, `result_count`, `latency_ms`, `request_id`.

## Testing approach (lab)

**Primary:** Integration — ingest fixture corpus; assert suggest and search results.

**Secondary:** Unit tests for trie insert/search (if in-memory trie).

**Exploration scenarios**

1. Empty prefix → empty or top popular (document policy).
2. Special characters in query → stable encoding.
3. Re-ingest same `doc_id` → idempotent update.
4. Cache hit on repeated prefix — log cache flag.

## Stretch

- Wire suggest to [Project 11](11-llm-web-app-lab.md) UI typeahead.
- **Fuzzy match** — Levenshtein or trigram (`pg_trgm`) — document tradeoff.
- **Big Tech benchmark:** shard index by doc_id hash; document rebuild strategy.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md).

- [ ] **Architecture diagram** — ingest → index → suggest/search paths.
- [ ] **ADR** — trie in-memory vs DB; Postgres FTS vs external engine.
- [ ] **Performance numbers** — commit `docs/portfolio/performance.md`: suggest p95; index build duration for N docs.
- [ ] **Failure modes** — stale index; cache stampede on viral prefix.
- [ ] **Observability evidence** — sample request log.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [per-project testing guide](../docs/concepts/per-project-testing.md)
- Log in [PROGRESS.md](../PROGRESS.md)
- **See also:** [System design interview map — search](../docs/career/system-design-interview-map.md#search--autocomplete)
