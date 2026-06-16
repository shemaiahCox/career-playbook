# Project 2 — RAG / tool-using LLM service

## Progress

| | |
|---|---|
| **Step** | 2 of 22 |
| **Previous** | [Project 1 — Integration webhook receiver](01-integration-webhook-receiver.md) |
| **Next** | [Project 3 — Observability lab](03-observability-lab.md) |

## What you will learn

- Ship grounded LLM features with eval JSONL regression
- Return citations and explicit guardrails / data boundaries
- Keep a stable `POST /query` contract and structured observability
- Split LLM logic (Python) from retrieval throughput (Go, later)

## Before you start

- **New to Python?** → [Python services map](../docs/languages/python.md) · [Stacks glossary](../docs/languages/glossary.md) · [Language fundamentals](../docs/languages/language-fundamentals-comparison.md)
- **Cross-stack depth:** [Generators and typing at scale](../docs/languages/language-fundamentals-comparison.md#lazy-evaluation-generators-and-iterators) · [Type systems beyond annotations](../docs/languages/language-fundamentals-comparison.md#type-systems-beyond-annotations)
- **Handbook:** [Observability](../docs/concepts/software-engineering.md#observability-logs-metrics-traces) · [Testing](../docs/concepts/software-engineering.md#testing) · [Algorithms study path](../docs/concepts/algorithms-study-path.md) · [Memory and performance](../docs/concepts/memory-and-performance.md)

## Problem

Ship an **applied** LLM feature: retrieval (and optionally tools) with **evaluation**, **safety notes**, and **observability**—not a demo-only chat UI.

## Career relevance

**Summary:** You practice shipping **LLM-backed features** with the same muscle memory as normal backend work: **grounding, regression tests, observability, and explicit risk notes**—so “AI” on your résumé reads as engineering, not vibes.

### In depth

Employers are moving from “prompt in a notebook” to **production AI features** that need the same rigor as any other service: **tests, evals, logging, and abuse thinking**. This project shows you can ship **grounded answers** without treating the model as magic. Interviewers increasingly ask how you’d **measure** quality and **bound** failure—not just which embedding model you’d pick.

**Why learning this moves the needle**

- **Product reality:** Internal copilots, support assistants, and doc search all need **RAG or tools** plus guardrails; slide-deck demos rarely ship. Hiring managers want evidence you can own **latency, cost, and error budgets** for model calls.
- **Quality at scale:** **Eval JSONL + regression** is how teams catch regressions when prompts, models, or chunking change—similar to snapshot tests for prose. Without evals, every model bump is **uncontrolled drift**.
- **Trust and compliance:** **Citations (`cited_chunk_ids`)** support “show your work” for legal, regulated, or enterprise procurement contexts. They also shorten **debugging**: wrong answer often traces to **wrong chunk**, not “the model felt wrong.”
- **Role fit:** “AI engineer” listings often mean **FastAPI/services + retrieval or orchestration layer + observability**, not only prompt design. Thin HTTP boundaries and loggable **`request_id`** are how you stay employable when the framework du jour changes.

**Real-world situations this project mirrors**

- **Support / CX bots** that **hallucinate** return or refund policy; leadership asks **which KB paragraph** drove the answer—citations answer that and feed internal QA.
- **Silent regressions:** a provider or model update **worsens** factual accuracy on your domain; **eval suites** catch “Paris → London” class failures in CI or pre-release gates.
- **Runaway spend:** unbounded context, infinite tool loops, or per-request retries cause **cost spikes**; **token counts + latency** in structured logs expose the bad pattern before finance pings you.
- **Abuse and data boundaries:** users paste **prompt-injecting** text or upload hostile PDFs; security review expects an explicit **allowlist**, data-handling rules, and **what never** goes to the model. A short README section is how you practice that conversation.

## Important concepts

### Concept spotlight

| **RAG + eval regression** | Maintain eval JSONL; run before release; cite `cited_chunk_ids` in responses |
| **Guardrails / boundaries** | Document what never goes to the model; handle bad retrieval explicitly |
| **Contract to retrieval** | Stable `POST /query` JSON; optional Go `/retrieve` boundary ([Project 8](08-go-retrieval-worker-lab.md)) |
| **Batch embed/index** | Index in batches with documented max size; profile Python path before moving fan-out to Go ([Memory and performance](../docs/concepts/memory-and-performance.md)) |

**Interview line:** *“We ship RAG with eval JSONL regression and citations so model bumps don’t silently drift on domain facts.”*


**Interview line:** *“We ship RAG with eval JSONL regression and citations so model bumps don’t silently drift on domain facts.”*

## Code repo

| | URL |
|---|-----|
| **GitHub** | [https://github.com/shemaiahCox/rag-llm-lab](https://github.com/shemaiahCox/rag-llm-lab) |
| **SSH** | `git@github.com:shemaiahCox/rag-llm-lab.git` |
| **Local sibling** | [`../career-projects/02-rag-llm-lab`](../career-projects/02-rag-llm-lab) |

## Stack

Python **3.11+** (align with supported upstream versions for FastAPI/Pydantic); FastAPI; dependencies in `requirements.txt`. Pick an **orchestration / retrieval** approach when you wire real behavior—**LangChain**, **LangGraph**, **LlamaIndex**, or a **thin provider SDK + your own retrieval**—the **`POST /query` JSON contract**, **eval JSONL**, and **logging** conventions stay stable regardless.

### Architecture split (Python + Go)

| Layer | Stack | Owns |
|-------|--------|------|
| LLM + evals + citations policy | **Python** (this lab) | Prompt boundaries, eval JSONL, guardrails |
| Concurrent retrieval / chunk fan-out | **Go** ([Project 8](08-go-retrieval-worker-lab.md)) | Timeouts, goroutine pools, retrieval gateway |
| Chunk storage + indexes | **SQL** ([Project 4](04-sql-performance-lab.md)) | Plans, pgvector-style indexes when used |

Python is the right place for **model vendor churn** and rapid eval iteration. Move **hot-path retrieval** to Go when profiling shows Python bound on I/O concurrency—not by default on day one.

Industry context: vector stores (Milvus, Weaviate, Qdrant) often ship Go components; you do not need to operate them to benefit from the **split-boundary** habit.

### Key concepts (with definitions and code)

### RAG (retrieval-augmented generation)

**What:** Before calling the LLM, **retrieve** relevant chunks (docs, tickets, KB) from a search index/embeddings store, inject them into context (with boundaries), then generate an answer **grounded** in those chunks.

**Problem it solves:** The model stops **hallucinating facts** about *your* private data because it must cite **provided** text—but you must still handle **bad retrieval** and **prompt injection** (see checklists).

**In this repo (stub):** `_stub_answer` returns fake `cited_chunk_ids`; replace with real retrieval + your chosen orchestration path (library stack or minimal SDK).

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

### Orchestration “behind the HTTP boundary”

**What:** Keep FastAPI thin: validate input, call a **service module** that runs retrieval, optional tool calls, and generation (via LangChain/LangGraph/LlamaIndex-style wiring or a small custom layer).

**Problem it solves:** Unit/integration tests hit Python functions without spinning HTTP; swapping orchestration libraries does not break clients or eval JSONL.

## Testing approach (lab)

**Primary:** **Eval JSONL + runner** as behavioral regression—add cases when you change prompts, chunking, or models; treat failures as release blockers once the suite exists.

**Secondary:** **Unit** tests for deterministic seams only: chunk boundaries, retrieval filters, citation id formatting, tool argument validation, routing—**not** “expect exact LLM prose” in a unit test.

**Compare:** **Eval** addresses **answer drift**; **unit** addresses **code you control**. Skipping evals and only unit-testing string helpers **misses** “model swap broke grounding.”

**Example asks for AI (optional):**  
“Given `evals/sample.jsonl` format [paste], propose 10 new lines for domain [X] with `expected_facts` and `must_not_contain`; keep cases independent of live APIs.”  
“Write pytest that invokes [pure function] for chunking with overlapping windows and asserts no dropped characters; mock only the embedding client boundary if needed.”

**Shared patterns:** [Per-project testing (labs + AI)](../docs/concepts/per-project-testing.md).

## Success criteria

- [ ] `POST /query` — accepts user question + optional session id; returns answer + cited chunk ids (when RAG wired).
- [ ] **`evals/`** — JSONL cases with `question`, `expected_facts` (or rubric field), optional `must_not_contain`.
- [ ] **Eval runner** — script or `pytest` that runs the chain against eval file and reports pass/fail (even keyword/rubric-based to start).
- [ ] **README “Safety & abuse”** — prompt injection note, what data must never go to the model, tool allowlist if applicable.
- [ ] **Structured logs** — latency, model id, token usage if available, `request_id`.

## Exploration scenarios

Run against [`02-rag-llm-lab`](../career-projects/02-rag-llm-lab) ([GitHub](https://github.com/shemaiahCox/rag-llm-lab)) locally; put API curls and env notes in that repo's README. Focus on **evals**, **response contract**, and **logs**—not chat UX polish.

### 1 — Eval suite green

- **Setup:** Install deps; optional API keys per README.
- **Action:** Run `scripts/run_eval.py` (or documented runner) against `evals/sample.jsonl`.
- **Expected outcome:** All cases **PASS** on current stub or wired chain.

### 2 — Introduce a regression

- **Action:** Change answer generation so it violates one case’s `expected_facts` or `must_not_contain` (temporary bug).
- **Expected outcome:** Runner prints **FAIL** with identifiable case—proves regression signal works.

### 3 — Response contract

- **Action:** `POST /query` with a sample question; inspect JSON.
- **Expected outcome:** `answer` present; `cited_chunk_ids` present (array)—matches stable contract for eval tooling.

### 4 — Observability fields

- **Action:** Run several queries; read stderr/aggregator logs.
- **Expected outcome:** Each completion logged with `request_id`, `latency_ms`, model identifier when wired—no secrets / full prompts if README forbids.

### 5 — Prompt-injection style input

- **Action:** Ask question that embeds “ignore previous instructions…” or paste hostile text per README safety section.
- **Expected outcome:** Behavior matches documented policy (refusal, grounding-only, etc.); note gaps in README **Safety & abuse**.

### 6 — Timeout / failure characterization

- **Action:** Point at invalid model name or disconnect network (simulate provider failure) if your harness allows.
- **Expected outcome:** Structured error path; logs show failure class without crashing process—document gaps.

### 7 — Stretch: new domain eval cases

- **Action:** Add 3–5 lines to `evals/*.jsonl` for your real retrieval corpus when wired.
- **Expected outcome:** Runner remains the gate before model/prompt changes.

### 8 — Stretch: bounded tool-using flow (optional)

- **Action:** Add an **allowlisted** tool path (fixed set of functions or APIs the model may call), with **hard caps** on iterations, wall-clock timeout, and documented refusal behavior. Align with [LLM feature ship checklist](../checklists/llm-feature-ship.md) (“Tool allowlist if using agents”).
- **Expected outcome:** Logs show tool rounds + `request_id`; evals or manual notes prove runaway loops cannot exhaust budget silently.

**MCP (Model Context Protocol):** Optional **literacy** only—many products expose tools over standard protocols; you do **not** need a separate playbook project. If you skim MCP docs, tie it to the same rules: **explicit allowlist**, no arbitrary shell/file access in prod, secrets never in tool payloads logged verbatim.

## Big Tech benchmark tier

Optional ceiling — see [big-tech-benchmark.md](../docs/career/big-tech-benchmark.md). Complete after UK £80k success criteria are green.

- [ ] **Remove `_stub_answer`** — wire real retrieval (Postgres/pgvector, Project 8 `/retrieve`, or in-process store).
- [ ] Eval JSONL regression green on real retrieval path; document baseline pass rate in `docs/portfolio/performance.md`.
- [ ] README contrasts keyword retrieval vs semantic/RAG path for interview SD tie-in ([system design map](../docs/career/system-design-interview-map.md#rag--llm-serving)).

## Orchestration alignment

When you add retrieval / orchestration code:

- Keep retrieval and tool wiring **behind** your FastAPI service boundaries (easier to test).
- Add regression runs to CI or pre-release checklist using `evals/*.jsonl`.
- Document environment variables (`OPENAI_API_KEY`, etc.) in `.env.example` only—never commit secrets.

## Bash scripting milestone

Ship `scripts/bootstrap-env.sh` — verify `python3`, venv, and required env vars with `command -v`; strict mode; exit 2 on missing config.

## Portfolio artifacts

Template: [Portfolio artifacts](../docs/templates/portfolio-artifacts.md). Commit under `docs/portfolio/` in your lab repo.

- [ ] **Architecture diagram** — `POST /query` → retrieval → LLM → response with `cited_chunk_ids`.
- [ ] **ADR** — orchestration library choice (LangChain vs thin SDK) or embedding store decision.
- [ ] **Performance numbers** — query p95 and/or eval runner duration baseline.
- [ ] **Failure modes** — model timeout, empty retrieval, eval regression on prompt change.
- [ ] **Observability evidence** — structured log with `request_id`, latency, token usage if available.
- [ ] Artifacts committed in lab repo `docs/portfolio/`.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Production readiness](../checklists/production-readiness.md) (step 2)
- Checklist: [LLM feature ship checklist](../checklists/llm-feature-ship.md)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 3 — Observability lab](03-observability-lab.md)
