# Request flow — RAG / LLM service

**Spec:** [Project 2](../../../career-project-specs/02-rag-llm-service.md)

```mermaid
sequenceDiagram
  participant Client
  participant Middleware as request_context
  participant Query as POST_query
  participant Stub as _stub_answer
  participant Logs as structured_logs

  Client->>Middleware: POST /query JSON body
  Middleware->>Middleware: set X-Request-Id
  Middleware->>Query: forward request
  Query->>Stub: body.question
  Stub-->>Query: answer + cited_chunk_ids
  Query->>Logs: query_complete event
  Query-->>Middleware: JSONResponse
  Middleware->>Logs: http_request event
  Middleware-->>Client: 200 + X-Request-Id
```

## Eval runner path (scenario 1)

```mermaid
sequenceDiagram
  participant Runner as run_eval.py
  participant API as POST_query

  loop each JSONL line
    Runner->>API: question from case
    API-->>Runner: answer JSON
    Runner->>Runner: check expected_facts / must_not_contain
  end
  Runner-->>Runner: exit 0 or 1
```

## France question (scenario 3)

Stub matches `capital` + `france` in the question → fixed answer + one citation id.

## Echo path (non-France)

Returns `(stub) Echo: …` with **empty** `cited_chunk_ids` — documents the contract when retrieval finds nothing.
