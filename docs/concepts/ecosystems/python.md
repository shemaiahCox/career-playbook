# Ecosystem map: Python (services and scripting)

**Use this:** You ship or review **Python** backends (**FastAPI**, **Flask**, **Django**), **workers**, **CLI tools**, or **notebooks** that leave the lab. This is **vocabulary + runtime footguns**, not a syntax course.

**Companion:** [term cards](../README.md) · [unfamiliar-stack ship](../../../checklists/unfamiliar-stack-ship.md) · [RAG / LLM service](../../../project-specs/04-rag-llm-service.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | **CPython** + **GIL** (Global Interpreter Lock): **threads** help **I/O-bound** work more than **CPU-bound** parallelism (use **multiprocessing** or native extensions for heavy CPU). |
| **Environments** | **venv** / **virtualenv**; lockfiles via **pip-tools**, **Poetry**, **PDM**, **uv** (`pyproject.toml`). **Never** run prod on “whatever was on PATH.” |
| **Packaging** | **Modules** = files; **packages** = dirs with `__init__.py` (implicit namespace packages exist—know your layout). **`PYTHONPATH`** hacks often mean a packaging smell. |
| **Async** | **`async`/`await`** + **`asyncio`** event loop; **FastAPI** runs async handlers on the loop—**blocking** calls in async routes **stall** concurrency (offload to threads/process pools). |

---

## How concepts show up

**HTTP / APIs**

- **FastAPI:** dependency injection via **Depends**, **Pydantic** models at the boundary—validation **is** contract discipline.
- **WSGI (Flask/Django legacy)** vs **ASGI (Starlette/FastAPI)** — deployment and concurrency models differ; don’t mix assumptions.

**Data access**

- **SQLAlchemy** (2.x style) / **Django ORM**: **N+1** and **lazy loading** in request paths are the usual prod surprises—relate to [SQL map](sql.md) and [database design](../../reference/database-design.md).

**Observability**

- **`structlog`** / standard **logging**; **OpenTelemetry** for traces—set **correlation IDs** at the request edge (aligns with [observability lab](../../../project-specs/03-observability-lab.md)).

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

## See also

- [Software engineering breadth](../../reference/software-engineering.md)
- [SQL ecosystem map](sql.md) when the system is **data-heavy**
