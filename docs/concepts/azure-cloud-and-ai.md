# Azure cloud and AI

**Use this:** When Azure names (subscription, VNet, Entra, Service Bus, AKS) show up before you have mapped them to playbook patterns.

**Reading order:**

1. [Architecture framework](architecture-framework.md)
2. **You are here**
3. [Azure certification track](../career/azure-certification-track.md) — AZ-104 = Phase 4, CKA = Phase 7
4. [Cloud portability](cloud-portability.md) — AWS/GCP names only
5. Provision in [Phase 3](../../career-project-specs/03-azure-terraform-stack.md); competence labs [08–13](../../career-project-specs/08-ops-cli.md) stay on Azure

**Companion:** [Glossary — Azure index](software-engineering-glossary.md#azure-index) · [Cloud portability](cloud-portability.md) · [Messaging and RPC](messaging-and-rpc.md) · [LLMs](llms.md)

Microsoft Azure is one cloud vendor. The playbook teaches **patterns** (idempotency, queues, agent evals, IaC); Azure gives those patterns **managed names**.

You do not need Azure on day one of [Phase 1](../../career-project-specs/01-agentic-orchestration.md). You need this doc when you start Terraform (Phase 3).

---

## Subscription and resource hierarchy

```text
Tenant (Entra ID)
  └── Subscription (billing)
        └── Resource group (lifecycle / destroy bucket)
              └── Resources (App Service, Key Vault, Service Bus, …)
```

- **Subscription** — costs and quotas.
- **Resource group** — delete the group → delete the lab.
- **Region** — pick one (e.g. UK South). **Availability zones** are isolated datacenters inside a region.

**Governance:** **Azure RBAC** is who can do what. **Azure Policy** is “only deploy to UK South.” **Entra ID** is the identity plane (humans and many workload identities).

---

## Compute

| What you are running | Azure option | Phase |
|----------------------|--------------|-------|
| Phase 2 image, long-lived | **App Service** or **Container Apps** | 3 |
| Bursty tool adapter | **Azure Functions** (Python primary; TypeScript stretch) | 5 |
| Always-on Go worker | Container Apps, App Service, or AKS deploy | 5, 7 |
| Full cluster | **AKS** | 7 |
| Raw VMs you patch | **Virtual Machines** | AZ-104 vocab; rare on this path |

**Scale-to-zero:** Functions and Container Apps can stop when idle (cold start). Queue workers often keep **min replicas ≥ 1**.

---

## Data and AI

| Need | Azure service | Phase |
|------|---------------|-------|
| Serving SQL | **Azure Database for PostgreSQL** | 6 |
| Cache | **Azure Managed Redis** | 5 |
| Agent / blob files | **Storage Account** | 4, 6 |
| Hosted LLM | **Azure OpenAI** | 1 (provider choice) |

Keep Phase 1 evals and tool contracts stable when you swap the model endpoint.

---

## Messaging

| Azure service | Pattern | Phase |
|---------------|---------|-------|
| **Service Bus** (queue + dead-letter) | At-least-once; idempotent Go handler | 5 |
| **Event Hubs** | Event log into Spark/Pandas | 6 |
| **Event Grid** | “Something happened” notifications | optional |

Same playbook skills as Redis/Kafka: duplicates, DLQ, watermarks.

---

## Secrets and identity

- **Key Vault** — secrets at runtime.
- **Managed identity** — the app identity that is allowed to read the vault. No passwords in git.
- **Entra ID + RBAC** — humans and deploy pipelines get least privilege on the RG ([Phase 4](../../career-project-specs/04-azure-admin-governance.md)).

---

## Networking

**VNet** + subnets + **NSG** rules are Phase 3/4. AKS adds Kubernetes **network policies** in Phase 7.

---

## Observability

**Application Insights** / **Azure Monitor** collect logs, metrics, traces. Keep a `request_id` (or W3C trace) you already emit from the agent and Go workers.

---

## Where to practice

| Goal | Phase |
|------|-------|
| Agent + optional Azure OpenAI | 1 |
| Image | 2 |
| Terraform RG, VNet, compute | 3 |
| Entra, RBAC, Key Vault, Storage, NSG | 4 |
| Functions, Service Bus, Redis, Go workers | 5 |
| Event Hubs + SQL | 6 |
| AKS + Helm | 7 |

**Read next:** [Azure certification track](../career/azure-certification-track.md) · [Cloud portability](cloud-portability.md) (AWS/GCP names only)

---

## Technical reference

### AZ-900 (optional vocab)

| Area | Covers |
|------|--------|
| Cloud concepts | IaaS/PaaS/SaaS, CapEx vs OpEx |
| Services | Compute, networking, storage, VNet |
| Governance | RBAC, Policy, cost, ARM |

### AZ-104 / CKA (in-path)

See [azure-certification-track.md](../career/azure-certification-track.md) and [course-track.md](../career/course-track.md).

### Azure CLI

```bash
az login
az group create --name rg-playbook-lab --location uksouth
```

Prefer Terraform for anything you will destroy and recreate ([Phase 3](../../career-project-specs/03-azure-terraform-stack.md)).

### Interview one-liners

- “Service Bus is at-least-once with a dead-letter queue—the Go handler is idempotent.”
- “The Deep Agent contract stayed put; Azure OpenAI is just the model provider.”
- “Secrets live in Key Vault; the workload uses managed identity.”
- “Terraform state is remote; destroy is how the lab dies.”

**Read next:** [Azure certification track](../career/azure-certification-track.md) · [Cloud portability](cloud-portability.md) (AWS/GCP names only)
