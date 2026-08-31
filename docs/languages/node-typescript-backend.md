# Ecosystem map: Node.js + TypeScript (HTTP / API services)

**Use this:** You ship or review **Node** backends as **HTTP APIs**. On the 7-phase path TypeScript is **secondary** (MCP SDK, thin APIs)—not required to exit a phase.

**Companion:** [docs README](../README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md) · [Phase 1 stretch](../../career-project-specs/01-agentic-orchestration.md#stretch-typescript--node)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Best for, alternatives, and playbook fit

| Best for | Use instead when | Primary projects |
|----------|------------------|------------------|
| BFF and contract APIs, BullMQ worker track, TypeScript-first HTTP | PHP for Project 1 webhook parity; Python for LLM/RAG when spec says so | [Project 7 — Node / TypeScript lab](../../archive/v1-22-step/career-project-specs/07-node-typescript-lab.md) |

---

## How it runs

| Execution | Typing | Memory / concurrency |
|-----------|--------|----------------------|
| **Node** interprets JS on a **single-threaded event loop** per process; **TS** compiles to JS (`tsc`) or runs via **tsx** in dev | Structural typing with **`strict`** tsconfig | V8 garbage collection (GC); async I/O via Promises—CPU-heavy work blocks the loop unless offloaded to worker threads or another service |

---

## Environment setup

1. Verify: `node -v` and `npm -v` (or `pnpm -v`); match project README (Node 20 LTS common).
2. Install: `npm install` or `pnpm install` in repo root—commit **lockfile** (`package-lock.json`, `pnpm-lock.yaml`, or `yarn.lock`).
3. TypeScript: ensure `"strict": true` in `tsconfig.json`; set `"type": "module"` when using ESM.
4. Dev script: `npm run dev` (project defines entry—often `tsx watch src/index.ts`).
5. Project 7 lab clone under [`career-projects/`](../../career-projects/) per spec.

---

## Project layout

```
my-api/
├── src/
│   ├── index.ts         # HTTP server entry
│   ├── routes/
│   └── middleware/
├── package.json
├── package-lock.json    # or pnpm-lock.yaml
├── tsconfig.json
└── dist/                # tsc output when not using tsx-only deploy
```

---

## Commands you'll use often

| Intent | Command | Notes |
|--------|---------|-------|
| Dev server | `npm run dev` | Usually tsx/watch or nodemon |
| Test | `npm test` | Often vitest or jest |
| Build | `npm run build` | `tsc` → `dist/` |
| Typecheck only | `npx tsc --noEmit` | CI without emit |
| Lint | `npm run lint` | eslint if configured |

---

## How concepts show up

**HTTP / APIs**

- **Middleware** chains (Express-style) or **hooks** (Fastify)—ordering matters: auth, body parsing, error handler last.
- **Validation at the boundary:** **Zod**, **joi**, or framework schemas—same discipline as Pydantic in Python: reject bad input before business logic.
- Align habits with [Project 7](../../archive/v1-22-step/career-project-specs/07-node-typescript-lab.md): **correlation IDs**, structured JSON logs.

**Async**

- **Promises** everywhere; **`async`/`await`** compiles to promise chains. **Forgotten `.catch()`** or unhandled rejections become **500s** or silent process warnings—wire a global handler in production.
- **Callbacks** still appear in older libraries; **`util.promisify`** or native promise APIs reduce drift.

**Data**

- **Prisma**, **TypeORM**, **Knex**, raw **`pg`**: same ORM themes as other maps—**N+1**, connection pooling—see [SQL map](sql.md) and [ORMs and N+1](../concepts/database-design.md#orms-and-the-n1-query-pattern).

**Observability**

- **`pino`** / **`winston`** structured logs; **OpenTelemetry** SDKs for Node; propagate **`request_id`** on every line (tie to [observability lab](../../archive/v1-22-step/career-project-specs/03-observability-lab.md)).

**Security**

- Secrets in **env** only; **`process.env`** in code, not committed `.env`. Rate limits and payload caps on public HTTP edges.

---

## Footguns

- [ ] **`unhandledRejection` / `uncaughtException`** — log, metric, and exit policy documented; swallowed promises in async routes.
- [ ] **Blocking the event loop** — sync fs on large files, heavy JSON parse, `crypto` misuse on hot paths.
- [ ] **Buffering full HTTP responses or SSE arrays** — stream or batch; cap client-side retention ([Memory and performance](../concepts/memory-and-performance.md)).
- [ ] **CJS vs ESM** — `require` vs `import` mismatch breaks only in certain bundlers or Node flags.
- [ ] **Trusting `req.body`** without validation — schema-first boundary.
- [ ] **Floating semver** in `package.json` without lockfile discipline in CI.

---

## Plain language: terms used on this page

Read this **after** the tables if the jargon felt dense.

- **Node.js** — JavaScript runtime built on V8, oriented to **non-blocking I/O** (network, filesystem callbacks).
- **Event loop** — One thread schedules callbacks when I/O completes; it is **not** a free parallel CPU machine for heavy compute. Layers: [Concurrency runtime model (Part 1)](../concepts/concurrency-runtime-model.md) · scale: [Node event loop at scale (Part 2)](../concepts/concurrency-deep-dives.md#node-event-loop-at-scale).
- **npm / pnpm / yarn** — Package managers; **lockfile** pins transitive versions for reproducible builds.
- **`package.json`** — Manifest: dependencies, scripts (`npm test`, `npm run dev`), sometimes `"type": "module"`.
- **TypeScript** — Typed JavaScript; **`tsc`** emits JS; **`strict`** catches many null and shape bugs early.
- **ECMAScript modules (ESM) vs CommonJS (CJS)** — Two module systems; mixing them without tooling causes “cannot use import outside a module” class errors.
- **Express / Fastify / NestJS** — Popular HTTP frameworks—Express is minimal middleware stack; Fastify emphasizes schema and speed; Nest adds Angular-inspired structure (modules, DI).
- **Middleware** — Functions run in order on each request (auth, parse JSON, attach context).
- **Zod / joi** — Runtime validation libraries—define input shapes and fail fast with 400s.
- **Prisma / TypeORM / Knex** — Database access layers—N+1 and lazy loading story matches other ORM notes in this playbook.
- **pino / winston** — Fast structured logging vs flexible logging—both pair with correlation IDs.
- **Worker threads / cluster** — Escape hatches when CPU or isolation needs exceed one event-loop thread.

### Read next (handbook)

- **[Language gotchas deep dive](language-gotchas-deep-dive.md)** — JS/TS sections: truthiness, loop capture, floats, hoisting, `this`, ASI, NaN (#1, #3, #5, #8, #11, #14, #17, #20).
- **[Concurrency basics](../concepts/software-engineering.md#concurrency-basics)** — event loop vs workers on your stack.
- **[Concurrency runtime model (Part 1)](../concepts/concurrency-runtime-model.md)** · **[Deep dives (Part 2)](../concepts/concurrency-deep-dives.md)** — layers before operational patterns.
- **[Example: idempotent webhook or job](../concepts/software-engineering.md#example-idempotent-webhook-or-job-consumer)** — HTTP + retries at integration edges.
- **[ORMs and the N+1 pattern](../concepts/database-design.md#orms-and-the-n1-query-pattern)** — ORM-shaped data access.
- **[Observability: logs, metrics, traces](../concepts/software-engineering.md#observability-logs-metrics-traces)** — correlation across services.
- **[Memory and performance](../concepts/memory-and-performance.md)** — event-loop blocking and client buffer caps.
- **[Debugging (workflow)](../concepts/software-engineering.md#debugging-workflow)** — promises and production versus local repro.

---

## See also

- [Language fundamentals comparison — JS/TS](language-fundamentals-comparison.md) — syntax side-by-side
- [Go stack map](go.md) — workers and retrieval gateway beside Node/Python
- [Integration-automation patterns](../concepts/integration-automation.md) — n8n custom node stretch for Project 7
- [Software engineering breadth](../concepts/software-engineering.md) — REST, versioning, security
