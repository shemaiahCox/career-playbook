# Ecosystem map: Next.js + React + TypeScript

**Use this:** You ship a **web app or BFF-shaped site** with **Next.js** (App Router mindset). **TypeScript** + **React** are treated **as used inside Next**—not three separate tutorials.

**Companion:** [term cards](README.md) · [unfamiliar-stack ship](../../checklists/unfamiliar-stack-ship.md)

---

## Mental model

| Piece | What to know |
|--------|----------------|
| **Runtime** | **Node.js** runs server components, route handlers, SSR/SSG pipelines; **browser** runs client components and hydration. |
| **Boundaries** | **Server vs client components** (and “use client”) determine where **secrets**, **FS**, and **DB** may run. |
| **Bundling** | **Turbopack/Webpack**; **tree shaking**; **env** vars exposed to client only if prefixed/configured (**never leak server secrets**). |
| **Data** | **fetch** on server, **React Query/SWR** or server actions—pick **one** coherent story per feature. |

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

## See also

- [Software engineering breadth](../handbook/software-engineering.md) — REST, security, CORS, cookies vs tokens.
- OWASP-minded review for anything user-facing.
