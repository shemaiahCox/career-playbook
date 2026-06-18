# Request flow — webhook receiver

**Spec:** [Project 1](../../../career-project-specs/01-integration-webhook-receiver.md)

```mermaid
sequenceDiagram
  participant Partner
  participant Controller as public_index.php
  participant Sig as SignatureVerifier
  participant Store as IdempotencyStore
  participant Handler as handleWebhook
  participant DLQ as dead_letters

  Partner->>Controller: POST /webhook raw body + headers
  Controller->>Sig: verify HMAC on raw bytes
  alt invalid signature
    Sig-->>Controller: 401
    Controller-->>Partner: JSON error
  else valid signature
    Controller->>Store: beginOrResume idempotency key
    alt completed replay
      Store-->>Controller: stored status + body
      Controller-->>Partner: same 200 body as first delivery
    else in flight
      Store-->>Controller: processing
      Controller-->>Partner: 409
    else new delivery
      Controller->>Handler: domain logic
      alt handler throws
        Handler-->>Controller: exception
        Controller->>DLQ: recordDeadLetter
        Controller->>Store: abandon key
        Controller-->>Partner: 500 handler_failed
      else success
        Handler-->>Controller: result array
        Controller->>Store: complete 200 + body
        Controller-->>Partner: 200 JSON
      end
    end
  end
```

## Happy path (scenario 1)

1. Partner sends signed POST with new `Idempotency-Key`.
2. HMAC passes; store inserts `processing` row.
3. Handler returns result; store updates to `completed` with response body.
4. Structured log `webhook_ok` on stderr.

## Replay (scenario 2)

Same key and body: store returns `completed`; handler **not** invoked again; response body matches first delivery (including stored `request_id`).

## Poison path (scenario 5)

`event: test.boom` triggers handler throw → `dead_letters` insert → `abandon()` deletes `processing` row → `500` to partner. Partner may retry same key after fix (scenario 9).
