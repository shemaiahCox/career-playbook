# Ecosystem map: Python (services and scripting)

**Use this:** You ship or review **Python** backends (**FastAPI**, **Flask**, **Django**), **workers**, **CLI tools**, or **notebooks** that leave the lab. This is **vocabulary + runtime footguns**, not a syntax course.

**Companion:** [docs README](../README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md) · [RAG / LLM service](../../career-project-specs/02-rag-llm-service.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Best for, alternatives, and playbook fit

| Best for | Use instead when | Primary projects |
|----------|------------------|------------------|
| LLM/RAG services, eval harnesses, FastAPI product APIs | Go for retrieval throughput and queue workers; PHP/Node when the spec names them for HTTP ingress | [Project 2 — RAG / LLM](../../career-project-specs/02-rag-llm-service.md), observability and eval labs |

---

## How it runs

| Execution | Typing | Memory / concurrency |
|-----------|--------|----------------------|
| **CPython** interprets bytecode; **global interpreter lock (GIL)** limits parallel CPU in one process | Gradual typing (`type hints` + mypy/pyright optional) | garbage collection (GC); **asyncio** event loop for I/O-bound ASGI; threads help I/O waits, not CPU-heavy bytecode |

---

## Environment setup

1. Verify: `python3 --version` (match project README; 3.11+ common for FastAPI labs).
2. Create venv: `python3 -m venv .venv && source .venv/bin/activate` (Windows: `.venv\Scripts\activate`).
3. Install deps: `pip install -r requirements.txt` or `uv sync` when `pyproject.toml` is the source of truth.
4. Lock habit: commit `requirements.txt` / `uv.lock` / `poetry.lock`—never “whatever my laptop has.”
5. Project 2 lab clone lives under [`career-projects/`](../../career-projects/) per spec.

---

## Project layout

```
my-service/
├── app/                 # package: routes, services, models
│   ├── main.py          # FastAPI app entry (or app/__init__.py)
│   └── ...
├── tests/
├── evals/               # Project 2 eval JSONL + harness
├── requirements.txt     # or pyproject.toml + lockfile
└── .env                 # local only — not committed
```

---

## Commands you'll use often

| Intent | Command | Notes |
|--------|---------|-------|
| Run dev API | `uvicorn app.main:app --reload --host 0.0.0.0 --port 8000` | Adjust module path to your app |
| Run module | `python -m app` | Prefer over `python app/main.py` (import paths) |
| Test | `pytest` | Add `-v` / `-k name` as needed |
| Lint / types | `ruff check .` · `mypy app` | Match what CI runs |
| Dependency audit | `pip-audit` | Supply chain for integrations |

---

## How concepts show up

**HTTP / APIs**

- **FastAPI:** dependency injection via **Depends**, **Pydantic** models at the boundary—validation **is** contract discipline.
- **WSGI (Flask/Django legacy)** vs **ASGI (Starlette/FastAPI)** — deployment and concurrency models differ; don’t mix assumptions.

**LLM / RAG-shaped services**

- Keep **`POST /query` (or equivalent) contract** and **eval JSONL** stable; treat **LangChain**, **LangGraph**, **LlamaIndex**, or **minimal SDK + custom retrieval** as **replaceable implementation** behind one service module ([RAG / LLM service](../../career-project-specs/02-rag-llm-service.md)).

**Data access**

- **SQLAlchemy** (2.x style) / **Django ORM**: **N+1** and **lazy loading** in request paths are the usual prod surprises—relate to [SQL map](sql.md) and [database design](../concepts/database-design.md).

**Observability**

- **`structlog`** / standard **logging**; **OpenTelemetry** for traces—set **correlation IDs** at the request edge (aligns with [observability lab](../../career-project-specs/03-observability-lab.md)).

**Security**

- **Secrets:** env or vault—not committed; **`.env`** not in images/repos.
- **Dependency scanning:** **pip-audit** / GitHub Dependabot; supply chain matters for integrations.

---

## Footguns

- [ ] **Mutable default arguments** (`def f(x=[]):`) and **shared mutable state** across requests—classic bug class. Deep dive: [Gotchas #2, #6, #9, #18](language-gotchas-deep-dive.md).
- [ ] **`except Exception:`** swallowing without log context—production blindness.
- [ ] **Blocking I/O** inside **async** handlers (DB drivers, `requests`) without **executor** offload—throughput collapse under load.
- [ ] **Loading full corpus into RAM** for embed/index—batch with documented max size; profile with `tracemalloc` before moving retrieval to Go ([Memory and performance](../concepts/memory-and-performance.md)).
- [ ] **Implicit relative imports** / running scripts as files—breaks when cwd changes; prefer **`python -m package.module`**.

---

## Plain language: terms used on this page

Read this **after** the tables if they felt like alphabet soup. You can come back later.

- **CPython** — The standard Python implementation (what `python` usually runs). “CPython” distinguishes it from other runtimes (PyPy, etc.).
- **GIL / Global Interpreter Lock** — Lets only one thread execute Python bytecode at a time inside one process—plain multithreading is not free CPU parallelism.
- **I/O-bound vs CPU-bound** — *I/O-bound* = waiting on disk/network/other services. *CPU-bound* = chewing numbers; Python threads do not magically parallelize CPU-heavy bytecode work because of the GIL.
- **venv / virtualenv** — A folder-local install so dependencies do not collide between projects.
- **pip-tools, Poetry, PDM, uv** — Ways to declare and **lock** exact library versions (`pyproject.toml` is the modern config hub).
- **Module / package** — Files vs folders Python imports—layout matters once the app grows past one file.
- **async / asyncio** — Cooperative multitasking inside one OS thread (“while this waits on the network, run something else”).
- **FastAPI** — Popular async-first web/API framework built on Starlette/Pydantic.
- **WSGI vs ASGI** — Two specs for plugging Python apps into servers; ASGI understands **long-lived** connections and asyncio-style apps better (Starlette/FastAPI).
- **Pydantic / Depends** — Pydantic types validate JSON-like data; Depends injects reusable setup (database session, auth) into route handlers—think “small tools the framework hands each request.”
- **SQLAlchemy / Django ORM** — Layers that emit SQL—you still debug **queries** under the hood when things get slow or wrong.
- **N+1 queries** — One query for a list plus **another query per row** because data was fetched lazily—classic slow-path bug.
- **Lazy loading vs eager loading** — Fetch linked data **on first touch** vs **batch up-front**—maps to N+1 pain.
- **structlog / OpenTelemetry** — `structlog` makes logs structured (easy for machines/humans to filter); OpenTelemetry hooks into **tracing** across services—the observability projects in this repo use similar habits.
- **`PYTHONPATH`** — Environment knob that tricks Python into finding imports; overuse hides broken packaging.

### Read next (handbook)

- **[Concurrency basics](../concepts/software-engineering.md#concurrency-basics)** and **[Async sketch — Python row](../concepts/software-engineering.md#async-sketch)** — event loops vs blocking I/O.
- **[Memory and performance](../concepts/memory-and-performance.md)** — when to profile Python vs split retrieval to Go.
- **[Example: idempotent webhook or job](../concepts/software-engineering.md#example-idempotent-webhook-or-job-consumer)** — retries, queues, integrations.
- **[ORMs and the N+1 pattern](../concepts/database-design.md#orms-and-the-n1-query-pattern)** — Django/SQLAlchemy-shaped access.

---

## See also

- [Language fundamentals comparison — Python](language-fundamentals-comparison.md) — syntax side-by-side
- [Go stack map](go.md) — retrieval throughput lane beside Python
- [Software engineering breadth](../concepts/software-engineering.md)
- [SQL ecosystem map](sql.md) when the system is **data-heavy**
