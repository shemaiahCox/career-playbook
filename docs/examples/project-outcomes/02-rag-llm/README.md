# Project 2 — reference outcomes (RAG / LLM service)

Captured exemplars for [Project 2 spec](../../../career-project-specs/02-rag-llm-service.md). Read these **without running** the lab; use [Exploration scenarios](../../../career-project-specs/02-rag-llm-service.md#exploration-scenarios) to verify yourself.

**Source repo:** [rag-llm-lab](https://github.com/shemaiahCox/rag-llm-lab)  
**Captured:** 2026-06-18 — stub `_stub_answer` path (no live LLM provider); uvicorn on `127.0.0.1:18001`

## Files

| File | Exploration scenarios | Content |
|------|----------------------|---------|
| [architecture.md](architecture.md) | — | System context + pillar table |
| [flow.md](flow.md) | 1, 3 | `/query` sequence + eval runner |
| [http-responses.md](http-responses.md) | 3, 5 | `POST /query`, `GET /health`, validation `422` |
| [logs-success.jsonl](logs-success.jsonl) | 3, 4 | `http_request`, `query_complete` |
| [eval-output.md](eval-output.md) | 1, 2 | `run_eval.py` PASS; example FAIL shape |
| [eval-cases.md](eval-cases.md) | 1, 7 | `sample.jsonl` lines + matching responses |

## Regenerate

```bash
cd career-projects/02-rag-llm-lab
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --host 127.0.0.1 --port 18001 2> /tmp/rag-stderr.log
export EVAL_BASE_URL=http://127.0.0.1:18001
python scripts/run_eval.py evals/sample.jsonl
# curl examples in http-responses.md
```

When you wire real retrieval/LLM, re-capture responses and logs and note model/provider in this README.
