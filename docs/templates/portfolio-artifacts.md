# Portfolio artifacts template (resume-ready)

Each lab repo should accumulate an **interview packet** under `docs/portfolio/` (or equivalent README sections). Commit artifacts when you call the milestone **done** — they are what senior engineers show in reviews and interviews.

**Framework:** tag every architecture decision record (ADR) and diagram to a [pillar](../concepts/architecture-framework.md#the-five-pillars). **Quality bar:** [sample portfolio](../examples/sample-portfolio/).

**Template location:** this file lives in the playbook; copy structure into your lab repo.

---

## 1. Architecture diagram

**File:** `docs/portfolio/architecture.md` (or `architecture.png` + short caption)

This diagram shows how your service fits in the system — who calls whom and where data flows.

One box-and-arrow diagram showing:

- Service boundaries (who calls whom) — **Pillar 1**
- Sync vs async paths (HTTP vs queue) — **Pillar 1 + 2**
- Data stores and external dependencies — **Pillar 3**

**Mermaid starter** (replace labels for your lab):

```mermaid
flowchart LR
  Client[Client or partner] --> API[Your service]
  API --> Store[(Database or queue)]
  API --> Downstream[Optional downstream]
```

**Tips:** Context level is enough for early labs; add component detail when you split services (Projects 8, 11, 21).

---

## 2. ADR (Architecture Decision Record)

**File:** `docs/portfolio/adr-001-short-title.md`

Use one page per significant fork — what you chose, what you rejected, and why. Glossary: [ADR](../concepts/software-engineering-glossary.md#adr-architecture-decision-record).

```markdown
# ADR-001: [Short title]

## Status
Accepted | Superseded by ADR-00N

## Pillar
N — [System shape | Integration & messaging | Data architecture | Performance & language boundaries | Reliability, security, operations]
(primary; add secondary pillar if the decision spans two)

## Context
What problem or constraint forced a decision?

## Decision
What we chose and what we rejected.

## Consequences
Positive, negative, and follow-ups (monitoring, debt, team skill).
```

Cross-project ADRs (e.g. Go vs Rust) may also live in playbook [PROGRESS.md](../../PROGRESS.md) with a link from the lab repo.

---

## 3. Performance numbers

**File:** `docs/portfolio/performance.md`

Record at least one measured baseline or before/after — numbers beat claims in interviews.

At least **one measured** baseline or before/after:

| Metric | Before | After | How measured |
|--------|--------|-------|--------------|
| p95 latency | … | … | curl loop / hey / wrk |
| Throughput | … | … | … |
| Peak RSS / memory | … | … | profiler / `docker stats` |
| Query plan | seq scan | index scan | `EXPLAIN ANALYZE` |

**Per-project starters (copy into your lab repo):**

| Project | Template |
|---------|----------|
| 4 — SQL | [performance-p4-sql.md](performance-p4-sql.md) |
| 8 — Go retrieval | [performance-p8-go.md](performance-p8-go.md) (Go-first; replaces P19 Rust ADR) |
| 18 — Proxy | [performance-p18-proxy.md](performance-p18-proxy.md) |
| 23 — Rate limiter (optional) | Same table format; middleware p95 + 429 accuracy |
| 25 — Search (optional) | Same table format; suggest p95 + index build time |

**Early labs:** “N/A — no hot path yet; will baseline at Project 8” is acceptable **with one sentence why**.

See [Memory and performance](../concepts/memory-and-performance.md) for measure → profile → fix → verify workflow.

---

## 4. Failure modes

**File:** `docs/portfolio/failure-modes.md`

List what breaks in production **without** this project’s mitigations — this is interview gold.

Three bullets minimum — what breaks in production **without** this project’s mitigations:

```markdown
## Failure modes without this work

1. **Duplicate webhook delivery** → double billing unless idempotency key stored.
2. **Forged POST** → unauthorized state change unless hash-based message authentication code (HMAC) verified on raw body.
3. **Poison payload loop** → partner retries forever unless dead-letter queue (DLQ) + documented abandon.
```

Mirror optional **Failure mode** field in [PROGRESS.md](../../PROGRESS.md) milestone entries.

---

## 5. Observability evidence

**File:** `docs/portfolio/observability.png` (or `.md` with fenced log excerpt)

Attach proof that you can trace a real request — screenshot or redacted log snippet.

Screenshot or redacted log snippet showing:

- **request_id** (or trace id) on a real request
- Latency or status in structured form
- Optional: metric dashboard or grep count

**Do not commit:** API keys, tokens, full prompts with personally identifiable information (PII), production customer data.

Project 3 success criteria often satisfy this artifact for the host service; still copy one excerpt into `docs/portfolio/` for the portfolio folder.

---

## Checklist before milestone done

- [ ] `docs/portfolio/` exists in lab repo (or linked README sections)
- [ ] Architecture diagram committed
- [ ] At least one ADR (or explicit “single-path lab, ADR at integration step” note)
- [ ] Performance numbers or N/A with reason
- [ ] Failure modes documented
- [ ] Observability evidence attached
- [ ] Optional: `scripts/` with strict mode; `shellcheck` clean ([Bash map](../languages/bash.md))

**Capstone (Project 22):** Flagship README links to each service’s `docs/portfolio/` plus one **system-level** diagram and demo walkthrough.
