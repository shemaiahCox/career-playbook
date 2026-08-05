# Azure cloud and AI (playbook overlay)

**Use this:** When **AZ-900** or **AI-200T00** vocabulary (subscription, Container Apps, Service Bus, Key Vault) appears before you know how it maps to playbook patterns—before [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) deploy work.

**Reading order:**

1. [Architecture framework](architecture-framework.md) — vendor-neutral pillars first
2. **You are here** — Azure names ↔ patterns you already learn
3. [Azure certification track](../career/azure-certification-track.md) — which project this week
4. Ship Azure stretches on [Project 2](../../career-project-specs/02-rag-llm-service.md) → [16](../../career-project-specs/16-cloud-deploy-lab.md)

**Companion:** [Glossary — Azure index](software-engineering-glossary.md#azure-index) · [Messaging and RPC](messaging-and-rpc.md) · [Database design — vectors](database-design.md#vector-databases-and-embeddings) · [LLMs](llms.md)

Microsoft Azure is one cloud vendor. The playbook teaches **patterns** (idempotency, queues, RAG evals, deploy hygiene); Azure gives you **managed names** for those patterns in interviews and on cert exams.

---

## Why this matters

Cert exams ask you to **label** services: “Where do secrets live?” “Which compute fits a background worker?” Projects ask you to **implement** the behavior: duplicate-safe handlers, health checks, eval regression.

You do not need Azure on day one of [Project 1](../../career-project-specs/01-integration-webhook-receiver.md). You **do** need a bridge doc when you study [AZ-900](https://learn.microsoft.com/en-us/credentials/certifications/azure-fundamentals/) early and deploy on Azure during [AI-200T00](https://learn.microsoft.com/en-us/training/courses/ai-200t00) later.

---

## Subscription and resource hierarchy

Think of Azure as nested boxes:

```text
Tenant (your org)
  └── Subscription (billing boundary)
        └── Resource group (lifecycle bucket for one app/env)
              └── Resources (Postgres, Container App, Key Vault, …)
```

- **Subscription** — where costs and quotas roll up; one person often has a free-tier or Visual Studio subscription for labs.
- **Resource group** — delete the group → delete everything inside (good for lab cleanup).
- **Region** — physical datacenter area; pick one close to you for latency. **Availability zones** are isolated datacenters within a region for redundancy.

**Governance (AZ-900):** **Azure RBAC** assigns who can do what on resources. **Azure Policy** enforces rules (“only deploy to UK South”). You will write about both in [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) ADRs when secrets and deploy pipelines touch production-shaped Azure.

---

## Compute choices for playbook labs

| What you are running | Azure option | Playbook equivalent | Typical project |
|----------------------|--------------|---------------------|-----------------|
| Long-lived API or worker in a container | **Azure Container Apps** | `docker compose` service | [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) |
| Full Kubernetes control plane | **Azure Kubernetes Service (AKS)** | kind/minikube locally | [Project 17](../../career-project-specs/17-k8s-controller-lab.md) |
| One small HTTP handler, scale-to-zero | **Azure Functions** | Single route in FastAPI/Express | [Project 10](../../career-project-specs/10-automation-bot-lab.md) stretch |
| Raw VMs you patch yourself | **Azure Virtual Machines** | Rare in this playbook | AZ-900 vocabulary only |

**Container Apps vs AKS:** Container Apps is simpler—good first Azure deploy. AKS is when you need controllers, custom CRDs, or team-standard Kubernetes ([Project 17](../../career-project-specs/17-k8s-controller-lab.md)).

**Scale-to-zero:** Container Apps and Functions can stop when idle (cold start on next request). Workers with queues often keep **minimum replicas ≥ 1** so messages are not delayed.

---

## Data for AI workloads

| Need | Azure service | Playbook pattern | Project |
|------|---------------|------------------|---------|
| SQL + indexes + pgvector | **Azure Database for PostgreSQL** (Flexible Server) | Postgres + vector column | [Project 4](../../career-project-specs/04-sql-performance-lab.md) |
| Document/NoSQL at scale | **Azure Cosmos DB** | Optional alternative store | Capstone stretch only |
| Cache, pub/sub, vector search helper | **Azure Managed Redis** | Redis queue/cache | [Project 6](../../career-project-specs/06-async-worker-stretch.md), [8](../../career-project-specs/08-go-retrieval-worker-lab.md) |

Run the **same SQL exercises** from Project 4 against Azure Postgres—connection string changes; `EXPLAIN ANALYZE` lessons do not.

For RAG, **Azure OpenAI** (or Azure AI Foundry) is a managed LLM API—keep your [Project 2](../../career-project-specs/02-rag-llm-service.md) `POST /query` contract and eval JSONL; swap the provider endpoint and keys.

---

## Messaging and events

| Azure service | What it does | Playbook term |
|---------------|--------------|---------------|
| **Azure Service Bus** (queue + dead-letter) | Durable messages, at-least-once, poison queue | Same as Redis/SQS queue + DLQ in [Project 6](../../career-project-specs/06-async-worker-stretch.md) |
| **Azure Event Grid** | Push events when something happens (blob uploaded, subscription fired) | Webhook/event ingress—compare [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) |

**What you see:** duplicate deliveries, visibility timeout, dead-letter after max retries—the fixes are still **idempotency keys** and **DLQ replay**, not Azure-specific magic.

---

## Secrets and identity

- **Azure Key Vault** — store API keys, DB passwords, signing secrets; apps read at runtime via **managed identity** (no password in config files).
- **Managed identity** — Azure gives your Container App or Function an identity so Key Vault grants access without embedding credentials.

Playbook rule unchanged: **never commit secrets**—[Project 16](../../career-project-specs/16-cloud-deploy-lab.md) `.env.example` lists key names only; Key Vault holds values in Azure deploys.

---

## Observability

**Application Insights** collects logs, metrics, and request traces from your app. Map your existing **`request_id`** structured logs ([Project 3](../../career-project-specs/03-observability-lab.md)) to App Insights correlation—same story, different backend.

**Azure Monitor** is the umbrella (metrics, alerts, dashboards) across resources—not a replacement for defining SLOs and failure modes in portfolio ADRs.

---

## What it really means (quick table)

| Azure name | One line | Project |
|------------|----------|---------|
| Container Apps | Run containers without managing Kubernetes yourself | 16 |
| Service Bus | Managed queue with DLQ | 6, 8 |
| Event Grid | Route events to handlers | 1, 6 stretch |
| Azure Postgres + pgvector | Managed Postgres with vector extension | 4, 2 |
| Managed Redis | Managed Redis protocol | 6, 8 |
| Azure OpenAI | Hosted GPT/embeddings API | 2, 11 |
| Key Vault | Secret store | 16 |
| Application Insights | APM / tracing | 3 |

---

## Where to practice

| Goal | Project | Azure stretch section in spec |
|------|---------|-------------------------------|
| RAG on Azure OpenAI | [Project 2](../../career-project-specs/02-rag-llm-service.md) | Azure certification stretch |
| SQL + vectors on Azure Postgres | [Project 4](../../career-project-specs/04-sql-performance-lab.md) | Azure certification stretch |
| Queue on Service Bus | [Project 6](../../career-project-specs/06-async-worker-stretch.md) | Azure certification stretch |
| Worker + Redis on Azure | [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) | Azure certification stretch |
| Primary Azure deploy | [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) | Azure certification stretch |
| AKS optional | [Project 17](../../career-project-specs/17-k8s-controller-lab.md) | Azure certification stretch |
| BFF + streaming LLM | [Project 11](../../career-project-specs/11-llm-web-app-lab.md) | Azure certification stretch |

**Read next:** [Azure certification track](../career/azure-certification-track.md)

---

## Technical reference

### AZ-900 exam areas (one line each)

| Area | Covers |
|------|--------|
| Cloud concepts | IaaS/PaaS/SaaS, CapEx vs OpEx, elasticity |
| Azure architecture & services | Compute, networking, storage accounts, VNet |
| Management & governance | RBAC, Policy, cost management, ARM |

### AI-200 services index

| Service | Glossary |
|---------|----------|
| Container Apps | [Azure Container Apps](software-engineering-glossary.md#azure-container-apps) |
| AKS | [Azure Kubernetes Service](software-engineering-glossary.md#azure-kubernetes-service-aks) |
| Service Bus | [Azure Service Bus](software-engineering-glossary.md#azure-service-bus) |
| Event Grid | [Azure Event Grid](software-engineering-glossary.md#azure-event-grid) |
| Key Vault | [Azure Key Vault](software-engineering-glossary.md#azure-key-vault) |
| Azure Postgres | [Azure Database for PostgreSQL](software-engineering-glossary.md#azure-database-for-postgresql) |
| Managed Redis | [Azure Managed Redis](software-engineering-glossary.md#azure-managed-redis) |
| Azure OpenAI | [Azure OpenAI](software-engineering-glossary.md#azure-openai) |
| Application Insights | [Application Insights](software-engineering-glossary.md#application-insights) |

### Azure CLI (login + resource group)

```bash
az login
az group create --name rg-playbook-lab --location uksouth
az postgres flexible-server create --help   # read flags before create
az containerapp up --help
```

Prefer `--help` and [Microsoft Learn](https://learn.microsoft.com/en-us/training/courses/ai-200t00) module steps over memorizing flags.

### Official links

- [AZ-900 certification](https://learn.microsoft.com/en-us/credentials/certifications/azure-fundamentals/)
- [AZ-900 study guide](https://aka.ms/AZ900-StudyGuide)
- [AI-200T00 course](https://learn.microsoft.com/en-us/training/courses/ai-200t00)
- [Azure AI Cloud Developer Associate](https://learn.microsoft.com/en-us/credentials/certifications/azure-ai-cloud-developer-associate/)

### Interview one-liners

- “Service Bus gives me at-least-once with a dead-letter queue—the same semantics I proved with Redis in Project 6.”
- “I kept the RAG eval JSONL contract; Azure OpenAI is just the inference provider behind `POST /query`.”
- “Secrets live in Key Vault; the Container App uses managed identity—nothing sensitive in git.”
