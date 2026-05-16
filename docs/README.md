# Documentation map

Material here supports both the **project ladder** ([README.md](../README.md)) and **“build A in stack B”** work—especially when B is unfamiliar and you are using AI for velocity.

## Choose your job

Pick the folder that matches what you need right now:

- **[playbook/](playbook/)** — **How do I test each lab (and use AI helpers responsibly)?** [Per-project testing (labs + AI)](playbook/per-project-testing.md) links layered testing and example prompts to every `project-specs/` file. Pair with [Testing](handbook/software-engineering.md#testing) in the handbook for pyramid and doubles.
- **[paths/](paths/)** — **Where am I going?** Ordered workflows and journeys: [learning journey (weeks + builds)](paths/learning-journey.md), [AI-assisted unfamiliar stack](paths/ai-assisted-unfamiliar-stack.md), [systems architect across languages](paths/systems-architect-across-languages.md). Start with the learning journey if you want a linear path.
- **[handbook/](handbook/)** — **What should I know deeply?** Long-form study notes: CLI, networking, databases, software engineering breadth ([software engineering](handbook/software-engineering.md), [database design](handbook/database-design.md), [algorithms and data structures](handbook/algorithms-and-data-structures.md), [command-line tooling](handbook/command-line-tooling.md), [servers and networking](handbook/servers-and-networking.md)). Deep dives and interview breadth—**worked examples:** [Integration + idempotent webhook](handbook/software-engineering.md#integration-sync-async-and-messaging) · [ORM N+1 pattern](handbook/database-design.md#orms-and-the-n1-query-pattern).
- **[stacks/](stacks/)** — Short cheat sheets (“ecosystem maps”) for Swift, Kotlin, Next/TS, Node API, Java/JVM, .NET, PHP/Laravel, Python, SQL—they pack lots of jargon on purpose.

  **Totally confused?** Start with [Stacks glossary (plain-language jump links)](stacks/glossary.md) or the newcomer intro in [Stacks README — New here?](stacks/README.md#new-here-read-this-once). Dense tables plus the printable **term-card** worksheet live in [stacks/README.md](stacks/README.md).

**Checklists** at the repo root under [checklists/](../checklists/) include [unfamiliar-stack-ship.md](../checklists/unfamiliar-stack-ship.md) for a definition-of-done pass before you call AI-assisted work “shipped.”

## By topic

One primary pointer per theme (details stay in specs and handbook):

- **Testing (labs + optional AI prompts)** — [Per-project testing](playbook/per-project-testing.md) · handbook [Testing](handbook/software-engineering.md#testing).
- **Integrations** — [Project 1: webhook receiver](../project-specs/01-integration-webhook-receiver.md); handbook: [integration (sync, async, messaging)](handbook/software-engineering.md#integration-sync-async-and-messaging).
- **AI + LLM** — [Project 4: RAG / LLM service](../project-specs/04-rag-llm-service.md); checklist [LLM feature ship](../checklists/llm-feature-ship.md); workflow [AI-assisted unfamiliar stack](paths/ai-assisted-unfamiliar-stack.md) when the stack is new.
- **SQL** — [Project 7: SQL performance lab](../project-specs/07-sql-performance-lab.md); handbook [Database design](handbook/database-design.md); stack lens [SQL ecosystem map](stacks/sql.md).
- **Observability** — [Project 3: observability lab](../project-specs/03-observability-lab.md); handbook [Observability: logs, metrics, traces](handbook/software-engineering.md#observability-logs-metrics-traces) · [Debugging (workflow)](handbook/software-engineering.md#debugging-workflow) (narrow failures once you have signals).
- **Security / OWASP (web)** — [Project 8: application security lab](../project-specs/08-application-security-lab.md); checklist [application-security-web-owasp](../checklists/application-security-web-owasp.md); handbook [Security for applications](handbook/software-engineering.md#security-for-applications).
- **Polyglot architecture / stack exploration** — [Systems architect across languages](paths/systems-architect-across-languages.md); [ecosystem maps](stacks/README.md#ecosystem-maps-optional-short); optional depth [Node + TS API](stacks/node-typescript-backend.md) · [Java / JVM](stacks/java-jvm.md) · [glossary](stacks/glossary.md).
