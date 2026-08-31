# Project 1 — reference outcomes (webhook receiver)

Captured exemplars for [Project 1 spec](../../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md). Read these **without running** the lab; use [Exploration scenarios](../../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md#exploration-scenarios) to verify yourself.

**Source repo:** [webhook-receiver-lab](https://github.com/shemaiahCox/webhook-receiver-lab)  
**Captured:** 2026-06-18 — PHP 8.5 built-in server on `127.0.0.1:18080`, fresh SQLite `capture-test.sqlite`

## Files

| File | Exploration scenarios | Content |
|------|----------------------|---------|
| [architecture.md](architecture.md) | — | System context + pillar table |
| [flow.md](flow.md) | 1–5 | Request sequence diagram |
| [logs-success.jsonl](logs-success.jsonl) | 1, 2 | `webhook_ok`, `idempotent_replay` |
| [logs-reject.jsonl](logs-reject.jsonl) | 3, 4, 5 | `signature_rejected`, `missing_idempotency`, `webhook_failed` |
| [http-responses.md](http-responses.md) | 1–5, 9 | `curl -i` captures |
| [store-snapshots.md](store-snapshots.md) | 2, 5 | `idemp` and `dead_letters` rows |

## Regenerate

```bash
cd career-projects/01-webhook-receiver-lab   # or clone from GitHub
export WEBHOOK_SECRET='your-secret'
export DATABASE_PATH=storage/capture-test.sqlite
php -S 127.0.0.1:18080 -t public public/router.php 2> /tmp/webhook-stderr.log
# run curls from http-responses.md; then sqlite3 queries from store-snapshots.md
```
