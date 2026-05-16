# Project 3 — Observability lab

## Problem

Make a small service **debuggable in production**: correlate requests, log structured facts, optional traces.

## Career relevance

**Summary:** You learn to leave **breadcrumbs in production**—so one user report, deploy, or slow query becomes a **searchable story** instead of guesswork across five services.

### In depth

Production systems spend most of their life **failing in ways you did not expect**. Observability is how you earn trust with **on-call, SREs, and support**—and how you shorten incidents from hours to minutes. Happy-path logging alone is what keeps teams **guessing** when prod misbehaves; structured correlation is how you **earn** the next incident postmortem with facts, not theories.

**Why learning this moves the needle**

- **Incident response:** Correlation IDs turn vague reports (“checkout broke”) into **one grep or one trace** across services. The skill is **propagation**: browser → edge → API → worker → DB, same id everywhere stakeholders can agree on.
- **Why this matters:** Production backend work rewards **logging, metrics, and tracing** you can actually use; hands-on beats textbook definitions. Owning *“we added `request_id` to every log line and returned it in the header”* as lived behavior is more credible than naming three vendors.
- **Cost and performance:** Structured fields (`duration_ms`, `db_ms`, `partner_status`, cache hit/miss) feed **dashboards and alerts** before customers notice slowness. SRE-minded teams **alert on SLOs**, not on “someone read the logs.”
- **Compliance and audits:** Log shape and retention policies matter when someone asks **who saw what data and when**. Even a README that states **what you never log** (full card numbers, passwords) shows you’ve thought past the happy path.

**Real-world situations this project mirrors**

- **Deploy regression:** a spike in **`5xx`** after release—you need to **slice** by route, build SHA, and error class. English sentences in syslog don’t support that; JSON fields do.
- **Support escalations:** a screenshot with **request id** or **trace id** from the app, CDN, or mobile client—you follow it through the platform to the exact failing dependency.
- **Latency mysteries:** a **noisy neighbor** query or N+1 only appears under load; spans show **which hop** ate the budget (DB vs HTTP vs cache vs LLM) without attaching a debugger in prod.
- **Distributed lies:** the edge returned **200** but async work or a downstream **billing** call failed—without shared context, each service’s logs look “fine”; with correlation, the failure is **one narrative**.

## Code repo

**Default (playbook phase 2):** Meet the observability success criteria on the **same codebase** as [Project 4 — RAG / LLM service](04-rag-llm-service.md)—the FastAPI skeleton already exposes **request id + JSON logs** (`request_context` middleware).

| | URL |
|---|-----|
| **GitHub** | [https://github.com/shemaiahCox/rag-llm-lab](https://github.com/shemaiahCox/rag-llm-lab) |
| **SSH** | `git@github.com:shemaiahCox/rag-llm-lab.git` |
| **Local sibling** | [`../projects/04-rag-llm-lab`](../projects/04-rag-llm-lab) |

**Alternatives:** A minimal Express/FastAPI/Laravel app; extend [Project 2 — Contract-first API](02-contract-first-api.md); for **TypeScript-first**, piggyback on [Project 6](06-node-typescript-lab.md) (any track) and apply the same success criteria there.

## Key concepts (with definitions and code)

### Correlation / trace id

**What:** A single string (often UUID) attached to **one user-facing request** end-to-end across services.

**Problem it solves:** Without it, five microservices each log unrelated IDs and **you cannot reconstruct one story**.

**Example from rag-llm-lab** (`request_context` middleware):

```python
rid = request.headers.get("X-Request-Id") or str(uuid.uuid4())
request.state.request_id = rid
# ... after handler ...
response.headers["X-Request-Id"] = rid
```

### Structured logging

**What:** Logs as **JSON** (or key=value fields), one event per line, **searchable** in Datadog, CloudWatch, Grafana Loki, etc.

**Problem it solves:** Regex on English sentences does not scale; **fields** (e.g. `request_id`, `latency_ms`) enable alerts and dashboards.

**Example** (webhook lab stderr):

```php
// src/Logger.php — merge context into one JSON object
$row = array_merge([
    'ts' => gmdate('c'),
    'level' => $level,
    'message' => $message,
], $context);
fwrite(STDERR, json_encode($row, JSON_UNESCAPED_SLASHES) . "\n");
```

### Trace / span (optional stretch)

**What:** **OpenTelemetry** is the **portable default** for traces in cross-language backends: parent/child **spans** (e.g. “HTTP in” → “DB query” → “LLM call”) with timings, exportable to vendors or a local collector. Vendor-specific APM SDKs still exist; OTel-first thinking maps cleanly when you change hosts.

**Problem it solves:** Shows **where** latency lives (network vs DB vs external API) without printf debugging.

## Success criteria

- [ ] Every request has a **correlation / trace id** (header + log field).
- [ ] Logs are **JSON** (or one line per field) suitable for log aggregation.
- [ ] Log at least: method, path, status, duration, error stack when 5xx.
- [ ] README documents how you would find a user’s failed request given a `request_id`.

## Exploration scenarios

Implement these against **your** observability lab host ([`04-rag-llm-lab`](../projects/04-rag-llm-lab) / [GitHub](https://github.com/shemaiahCox/rag-llm-lab) already exposes request ids + JSON logs; or any minimal service from [Project 6](06-node-typescript-lab.md)). Put concrete curls in the **service README**.

### 1 — Generated correlation id

- **Action:** Call any route **without** `X-Request-Id`.
- **Expected outcome:** Response includes `X-Request-Id`; logs include the same value on every line for that request.

### 2 — Client-provided correlation id

- **Action:** Send a known UUID in `X-Request-Id`; repeat with typos / empty (document policy).
- **Expected outcome:** Known good id preserved end-to-end; invalid handled per README (reject vs replace).

### 3 — Happy path log shape

- **Action:** Successful request to a representative route.
- **Expected outcome:** JSON log includes method, path, status, `duration_ms` (or equivalent), `request_id`.

### 4 — Error path log shape

- **Action:** Trigger `5xx` or uncaught exception path your app exposes in dev.
- **Expected outcome:** Logs include error class/stack (per policy), **same** `request_id`, status—supports incident drills.

### 5 — Support drill (README procedure)

- **Setup:** Ask a friend or past-you: “User saw failure at 14:02.”
- **Action:** Follow **only** your README’s steps using `request_id` from a simulated client header.
- **Expected outcome:** You reach the exact failing log line (or acknowledge gaps and fix README).

### 6 — Stretch: latency attribution

- **Action:** Add temporary slow dependency or sleep in one code branch.
- **Expected outcome:** Logs or spans show **which segment** dominated duration—prep for OpenTelemetry stretch.

## Stretch

- OpenTelemetry export to console or local collector (recommended path before tying traces to a single vendor).

## Companion reading

- [Debugging (workflow)](../docs/handbook/software-engineering.md#debugging-workflow) — structured loop for narrowing failures once you have correlation IDs and logs.

## Maps to

SRE-minded backend roles, on-call readiness.
