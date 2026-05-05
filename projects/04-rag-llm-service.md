# Project 4 — RAG / tool-using LLM service

## Problem

Ship an **applied** LLM feature: retrieval (and optionally tools) with **evaluation**, **safety notes**, and **observability**—not a demo-only chat UI.

## Code repo

| | URL |
|---|-----|
| **GitHub** | [https://github.com/shemaiahCox/rag-llm-lab](https://github.com/shemaiahCox/rag-llm-lab) |
| **SSH** | `git@github.com:shemaiahCox/rag-llm-lab.git` |
| **Local sibling** | [`../../rag-llm-lab`](../../rag-llm-lab) |

## Stack

Python **3.9+** (3.11+ recommended), FastAPI, dependencies in `requirements.txt`. Integrate **LangChain** in this repo when your main work starts; keep the **eval JSONL** and **logging** conventions from day one.

## Key concepts (with definitions and code)

### RAG (retrieval-augmented generation)

**What:** Before calling the LLM, **retrieve** relevant chunks (docs, tickets, KB) from a search index/embeddings store, inject them into context (with boundaries), then generate an answer **grounded** in those chunks.

**Problem it solves:** The model stops **hallucinating facts** about *your* private data because it must cite **provided** text—but you must still handle **bad retrieval** and **prompt injection** (see checklists).

**In this repo (stub):** `_stub_answer` returns fake `cited_chunk_ids`; replace with real retrieval + LangChain.

```python
# app/main.py — contract you keep stable for evals
return {"answer": "...", "cited_chunk_ids": ["doc:france:1"]}
```

### `cited_chunk_ids`

**What:** Identifiers of **which chunks** influenced the answer (document id + chunk offset, chunk UUID, etc.).

**Problem it solves:** **Accountability** (“why did the bot say that?”) and **debugging** retrieval (wrong chunk → fix indexer or query).

**In API response:**

```json
{
  "answer": "The capital of France is Paris.",
  "cited_chunk_ids": ["doc:france:1"]
}
```

### Eval JSONL + regression runner

**What:** One **test case per line** (JSON), checked into git; a script calls your live `/query` (or in-process chain) and asserts simple rules (`expected_facts` substrings, `must_not_contain`).

**Problem it solves:** LLM outputs drift when you change prompts/models—**automated regression** catches “Paris → London” style failures cheaply before prod.

**Case file** (`evals/sample.jsonl`):

```json
{"question": "What is the capital of France?", "expected_facts": ["Paris"], "must_not_contain": ["London"]}
```

**Runner loop** (`scripts/run_eval.py`):

```python
for fact in case.get("expected_facts") or []:
    if fact.lower() not in answer:
        print(f"FAIL ... missing fact {fact!r}")
```

### Observability on the LLM path

**What:** Log **`request_id`**, wall-clock **latency**, and (when wired) **model name + token usage**—**not** necessarily full prompts if PII policy forbids.

**Problem it solves:** Cost spikes, slow prompts, and error rates become **measurable**; support can tie a bad answer to logs.

```python
_log_event(
    logging.INFO,
    "query_complete",
    rid,
    latency_ms=latency_ms,
    extra={"model": model, "citations": len(out.get("cited_chunk_ids") or [])},
)
```

### LangChain “behind the HTTP boundary”

**What:** Keep FastAPI thin: validate input, call a **service module** that runs LangChain (retrieval, tools, memory).

**Problem it solves:** Unit/integration tests hit Python functions without spinning HTTP; swapping frameworks does not break clients.

## Success criteria

- [ ] `POST /query` — accepts user question + optional session id; returns answer + cited chunk ids (when RAG wired).
- [ ] **`evals/`** — JSONL cases with `question`, `expected_facts` (or rubric field), optional `must_not_contain`.
- [ ] **Eval runner** — script or `pytest` that runs the chain against eval file and reports pass/fail (even keyword/rubric-based to start).
- [ ] **README “Safety & abuse”** — prompt injection note, what data must never go to the model, tool allowlist if applicable.
- [ ] **Structured logs** — latency, model id, token usage if available, `request_id`.

## LangChain alignment

When you add LangChain:

- Keep retrieval and tool wiring **behind** your FastAPI service boundaries (easier to test).
- Add regression runs to CI or pre-release checklist using `evals/*.jsonl`.
- Document environment variables (`OPENAI_API_KEY`, etc.) in `.env.example` only—never commit secrets.

## Maps to

“AI engineer” roles that still want **software discipline**, not-only prompt iteration.
