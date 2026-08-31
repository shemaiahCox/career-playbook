# Cloud portability — Azure is the learning ground

**Use this:** When an ADR names an Azure SKU and you need the **same pattern** on AWS or GCP — not to deploy a second cloud.

**Reading order:**

1. [Architecture framework](architecture-framework.md) — vendor-neutral pillars
2. **You are here** — pattern → Azure (what you build) → AWS → GCP
3. Ship on Azure: [Phase 3+](../../career-project-specs/03-azure-terraform-stack.md) and competence labs 08–13

**Companion:** [Azure cloud and AI](azure-cloud-and-ai.md) · [Azure certification track](../career/azure-certification-track.md)

You learn **one** cloud in depth (Azure — what work uses). Competence means you can say: *“Service Bus is at-least-once + DLQ; on AWS that is SQS; on GCP that is Pub/Sub.”* Do **not** stand up AWS or GCP for playbook labs.

Every Azure ADR from Phase 3 onward includes **one sentence** naming the AWS and GCP analogue. Same rule on labs 08–13.

---

## Pattern map

| Pattern | Azure (you build this) | AWS analogue | GCP analogue |
|---------|------------------------|--------------|--------------|
| Identity / RBAC | Entra ID + Azure RBAC | IAM users/roles/policies | Cloud IAM |
| Secrets | Key Vault + managed identity | Secrets Manager + IAM role | Secret Manager + service account |
| Object storage | Storage Account (blobs) | S3 | Cloud Storage (GCS) |
| Queue + DLQ | Service Bus (queue + dead-letter) | SQS + DLQ | Pub/Sub + dead-letter topic |
| Pub/sub fan-out | Service Bus topics or Event Grid | SNS + SQS | Pub/Sub |
| Event log | Event Hubs | Kinesis Data Streams | Pub/Sub (or Dataflow source) |
| Long-lived containers | App Service / Container Apps | ECS/Fargate or Cloud Run-like | Cloud Run |
| Kubernetes | AKS | EKS | GKE |
| Edge / ingress | App Gateway / Front Door / ingress | ALB/NLB + CloudFront | HTTPS LB + Cloud CDN |
| Rate limit / API edge | App Gateway WAF, APIM, or **your Go limiter** | API Gateway usage plans, WAF | Cloud Armor / API Gateway quotas |
| Cache | Azure Managed Redis | ElastiCache | Memorystore |
| Observability | Application Insights / Monitor | CloudWatch + X-Ray | Cloud Monitoring + Trace |
| IaC | Terraform `azurerm` | Terraform `aws` | Terraform `google` |

Kubernetes **API** (pods, Deployments, Services, reconcile) is the same on AKS, EKS, and GKE. CKA and [lab 13](../../career-project-specs/13-k8s-controller.md) are already portable.

---

## Interview one-liners

- “I implemented at-least-once + idempotent handlers on Service Bus; the semantics do not change on SQS.”
- “Key Vault + managed identity is secrets-at-runtime; Secrets Manager + task role is the same shape.”
- “I wrote a reverse proxy with timeouts and graceful shutdown — App Gateway or ALB is that pattern managed.”
- “Terraform state and plan/apply are the skill; the provider block is what changes.”

---

## Technical reference

- Specs that must cite this map: Phases [3](../../career-project-specs/03-azure-terraform-stack.md)–[7](../../career-project-specs/07-aks-orchestration.md), labs [08](../../career-project-specs/08-ops-cli.md)–[13](../../career-project-specs/13-k8s-controller.md)
- Handbook: [Azure-shaped backends](software-engineering.md#azure-shaped-backends) · [Infrastructure as Code](software-engineering.md#infrastructure-as-code)
