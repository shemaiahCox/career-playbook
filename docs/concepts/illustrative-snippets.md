# Illustrative snippets (playbook patterns)

**Use this:** Copy-paste **starting patterns** for lab READMEs and portfolio docs—adapt types, store, and broker to your stack; label **Illustrative** when no repo exists yet.

**Companion:** [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) · [Messaging and RPC](messaging-and-rpc.md) · [Integration hardening checklist](../../checklists/integration-hardening.md)

---

## Idempotency store (HTTP ingress)

**What:** Durable record keyed by `Idempotency-Key` before side effects.

**Problem it solves:** Partner or workflow retries must not double-apply business effects.

```typescript
// Illustrative — TypeScript (Fastify/Express middleware)
async function withIdempotency(
  key: string,
  run: () => Promise<{ status: number; body: unknown }>,
): Promise<{ status: number; body: unknown }> {
  const existing = await store.findCompleted(key);
  if (existing) return existing;
  const lock = await store.tryLock(key);
  if (!lock) return { status: 409, body: { error: "in_flight" } };
  try {
    const result = await run();
    await store.complete(key, result);
    return result;
  } finally {
    await store.releaseLock(key);
  }
}
```

```go
// Illustrative — Go worker dedupe before side effect
func (w *Worker) Handle(ctx context.Context, job Job) error {
    applied, err := w.store.MarkApplied(ctx, job.ID)
    if err != nil { return err }
    if !applied { return nil } // duplicate delivery — safe no-op
    return w.process(ctx, job.Payload)
}
```

---

## HMAC verification (raw body)

**What:** Compare sender signature over **exact request bytes** before JSON parse.

**Problem it solves:** Re-encoding JSON breaks signatures; forgeries fail at the boundary.

```typescript
// Illustrative — Node: preserve rawBody in route config
import { createHmac, timingSafeEqual } from "node:crypto";

function verifyHmac(rawBody: Buffer, signature: string, secret: string): boolean {
  const expected = createHmac("sha256", secret).update(rawBody).digest("hex");
  const a = Buffer.from(expected, "hex");
  const b = Buffer.from(signature.replace(/^sha256=/, ""), "hex");
  return a.length === b.length && timingSafeEqual(a, b);
}
```

---

## Server-Sent Events (SSE) endpoint

**What:** One-way server push over HTTP; client uses `EventSource` with reconnect.

**Problem it solves:** Ops dashboards update without polling; simpler than WebSocket for one-way feeds.

```typescript
// Illustrative — Fastify SSE handler
app.get("/events", async (req, reply) => {
  reply.raw.writeHead(200, {
    "Content-Type": "text/event-stream",
    "Cache-Control": "no-cache",
    Connection: "keep-alive",
  });
  const lastId = req.headers["last-event-id"] as string | undefined;
  for await (const evt of eventStream({ after: lastId })) {
    reply.raw.write(`id: ${evt.id}\nevent: job\ndata: ${JSON.stringify(evt)}\n\n`);
  }
});
```

| Approach | Pros | Cons | Use when |
|----------|------|------|----------|
| **SSE** | Simple HTTP; auto-reconnect in browsers | One-way only; proxy buffering quirks | Ops dashboards, job status |
| **WebSocket** | Bidirectional; lower overhead at scale | More client/server complexity | Chat, collaborative UI |
| **Polling** | Easiest to debug | Wastes bandwidth; stale UI | Low-frequency updates only |

---

## JWT tenant middleware

**What:** Extract `tenant_id` from verified JWT claims; never trust client body.

**Problem it solves:** Cross-tenant data leaks when scope comes from forged JSON fields.

```typescript
// Illustrative — attach tenant to request after verify
import jwt from "jsonwebtoken";

function tenantMiddleware(req: Request, res: Response, next: NextFunction) {
  const token = req.headers.authorization?.replace(/^Bearer /, "");
  if (!token) return res.status(401).json({ error: "missing_token" });
  try {
    const claims = jwt.verify(token, process.env.JWT_SECRET!) as { sub: string; tenant_id: string };
    req.tenantId = claims.tenant_id; // use in every query: WHERE tenant_id = req.tenantId
    next();
  } catch {
    return res.status(401).json({ error: "invalid_token" });
  }
}
```

---

## Queue consumer (Redis list)

**What:** `BRPOP` loop with ack-after-success and DLQ after N failures.

**Problem it solves:** Durable async work with at-least-once delivery semantics.

```go
// Illustrative — Go + Redis
func (c *Consumer) Run(ctx context.Context) error {
    for {
        msg, err := c.redis.BRPop(ctx, 0, c.queueKey).Result()
        if err != nil { return err }
        payload := msg[1]
        if err := c.handle(ctx, payload); err != nil {
            if c.retriesExceeded(payload) {
                c.dlq.Push(ctx, payload, err.Error())
                continue
            }
            c.requeueWithBackoff(ctx, payload)
            continue
        }
    }
}
```

See [Messaging and RPC — Redis usage](messaging-and-rpc.md#message-brokers--when-employers-use-each).

---

## Kubernetes reconcile loop (controller-lite)

**What:** Observe desired state, diff against cluster, apply idempotently, requeue on error.

**Problem it solves:** Cluster drift and missed watch events without spamming side effects.

```go
// Illustrative — reconcile function (pure logic testable without cluster)
func Reconcile(desired DeploymentSpec, actual DeploymentSpec) (DeploymentSpec, bool, error) {
    if desired.Replicas == actual.Replicas && desired.Image == actual.Image {
        return actual, false, nil // converged — no change
    }
    actual.Replicas = desired.Replicas
    actual.Image = desired.Image
    return actual, true, nil
}
```

---

## BFF proxy to RAG service

**What:** Browser calls your TypeScript server; server holds API keys and calls Python `POST /query`.

**Problem it solves:** Secrets and rate limits stay server-side; eval-aware errors map to UI copy.

```typescript
// Illustrative — map upstream errors for UI
app.post("/api/query", async (req, reply) => {
  const requestId = req.headers["x-request-id"] ?? crypto.randomUUID();
  try {
    const upstream = await fetch(`${RAG_URL}/query`, {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-Request-Id": requestId },
      body: JSON.stringify(req.body),
      signal: AbortSignal.timeout(30_000),
    });
    if (upstream.status === 504) {
      return reply.status(503).send({ error: "retrieval_timeout", request_id: requestId });
    }
    if (upstream.status === 422) {
      return reply.status(200).send({ error: "empty_retrieval", request_id: requestId });
    }
    return reply.send(await upstream.json());
  } catch (e) {
    return reply.status(503).send({ error: "upstream_unavailable", request_id: requestId });
  }
});
```

---

## See also

- [Per-project testing](per-project-testing.md) — how to test each pattern in labs
- [Portfolio artifacts template](../templates/portfolio-artifacts.md) — ADR + diagram expectations
