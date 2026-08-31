# Career targeting — Backend & Systems Engineer (UK), Azure-first

**Use this:** Map the [README roadmap](../../README.md#roadmap) to UK **Backend & Systems** roles in the £70k–£100k band. Azure enterprise + agentic AI (Python + Go). Not a job board.

**Architecture spine:** [Architecture framework](../concepts/architecture-framework.md) — minimum credible = rows **1 + 2 + 3 + 5**.

**Language split:** **Python and Go are primary (80%).** TypeScript/Node is complementary (20%) — MCP SDK and thin APIs, not the hiring headline. PHP stays commercial background only.

**Companion:** [Portfolio artifacts](../templates/portfolio-artifacts.md) · [Course track](course-track.md) · [Azure certification track](azure-certification-track.md) · [Cloud portability](../concepts/cloud-portability.md) · [Big Tech benchmark](big-tech-benchmark.md) (optional ceiling)

---

## Verdict

The 7-phase spine (with Phase 5–7 slices in the same table) matches **Azure platform + AI systems** roles. Execution and **portfolio artifact quality** still matter more than adding extra phases.

Your target band is **not** HFT or blockchain core — those asks are out of scope.

---

## Project ideas → roadmap rows

Follow the [README table](../../README.md#roadmap). Highlights:

| Row | Signal | Spec | Status |
|-----|--------|------|--------|
| 1 | Production-shaped Deep Agent | [01](../../career-project-specs/01-agentic-orchestration.md) | Current focus |
| 2 | Containerized agent + CI | [02](../../career-project-specs/02-containerize-agent.md) | After 1 |
| 3 | Azure as code | [03](../../career-project-specs/03-azure-terraform-stack.md) | After 2 |
| 4 | Identity (AZ-104) | [04](../../career-project-specs/04-azure-admin-governance.md) | Differentiation |
| 5 | Go workers, queue, observability | [05](../../career-project-specs/05-azure-backends.md) | Minimum credible |
| 5.0–5.4 | Signed HTTP, proxy, limiter, fan-out, ops CLI | see README | After 5 |
| 6 | Pipelines | [06](../../career-project-specs/06-data-pipelines.md) | Differentiation |
| 6.1–6.2 | Search, RAG | [6.1](../../career-project-specs/06-1-search-autocomplete.md) · [6.2](../../career-project-specs/06-2-rag-retrieve.md) | Differentiation |
| 7.1–7 | Controller then AKS + CKA | [7.1](../../career-project-specs/07-1-k8s-controller.md) · [07](../../career-project-specs/07-aks-orchestration.md) | Capstone |

### GitHub / interview bar (every pinned repo)

Runnable demo, tests, `docs/portfolio/` (diagram, ADR, failure modes, observability), CI on PR. See [portfolio-artifacts.md](../templates/portfolio-artifacts.md).

---

## UK role categories you fit

| Category | Playbook fit | Notes |
|----------|--------------|-------|
| **Backend / platform (Python + Go) on Azure** | **Primary** | 1, 5–5.4, 3, 7 |
| **AI systems / agentic platforms** | **Primary** | Phase 1 + 6.2 |
| **Azure administrator / cloud engineer** | Strong after 4 | AZ-104 is in-path |
| **SRE-adjacent** | Partial | 2, 5.4, 5.1, 7.1, 7 |
| **TypeScript full-stack** | Secondary | Stretch MCP/API only |

---

## What employers ask vs playbook

| Employer ask | Playbook | Gap |
|--------------|----------|-----|
| Agentic / tool-using LLM systems | Strong — Phase 1 | Ship evals |
| RAG | Phase 6.2 | After pipelines |
| Python services | Strong — 1, 6 | — |
| Go microservices + queues | Strong — Phase 5 | — |
| Signed inbound HTTP | Phase 5.0 | — |
| Ops CLI / DLQ replay | Phase 5.4 | — |
| Edge / timeouts | Phase 5.1 | — |
| Rate limiting | Phase 5.2 | — |
| Pub/sub fan-out | Phase 5.3 | — |
| Search / autocomplete | Phase 6.1 | — |
| Docker + CI | Phase 2 | — |
| Terraform Azure | Phase 3 | — |
| Entra / RBAC / Key Vault | Phase 4 | Sit AZ-104 |
| Kafka / Event Hubs | Phase 6 | Zoomcamp + lab |
| Kubernetes / AKS | 7.1 then 7 | Sit CKA |
| TypeScript MCP / APIs | Stretch | Optional |
| AWS-first | [Cloud portability](../concepts/cloud-portability.md) | Names only |
| HFT / blockchain | Out of spine | Skip |

---

## £80k-ready milestones

### Minimum credible

Ship with full portfolio artifacts: rows **1 + 2 + 3 + 5**.

**Interview narrative:** *“Python Deep Agent with MCP tools, checkpoints, and evals; containerized with CI; provisioned on Azure with Terraform; Go workers on a queue with idempotency, DLQ, and follow-the-id logs.”*

### Full differentiation

Slices **5.0–5.4**, **6–6.2**, **4 (AZ-104)**, **7.1–7 (CKA / AKS)**.

---

## GitHub pin order

1. Agentic orchestration (Phase 1)
2. Azure Terraform (Phase 3)
3. Azure backends / Go workers (Phase 5)
4. Signed HTTP + edge proxy (5.0–5.1) when shipped
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
Now     → Phase 1
Then    → Phase 2 → Phase 3 → Phase 5 (then 5.0–5.4)
Parallel → Phase 4 (AZ-104) when Terraform exists
Later   → Phase 6 → 6.1 → 6.2 → 7.1 → Phase 7 (CKA)
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
