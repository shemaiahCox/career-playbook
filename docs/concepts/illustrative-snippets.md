# Illustrative snippets (playbook patterns)

**Use this:** Copy-paste **starting patterns** for lab READMEs and portfolio docs—adapt types, store, and broker to your stack; label **Illustrative**.

**Primary languages:** Python and Go. **Secondary:** TypeScript only for MCP/API stretch.

**Companion:** [Phase 1](../../career-project-specs/01-agentic-orchestration.md) · [Phase 5](../../career-project-specs/05-azure-backends.md) · [Agentic orchestration](agentic-orchestration.md)

v1 PHP-first snippets: [archive/v1-22-step](../../archive/v1-22-step/README.md).

---

## Deep Agent (Python)

**What:** Harness with allowlisted tools.

**Problem it solves:** Multi-step work without a custom graph on day one.

```python
# Illustrative — Python
from deepagents import create_deep_agent

agent = create_deep_agent(
    model="openai:gpt-4.1",
    tools=[lookup_ticket],
    system_prompt="Use only listed tools.",
)
```

---

## LangGraph checkpoint (Python)

**What:** A graph you own plus a checkpointer.

```python
# Illustrative — Python
from langgraph.graph import StateGraph
from langgraph.checkpoint.memory import MemorySaver

graph = (
    StateGraph(dict)
    .add_node("plan", plan_node)
    .add_node("act", act_node)
    .add_edge("plan", "act")
    .compile(checkpointer=MemorySaver())
)
```

---

## FastMCP tool stub (Python)

**What:** One allowlisted tool over MCP.

```python
# Illustrative — Python
from fastmcp import FastMCP

mcp = FastMCP("ops-tools")

@mcp.tool
def lookup_ticket(ticket_id: str) -> dict:
    return {"ticket_id": ticket_id, "status": "open"}
```

---

## Idempotent Go consumer

**What:** Mark applied before side effects (Service Bus or Redis).

```go
// Illustrative — Go
func (w *Worker) Handle(ctx context.Context, job Job) error {
    applied, err := w.store.MarkApplied(ctx, job.ID)
    if err != nil {
        return err
    }
    if !applied {
        return nil
    }
    return w.process(ctx, job.Payload)
}
```

---

## Redis / Service Bus retry + DLQ (Go)

```go
// Illustrative — Go
func (c *Consumer) Run(ctx context.Context) error {
    for {
        msg, err := c.next(ctx)
        if err != nil {
            return err
        }
        if err := c.handle(ctx, msg); err != nil {
            if c.retriesExceeded(msg) {
                _ = c.deadLetter(ctx, msg, err)
                continue
            }
            _ = c.requeue(ctx, msg)
        }
    }
}
```

---

## Health check (Python)

```python
# Illustrative — Python
@app.get("/health")
def health():
    return {"status": "ok"}
```

---

## TypeScript stretch — MCP or thin gateway

Not required to exit a phase. Official MCP SDK or a small HTTP front that forwards `request_id` to the Python agent.

```typescript
// Illustrative — TypeScript stretch
const requestId = req.headers["x-request-id"] ?? crypto.randomUUID();
const upstream = await fetch(`${AGENT_URL}/run`, {
  method: "POST",
  headers: { "Content-Type": "application/json", "X-Request-Id": requestId },
  body: JSON.stringify(req.body),
  signal: AbortSignal.timeout(30_000),
});
```

---

## See also

- [Per-project testing](per-project-testing.md)
- [Portfolio artifacts](../templates/portfolio-artifacts.md)
- [Software engineering handbook](software-engineering.md)
