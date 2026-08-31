# Stacks glossary — plain language index

Jump to **Plain language** sections at the bottom of each ecosystem map. Each map follows a shared **top-to-bottom** flow ([template](../templates/language-ecosystem-map.md)).

**Primary stack:** Python · Go · SQL · Bash. **Secondary:** TypeScript/Node (MCP SDK, thin APIs). PHP and Rust maps stay as commercial / optional background.

The learning order is the [7-phase path](../../README.md#progression-phase-1--7), not the archived 22-step labs.

| Term | One-line meaning | Deep dive |
|------|------------------|-----------|
| **Deep Agents** | LangChain harness: plan, subagents, filesystem | [agentic-orchestration.md](../concepts/agentic-orchestration.md) · [Phase 1](../../career-project-specs/01-agentic-orchestration.md) |
| **LangGraph** | Graph runtime + checkpoints | [Glossary](../concepts/software-engineering-glossary.md#langgraph) |
| **LangChain** | Models, tools, MCP adapters | [Glossary](../concepts/software-engineering-glossary.md#langchain) |
| **MCP / FastMCP** | Protocol / Python server for allowlisted tools | [Phase 1](../../career-project-specs/01-agentic-orchestration.md) |
| **Idempotency key** | Names one logical delivery; replays return same outcome | [Phase 5](../../career-project-specs/05-azure-backends.md) |
| **DLQ** | Dead-letter queue after N failures | [Phase 5](../../career-project-specs/05-azure-backends.md) |
| **Terraform / azurerm** | Azure as code | [Phase 3](../../career-project-specs/03-azure-terraform-stack.md) |
| **Entra ID** | Azure identity (humans and many workloads) | [Phase 4](../../career-project-specs/04-azure-admin-governance.md) |
| **Helm** | Kubernetes package + values | [Phase 7](../../career-project-specs/07-aks-orchestration.md) |
| **Event Hubs** | Azure event log | [Phase 6](../../career-project-specs/06-data-pipelines.md) |
| **Spark** | Distributed transform jobs (Python) | [Phase 6](../../career-project-specs/06-data-pipelines.md) |
| **RAG** | Retrieval-augmented generation | [LLMs](../concepts/llms.md) |
| **Goroutine** | Go runtime lightweight task | [Concurrency runtime model](../concepts/concurrency-runtime-model.md) |
| **CDC** | Stream DB row changes | [Database design — CDC](../concepts/database-design.md#change-data-capture) |

| Map | Role |
|-----|------|
| [Python services](python.md#plain-language-terms-used-on-this-page) | **Primary** — agents, MCP, data |
| [Go](go.md#plain-language-terms-used-on-this-page) | **Primary** — workers, Azure backends |
| [SQL / relational databases](sql.md#plain-language-terms-used-on-this-page) | **Primary** — serving layer |
| [Bash / shell automation](bash.md#plain-language-terms-used-on-this-page) | Ops glue |
| [Node.js + TypeScript](node-typescript-backend.md#plain-language-terms-used-on-this-page) | **Secondary** — MCP SDK, thin APIs |
| [PHP + Laravel](php-laravel.md#plain-language-terms-used-on-this-page) | Commercial background |
| [Rust](rust.md#plain-language-terms-used-on-this-page) | Optional / archived path |

**Doc index:** [docs/README.md](../README.md)

**Handbook:** [Software engineering](../concepts/software-engineering.md) · [Agentic orchestration](../concepts/agentic-orchestration.md)
