# DSA interview track — parallel LeetCode prep

**Use this:** Prepare for **Google/Meta coding screens** alongside your [22-step spine](../../README.md#progression-step-1--22). This is a **parallel track** — not a replacement for shipping labs.

**Companion handbook:** [Algorithms and data structures](../concepts/algorithms-and-data-structures.md) · [Algorithms study path](../concepts/algorithms-study-path.md) (lab-applied literacy) · [Big Tech benchmark](big-tech-benchmark.md)

---

## Rules

1. **One active project** on the spine — DSA runs in **evenings or dedicated blocks**, not instead of lab work.
2. **Timed sessions:** 45 minutes per problem (or 2 × 25 min easy). Use a timer.
3. **Frequency:** 5 sessions/week minimum during active prep; 2–3/week maintenance after initial pass.
4. **After each problem:** State time/space complexity aloud; name the pattern; log misses in [PROGRESS.md](../../PROGRESS.md).
5. **Do not memorize solutions** — recognize patterns and reproduce from scratch.

**Target volume:** 150 problems for Level 3–Level 4 (L3–L4) readiness; 200–300 for hard-round comfort. Quality + timed reps beat raw count.

---

## Playbook lab reinforcement

| Lab | Data structure / pattern | Spec enrichment |
|-----|--------------------------|-----------------|
| [Project 4](../../career-project-specs/04-sql-performance-lab.md) | B-tree indexes, query plans | Key concepts + EXPLAIN patterns |
| [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) | Concurrency, timeouts | Key concepts + pprof evidence |
| [Project 25](../../career-project-specs/25-search-autocomplete-lab.md) | Trie, inverted index | Key concepts + keyword vs RAG ADR |

---

## How this maps to the handbook

| Handbook section | Interview pattern | When in track |
|------------------|-------------------|---------------|
| [Big-O](../concepts/algorithms-and-data-structures.md#big-o-is-scaling-not-seconds) | Complexity analysis on every problem | Week 1+ |
| [Hash tables](../concepts/algorithms-and-data-structures.md#hash-map-and-hash-set) | Two sum, anagrams, frequency maps | Weeks 1–2 |
| [Two pointers / sliding window](../concepts/algorithms-and-data-structures.md#two-pointers-and-sliding-window) | Subarray sum, longest substring | Weeks 2–3 |
| [Binary search](../concepts/algorithms-and-data-structures.md#binary-search) | Search on answer, rotated array | Week 4 |
| [Trees / BST](../concepts/algorithms-and-data-structures.md#trees-and-balanced-bst-conceptual) | Traversals, Lowest Common Ancestor (LCA), validate BST | Weeks 5–6 |
| [Heap](../concepts/algorithms-and-data-structures.md#heap--priority-queue) | Top K, merge K lists, median stream | Week 7 |
| [BFS / DFS](../concepts/algorithms-and-data-structures.md#bfs-and-dfs) | Islands, shortest path, topological sort | Weeks 7–8 |
| [Graphs](../concepts/algorithms-and-data-structures.md#graph-representations) | Course schedule, clone graph | Week 8 |
| [DP](../concepts/algorithms-and-data-structures.md#greedy-vs-dynamic-programming) | 1D/2D DP, knapsack shapes | Weeks 9–10 |
| [Trie](../concepts/algorithms-and-data-structures.md#trie-prefix-tree) | Word search, autocomplete | Week 10 |
| [Interview flow](../concepts/algorithms-and-data-structures.md#interview-and-design-discussion-flow) | Clarify → brute → optimize → edge cases | Every session |

**Lab tie-in:** When you hit hash maps (Week 1), relate to idempotency stores in [Project 1](../../career-project-specs/01-integration-webhook-receiver.md). When you hit BFS (Week 7), relate to dependency graphs in integration flows per [algorithms study path](../concepts/algorithms-study-path.md).

---

## 12-week curriculum

Use **NeetCode 150** or **Blind 75** as problem lists — grouped below by pattern. Pick any platform (LeetCode, NeetCode.io). Difficulty ramps by week.

### Week 1 — Arrays, hash maps, basics

Read the handbook Big-O and hash table sections. Focus on frequency count, two sum, contains duplicate, valid anagram, and group anagrams patterns (NeetCode "Arrays & Hashing" — first 8–10 problems).

**Stop and explain:** Why hash map lookup is O(1) average; when nested loops become O(n²).

**Lab link:** Idempotency key store = hash map / unique index ([Project 1](../../career-project-specs/01-integration-webhook-receiver.md)).

---

### Week 2 — Two pointers, sliding window, stack

Patterns include valid palindrome, 3sum, container with most water, longest substring without repeat, min window substring, valid parentheses, and daily temperatures (NeetCode Two Pointers and Stack — first 6–8 each).

**Stop and explain:** When two pointers beat nested loops; stack for matching/nearest greater.

---

### Week 3 — Linked lists, intervals (awareness)

Patterns include reverse linked list, merge two lists, reorder list, merge intervals, and insert interval (NeetCode Linked List and Intervals). Less common in backend interviews than arrays/graphs — 5–6 problems sufficient; do not over-invest.

---

### Week 4 — Binary search, sorting applications

Patterns include binary search, search rotated array, find minimum in rotated, Koko eating bananas (search on answer), and time-based key-value store (NeetCode Binary Search).

**Stop and explain:** Monotonic predicate for "search on answer."

**Lab link:** Keyset pagination vs OFFSET ([Project 4](../../career-project-specs/04-sql-performance-lab.md)).

---

### Week 5 — Trees (traversals, properties)

Patterns include invert tree, max depth, same tree, subtree, lowest common ancestor, validate BST, and level order traversal (NeetCode Trees — first 10).

**Stop and explain:** DFS vs BFS on trees; why BST search is O(log n) when balanced.

---

### Week 6 — Trees (advanced) + backtracking intro

Patterns include path sum, construct from preorder/inorder, serialize/deserialize, and word search as backtracking intro (NeetCode Trees remaining, Backtracking 1–2).

---

### Week 7 — Graphs + heap

Patterns include number of islands, clone graph, Pacific Atlantic water flow, course schedule (topological), min cost to connect points; plus Kth largest, merge K sorted lists, find median from data stream (NeetCode Graphs first 6, Heap first 4).

**Stop and explain:** Adjacency list vs matrix; when BFS gives shortest unweighted path.

**Lab link:** Job dependency DAG ([Project 6](../../career-project-specs/06-async-worker-stretch.md)).

---

### Week 8 — Graphs (advanced) + union-find awareness

Patterns include course schedule II, redundant connection, graph valid tree, word ladder; optional union-find problems (NeetCode Graphs remaining, Advanced Graphs 1–2).

---

### Week 9 — 1D dynamic programming

Patterns include climbing stairs, house robber, house robber II, longest palindromic substring, decode ways, coin change, and maximum product subarray (NeetCode 1-D DP — first 8).

**Stop and explain:** Overlapping subproblems; memo vs tabulation.

---

### Week 10 — 2D DP + trie + greedy

Patterns include unique paths, longest common subsequence, word break, palindromic substrings; implement trie, design add/search words; jump game, gas station (NeetCode 2-D DP first 5, Trie 2, Greedy 2–3).

**Lab link:** Trie section complements [Project 25](../../career-project-specs/25-search-autocomplete-lab.md) if you build it.

---

### Week 11 — Mixed mediums (mock pressure)

Run 5 timed sessions — pick random **medium** problems from weeks 1–10 without looking at tags first. Goal: pattern recognition under ambiguity (closest to phone screen). Log pattern missed, time to solution, and whether complexity was stated correctly.

---

### Week 12 — Hard intro + maintenance plan

Complete 3 hard problems (1D DP hard, graph hard, heap hard) and 2 full **mock interviews** (Pramp, interviewing.io, or peer). Ongoing maintenance: 2–3 problems/week; 1 mock/month until offers or pause.

---

## Problem-solving checklist (every session)

From [Interview and design discussion flow](../concepts/algorithms-and-data-structures.md#interview-and-design-discussion-flow):

1. **Clarify** — constraints, size of `n`, sorted?, memory limits?
2. **Example** — walk a tiny input by hand.
3. **Brute force** — state complexity (establishes ceiling).
4. **Optimize** — name structure (hash map, heap, two pointers) and justify improvement.
5. **Code** — clean names, handle empty/single/duplicate inputs.
6. **Verify** — trace one edge case.

---

## What Big Tech expects by level

| Level | Coding expectation |
|-------|-------------------|
| **L3 / E3** | 1 medium in 35–45 min cleanly; occasional easy warm-up |
| **L4 / E4** | 1 medium–hard in 45 min; follow-ups (optimize space, scale to streaming) |
| **L5+** | Hard or medium with multiple optimal approaches discussed |

**Backend-specific note:** Google/Meta backend loops still use **general DSA** — not language trivia. Your Go/Rust depth shows in **other rounds** (system design, domain, behavioral).

---

## Common mistakes

| Mistake | Fix |
|---------|-----|
| Only reading solutions | Close tab; 25 min attempt before hints |
| Skipping complexity statement | Last 2 min of every session: "This is O(…) because …" |
| Grinding while spine stalled | Resume labs first; DSA is parallel, not substitute |
| No mocks | Week 11+ mocks expose communication gaps |
| Ignoring follow-ups | Practice "what if n is 10⁹" and streaming variants aloud |

---

## Progress logging

After each week, append to [PROGRESS.md](../../PROGRESS.md):

```markdown
### DSA week N
- Problems completed: (count + list)
- Patterns solid: …
- Patterns weak: …
- Mock / timed notes: …
```

The template above tracks volume, solid patterns, weak patterns, and mock notes — enough to spot gaps without over-logging every problem.

---

## See also

- [Big Tech benchmark](big-tech-benchmark.md) — dual-track roadmap
- [System design interview map](system-design-interview-map.md) — complementary SD prep
- [Target alignment](target-alignment.md) — UK primary plan
