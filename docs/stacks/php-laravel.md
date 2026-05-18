# Ecosystem map: PHP + Laravel

**Use this:** **Laravel** is the frame (HTTP, queues, events, Eloquent); **PHP** basics below are what you need to **read and ship** safely—matches this playbook’s **PHP integration** lane.

**Companion:** [term cards](README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md) · [Project 1 webhook spec](../../career-project-specs/01-integration-webhook-receiver.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | **PHP-FPM** spins workers that handle **one web request lifecycle**—memory resets naturally. **CLI** scripts (`artisan`, queues) and **Octane/long-lived worker** setups **reuse RAM** across requests—you must rethink globals/singleton caches. |
| **Deps** | **Composer** (`composer.json` + lock) restores libraries; **PSR-4 autoload** maps namespaces to folders. **`vendor/`** is upstream code—fork inside `vendor/` is a trap. |
| **Laravel boot** | Incoming HTTP traverses kernel → ordered **middleware** → matched **route** → **controller/action**; the **service container** wires injected dependencies (“this class needs Logger X”). |
| **Config** | `config/*.php` reads **environment** (`APP_ENV`, `.env`). `php artisan config:cache` bakes configs in prod—flip env vars without rebuilding at your peril. |

---

## How concepts show up

**HTTP & boundaries**

- **Middleware** for cross-cutting: auth, throttling, request IDs. Ordering matters (outer vs inner).
- **FormRequests / validation** — treat as **contract** at the edge; don’t duplicate three layers without reason.

**Async / background**

- **Queues** (`ShouldQueue` jobs): **idempotency** and **retry** config are architectural—**at-least-once** delivery is the default mental model.
- **Scheduler** (`app/Console/Kernel.php` or Laravel 11+ scheduling) — cron + **single-machine** assumptions; use **locks** for overlapping jobs if needed.

**Data (Eloquent)**

- **N+1 queries** (`with()` / eager loading) — classic prod footgun.
- **Transactions** for invariants spanning multiple rows/tables.
- **Migrations** — **reversible** where possible; **zero-downtime** deploy needs care (expand/contract pattern for serious scale).

**“Memory leaks” in PHP**

- **Per-request** FPM model often **hides** leaks (process recycle). **Octane / RoadRunner / FrankenPHP** — **statics, singletons holding state**, **unbounded caches** in memory — become **real** across requests.

---

## Footgun checklist

- [ ] **`APP_DEBUG`** / **`APP_ENV`** never wrong in prod; `.env` not committed; **keys** (`APP_KEY`) managed.
- [ ] **Secrets** in env or secret manager—not in repo, not in `config` committed with real values.
- [ ] **Webhook handlers:** signature, **idempotency**, **replay** behavior (see integration hardening checklist).
- [ ] **Queue workers:** **failed_jobs** / DLQ discipline; **max retries** and **timeout** aligned with partner SLAs.
- [ ] If **Octane/long-lived**: audit **global state**, **static caches**, **connection pools**.

---

## Plain language: terms used on this page

Laravel hides ceremony—come here when tutorials assume buzzwords sunk in overnight.

- **PHP-FPM** — Pool of PHP workers—each typical web **request is born and dies isolated** (**memory resets** when the handler finishes unless you opted into long-lived runtimes).
- **`artisan`** — Laravel CLI you run for queues, migrations, generators, cron glue.
- **Octane / RoadRunner / FrankenPHP / long-lived workers** — Faster because processes stay alive—**globals/static caches/leaks** behave like backend services (**not throwaway RAM** anymore).
- **Composer / lock / PSR-4** — Composer downloads packages (`vendor/`) following `composer.lock`; namespaces map predictable paths—**don't edit upstream inside `vendor/`**.
- **Service container / DI** — Framework answers “give me Mailer”—constructs wired objects recursively.
- **Middleware** — Code wrapping requests—ordering from outside-in decides who runs first (**auth**, throttling, request IDs…).
- **`FormRequests` / validation** — Opinionated Laravel layer saying “incoming JSON/query must satisfy these rules.”
- **`ShouldQueue` / retry / DLQ mindset** — Async jobs assumed **possibly duplicated** (**at-least-once**)—handlers must tolerate replays (**idempotent** helpers).
- **Scheduler + overlap locks** — Cron hits one VM—long jobs need explicit locking so overlaps do not corrupt data twice.
- **Eloquent ORM / N+1 / eager (`with`)** — ORM ergonomics hiding SQL until hot paths regress—preload related rows consciously.
- **Migrations reversible / zero-downtime discipline** — Evolve schema gradually so deploys rolling old+new binaries stay safe (**expand/contract** pattern).
- **`APP_DEBUG` / `APP_KEY` / `.env`** — Secrets + debug flags treated as radioactive for production parity.

### Read next (handbook)

- **[Example: idempotent webhook or job](../handbook/software-engineering.md#example-idempotent-webhook-or-job-consumer)** — webhooks + queue retries (fits **ShouldQueue** mental model).
- **[Integration: sync, async, and messaging](../handbook/software-engineering.md#integration-sync-async-and-messaging)** — delivery semantics in prose.
- **[ORMs and the N+1 pattern](../handbook/database-design.md#orms-and-the-n1-query-pattern)** — Eloquent preload story.
- **[Observability: logs, metrics, traces](../handbook/software-engineering.md#observability-logs-metrics-traces)** — structured logs in PHP-shaped services.

---

## Plain PHP (no Laravel)

Only spin up a separate note if you maintain **legacy scripts** or **micro-sites** without the framework—same **PHP** section above applies; you lose Laravel’s **structured HTTP/queue/DI** guardrails, so **explicit** structure matters more.

---

## See also

- [Integration hardening](../../checklists/integration-hardening.md)
- [Software engineering breadth](../handbook/software-engineering.md)
- Laravel docs: **Requests**, **Queues**, **Eloquent**, **Octane**
