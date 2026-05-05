# Project 3 — Observability lab

## Problem

Make a small service **debuggable in production**: correlate requests, log structured facts, optional traces.

## Code repo

_TBD — can extend Project 2 or a minimal Express/FastAPI/Laravel app._ Link it here.

You can **reference** [rag-llm-lab](https://github.com/shemaiahCox/rag-llm-lab) today for a minimal **request id + JSON log** pattern (Project 4 stack overlap).

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

**What:** **OpenTelemetry** (or vendor APM) records parent/child **spans** (e.g. “HTTP in” → “DB query”) with timings.

**Problem it solves:** Shows **where** latency lives (network vs DB vs external API) without printf debugging.

## Success criteria

- [ ] Every request has a **correlation / trace id** (header + log field).
- [ ] Logs are **JSON** (or one line per field) suitable for log aggregation.
- [ ] Log at least: method, path, status, duration, error stack when 5xx.
- [ ] README documents how you would find a user’s failed request given a `request_id`.

## Stretch

- OpenTelemetry export to console or local collector.

## Maps to

SRE-minded backend roles, on-call readiness.
