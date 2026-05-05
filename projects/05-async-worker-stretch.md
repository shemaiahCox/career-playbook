# Project 5 — Async worker (stretch)

## Problem

Move from “request in → response out” to **durable processing**: enqueue, worker, retries, visibility.

## Code repo

_TBD — often extends [Project 1](01-integration-webhook-receiver.md) (same domain)._ Link it here.

Optional pattern: keep [webhook-receiver-lab](https://github.com/shemaiahCox/webhook-receiver-lab) HTTP-thin: validate + enqueue, then a worker process drains the queue.

## Stack (suggestions)

Redis + PHP worker, Laravel queues, BullMQ (Node), or RDS outbox pattern.

## Key concepts (with definitions)

### Message queue (job queue)

**What:** A **broker** (Redis, SQS, RabbitMQ, database table) holds **messages** representing work; producers **enqueue**, consumers **dequeue** and ack/fail.

**Problem it solves:** HTTP timeouts: Stripe webhook must return `200` in seconds while **heavy** work (PDFs, third-party APIs) runs **asynchronously** without losing jobs.

### At-least-once delivery

**What:** The queue may deliver the **same message more than once** (crash before ack, visibility timeout).

**Problem it solves:** Your handler must be **idempotent** (same theme as `Idempotency-Key` in Project 1) or use **dedupe keys** in the worker.

**Tie-in:** Reuse the idea from Project 1—**business idempotency** is queue-independent.

### Worker / consumer

**What:** Long-running process that polls or subscribes, runs business logic, **acks** on success, **nacks** or **requeues** with backoff on transient failure.

**Problem it solves:** Scales **CPU-heavy** work horizontally (N workers) vs one web thread.

### Dead-letter queue (DLQ)

**What:** After N failures or non-retryable error, move message to a **DLQ** for inspection—same **operational idea** as `dead_letters` in webhook-receiver-lab.

**Problem it solves:** Poison messages do not block the main queue forever.

**Cross-reference** (Project 1): synchronous dead-letter **table** + abandon for retries.

```php
// public/index.php — synchronous analogue
$store->recordDeadLetter($idempotencyKey, $rawBody, $trace);
$store->abandon($idempotencyKey);
```

## Success criteria

- [ ] Producer enqueues a job from webhook validation path (or separate endpoint).
- [ ] Worker processes with at-least-once semantics; **idempotency** still prevents duplicate side effects.
- [ ] Failed jobs land in a **dead-letter** state with reason and payload ref.
- [ ] README diagrams happy path + retry path.

## Maps to

Scale, background jobs, integration-heavy systems.
