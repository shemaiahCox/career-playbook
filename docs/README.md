# Documentation map

Material here supports both the **project ladder** ([README.md](../README.md)) and **“build A in stack B”** work—especially when B is unfamiliar and you are using AI for velocity.

## Choose your job

Pick the folder that matches what you need right now:

- **[playbook/](playbook/)** — **How do I test each lab (and use AI helpers responsibly)?** [Per-project testing (labs + AI)](playbook/per-project-testing.md) links layered testing and example prompts to every `career-project-specs/` file. Pair with [Testing](handbook/software-engineering.md#testing) in the handbook for pyramid and doubles.
- **[paths/](paths/)** — **Where am I going?** [Learning journey](paths/learning-journey.md) (start: [AI + automation + cloud quick map](paths/learning-journey.md#ai-automation-and-cloud--quick-map)), [Systems integration architect](paths/systems-integration-architect.md), [Algorithms study path](paths/algorithms-study-path.md), [AI-assisted unfamiliar stack](paths/ai-assisted-unfamiliar-stack.md).
- **[handbook/](handbook/)** — **What should I know deeply?** Long-form study notes: CLI, networking, databases, software engineering breadth ([software engineering](handbook/software-engineering.md), [database design](handbook/database-design.md), [algorithms and data structures](handbook/algorithms-and-data-structures.md), [language fundamentals comparison](handbook/language-fundamentals-comparison.md), [command-line tooling](handbook/command-line-tooling.md), [servers and networking](handbook/servers-and-networking.md), [LLMs](handbook/llms.md)). **Jargon on one page (A–Z):** [Software engineering glossary](handbook/software-engineering-glossary.md). Deep dives and interview breadth—**worked examples:** [Integration + idempotent webhook](handbook/software-engineering.md#integration-sync-async-and-messaging) · [ORM N+1 pattern](handbook/database-design.md#orms-and-the-n1-query-pattern).
- **[stacks/](stacks/)** — Ecosystem maps for **core stack**: PHP/Laravel, Node/TS, Go, Python, SQL, integration/automation patterns.

  **Totally confused?** Start with [Stacks glossary (plain-language jump links)](stacks/glossary.md) or the newcomer intro in [Stacks README — New here?](stacks/README.md#new-here-read-this-once). Dense tables plus the printable **term-card** worksheet live in [stacks/README.md](stacks/README.md).

**Checklists** at the repo root under [checklists/](../checklists/) include [unfamiliar-stack-ship.md](../checklists/unfamiliar-stack-ship.md) for a definition-of-done pass before you call AI-assisted work “shipped.”

## By topic

One primary pointer per theme (details stay in specs and handbook):

- **Testing (labs + optional AI prompts)** — [Per-project testing](playbook/per-project-testing.md) · handbook [Testing](handbook/software-engineering.md#testing).
- **Integrations** — [Project 1: webhook receiver](../career-project-specs/01-integration-webhook-receiver.md); handbook: [integration (sync, async, messaging)](handbook/software-engineering.md#integration-sync-async-and-messaging).
- **AI + LLM** — handbook [Large language models (LLMs)](handbook/llms.md); [Project 4: RAG / LLM service](../career-project-specs/04-rag-llm-service.md); checklist [LLM feature ship](../checklists/llm-feature-ship.md); workflow [AI-assisted unfamiliar stack](paths/ai-assisted-unfamiliar-stack.md) when the stack is new.
- **SQL** — [Project 7: SQL performance lab](../career-project-specs/07-sql-performance-lab.md); handbook [Database design](handbook/database-design.md); stack lens [SQL ecosystem map](stacks/sql.md).
- **Observability** — [Project 3: observability lab](../career-project-specs/03-observability-lab.md); handbook [Observability: logs, metrics, traces](handbook/software-engineering.md#observability-logs-metrics-traces) · [Debugging (workflow)](handbook/software-engineering.md#debugging-workflow) (narrow failures once you have signals).
- **Security / OWASP (web)** — [Project 8: application security lab](../career-project-specs/08-application-security-lab.md); checklist [application-security-web-owasp](../checklists/application-security-web-owasp.md); handbook [Security for applications](handbook/software-engineering.md#security-for-applications).
- **AI + automation + cloud (one spine)** — [Learning journey quick map](paths/learning-journey.md#ai-automation-and-cloud--quick-map) · [P4 RAG](../career-project-specs/04-rag-llm-service.md) · [P5 worker](../career-project-specs/05-async-worker-stretch.md) · [P9 Go](../career-project-specs/09-go-retrieval-worker-lab.md) · [Rust Tier‑2](paths/learning-journey.md#rust-tier-2-after-p9-go) · [integration-automation](stacks/integration-automation.md).
- **Integrations + automation + core stack** — [Systems integration architect](paths/systems-integration-architect.md); [Language fundamentals](handbook/language-fundamentals-comparison.md); [Go map](stacks/go.md); [integration-automation](stacks/integration-automation.md); [Algorithms study path](paths/algorithms-study-path.md).
