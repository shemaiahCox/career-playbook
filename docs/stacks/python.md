# Ecosystem map: Python (services and scripting)

**Use this:** You ship or review **Python** backends (**FastAPI**, **Flask**, **Django**), **workers**, **CLI tools**, or **notebooks** that leave the lab. This is **vocabulary + runtime footguns**, not a syntax course.

**Companion:** [term cards](README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md) · [RAG / LLM service](../../career-project-specs/04-rag-llm-service.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | Most people run **CPython** (the normal `python` interpreter). A **GIL** (Global Interpreter Lock) means **only one thread runs Python bytecode at a time**, so extra threads help when work **waits on network or disk** (*I/O-bound*), not for parallel **heavy CPU on one machine** (use **multiprocessing**, job runners, or native extensions for that). |
| **Environments** | A **venv** (or similar) isolates libraries per project—like a sandbox so Project A cannot break Project B. Lockfiles (**pip-tools**, **Poetry**, **PDM**, **uv**) pin versions; **`pyproject.toml`** is where modern projects declare tooling. Treat “whatever Python my laptop woke up with” as **never** prod. |
| **Packaging** | **Modules** = files; **packages** = dirs (often with `__init__.py`; “namespace packages” also exist—know how your repo is laid out). Tweaking **`PYTHONPATH`** everywhere usually means imports are wired wrong somewhere else. |
| **Async** | **`async` / `await`** runs on **`asyncio`’s** event loop (**one thread juggling many waits**). **FastAPI** uses this model—calling **blocking** APIs (slow disk, naive `requests.get`) inside async routes **stalls everyone** waiting on that worker (offload to thread pools etc.). |

---

## How concepts show up

**HTTP / APIs**

- **FastAPI:** dependency injection via **Depends**, **Pydantic** models at the boundary—validation **is** contract discipline.
- **WSGI (Flask/Django legacy)** vs **ASGI (Starlette/FastAPI)** — deployment and concurrency models differ; don’t mix assumptions.

**LLM / RAG-shaped services**

- Keep **`POST /query` (or equivalent) contract** and **eval JSONL** stable; treat **LangChain**, **LangGraph**, **LlamaIndex**, or **minimal SDK + custom retrieval** as **replaceable implementation** behind one service module ([RAG / LLM service](../../career-project-specs/04-rag-llm-service.md)).

**Data access**

- **SQLAlchemy** (2.x style) / **Django ORM**: **N+1** and **lazy loading** in request paths are the usual prod surprises—relate to [SQL map](sql.md) and [database design](../handbook/database-design.md).

**Observability**

- **`structlog`** / standard **logging**; **OpenTelemetry** for traces—set **correlation IDs** at the request edge (aligns with [observability lab](../../career-project-specs/03-observability-lab.md)).

**Security**

- **Secrets:** env or vault—not committed; **`.env`** not in images/repos.
- **Dependency scanning:** **pip-audit** / GitHub Dependabot; supply chain matters for integrations.

---

## Footgun checklist

- [ ] **Mutable default arguments** (`def f(x=[]):`) and **shared mutable state** across requests—classic bug class.
- [ ] **`except Exception:`** swallowing without log context—production blindness.
- [ ] **Blocking I/O** inside **async** handlers (DB drivers, `requests`) without **executor** offload—throughput collapse under load.
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

- **[Concurrency basics](../handbook/software-engineering.md#concurrency-basics)** and **[Async sketch — Python row](../handbook/software-engineering.md#async-sketch)** — event loops vs blocking I/O.
- **[Example: idempotent webhook or job](../handbook/software-engineering.md#example-idempotent-webhook-or-job-consumer)** — retries, queues, integrations.
- **[ORMs and the N+1 pattern](../handbook/database-design.md#orms-and-the-n1-query-pattern)** — Django/SQLAlchemy-shaped access.

---

## See also

- [Software engineering breadth](../handbook/software-engineering.md)
- [SQL ecosystem map](sql.md) when the system is **data-heavy**
