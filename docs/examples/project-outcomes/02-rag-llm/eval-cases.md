# Eval cases — RAG / LLM service

**File:** `evals/sample.jsonl` in [rag-llm-lab](https://github.com/shemaiahCox/rag-llm-lab)

---

## Line 1 — France capital

**Case:**

```json
{"question": "What is the capital of France?", "expected_facts": ["Paris"], "must_not_contain": ["London"]}
```

**Matching `/query` response (stub):**

```json
{
  "answer": "The capital of France is Paris.",
  "cited_chunk_ids": ["doc:france:1"],
  "session_id": null,
  "request_id": "<uuid or X-Request-Id>"
}
```

Runner checks: `Paris` in answer (case-insensitive); `London` must not appear.

---

## Line 2 — Brief tone (no fact checks)

**Case:**

```json
{"question": "Summarize tone: be brief.", "expected_facts": [], "must_not_contain": []}
```

**Matching `/query` response (stub):**

```json
{
  "answer": "(stub) Echo: Summarize tone: be brief.",
  "cited_chunk_ids": [],
  "session_id": null,
  "request_id": "<uuid>"
}
```

Empty `expected_facts` / `must_not_contain` → runner only verifies HTTP success and answer presence.

---

## Extending the suite (scenario 7)

Add domain-specific lines when retrieval is wired:

```json
{"question": "What is our refund window?", "expected_facts": ["30 days"], "must_not_contain": ["lifetime"]}
```

Keep one JSON object per line; commit in git; run `run_eval.py` before prompt or model changes.
