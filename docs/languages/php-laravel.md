# Ecosystem map: PHP + Laravel

**Use this:** **Laravel** is the frame (HTTP, queues, events, Eloquent); **PHP** basics below are what you need to **read and ship** safely—matches this playbook’s **PHP integration** lane.

**Companion:** [docs README](../README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md) · [Project 1 webhook spec](../../career-project-specs/01-integration-webhook-receiver.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Best for, alternatives, and playbook fit

| Best for | Use instead when | Primary projects |
|----------|------------------|------------------|
| Integration HTTP ingress, Laravel queues/contracts, webhook receivers | Node/Python when the spec names them for BFF or LLM paths | [Project 1 — Integration webhook](../../career-project-specs/01-integration-webhook-receiver.md) |

---

## How it runs

| Execution | Typing | Memory / concurrency |
|-----------|--------|----------------------|
| **Interpreted** per request under **PHP-FPM** (memory resets each request); **Octane/long-lived** workers reuse RAM across requests | Dynamic typing with optional **typed properties** and return types (PHP 7.4+) | Request-scoped by default; statics/singleton caches become footguns under Octane |

---

## Environment setup

1. Verify: `php -v` (8.2+ typical for Laravel 11).
2. Install deps: `composer install` in project root—commit **`composer.lock`**.
3. Copy env: `cp .env.example .env` then `php artisan key:generate`.
4. Optional scaffold before Project 1 lab clone:

```bash
composer create-project laravel/laravel laravel-scaffold && cd laravel-scaffold && php artisan serve
```

Paste into `routes/web.php`:

```php
Route::get('/exploration/hello', function () {
    return response()->json([
        'ok' => true,
        'via' => 'closure-route',
        'at' => now()->toIso8601String(),
    ]);
});
```

Webhook and integration work belongs in the **Project 1 lab** under [`career-projects/`](../../career-projects/)—not a separate sandbox repo.

---

## Project layout

```
my-app/
├── app/                 # models, jobs, HTTP layer
├── routes/
│   ├── web.php
│   └── api.php
├── config/              # reads .env — cache in prod with care
├── database/
│   └── migrations/
├── tests/
├── composer.json
└── .env                 # local only — not committed
```

---

## Commands you'll use often

| Intent | Command | Notes |
|--------|---------|-------|
| Dev server | `php artisan serve` | Local HTTP on :8000 |
| Test | `php artisan test` or `./vendor/bin/phpunit` | Match CI |
| Queue worker | `php artisan queue:work` | Idempotent handlers—at-least-once |
| Migrate | `php artisan migrate` | Reversible migrations where possible |
| Config cache (prod) | `php artisan config:cache` | Env changes need rebuild |

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

## Footguns

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

- **[Example: idempotent webhook or job](../concepts/software-engineering.md#example-idempotent-webhook-or-job-consumer)** — webhooks + queue retries (fits **ShouldQueue** mental model).
- **[Integration: sync, async, and messaging](../concepts/software-engineering.md#integration-sync-async-and-messaging)** — delivery semantics in prose.
- **[ORMs and the N+1 pattern](../concepts/database-design.md#orms-and-the-n1-query-pattern)** — Eloquent preload story.
- **[Observability: logs, metrics, traces](../concepts/software-engineering.md#observability-logs-metrics-traces)** — structured logs in PHP-shaped services.

---

## See also

- [Language fundamentals comparison — PHP](language-fundamentals-comparison.md) — syntax side-by-side
- [Integration hardening](../../checklists/integration-hardening.md)
- [Software engineering breadth](../concepts/software-engineering.md)
- Laravel docs: **Requests**, **Queues**, **Eloquent**, **Octane**

**Plain PHP (no Laravel):** Only spin up a separate note if you maintain **legacy scripts** or **micro-sites** without the framework—same runtime notes above apply; you lose Laravel’s **structured HTTP/queue/DI** guardrails, so **explicit** structure matters more.
