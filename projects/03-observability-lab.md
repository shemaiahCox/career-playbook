# Project 3 — Observability lab

## Problem

Make a small service **debuggable in production**: correlate requests, log structured facts, optional traces.

## Code repo

_TBD — can extend Project 2 or a minimal Express/FastAPI/Laravel app._ Link it here.

## Success criteria

- [ ] Every request has a **correlation / trace id** (header + log field).
- [ ] Logs are **JSON** (or one line per field) suitable for log aggregation.
- [ ] Log at least: method, path, status, duration, error stack when 5xx.
- [ ] README documents how you would find a user’s failed request given a `request_id`.

## Stretch

- OpenTelemetry export to console or local collector.

## Maps to

SRE-minded backend roles, on-call readiness.
