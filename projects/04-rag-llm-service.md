# Project 4 — RAG / tool-using LLM service

## Problem

Ship an **applied** LLM feature: retrieval (and optionally tools) with **evaluation**, **safety notes**, and **observability**—not a demo-only chat UI.

## Code repo

**Local:** [`../../rag-llm-lab`](../../rag-llm-lab) (FastAPI skeleton + eval template LangChain-ready).

**Remote:** _Add after publish._

## Stack

Python **3.9+** (3.11+ recommended), FastAPI, dependencies in `requirements.txt`. Integrate **LangChain** in this repo when your main work starts; keep the **eval JSONL** and **logging** conventions from day one.

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
