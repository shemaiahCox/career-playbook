# Stacks glossary — plain language index

Jump to **Plain language** sections at the bottom of each ecosystem map. Each map follows a shared **top-to-bottom** flow—best for → how it runs → setup → layout → daily commands → playbook concepts ([template](../templates/language-ecosystem-map.md)). Core stack: **JavaScript/TypeScript (JS/TS), PHP, SQL, Go, Python, Rust, Bash**, plus **integration/automation** patterns.

| Term | One-line meaning | Deep dive |
|------|------------------|-----------|
| **Idempotency key** | Names one logical delivery; replays return same outcome | [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) |
| **DLQ** | Dead-letter queue for poison messages after N failures | [Project 6](../../career-project-specs/06-async-worker-stretch.md) |
| **BFF** | Backend-for-frontend; browser talks to your server, not model keys | [Project 11](../../career-project-specs/11-llm-web-app-lab.md) |
| **RAG** | Retrieval-augmented generation—docs injected into LLM prompt | [LLMs](../concepts/llms.md) |
| **OpenAPI** | Machine-readable HTTP contract checked into git | [Project 5](../../career-project-specs/05-contract-first-api.md) |
| **SSE** | Server-Sent Events—one-way HTTP push with reconnect | [Project 13](../../career-project-specs/13-realtime-dashboard-lab.md) |
| **WebSocket** | Full-duplex persistent connection for chat-scale bidirectional push | [Project 13](../../career-project-specs/13-realtime-dashboard-lab.md) |
| **OAuth / OIDC** | Delegated login; IdP issues tokens your API verifies | [Auth and tenancy](../concepts/software-engineering.md#auth-and-tenancy) · [Project 12](../../career-project-specs/12-multi-tenant-auth-lab.md) |
| **JWT** | Signed token carrying claims such as `sub` and `tenant_id` | [Glossary — JWT](../concepts/software-engineering-glossary.md#jwt-json-web-token) · [Project 12](../../career-project-specs/12-multi-tenant-auth-lab.md) |
| **tenant_id** | Row scope for multi-tenant SaaS isolation | [Project 12](../../career-project-specs/12-multi-tenant-auth-lab.md) |
| **RLS** | Postgres Row-Level Security—DB-enforced tenant row filters | [Glossary — RLS](../concepts/software-engineering-glossary.md#row-level-security-rls) |
| **CDC** | Change Data Capture—stream DB row changes to downstream consumers | [Database design — CDC](../concepts/database-design.md#change-data-capture) |
| **Reconcile loop** | Observe → diff → apply → requeue (K8s controllers) | [Project 17](../../career-project-specs/17-k8s-controller-lab.md) |
| **Goroutine** | Go runtime lightweight task—not one OS thread each | [Concurrency runtime model (Part 1)](../concepts/concurrency-runtime-model.md) |
| **Event loop** | Node's single thread scheduling I/O callbacks | [Part 1](../concepts/concurrency-runtime-model.md) · [Node at scale (Part 2)](../concepts/concurrency-deep-dives.md#node-event-loop-at-scale) |
| **Concurrency vs parallelism** | Many tasks in progress vs many executing at once on multiple cores | [Concurrency runtime model (Part 1)](../concepts/concurrency-runtime-model.md) |

| Map | Jump to definitions |
|-----|---------------------|
| [Bash / shell automation](bash.md#plain-language-terms-used-on-this-page) | bash.md |
| [PHP + Laravel](php-laravel.md#plain-language-terms-used-on-this-page) | php-laravel.md |
| [Node.js + TypeScript (HTTP / API)](node-typescript-backend.md#plain-language-terms-used-on-this-page) | node-typescript-backend.md |
| [Go](go.md#plain-language-terms-used-on-this-page) | go.md |
| [Python services](python.md#plain-language-terms-used-on-this-page) | python.md |
| [Rust](rust.md#plain-language-terms-used-on-this-page) | rust.md |
| [SQL / relational databases](sql.md#plain-language-terms-used-on-this-page) | sql.md |
| [Integration and automation](../concepts/integration-automation.md#plain-language-terms-used-on-this-page) | Boomi/n8n/workflow vocabulary |

**Doc index:** [README.md](../README.md#languages-new-to-a-stack)

**Handbook depth (study, not skim):**

- [Software engineering — Integration](../concepts/software-engineering.md#integration-sync-async-and-messaging)
- [Event-driven integration](../concepts/software-engineering.md#event-driven-integration)
- [Concurrency basics](../concepts/software-engineering.md#concurrency-basics)
- [Algorithms study path](../concepts/algorithms-study-path.md)
- [Database design — N+1 query pattern](../concepts/database-design.md#orms-and-the-n1-query-pattern)

Syntax across core languages (including **Rust**): [Language fundamentals comparison](language-fundamentals-comparison.md). **20-concept study map** (examples + links to depth): [Cross-stack study map](language-fundamentals-comparison.md#cross-stack-study-map). **Language gotchas deep dive** (Python · TS/JS · PHP): [Language gotchas deep dive](language-gotchas-deep-dive.md).
