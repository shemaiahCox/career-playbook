# Project 5 — Async worker (stretch)

## Problem

Move from “request in → response out” to **durable processing**: enqueue, worker, retries, visibility.

## Career relevance

**Summary:** You move **heavy, slow, or flaky work** off the HTTP thread into **durable jobs**—the pattern behind most “webhook returned 200 but we’re still working” systems and almost every scaled backend.

### In depth

Almost every mature product eventually splits **fast acknowledgment** (HTTP 200 in seconds) from **slow or flaky work** (PDFs, ML, third-party APIs, batch fan-out). Queues and workers are the standard pattern; understanding **at-least-once delivery and idempotency** is a core backend skill. If you only ever think in request/response, you’ll struggle anywhere **throughput and reliability** matter more than latency to the first byte.

**Why learning this moves the needle**

- **Partner SLAs:** Webhook providers expect a quick **`2xx`**; heavy work belongs **after** the response, in a durable queue. Keeping the HTTP handler thin is how you stay inside **their timeout and retry rules** without lying about success.
- **Scale:** Workers scale **horizontally**; monolithic request threads do not. This pattern appears in **e-commerce, fintech, and data pipelines**—anywhere work is **bursty** or **CPU-bound** relative to your web tier.
- **Resilience:** Retries + **DLQ** are how you **survive deploys, blips, and poison messages** without losing jobs or blocking the whole queue. You learn the vocabulary: **visibility timeout**, **ack**, **nack**, **backoff**, **poison pill**.
- **Interviews:** “What if the message is delivered twice?” is a standard filter; this project ties directly to [**Project 1**](01-integration-webhook-receiver.md)’s idempotency story. Answering with **both** transport duplicates and business keys is what passes the bar.

**Real-world situations this project mirrors**

- **Payments and provisioning:** webhooks must **ack fast** while you **open accounts**, sync CRM, or run **risk scoring**—too slow in HTTP and the provider marks deliveries failed and floods retries.
- **Long-running tasks:** image, video, or PDF generation **exceeds** reverse-proxy or **mobile** timeouts; the job completes **in workers**, and the UI polls or gets **pushed** a completion event.
- **Rate limits and partners:** a downstream API **429s** you; workers **back off** and spread load instead of tying up web workers or cascading timeouts to users.
- **Operational safety:** one malformed message **crashes** the consumer loop; **DLQ + alerting** isolates the bad payload so the main queue **drains** while someone replays or patches the handler.

## Code repo

_TBD — often extends [Project 1](01-integration-webhook-receiver.md) (same domain)._ Link it here.

Optional pattern: keep [webhook-receiver-lab](https://github.com/shemaiahCox/webhook-receiver-lab) HTTP-thin: validate + enqueue, then a worker process drains the queue.

## Stack (suggestions)

Redis + PHP worker, Laravel queues, **BullMQ (Node)**—see [Project 6 — track C](06-node-typescript-lab.md) for a TS-shaped webhook + worker story—or RDS outbox pattern.

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
