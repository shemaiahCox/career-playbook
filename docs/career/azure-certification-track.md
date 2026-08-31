# Azure certification track — in-path (AZ-104 + CKA)

**Use this:** Certifications sit **on the 7-phase path**, not beside it. AZ-104 is Phase 4. CKA is Phase 7.

**Reading order:**

1. [Architecture framework](../concepts/architecture-framework.md)
2. Optional **AZ-900** vocabulary before Phase 3 — [Azure cloud and AI](../concepts/azure-cloud-and-ai.md)
3. [Phase 3 Terraform](../../career-project-specs/03-azure-terraform-stack.md) → [Phase 4 AZ-104](../../career-project-specs/04-azure-admin-governance.md)
4. [Phase 7 CKA](../../career-project-specs/07-aks-orchestration.md)

**Companion:** [Course track](course-track.md) · [Target alignment](target-alignment.md) · [PROGRESS.md](../../PROGRESS.md)

---

## What sits on the critical path

| Credential | Phase | Role |
|------------|-------|------|
| AZ-900 (optional) | Before 3 | Labels: RG, RBAC, IaaS/PaaS |
| **AZ-104** | **4** | Required course — admin, identity, network, storage, governance on *your* Terraform stack |
| **CKA** | **7** | Required course — schedule, observe, and secure the same workloads on AKS |

Azure OpenAI (or any LLM provider) is an **implementation choice** in Phase 1/5, not a separate organizing course.

---

## Timing

| When | Credential | Outcome |
|------|------------|---------|
| Before or during Phase 3 | Optional AZ-900 | You can name SKUs and RBAC in Terraform ADRs |
| Phase 4 | AZ-104 (KodeKloud + Microsoft Learn) | Least privilege, Key Vault, NSG, Storage on the lab RG |
| Phase 7 | CKA (KodeKloud) | Helm, probes, policies on AKS |

Do not pause Phase 1 to collect AZ-900. Learn Azure names when you provision (Phase 3).

---

## Service → phase (pattern translation)

| Azure service | Playbook pattern | Phase |
|---------------|------------------|-------|
| Azure OpenAI | LLM behind the Deep Agent | 1 |
| App Service / Container Apps | Run the Phase 2 image | 3 |
| VNet + NSG | Network boundary | 3, 4 |
| Entra ID + RBAC | Human and deploy identity | 4 |
| Key Vault + managed identity | Secrets at runtime | 4, 5, 7 |
| Storage Account | State, blobs, agent files | 4, 6 |
| Service Bus + DLQ | At-least-once + poison | 5 |
| Azure Functions | Bursty Python tool adapter | 5 |
| Azure Managed Redis | Cache, not source of truth | 5 |
| Event Hubs | Event log into pipelines | 6 |
| Azure Database for PostgreSQL | Serving SQL | 6 |
| AKS | Capstone runtime | 7 |
| Application Insights | Logs / traces | 5, 7 |

---

## Official links

- [AZ-900](https://learn.microsoft.com/en-us/credentials/certifications/azure-fundamentals/)
- [AZ-104](https://learn.microsoft.com/en-us/credentials/certifications/azure-administrator/)
- [CKA](https://www.cncf.io/training/certification/cka/)
- KodeKloud URLs: [course-track.md](course-track.md)

---

## Portfolio note

Add cert badges after you pass. One **ADR per Azure stretch**: Azure name → vendor-neutral pattern → tradeoff (cost, lock-in, cold start).
