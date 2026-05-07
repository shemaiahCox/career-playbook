# Ecosystem map: Next.js + React + TypeScript

**Use this:** You ship a **web app or BFF-shaped site** with **Next.js** (App Router mindset). **TypeScript** + **React** are treated **as used inside Next**—not three separate tutorials.

**Companion:** [term cards](README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md)

**New here?** [Plain language (bottom of this page)](#plain-language-terms-used-on-this-page) · [Stacks glossary index](glossary.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | **Node.js** (server-side JavaScript) runs layouts, loaders, APIs, SSR/SSG; the **browser** runs **interactive** widgets and attaches them (**hydration**). |
| **Boundaries** | **Server vs client components** (+ `"use client"`) decides where **secrets, filesystem, databases** may safely run—you cannot ship `.env` secrets to the bundle by accident if you obey the fence. |
| **Bundling** | **Webpack / Turbopack** package files; **tree shaking** deletes unused imports; **`NEXT_PUBLIC_…`** exposes env vars—double-check naming so keys never reach the bundle. |
| **Data** | Use **native `fetch` on the server**, or **React Query/SWR** on the client, or **server actions**—just pick **one** clear story per feature so data flow stays reviewable. |

---

## How concepts show up

**State & effects**

- **React:** `useState`, `useReducer`, `useEffect` — effects are for **sync with external systems**; overusing them creates stale closure and dependency-array bugs.
- **Derived state:** compute during render when possible; use effect chains only when an external source Must be subscribed.

**TypeScript (practical bar)**

- **`strict` mode** where you can; **`unknown` over `any`** at boundaries (API/JSON).
- **Module path** and **bundler** resolution (`@/`, `paths` in `tsconfig`) — breakage shows up as “works locally, fails in CI.”

**Next.js App Router (high level)**

- **`page.tsx`** vs **`layout.tsx`** vs **`route.ts`**: who owns loading/error boundaries.
- **Caching / revalidation** defaults changed across versions — **verify** server output for dynamic routes (no stale auth or billing views).
- **Middleware** for auth gating: easy to get **partial protection** if only some routes pass through it.

**“Memory leaks” in frontends**

- Less ARC, more **subscriptions**: WebSockets, `setInterval`, event listeners, **global singletons** holding huge graphs.
- **AbortController** for fetch; cleanup in effect return functions.

---

## Footgun checklist

- [ ] **Secrets:** only in server env; never `NEXT_PUBLIC_` for private keys.
- [ ] **Auth:** session/JWT validation on **every** server path that mutates data; don’t trust client-only checks.
- [ ] **Server/client boundary:** no `window` in server components; no secret imports in client bundles (audit **barrel exports**).
- [ ] **Hydration** mismatches — often time/random/formatting; fix **deterministic** server render or suppress consistently (know **why**).

---

## Non-Next React (Vite, CRA, SPA)

Same **React + TS** footguns; you **lose** framework-enforced server boundaries—**you** must enforce API/auth/data discipline. Prefer this doc’s **React/TS** sections and add your own **routing + API** map.

---

## Plain language: terms used on this page

If “server component” scrambled your brain, read only this section tonight.

- **Node.js** — JavaScript runtime on servers (and during `next dev/build`), not inside the visitor’s tabs.
- **SSR / SSG / hydration** — *SSR* renders HTML per request or when data changes; *SSG* renders once ahead of time; *hydration* reattaches JavaScript event handlers in the browser so the page becomes interactive.
- **React** — Component-based UI toolkit for the browser (+ server helpers in frameworks).
- **TypeScript** — JavaScript plus static types—you catch mismatches earlier.
- **`use client`** — Directive telling Next.js “bundle this boundary for the browser.”
- **Server component vs client component** — Roughly **data and secrets belong server-side**, **animations and timers belong client-side**—Next enforces fences if you cooperate.
- **Webpack / Turbopack** — Bundlers assembling files tree-shaken for production.
- **Tree shaking** — Dead-code elimination (“imported but unused” disappears).
- **React Query / SWR** — Helpers for caching/displaying fetched data client-side—think “friendly layer over `fetch`.”
- **Server actions** — Next feature to mutate data from tightly coupled server endpoints without always hand-writing REST.
- **`useEffect` / dependency array** — Hook for syncing with **outside** systems; easy to misuse and create stale data bugs.
- **Middleware** — Runs at the edge of routing—common for auth checks; easy to miss paths if not global.
- **AbortController** — Cancels in-flight `fetch` when user navigates away—stops ghost updates.
- **BFF** — “Backend for frontend”—this Next app often plays that role for a separate API.
- **CRA / Vite / plain SPA** — Create React App (legacy-ish) or Vite—**bundled browser apps** without Next’s fences; you replicate auth/data hygiene yourself (**see Non-Next** section earlier).

### Read next (handbook)

- **[Security for applications](../handbook/software-engineering.md#security-for-applications)** — CORS is not auth; CSRF for cookie sessions; OWASP categories named there.
- **[REST](../handbook/software-engineering.md#rest)** and **[GraphQL, gRPC, and webhooks](../handbook/software-engineering.md#graphql-grpc-and-webhooks)** — how this BFF usually talks to backends.
- **[Observability: logs, metrics, traces](../handbook/software-engineering.md#observability-logs-metrics-traces)** — correlation IDs through server and client fetch paths.
- **[Concurrency basics](../handbook/software-engineering.md#concurrency-basics)** — why blocking the wrong runtime thread still matters on the server.

---

## See also

- [Software engineering breadth](../handbook/software-engineering.md) — REST, security, CORS, cookies vs tokens.
- OWASP-minded review for anything user-facing.
