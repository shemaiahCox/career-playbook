# Project 24 — Search / autocomplete microservice (optional)

## Progress

| | |
|---|---|
| **Step** | Optional — after [Project 8](08-go-retrieval-worker-lab.md) and [Project 4](04-sql-performance-lab.md) |
| **Previous** | [Project 23 — Notification fan-out](23-notification-fanout-lab.md) (optional) or [Project 21](21-integrated-platform-capstone.md) |
| **Next** | — (optional branch) |

**Not in the linear spine.** One active project rule still applies.

## What you will learn

- Prefix trie for autocomplete typeahead
- Inverted index basics for full-text search (Postgres `tsvector` or in-memory)
- Ranking, caching hot prefixes, and debounced client contract

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

**Interview line:** *"Autocomplete uses a trie for O(L) prefix lookup; full search uses an inverted index with BM25-style ranking vocabulary — RAG retrieval is a different path for semantic match."*

## Important concepts

### Concept spotlight

| **Trie** | Shared prefixes; O(L) per query length |
| **Inverted index** | term → document IDs; core of full-text search |
| **Ranking** | TF-IDF / BM25 intuition; boost exact matches |
| **Cache** | Top prefixes in Redis; TTL on suggest path |

## Code repo

_TBD — create sibling repo (e.g. `search-autocomplete-lab`)._

Suggested local folder: [`../career-projects/24-search-autocomplete-lab`](../career-projects/24-search-autocomplete-lab).

## Stack

- **Go 1.22+** or **Rust** (after [Project 18](18-rust-hot-path-lab.md))
- **Postgres** — documents table + `tsvector` GIN index (or sqlite for minimal local)
- **Redis** (optional) — hot prefix cache
- Seed corpus: 10k+ titles/descriptions (generate or public dataset)

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
- [ ] **Performance numbers** — suggest p95; index build duration for N docs.
- [ ] **Failure modes** — stale index; cache stampede on viral prefix.
- [ ] **Observability evidence** — sample request log.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [per-project testing guide](../docs/concepts/per-project-testing.md)
- Log in [PROGRESS.md](../PROGRESS.md)
- **See also:** [System design interview map — search](../docs/career/system-design-interview-map.md#search--autocomplete)
