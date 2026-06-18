# Eval runner output — RAG / LLM service

**Script:** `scripts/run_eval.py`  
**Cases:** `evals/sample.jsonl`  
**Base URL:** `EVAL_BASE_URL=http://127.0.0.1:18001`

---

## Scenario 1 — Eval suite green (captured)

```bash
export EVAL_BASE_URL=http://127.0.0.1:18001
python scripts/run_eval.py evals/sample.jsonl
```

```text
OK line 1
OK line 2
All cases passed.
```

Exit code: `0`

---

## Scenario 2 — Regression signal (example FAIL shape)

Not captured by mutating the live repo. When a case violates `expected_facts` or `must_not_contain`, the runner prints:

```text
FAIL line 1: missing fact 'Paris' in answer: 'The capital of France is London.'

1 case(s) failed
```

Exit code: `1`

To reproduce locally: temporarily change `_stub_answer` to return wrong text, run the eval script, then revert.

---

## Scenario 7 — Adding cases

Add lines to `evals/*.jsonl`; runner output grows with `OK line N` per passing case. See [eval-cases.md](eval-cases.md).
