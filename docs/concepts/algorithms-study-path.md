# Algorithms study path

**Use this:** Guided **read and apply** path through [Algorithms and data structures](algorithms-and-data-structures.md)—required when you are in [Project 4](../../career-project-specs/04-sql-performance-lab.md), [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md), or chunk/retrieval work in [Project 2](../../career-project-specs/02-rag-llm-service.md).

**Reading order:** [Algorithms and data structures](algorithms-and-data-structures.md) (concepts) → **this path** (prompts) → your lab spec.

**Rule:** After each section below, **stop and explain aloud** (or write in [PROGRESS.md](../../PROGRESS.md)) the answer to the prompt — one paragraph minimum.

---

## 1. Big-O is scaling, not seconds

**Read:** [Big-O is scaling, not seconds](algorithms-and-data-structures.md#big-o-is-scaling-not-seconds) through [Reading loops](algorithms-and-data-structures.md#reading-loops-practical).

**Apply in your labs:**

| Situation | Question |
|-----------|----------|
| RAG: score every chunk with a nested loop over tokens × chunks | What is `n` and `m`? Is this O(n×m)? |
| Webhook idempotency table lookup by `event_id` | Why is average O(1)? What breaks worst case? |
| SQL `OFFSET` pagination on hot list | Why does cost grow with page number? |

**Stop and explain:** Write one paragraph on why O(n²) is dangerous at 10⁶ items but might be fine at 10².

---

## 2. Arrays and dynamic arrays

**Read:** [Array, dynamic array, list](algorithms-and-data-structures.md#array-dynamic-array-list-contiguous).

**Apply:** Compare Go slice append in a loop versus preallocated capacity; PHP array growth; Python list comprehension versus repeated append.

**Stop and explain:** What **amortized O(1) append** means and when you still pay O(n).

---

## 3. Hash tables (maps / sets)

**Read:** Hash map section in the algorithms handbook.

**Apply:** Idempotency key store; dedupe set for seen job IDs in Project 8 worker; JavaScript `Map` for in-memory cache.

**Stop and explain:** Average O(1) lookup versus worst O(n) collisions — when would you worry?

---

## 4. Queues and stacks

**Read:** Queue/stack sections in the handbook; if you need idioms, see [Built-in data structures — stack/queue](../languages/language-fundamentals-comparison.md#stack-and-queue-idioms).

**Apply:** Project 6 worker drain; DLQ as secondary queue; Boomi "execution" as ordered steps.

**Stop and explain:** Why queue drain is O(n) in number of messages and what **backpressure** means when producers outrun consumers.

---

## 5. Trees and indexes (SQL connection)

**Read:** [Database design — Indexes](database-design.md#indexes) alongside handbook tree/B-tree mentions.

**Apply:** Project 4 `EXPLAIN` before/after index; why B-tree index helps `WHERE id = ?` but not always `LIKE '%x%'`.

**Stop and explain:** The difference between **full table scan** and **index scan** in plain language.

---

## 6. Graphs (awareness)

**Read:** Graph section in the algorithms handbook, or skim graph terminology in the glossary.

**Apply:** Integration flows (Boomi process with branches) — you do not need to code a graph library; recognize **cycle** risk in saga compensations.

**Stop and explain:** One integration workflow that is a **Directed Acyclic Graph (DAG)** versus one that could **cycle**.

---

## Checklist before calling Project 4/Project 8 "done"

- [ ] Named Big-O of at least **one hot path** in your lab README.
- [ ] Showed **before/after** plan or timing for one SQL or retrieval change.
- [ ] Documented **idempotency** structure choice (hash map / unique index) and why duplicates are safe.

---

## Related

- [Language fundamentals — choosing structures](../languages/language-fundamentals-comparison.md#choosing-at-a-glance)
- [Systems integration architect](systems-integration-architect.md)
- [Software engineering — Concurrency](software-engineering.md#concurrency-basics)

---

## Technical reference

| Topic | Doc anchor |
|-------|------------|
| Big-O | [algorithms-and-data-structures.md#big-o-is-scaling-not-seconds](algorithms-and-data-structures.md#big-o-is-scaling-not-seconds) |
| Hash maps / idempotency | [algorithms-and-data-structures.md#hash-map-and-hash-set](algorithms-and-data-structures.md#hash-map-and-hash-set) |
| SQL OFFSET cost | [database-design.md#pagination](database-design.md#pagination) |
| Worker concurrency | [concurrency-runtime-model.md](concurrency-runtime-model.md) |
