# Ecosystem map: Node.js + TypeScript (HTTP / API services)

**Use this:** You ship or review **Node** backends as **HTTP APIs** (**Express**, **Fastify**, **NestJS-shaped** layering)—**not** primarily React/Next. For **Next.js + React + SSR**, use [nextjs-react-typescript.md](nextjs-react-typescript.md) first; Node is still the server runtime there, but vocabulary and footguns differ.

**Companion:** [term cards](README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md) · [Project 6 — Node / TypeScript lab](../../career-project-specs/06-node-typescript-lab.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | **Node.js** runs **JavaScript** (or compiled **TypeScript**) on a **single-threaded event loop** per process for most I/O-bound APIs—many concurrent waits, not many cores chewing CPU in one thread. **CPU-heavy** work on the hot path **blocks** other requests unless you offload (**worker threads**, **child processes**, or a dedicated worker service). |
| **Tooling** | **`package.json`** declares scripts and dependencies; **npm**, **pnpm**, or **yarn** install into `node_modules`. Commit a **lockfile** (`package-lock.json`, `pnpm-lock.yaml`, or `yarn.lock`) so CI and prod resolve the same graph. |
| **TypeScript** | Adds static types over JS—**`tsc`** compiles to JS, or **tsx** / **ts-node** runs dev without a separate build step. `strict` mode catches whole classes of null/undefined bugs at compile time. |
| **Module systems** | **ESM** (`import` / `export`) vs **CommonJS** (`require`) still collide in real repos—bundlers, `"type": "module"`, and interop shims matter when something breaks only in prod. |

---

## How concepts show up

**HTTP / APIs**

- **Middleware** chains (Express-style) or **hooks** (Fastify)—ordering matters: auth, body parsing, error handler last.
- **Validation at the boundary:** **Zod**, **joi**, or framework schemas—same discipline as Pydantic in Python: reject bad input before business logic.
- Align habits with [Project 6](../../career-project-specs/06-node-typescript-lab.md): **correlation IDs**, structured JSON logs.

**Async**

- **Promises** everywhere; **`async`/`await`** compiles to promise chains. **Forgotten `.catch()`** or unhandled rejections become **500s** or silent process warnings—wire a global handler in production.
- **Callbacks** still appear in older libraries; **`util.promisify`** or native promise APIs reduce drift.

**Data**

- **Prisma**, **TypeORM**, **Knex**, raw **`pg`**: same ORM themes as other maps—**N+1**, connection pooling—see [SQL map](sql.md) and [ORMs and N+1](../handbook/database-design.md#orms-and-the-n1-query-pattern).

**Observability**

- **`pino`** / **`winston`** structured logs; **OpenTelemetry** SDKs for Node; propagate **`request_id`** on every line (tie to [observability lab](../../career-project-specs/03-observability-lab.md)).

**Security**

- Secrets in **env** only; **`process.env`** in code, not committed `.env`. Rate limits and payload caps on public HTTP edges.

---

## Footgun checklist

- [ ] **`unhandledRejection` / `uncaughtException`** — log, metric, and exit policy documented; swallowed promises in async routes.
- [ ] **Blocking the event loop** — sync fs on large files, heavy JSON parse, `crypto` misuse on hot paths.
- [ ] **CJS vs ESM** — `require` vs `import` mismatch breaks only in certain bundlers or Node flags.
- [ ] **Trusting `req.body`** without validation — schema-first boundary.
- [ ] **Floating semver** in `package.json` without lockfile discipline in CI.

---

## Plain language: terms used on this page

Read this **after** the tables if the jargon felt dense.

- **Node.js** — JavaScript runtime built on V8, oriented to **non-blocking I/O** (network, filesystem callbacks).
- **Event loop** — One thread schedules callbacks when I/O completes; it is **not** a free parallel CPU machine for heavy compute.
- **npm / pnpm / yarn** — Package managers; **lockfile** pins transitive versions for reproducible builds.
- **`package.json`** — Manifest: dependencies, scripts (`npm test`, `npm run dev`), sometimes `"type": "module"`.
- **TypeScript** — Typed JavaScript; **`tsc`** emits JS; **`strict`** catches many null and shape bugs early.
- **ESM vs CommonJS** — Two module systems; mixing them without tooling causes “cannot use import outside a module” class errors.
- **Express / Fastify / NestJS** — Popular HTTP frameworks—Express is minimal middleware stack; Fastify emphasizes schema and speed; Nest adds Angular-inspired structure (modules, DI).
- **Middleware** — Functions run in order on each request (auth, parse JSON, attach context).
- **Zod / joi** — Runtime validation libraries—define input shapes and fail fast with 400s.
- **Prisma / TypeORM / Knex** — Database access layers—N+1 and lazy loading story matches other ORM notes in this playbook.
- **pino / winston** — Fast structured logging vs flexible logging—both pair with correlation IDs.
- **Worker threads / cluster** — Escape hatches when CPU or isolation needs exceed one event-loop thread.

### Read next (handbook)

- **[Concurrency basics](../handbook/software-engineering.md#concurrency-basics)** and **[Async sketch](../handbook/software-engineering.md#async-sketch)** (see **JS** row in the table) — event loop vs workers.
- **[Example: idempotent webhook or job](../handbook/software-engineering.md#example-idempotent-webhook-or-job-consumer)** — HTTP + retries at integration edges.
- **[ORMs and the N+1 pattern](../handbook/database-design.md#orms-and-the-n1-query-pattern)** — ORM-shaped data access.
- **[Observability: logs, metrics, traces](../handbook/software-engineering.md#observability-logs-metrics-traces)** — correlation across services.
- **[Debugging (workflow)](../handbook/software-engineering.md#debugging-workflow)** — promises and production versus local repro.

---

## See also

- [Next.js + React + TypeScript](nextjs-react-typescript.md) — full-stack web and SSR; Node appears as **build and server** runtime.
- [Software engineering breadth](../handbook/software-engineering.md) — REST, versioning, security.
