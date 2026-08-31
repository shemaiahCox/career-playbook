# Career targeting — Backend & Systems Engineer (UK), Azure-first

**Use this:** Map the [7-domain path plus competence labs 08–13](../../README.md#progression-phase-1--7) to UK **Backend & Systems** roles in the £70k–£100k band. Azure enterprise + agentic AI (Python + Go). Not a job board.

**Architecture spine:** [Architecture framework](../concepts/architecture-framework.md) — minimum credible = domains **1 + 2 + 3 + 5** plus labs **08 + 09**.

**Language split:** **Python and Go are primary (80%).** TypeScript/Node is complementary (20%) — MCP SDK and thin APIs, not the hiring headline. PHP stays commercial background only.

**Companion:** [Portfolio artifacts](../templates/portfolio-artifacts.md) · [Course track](course-track.md) · [Azure certification track](azure-certification-track.md) · [Cloud portability](../concepts/cloud-portability.md) · [Big Tech benchmark](big-tech-benchmark.md) (optional ceiling)

---

## Verdict

The 7-phase spine matches **Azure platform + AI systems** roles better than a generic AWS/fintech Go-only story. Execution and **portfolio artifact quality** still matter more than adding extra phases.

Your target band is **not** HFT or blockchain core — those asks are out of scope.

---

## Project ideas → phases

| # | Signal | Phase spec | Status |
|---|--------|------------|--------|
| 1 | Production-shaped **Deep Agent** (tools, checkpoints, evals) | [Phase 1](../../career-project-specs/01-agentic-orchestration.md) | Current focus |
| 2 | Containerized agent | [Phase 2](../../career-project-specs/02-containerize-agent.md) | After 1 |
| 3 | Azure **as code** (Terraform) | [Phase 3](../../career-project-specs/03-azure-terraform-stack.md) | After 2 |
| 4 | Identity and governance (AZ-104) | [Phase 4](../../career-project-specs/04-azure-admin-governance.md) | Differentiation |
| 5 | Go workers + Service Bus + Redis | [Phase 5](../../career-project-specs/05-azure-backends.md) | Minimum credible |
| 08 | Ops CLI + DLQ replay | [Lab 08](../../career-project-specs/08-ops-cli.md) | Minimum credible |
| 09 | Edge proxy (timeouts, drain) | [Lab 09](../../career-project-specs/09-edge-proxy.md) | Minimum credible |
| 10 | Rate limiter (Redis) | [Lab 10](../../career-project-specs/10-rate-limiter.md) | Differentiation |
| 11 | Notification fan-out | [Lab 11](../../career-project-specs/11-notification-fanout.md) | Differentiation |
| 12 | Search / autocomplete | [Lab 12](../../career-project-specs/12-search-autocomplete.md) | Differentiation |
| 6 | Pipelines into agent context | [Phase 6](../../career-project-specs/06-data-pipelines.md) | Differentiation |
| 13 | K8s controller-lite | [Lab 13](../../career-project-specs/13-k8s-controller.md) | Differentiation |
| 7 | AKS + Helm + CKA | [Phase 7](../../career-project-specs/07-aks-orchestration.md) | Capstone |

### GitHub / interview bar (every pinned repo)

Runnable demo, tests, `docs/portfolio/` (diagram, ADR, failure modes, observability), CI on PR. See [portfolio-artifacts.md](../templates/portfolio-artifacts.md).

---

## UK role categories you fit

| Category | Playbook fit | Notes |
|----------|--------------|-------|
| **Backend / platform (Python + Go) on Azure** | **Primary** | Domains 1, 5, 3, 7 + labs 08–13 |
| **AI systems / agentic platforms** | **Primary** | Phase 1 + 6 |
| **Azure administrator / cloud engineer** | Strong after 4 | AZ-104 is in-path |
| **SRE-adjacent** | Partial | Phases 2, 5, 7 + labs 08, 09, 13 |
| **TypeScript full-stack** | Secondary | Stretch MCP/API only |

---

## What employers ask vs playbook

| Employer ask | Playbook | Gap |
|--------------|----------|-----|
| Agentic / tool-using LLM systems | Strong — Phase 1 | Ship evals |
| Python services | Strong — 1, 6 | — |
| Go microservices + queues | Strong — Phase 5 | — |
| Ops CLI / DLQ replay | Strong — [lab 08](../../career-project-specs/08-ops-cli.md) | — |
| Edge / timeouts / LB vocabulary | Strong — [lab 09](../../career-project-specs/09-edge-proxy.md) | — |
| Rate limiting | Strong — [lab 10](../../career-project-specs/10-rate-limiter.md) | — |
| Pub/sub fan-out | Strong — [lab 11](../../career-project-specs/11-notification-fanout.md) | — |
| Search / autocomplete | Strong — [lab 12](../../career-project-specs/12-search-autocomplete.md) | — |
| Docker | Strong — Phase 2 | — |
| Terraform Azure | Strong — Phase 3 | — |
| Entra / RBAC / Key Vault | Strong — Phase 4 | Sit AZ-104 |
| Kafka / Event Hubs | Phase 6 | Zoomcamp + lab |
| Kubernetes reconcile / AKS | Lab 13 then Phase 7 | Sit CKA |
| TypeScript MCP / APIs | Stretch | Optional |
| AWS-first / Monzo Kafka+Cassandra | Pattern transfer — [cloud portability](../concepts/cloud-portability.md) | Narrate “same semantics”; do not deploy AWS |
| HFT / blockchain core | Out of spine | Skip |

---

## £80k-ready milestones

### Minimum credible

Ship with full portfolio artifacts:

| Pillar | Minimum phase |
|--------|----------------|
| 1 System shape | Phase 1 |
| 2 Integration & messaging | Phase 5 |
| 3 Data architecture | Phase 6 *or* Phase 1 checkpoint/store + a serving query |
| 4 Performance & language | Phase 5 (Go vs Python ADR) |
| 5 Reliability, security, ops | Phases 2 + 3 |

Practical list: **1 + 2 + 3 + 5 + 08 + 09** (operate the queue and edge-protect the worker).

**Interview narrative:** *“Python Deep Agent with MCP tools and checkpoints; containerized; provisioned on Azure with Terraform; Go workers on Service Bus with idempotency and DLQ; ops CLI for replay; proxy with timeouts.”*

### Full differentiation

Add labs **10–13** (rate limit, fan-out, search, controller) plus domains **4 (AZ-104)**, **6 (pipelines)**, **7 (AKS + CKA)**.

---

## GitHub pin order

1. Agentic orchestration (Phase 1)
2. Azure Terraform (Phase 3)
3. Azure backends / Go workers (Phase 5)
4. Ops CLI + edge proxy (labs 08–09) when shipped
5. AKS charts (Phase 7) when shipped

---

## Interview themes

| Theme | Where you prove it |
|-------|-------------------|
| Harness vs graph | Phase 1 ADR |
| Tool allowlists / MCP | Phase 1 |
| Idempotency + DLQ | Phase 5 |
| IaC vs portal | Phase 3 |
| Least privilege | Phase 4 |
| Agent context from pipelines | Phase 6 |
| Helm rollback | Phase 7 |

---

## Suggested priority

```
Now     → Phase 1 (Deep Agent + LangGraph + FastMCP)
Then    → Phase 2 → Phase 3 → Phase 5
Parallel → Phase 4 (AZ-104) when Terraform exists
Later   → Phase 6 → Phase 7 (CKA)
Stretch → TypeScript MCP SDK
```

---

## LinkedIn ↔ playbook

- **Headline** — Backend & Systems Engineer · Python/Go · Azure · agentic AI
- **Featured** — Phase 1, 3, 5, then 7
- **About** — tie AI claims to Phase 1 evals and Phase 5 workers when shipped

---

## See also

- [Course track](course-track.md)
- [Azure certification track](azure-certification-track.md)
- [Big Tech benchmark](big-tech-benchmark.md)
- [DSA interview track](dsa-interview-track.md)
- [System design interview map](system-design-interview-map.md)
- Archived v1 22-step path: [archive/v1-22-step](../../archive/v1-22-step/README.md)
