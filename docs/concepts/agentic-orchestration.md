# Agentic orchestration (Deep Agents, LangGraph, LangChain)

**Use this:** Before and during [Phase 1](../../career-project-specs/01-agentic-orchestration.md) — when you need to tell **harness**, **runtime**, and **framework** apart.

**Reading order:**

1. [Architecture framework](architecture-framework.md)
2. **You are here**
3. [LLMs](llms.md) — tokens, evals, safety
4. Ship [Phase 1](../../career-project-specs/01-agentic-orchestration.md)

**Companion:** [LLM feature ship](../../checklists/llm-feature-ship.md) · [Glossary](software-engineering-glossary.md)

LangChain’s open-source stack is three layers. You move between them; you do not pick one forever.

| Layer | Product | Control | Playbook default |
|-------|---------|---------|------------------|
| **Harness** | **Deep Agents** (`deepagents`) | Least ceremony — planning, subagents, virtual filesystem, long-running tasks | **Start here** (Python) |
| **Framework** | **LangChain** | Models, tools, MCP adapters, minimal `create_agent` | Tools and providers |
| **Runtime** | **LangGraph** | Most control — you draw the state graph, checkpoints, interrupts | **Required slice** so the harness is not a black box |

Rule of thumb: start with Deep Agents; drop to LangGraph when you must encode the steps; use LangChain for models, tools, and MCP.

TypeScript exists for Deep Agents and LangGraph. On this path it is **secondary** (MCP SDK / thin API). Canonical examples below are **Python**.

---

## Deep Agents (harness)

A **deep agent** is built for work that takes many steps: research, coding-shaped tasks, ops runbooks. The harness adds:

- a **planning / todo** loop
- a **virtual filesystem** (offload large tool results)
- **subagents** for isolated parallel work
- LangGraph underneath (durable execution, streaming, human-in-the-loop)

```python
# Illustrative — Python
from deepagents import create_deep_agent

agent = create_deep_agent(
    model="openai:gpt-4.1",
    tools=[search_docs],
    system_prompt="Use only listed tools. Prefer files for large results.",
)
```

**Failure modes:** unbounded tool loops; subagents that share secrets; filesystem backends that write outside an allowlist.

---

## LangGraph (runtime)

A **state graph** is nodes + edges + state. A **checkpoint** writes that state so a run can pause and resume (crash, approval, long wait).

Phase 1 requires **one graph you authored** — even if Deep Agents is how you ship day to day — so you can explain nodes, edges, and checkpointers in an interview.

```python
# Illustrative — Python
from langgraph.graph import StateGraph
from langgraph.checkpoint.memory import MemorySaver

graph = (
    StateGraph(State)
    .add_node("retrieve", retrieve)
    .add_node("act", act)
    .add_edge("retrieve", "act")
    .compile(checkpointer=MemorySaver())
)
```

---

## LangChain (framework)

LangChain is how you bind **models** and **tools**. MCP servers become tools. Keep a stable tool contract (name, args, errors) the way you would keep an HTTP contract.

---

## MCP and FastMCP

The **Model Context Protocol (MCP)** is a standard way to expose tools (and sometimes resources) to an agent. **FastMCP** is a Python way to host those servers.

Rules that do not change with the protocol:

- **Allowlist** — the agent cannot invent a `shell` tool in production
- Timeouts and size limits on tool results
- Never log secrets that appeared in tool I/O

**Secondary:** the official **TypeScript MCP SDK** for a small gateway. Not required to exit Phase 1.

---

## Evals

Treat graph + tool behavior like any other backend: fixtures for happy path, unknown tool, timeout, injection. See [llm-feature-ship.md](../../checklists/llm-feature-ship.md) and [llms.md](llms.md).

---

## Technical reference

- [Deep Agents overview](https://docs.langchain.com/oss/python/deepagents/overview)
- [LangGraph](https://docs.langchain.com/oss/python/langgraph/overview)
- [FastMCP](https://gofastmcp.com/)
- Phase 1 spec: [01-agentic-orchestration.md](../../career-project-specs/01-agentic-orchestration.md)
