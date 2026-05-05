# Project 5 — Async worker (stretch)

## Problem

Move from “request in → response out” to **durable processing**: enqueue, worker, retries, visibility.

## Code repo

_TBD — often extends Project 1 (same domain)._ Link it here.

## Stack (suggestions)

Redis + PHP worker, Laravel queues, BullMQ (Node), or RDS outbox pattern.

## Success criteria

- [ ] Producer enqueues a job from webhook validation path (or separate endpoint).
- [ ] Worker processes with at-least-once semantics; **idempotency** still prevents duplicate side effects.
- [ ] Failed jobs land in a **dead-letter** state with reason and payload ref.
- [ ] README diagrams happy path + retry path.

## Maps to

Scale, background jobs, integration-heavy systems.
