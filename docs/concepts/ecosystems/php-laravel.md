# Ecosystem map: PHP + Laravel

**Use this:** **Laravel** is the frame (HTTP, queues, events, Eloquent); **PHP** basics below are what you need to **read and ship** safely—matches this playbook’s **PHP integration** lane.

**Companion:** [term cards](../README.md) · [unfamiliar-stack ship](../../../checklists/unfamiliar-stack-ship.md) · [Project 1 webhook spec](../../../project-specs/01-integration-webhook-receiver.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | **PHP-FPM** (per-request workers) vs **CLI** (`artisan`, queues, schedulers) vs **Laravel Octane** (long-lived workers — **different memory/lifetime** rules). |
| **Deps** | **Composer** (`composer.json` / lock); **autoloading** (PSR-4). `vendor/` is not your code — don’t “fix” upstream by editing. |
| **Laravel boot** | **HTTP kernel** → **middleware pipeline** → **router** → **controller action** / **closure**; **service container** resolves dependencies. |
| **Config** | `config/*.php` + **`.env`**; **`php artisan config:cache`** in prod — **env changes** require rebuild/redeploy awareness. |

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

## Plain PHP (no Laravel)

Only spin up a separate note if you maintain **legacy scripts** or **micro-sites** without the framework—same **PHP** section above applies; you lose Laravel’s **structured HTTP/queue/DI** guardrails, so **explicit** structure matters more.

---

## See also

- [Integration hardening](../../../checklists/integration-hardening.md)
- [Software engineering breadth](../../reference/software-engineering.md)
- Laravel docs: **Requests**, **Queues**, **Eloquent**, **Octane**
