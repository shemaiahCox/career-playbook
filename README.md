# career-playbook

A linear path from a **local agent** to the same system running on Azure. You already know Go and Python. This playbook is how you **practice** backend and systems work — and how you **ship** it.

**Rule:** one active row at a time. Open the **course** that week; build the **practice spec** the same week.

**Primary stack (80%):** Python (agent, data) · Go (workers, proxies, CLIs)

**Secondary (20%):** TypeScript/Node — Model Context Protocol (MCP) SDK and thin APIs. Stretch only.

## How to read this playbook

The table below **is** the path. Each row: what you learn, what you install, which external course, which spec in this repo.

Focus cells use the same labels as every spec:

| Label | Means |
|-------|--------|
| **Shape** | Boundaries, sync vs async, who owns what |
| **Integration** | Queues, delivery, idempotency, dead-letter queue |
| **Data** | Schema, indexes, pipelines, retrieval |
| **Performance** | Concurrency, timeouts, p95 (the latency 95% of requests beat) |
| **Security** | Secrets, allowlists, identity |
| **Observability** | Logs, metrics, traces, health |

1. Read the [architecture framework](docs/concepts/architecture-framework.md) once (~15 min)
2. Start **Phase 1**
3. Log milestones in [PROGRESS.md](PROGRESS.md)
4. Finish a row’s success criteria before the next row

## Roadmap

Walk **top to bottom**. Phase 5.0–5.4 still use the Phase 5 courses (ByteByteGo and DesignGurus). Phase 6.1–6.2 still use Zoomcamp / LangChain retrieval docs. Phase 7.1 starts the CKA course; Phase 7 finishes it.

| Phase | Core domain | Focus and concepts | Stack | Course (outside this repo) | Practice spec (this repo) |
|-------|-------------|--------------------|-------|----------------------------|---------------------------|
| **1** | Agentic AI and orchestration | **Shape:** agent vs allowlisted tools. **Security:** no secrets in logs; hostile-input evals; token/cost cap per run. **Observability:** run id on every tool call. **MCP** (Model Context Protocol — a standard way to expose tools the agent is allowed to call). | Python, LangChain, LangGraph, FastMCP | [Deep Agents](https://docs.langchain.com/oss/python/deepagents/overview) · [LangGraph](https://docs.langchain.com/oss/python/langgraph/overview) · [LangChain](https://docs.langchain.com/oss/python/langchain/overview) · [FastMCP](https://gofastmcp.com/) | [01-agentic-orchestration.md](career-project-specs/01-agentic-orchestration.md) |
| **2** | Containerization | **Security:** secrets via environment, not image layers. **Observability:** healthcheck. **CI** (continuous integration — tests run on every pull request). | Docker, Compose | [KodeKloud Docker](https://learn.kodekloud.com/courses/docker-for-the-absolute-beginner) | [02-containerize-agent.md](career-project-specs/02-containerize-agent.md) |
| **3** | Azure infrastructure as code | **IaC** (infrastructure as code — files instead of clicking the portal). **VNet** (virtual network — your private Azure network). | Terraform `azurerm`, App Service or Container Apps | [KodeKloud Terraform](https://learn.kodekloud.com/courses/terraform-for-beginners) | [03-azure-terraform-stack.md](career-project-specs/03-azure-terraform-stack.md) |
| **4** | Azure admin and governance | **Security:** **Entra ID** (Azure’s login directory for people and apps). **RBAC** (role-based access control — which identity may change which resource). **Key Vault** (secret store, not git). Managed identity for the model provider when the agent leaves the laptop. | IAM, Key Vault, Storage | [KodeKloud AZ-104](https://learn.kodekloud.com/) · [AZ-104 on Microsoft Learn](https://learn.microsoft.com/en-us/credentials/certifications/azure-administrator/) | [04-azure-admin-governance.md](career-project-specs/04-azure-admin-governance.md) |
| **5** | System architecture and backends | **Integration:** queue, **DLQ** (dead-letter queue — failed messages parked so they stop blocking). **Idempotency** (retry does not double the side effect). **Performance:** bounded Go workers, p95. **Observability:** JSON logs, `request_id`, one metric. **Data:** Redis is cache, not the system of record. **OpenAPI** (a machine-readable HTTP contract) on the worker or on 5.0. | Go, Python, Service Bus or local stand-in, Redis | [ByteByteGo](https://bytebytego.com/) · [DesignGurus Modern API](https://www.designgurus.io/) | [05-azure-backends.md](career-project-specs/05-azure-backends.md) |
| **5.0** | Signed inbound HTTP | **Security:** **HMAC** (hash-based message authentication — prove the caller holds a shared secret). **Integration:** POST, enqueue, **202** (accepted for later processing). | Go or Python | *(same as 5)* | [05-0-signed-http.md](career-project-specs/05-0-signed-http.md) |
| **5.1** | Edge proxy | **Performance:** timeouts, connection pool, graceful shutdown. **Shape:** circuit breaker named in an ADR (architecture decision record). | Go | *(same as 5)* | [05-1-edge-proxy.md](career-project-specs/05-1-edge-proxy.md) |
| **5.2** | Rate limiting | **Performance:** token bucket or sliding window; HTTP **429** (too many requests). | Go, Redis | *(same as 5)* | [05-2-rate-limiter.md](career-project-specs/05-2-rate-limiter.md) |
| **5.3** | Notification fan-out | **Integration:** one event, many deliveries; retries; idempotent notification id. | Go, topics or Event Grid (or local) | *(same as 5)* | [05-3-notification-fanout.md](career-project-specs/05-3-notification-fanout.md) |
| **5.4** | Ops CLI | **Observability:** DLQ replay; flags; exit codes. | Go | *(same as 5)* | [05-4-ops-cli.md](career-project-specs/05-4-ops-cli.md) |
| **6** | Data pipelines | **Data:** events → transform → serving SQL. Migrations. Idempotent jobs. | SQL, Kafka / Event Hubs, Spark | [Data Engineering Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp) | [06-data-pipelines.md](career-project-specs/06-data-pipelines.md) |
| **6.1** | Search / autocomplete | **Data:** indexes, prefix suggest. **Performance:** p95. Lexical (keyword) match, not meaning. | Go, Postgres, Redis | *(same as 6)* | [06-1-search-autocomplete.md](career-project-specs/06-1-search-autocomplete.md) |
| **6.2** | RAG | **Data:** **RAG** (retrieval-augmented generation — retrieve relevant chunks, then generate an answer). Retrieve **tool** on the Phase 1 agent over Phase 6 data. Eval: grounded vs “I don’t know.” | Python agent + store | [LangChain retrieval](https://docs.langchain.com/oss/python/langchain/overview) *(agent stack from 1)* | [06-2-rag-retrieve.md](career-project-specs/06-2-rag-retrieve.md) |
| **7.1** | Kubernetes control loop | **Shape:** reconcile desired vs actual. Local **kind** (Kubernetes in Docker). | Go, kind | [KodeKloud CKA](https://learn.kodekloud.com/courses/certified-kubernetes-administrator-cka) *(start here)* | [07-1-k8s-controller.md](career-project-specs/07-1-k8s-controller.md) |
| **7** | Enterprise orchestration | **AKS** (Azure Kubernetes Service — Microsoft’s managed Kubernetes). Helm, CI/CD, Azure Monitor. | AKS, Helm | KodeKloud CKA | [07-aks-orchestration.md](career-project-specs/07-aks-orchestration.md) |

**Minimum credible (interview-ready):** rows **1 + 2 + 3 + 5**. Add **6.2** when you want the “how does the model get facts?” story. Full path: 5.0–5.4, 6–7.

**Still out of scope:** second-cloud deploys, PHP webhook product, Rust/WASM, IoT, a LeetCode phase (use the [DSA track](docs/career/dsa-interview-track.md) on weekends).

v1 22-step specs live in [`archive/v1-22-step/`](archive/v1-22-step/README.md) — loot for patterns, not the order.

## Start here

1. **[Architecture framework](docs/concepts/architecture-framework.md)** — five (now six labelled) ways to think
2. **[Phase 1](career-project-specs/01-agentic-orchestration.md)**
3. **[PROGRESS.md](PROGRESS.md)**
4. **[Course track](docs/career/course-track.md)** — same rows, course URLs only

## How to work through a row

1. Open the spec; read the story and **Before you start**
2. Start the course from the table
3. Build in [`career-projects/`](career-projects/) (folder prefix matches the spec file)
4. Meet success criteria; gate with [production readiness](checklists/production-readiness.md)
5. Commit [portfolio artifacts](docs/templates/portfolio-artifacts.md) in the lab repo
6. Log in PROGRESS → open **Next** in the spec

## Role direction

UK **Backend & Systems** (~£80k): agentic AI on **Azure**. PHP stays commercial background only.

**Reference:** [target alignment](docs/career/target-alignment.md) · [cloud portability](docs/concepts/cloud-portability.md) (AWS/GCP **names** only) · [Azure certification](docs/career/azure-certification-track.md) (AZ-104 = Phase 4, CKA = Phase 7.1–7)

Full index: [docs/README.md](docs/README.md)
