# Azure certification track — overlay on the 22-step path

**Use this:** You are studying [Microsoft Certified: Azure Fundamentals (AZ-900)](https://learn.microsoft.com/en-us/credentials/certifications/azure-fundamentals/) and/or [Course AI-200T00-A: Develop AI cloud solutions on Azure](https://learn.microsoft.com/en-us/training/courses/ai-200t00)—and want to know **which playbook project to open this week** without leaving the linear spine.

**Reading order:**

1. [Architecture framework](../concepts/architecture-framework.md) — five pillars (vendor-neutral patterns first)
2. **AZ-900** study — [Azure cloud and AI](../concepts/azure-cloud-and-ai.md) + [glossary Azure entries](../concepts/software-engineering-glossary.md#azure-index)
3. Follow [README progression](../../README.md#progression-step-1--22) (Project 1 → 22)
4. **AI-200T00** modules — map to projects below as you reach each step
5. [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) — primary Azure deploy milestone

**Companion:** [Target alignment](target-alignment.md) · [Azure cloud and AI](../concepts/azure-cloud-and-ai.md) · [PROGRESS.md](../../PROGRESS.md)

This track is a **parallel overlay**. Success criteria for Steps 1–22 stay vendor-neutral (Compose, Postgres, Redis). Azure stretches are **portfolio and cert evidence**—log them in PROGRESS, not as blockers for the next step.

---

## Why overlay (not a new spine)

| Approach | Benefit |
|----------|---------|
| **Keep Compose-first labs** | Every project runs locally without cloud spend |
| **Azure on deploy stretches** | AI-200 hands-on maps to Projects 2, 4, 6, 8, 16 without reordering the path |
| **Certs + projects together** | Interview story: “Same idempotency/queue/RAG patterns—I deployed them on Container Apps + Service Bus” |

---

## Timing

| When | Certification / course | Playbook context | Outcome |
|------|------------------------|------------------|---------|
| **Early** (before or during Steps 1–5) | **AZ-900** | Webhooks, RAG, SQL—labs stay cloud-agnostic | Resource group, subscription, RBAC vocabulary for ADRs |
| **Mid** (Steps 2–8 green) | **AI-200** data + messaging modules | Projects 2, 4, 6, 8 | Azure Postgres + pgvector, Managed Redis, Service Bus mental model |
| **Late** (Steps 14–17) | **AI-200** compute + observability | Projects 14, 16, 17 | Container Apps, Key Vault, Application Insights |
| **Capstone** (Step 22) | Both creds in portfolio | Integrated platform | README + PROGRESS cite Azure deploy path and cert IDs |

Schedule **AZ-900 before Project 16** (~45-minute exam)—deploy ADRs use governance terms correctly. Spread **AI-200T00** (~5-day course) across Projects 2 → 16; do not treat it as a blocking detour before Project 1.

---

## AZ-900 ↔ playbook (vocabulary only)

| AZ-900 exam area | Playbook anchor |
|------------------|-----------------|
| Cloud concepts (IaaS/PaaS/SaaS, CapEx/OpEx) | [Architecture framework](../concepts/architecture-framework.md) Pillar 1 |
| Compute, networking, storage | [Servers and networking](../concepts/servers-and-networking.md); [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) |
| Management and governance (RBAC, Policy, cost) | [Project 16 ADR](../../career-project-specs/16-cloud-deploy-lab.md); [Azure cloud and AI](../concepts/azure-cloud-and-ai.md) |

**Microsoft Learn:** [AZ-900 certification](https://learn.microsoft.com/en-us/credentials/certifications/azure-fundamentals/) · [Study guide (PDF)](https://aka.ms/AZ900-StudyGuide) · [Practice assessment](https://learn.microsoft.com/en-us/credentials/certifications/azure-fundamentals/practice/assessment?assessment-type=practice&assessmentId=23)

---

## AI-200T00 ↔ projects (hands-on)

| AI-200 topic | Pillar | Project | Azure stretch in spec |
|--------------|--------|---------|------------------------|
| PostgreSQL + pgvector | 3 — Data | [Project 4](../../career-project-specs/04-sql-performance-lab.md) | Azure Database for PostgreSQL Flexible Server |
| AI solutions / Azure OpenAI | 1 + 3 | [Project 2](../../career-project-specs/02-rag-llm-service.md), [11](../../career-project-specs/11-llm-web-app-lab.md) | Azure OpenAI endpoint; eval JSONL unchanged |
| Managed Redis (cache/vector) | 3 + 4 | [Project 6](../../career-project-specs/06-async-worker-stretch.md), [8](../../career-project-specs/08-go-retrieval-worker-lab.md) | Azure Managed Redis vs local Redis ADR |
| Service Bus + Event Grid | 2 — Integration | [Project 6](../../career-project-specs/06-async-worker-stretch.md) | Queue + DLQ; compare to Redis visibility timeout |
| Container Apps | 5 — Ops | [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) | Primary Azure deploy target |
| Key Vault + managed identity | 5 — Ops | [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) | Secrets outside git |
| Application Insights | 5 — Ops | [Project 3](../../career-project-specs/03-observability-lab.md) | Correlation ID → App Insights |
| AKS deploy/monitor | 5 — Ops | [Project 17](../../career-project-specs/17-k8s-controller-lab.md) | Optional AKS vs local kind |
| Azure Functions | 1 — Shape | [Project 10](../../career-project-specs/10-automation-bot-lab.md) | Optional—one workflow step as Function |
| Cosmos DB | 3 — Data | [Project 5](../../career-project-specs/05-contract-first-api.md) or capstone | Optional—Postgres spine is enough |

**Microsoft Learn:** [AI-200T00 course](https://learn.microsoft.com/en-us/training/courses/ai-200t00) · Related cert: [Azure AI Cloud Developer Associate](https://learn.microsoft.com/en-us/credentials/certifications/azure-ai-cloud-developer-associate/)

### AI-200 Learn modules → project week (suggested)

| Learn module (AI-200 syllabus) | Open this project |
|--------------------------------|-------------------|
| Develop AI solutions with Azure Database for PostgreSQL | [Project 4](../../career-project-specs/04-sql-performance-lab.md) |
| Develop AI solutions with Azure Cosmos DB | Optional—[Project 5](../../career-project-specs/05-contract-first-api.md) or defer |
| Enhance AI solutions with Azure Managed Redis | [Project 6](../../career-project-specs/06-async-worker-stretch.md) or [8](../../career-project-specs/08-go-retrieval-worker-lab.md) |
| Integrate backend services for AI solutions | [Project 2](../../career-project-specs/02-rag-llm-service.md) + [8](../../career-project-specs/08-go-retrieval-worker-lab.md) |
| Implement container app hosting / deploy on Azure Container Apps | [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) |
| Deploy and monitor apps on AKS | [Project 17](../../career-project-specs/17-k8s-controller-lab.md) |
| Manage app secrets and configuration | [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) |
| Observe and troubleshoot apps | [Project 3](../../career-project-specs/03-observability-lab.md) on same repo as RAG |

---

## Pattern translation (for ADRs and interviews)

| Azure service | Playbook pattern | Where you already learn it |
|---------------|------------------|----------------------------|
| **Azure Service Bus** (queue + DLQ) | At-least-once + poison messages | [Project 6](../../career-project-specs/06-async-worker-stretch.md) |
| **Azure Event Grid** | Event notification into handlers | [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) webhook ingress |
| **Azure Database for PostgreSQL** + pgvector | Relational + vector retrieval | [Project 4](../../career-project-specs/04-sql-performance-lab.md) |
| **Azure Managed Redis** | Cache, pub/sub, optional vector index | [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) |
| **Azure OpenAI** | Managed LLM API | [Project 2](../../career-project-specs/02-rag-llm-service.md) |
| **Azure Key Vault** | Secrets at runtime, not in git | [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) |
| **Azure Container Apps** | Container deploy + scale rules | [Project 16](../../career-project-specs/16-cloud-deploy-lab.md) |
| **Application Insights** | Logs, metrics, distributed traces | [Project 3](../../career-project-specs/03-observability-lab.md) |

---

## PROGRESS.md — external certifications

Copy into [PROGRESS.md](../../PROGRESS.md) when you start the track:

```markdown
## External certifications — Azure

| Credential | Status | Exam / completion date | Notes |
|------------|--------|--------------------------|-------|
| AZ-900 Azure Fundamentals | Planned / Passed | | |
| AI-200T00 (course) | In progress / Done | | |
| Azure AI Cloud Developer Associate | Optional after AI-200 | | |

### Azure services used per project (stretch log)

| Project | Azure services deployed | ADR link |
|---------|---------------------------|----------|
| 2 RAG | e.g. Azure OpenAI, (optional) Azure Postgres | |
| 4 SQL | e.g. Azure Postgres Flexible + pgvector | |
| 6 Worker | e.g. Service Bus queue + DLQ | |
| 8 Go worker | e.g. Managed Redis | |
| 16 Deploy | e.g. Container Apps, Key Vault | |
| 17 K8s | e.g. AKS (optional) | |
```

---

## Portfolio note

- Add cert badges to LinkedIn / README **after pass**—link [Microsoft Learn credentials](https://learn.microsoft.com/en-us/credentials/).
- One **ADR per Azure stretch** naming: Azure choice → vendor-neutral pattern → tradeoff (cost, cold start, lock-in).
- Capstone [Project 22](../../career-project-specs/22-integrated-platform-capstone.md): optional footnote “Azure deploy path documented in Project 16 portfolio.”

---

## What this track does not change

- Linear order Project 1 → 22
- Compose-first local dev
- Required success criteria (Azure is stretch unless you choose Azure as your P16 cloud target voluntarily)
- No dedicated Project 26—existing labs + stretches cover AI-200 scope
