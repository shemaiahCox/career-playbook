# Architecture framework

**Use this:** **Read this first.** Every lab practices decisions under **five pillars**. The **learning order** is the [7-domain path plus required competence labs 08–13](../../README.md#progression-phase-1--7).

**Reading order:**

1. **You are here** — five pillars + reference architecture
2. Pillar deep docs:
   - Pillar 1 → [Systems integration architect](systems-integration-architect.md)
   - Pillar 2 → [Messaging and RPC](messaging-and-rpc.md)
   - Pillar 3 → [Database design](database-design.md)
   - Pillar 4 → [Memory and performance](memory-and-performance.md) · [Concurrency runtime model](concurrency-runtime-model.md)
   - Pillar 5 → [Software engineering § Observability](software-engineering.md#observability-logs-metrics-traces) · [Azure cloud and AI](azure-cloud-and-ai.md)
3. [Phase 1 — Agentic orchestration](../../career-project-specs/01-agentic-orchestration.md) → [PROGRESS.md](../../PROGRESS.md)

**Companion:** [Architecture checklist](../../checklists/architecture-checklist.md) · [Sample portfolio](../examples/sample-portfolio/) · [Agentic orchestration](agentic-orchestration.md) · [Cloud portability](cloud-portability.md)

Modern backend work is architectural work. Phases, languages, career docs, and checklists all map here.

**Quality bar:** [sample portfolio](../examples/sample-portfolio/). **Lifecycle questions:** [architecture-checklist.md](../../checklists/architecture-checklist.md).

---

## Why architecture is the backbone

Architecture is the set of **choices that are expensive to reverse**: how work is split, how data flows, what fails and how, and what you optimize for (latency, cost, consistency, operability).

| Lens | What it emphasizes | Where in this playbook |
|------|-------------------|------------------------|
| **Production architecture** | Boundaries, contracts, queues, identity, failure modes | Five pillars + portfolio artifacts |
| **Interview system design** | Scale estimates, classic problems, tradeoff narration | [System design interview map](../career/system-design-interview-map.md) |

Where this path is heading: **agentic AI** (Python Deep Agents / LangGraph / MCP), **Go** high-concurrency backends, and **Azure** as code (Terraform, Entra, AKS). Senior signal means end-to-end shape plus explicit failure modes, measured performance, and credible ADRs.

**Languages:** Python and Go are primary. TypeScript/Node is a secondary MCP/API skill.

---

## Reference architecture

Every phase connects to this shape — even when you build one slice at a time:

```text
Allowlisted MCP tools (FastMCP; TypeScript SDK stretch)
    → Python Deep Agent + LangGraph checkpoints                 [Pillar 1 + 3 + 5]
    → Containers (Compose → image tags)                         [Pillar 5]
    → Terraform Azure (RG, VNet, App Service / Container Apps)  [Pillar 5]
    → Entra / RBAC / Key Vault                                  [Pillar 5]
    → Go workers + Python Functions on Service Bus + Redis      [Pillar 1 + 2 + 4]
    → Event Hubs / Kafka + Spark → serving SQL                  [Pillar 2 + 3]
    → AKS + Helm (capstone)                                     [Pillar 5]
```

Python owns the agent and data transforms. Go owns workers that must take load. The agent calls tools; tools must not be an unbounded shell. Pipelines **feed** context; they are not the agent.

**Pillar 1 deep dive:** [Systems integration architect](systems-integration-architect.md)

---

## The five pillars

### Pillar 1 — System shape (highest leverage)

Where HTTP ends and durable work begins; who owns the agent vs the tool vs the worker. Default: **modular monolith first** (one agent process) and split tools to Go when Phase 5 evidence demands it.

**Deep docs:** [systems-integration-architect.md](systems-integration-architect.md) · [agentic-orchestration.md](agentic-orchestration.md)

**Example ADR prompts:** Deep Agents vs custom LangGraph; why a tool leaves the agent process.

**Primary phases:** 1, 5, 7

---

### Pillar 2 — Integration and messaging

Delivery semantics, MCP as a tool protocol, Service Bus / Event Hubs, idempotency, DLQ.

| Broker choice | Pros | Cons |
|---------------|------|------|
| **Redis** | Fast local iteration | Weaker durability vs Kafka |
| **Service Bus** | Azure-native queue + DLQ | Cloud cost |
| **Event Hubs / Kafka** | Durable event log | Heavier ops |

**Deep docs:** [messaging-and-rpc.md](messaging-and-rpc.md) · [software-engineering.md § Integration](software-engineering.md#integration-sync-async-and-messaging)

**Primary phases:** 5, 6

---

### Pillar 3 — Data architecture

Checkpoints and agent filesystem; serving SQL; pipeline sinks; indexes for the queries the agent actually runs.

**Deep docs:** [database-design.md](database-design.md)

**Primary phases:** 6 (and Phase 1 stores)

---

### Pillar 4 — Performance and language boundaries

Measure first. Python for orchestration and data; Go for throughput. No rewrite without a profile or a timeout budget.

**Deep docs:** [memory-and-performance.md](memory-and-performance.md) · [concurrency-runtime-model.md](concurrency-runtime-model.md)

**Primary phases:** 5

---

### Pillar 5 — Reliability, security, operations

Evals, identity, Key Vault, healthchecks, Terraform state, Helm rollback, failure modes.

Every lab documents **three failure modes**. Gate with [production-readiness.md](../../checklists/production-readiness.md).

**Deep docs:** [production-readiness.md](../../checklists/production-readiness.md) · [azure-cloud-and-ai.md](azure-cloud-and-ai.md) · [azure-certification-track.md](../career/azure-certification-track.md)

**Primary phases:** 2, 3, 4, 7

---

## Phase ↔ pillar matrix {#phase--pillar-matrix}

● = primary practice · ○ = secondary / touched

| Phase / lab | Lab | P1 Shape | P2 Integration | P3 Data | P4 Performance | P5 Reliability |
|-------------|-----|:--------:|:--------------:|:-------:|:--------------:|:--------------:|
| 1 | Agentic orchestration | ● | ○ | ○ | | ● |
| 2 | Containerize agent | ○ | | | | ● |
| 3 | Azure Terraform | ● | | | | ● |
| 4 | Azure admin | | | | | ● |
| 5 | Azure backends | ● | ● | | ● | ● |
| 08 | Ops CLI | | ● | | | ● |
| 09 | Edge proxy | ● | | | ● | ● |
| 10 | Rate limiter | | ○ | | ● | ● |
| 11 | Notification fan-out | ● | ● | | | ● |
| 12 | Search / autocomplete | | | ● | ● | ○ |
| 6 | Data pipelines | ○ | ● | ● | | ○ |
| 13 | K8s controller-lite | ● | ● | | | ● |
| 7 | AKS capstone | ● | ○ | ○ | ○ | ● |

**Minimum credible bar:** at least one **shipped** lab with ● in **each pillar** you claim — typically domains **1 + 2 + 3 + 5** plus labs **08 + 09**. Full differentiation: labs **10–13** plus domains **4 + 6 + 7**.

See [target-alignment.md](../career/target-alignment.md).

---

## Portfolio proof

Each lab repo accumulates `docs/portfolio/` tagged to pillars — [portfolio-artifacts.md](../templates/portfolio-artifacts.md):

| Artifact | Typical pillar(s) |
|----------|-------------------|
| Architecture diagram | 1 |
| ADR | Tag `**Pillar:** N` |
| Performance numbers | 4 |
| Failure modes | 5 |
| Observability evidence | 5 |

Log milestones in [PROGRESS.md](../../PROGRESS.md) with **Pillar(s)**, **Tradeoff**, and **Failure mode**.

---

## Interview appendix (not a sixth pillar)

[System design interview map](../career/system-design-interview-map.md) · [Big Tech benchmark](../career/big-tech-benchmark.md)

---

**Next:** [Phase 1 — Agentic orchestration](../../career-project-specs/01-agentic-orchestration.md)

---

## Technical reference

### Pillar one-liners

| # | Pillar | One-line focus |
|---|--------|----------------|
| 1 | System shape | Boundaries, sync vs async, who owns what |
| 2 | Integration & messaging | Delivery semantics, brokers, MCP, idempotency, DLQ |
| 3 | Data architecture | Schema, pipelines, serving tables, checkpoints |
| 4 | Performance and language boundaries | Measure first; Python AI, Go throughput |
| 5 | Reliability, security, operations | Observability, identity, deploy |

### Learning docs by pillar

| Pillar | Primary concept docs |
|--------|---------------------|
| 1 | [Systems integration architect](systems-integration-architect.md) · [Agentic orchestration](agentic-orchestration.md) |
| 2 | [Messaging and RPC](messaging-and-rpc.md) |
| 3 | [Database design](database-design.md) |
| 4 | [Memory and performance](memory-and-performance.md) · [Concurrency runtime model](concurrency-runtime-model.md) |
| 5 | [Software engineering handbook](software-engineering.md) · [Azure cloud and AI](azure-cloud-and-ai.md) |
