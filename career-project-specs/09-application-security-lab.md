# Project 9 — OWASP / cybersecurity foundations (web application)

## Progress

| | |
|---|---|
| **Step** | 9 of 20 |
| **Previous** | [Project 8 — Go retrieval gateway and worker lab](08-go-retrieval-worker-lab.md) |
| **Next** | [Project 10 — Automation bot / workflow connector lab](10-automation-bot-lab.md) |

## What you will learn

- Practice OWASP Top 10 risks in a deliberate lab setting
- Harden integration edges alongside user-facing forms
- Document secure SDLC habits for interviews

## Before you start

- **Handbook:** [Security for applications](../docs/concepts/software-engineering.md#security-for-applications)

## Problem

Ship a **small, intentional web application** (server-rendered forms + database is enough) where you **practice finding and fixing** OWASP-class issues—**SQL injection**, **cross-site scripting (XSS)**, **broken authentication / session handling**, **CSRF** on state-changing requests—so cybersecurity is **concrete code-level literacy**, not only vocabulary.

## Career relevance

**Summary:** Security is a product requirement; this lab makes **OWASP-class risks** concrete so you can **design and review** code like a senior backend engineer, not like a separate silo.

### In depth

Employers increasingly expect **baseline cybersecurity hygiene** from backend and full-stack-adjacent engineers: parameterized data access, sane auth/session defaults, and awareness of how HTML and browsers turn small mistakes into incidents. That is **not** the same as repositioning as a **cybersecurity specialist** (SOC-only, GRC-only, or red-team career)—this project strengthens **shipping engineers who build things that are hard to abuse**.

**Why learning this moves the needle**

- **Interview signal:** You can explain **why** string-concat SQL is unsafe, **where** XSS bites (contexts, encoding, CSP), and **what** CSRF protects when cookies carry session auth—stories grounded in **your** repo, not textbook lists.
- **Production reality:** Vulns still ship as **one unescaped field**, **one raw query**, **one missing CSRF token**, or **session fixation**-shaped mistakes. A lab repo is where you **reproduce** and **remediate** without risking production users.
- **Complements Project 1:** [Project 1](01-integration-webhook-receiver.md) and [integration-hardening.md](../checklists/integration-hardening.md) cover **integration-edge** security (signatures, idempotency). Project 8 covers **browser + database + forms**—how most business apps actually behave.

**Real-world situations this project mirrors**

- **Stored XSS** in a profile or comment field that executes for every admin who opens a ticket.
- **SQL injection** in a “quick” report or search endpoint that bypasses application auth.
- **Session issues:** fixation, weak cookie flags, or logout that doesn’t invalidate server-side session.
- **CSRF:** state-changing POST from another origin when the app relies on **session cookies** alone.

## Important concepts

### Concept spotlight

| **Parameterized data access** | No string-concat SQL; bound parameters / safe ORM APIs only |
| **XSS + output encoding** | Escape or sanitize by context; note CSP where applicable |
| **Session + CSRF hygiene** | Secure cookie flags; CSRF tokens on state-changing forms |

**Interview line:** *“We treat OWASP basics as ship criteria—parameterized queries, encoded output, and CSRF on cookie-authenticated forms—not a separate security phase.”*


**Interview line:** *“We treat OWASP basics as ship criteria—parameterized queries, encoded output, and CSRF on cookie-authenticated forms—not a separate security phase.”*

## Code repo

_TBD — create a sibling repo (e.g. `owasp-web-lab` or extend an existing contract/API repo with server-rendered routes) when you start._ Link it here and in [README.md](../README.md) quick links.

| | URL |
|---|-----|
| **GitHub** | _TBD_ |
| **SSH** | _TBD_ |
| **Local sibling** | _TBD — e.g. [`../career-projects/08-owasp-web-lab`](../career-projects/)_ |

## Stack (suggestion)

**Pick one primary path** so commits stay reviewable—alternates are valid; concepts transfer.

| Path | Notes |
|------|--------|
| **Laravel + Blade + MySQL/Postgres** | Aligns with PHP/Laravel anchors; forms, CSRF middleware, Eloquent parameterization. |
| **FastAPI + Jinja2 + SQLAlchemy** | Small templates + explicit queries—good for seeing **SQLi** vs bound parameters. |
| **Node + Express/Fastify + EJS/Pug** | Pairs with [Project 7](07-node-typescript-lab.md) if you want the same **language** as optional Node work. |

**Not gated on** [Project 5](05-contract-first-api.md): you may add **JSON endpoints** and OpenAPI later (optional **API Top 10** slice), but the **core** success criteria assume **HTML forms** and a **relational** store.

**Pairs with** [Project 4](04-sql-performance-lab.md): shared SQL engine discipline; Project 2 is about **plans and correctness under load**—Project 8 adds **injection** failure modes and **safe query** habits. Neither requires the other first.

### Non-goals

- Professional **penetration test** methodology or **certification chase** as the outcome.
- **Enterprise GRC** programs, exhaustive **Burp Suite** mastery, or replacing a dedicated security team.
- **API-only** delivery as the *only* surface—reuse your API if you already have one, but **forms + cookies** should appear somewhere in scope.

### Key concepts (with definitions and patterns)

### OWASP Top 10 (web)

**What:** A periodically updated **awareness document** listing high-prevalence web risks (exact ordering changes by year).

**Problem it solves:** Shared vocabulary across developers, security partners, and auditors—**not** a substitute for threat modeling your *specific* app.

**Practice:** Pick **3–5** items that map to your build (e.g. injection, broken access control, XSS, identification and authentication failures, cryptographic misuse—use the current list as a checklist **headline**, then tie each to **one** change in your repo).

### SQL injection

**What:** Attacker-controlled input **changes query structure** (not only data parameters)—often via string concatenation or unsafe dynamic fragments.

**Problem it solves (for builders):** **Parameterized queries**, bound parameters, and ORM methods that **never** interpolate untrusted SQL fragments.

**Practice:** One **intentionally unsafe** branch or documented snippet for learning—**never** left enabled in “production” config—contrasted with the fixed path.

### Cross-site scripting (XSS)

**What:** Untrusted data interpreted as **active content** in a browser (HTML/JS context)—**reflected**, **stored**, or **DOM**-based variants.

**Problem it solves:** **Context-appropriate encoding** for output, **Content-Security-Policy** (CSP) as defense in depth, and avoiding “HTML soup” in templates.

**Practice:** Demonstrate one stored or reflected XSS **before** fix and **after** encoding or CSP narrow enough to be explainable.

### Authentication and sessions

**What:** **AuthN** proves *who*; **AuthZ** decides *what* they may do. **Sessions** (often cookie-based) tie HTTP requests to server-side state.

**Problem it solves:** Password **hashing** (slow algorithms, per-password salt—use framework defaults), **session fixation** mitigation (rotate session id on privilege change/login), secure **cookie** attributes when applicable (`HttpOnly`, `Secure`, `SameSite`), and **logout** that invalidates server-side session.

**Practice:** Document your framework’s session and password flows; call out one **failure mode** you explicitly tested (e.g. reuse of pre-login session id).

### Cross-site request forgery (CSRF)

**What:** A **browser**‑automated request to *your* site that carries the user’s **cookies**, triggered from another origin unless prevented.

**Problem it solves:** **Synchronizer tokens** on state-changing requests, framework CSRF middleware, or (for APIs) **non-cookie** auth patterns where appropriate.

**Practice:** Show state-changing **POST** from a second origin **failing** after protection—document the exact mechanism you enabled.

### Dependency and secrets hygiene

**What:** Known-vulnerable libraries (**supply chain**) and **secrets** in env vs repo.

**Problem it solves:** Lockfiles, **dependabot** or equivalent alerts, optional **SAST**/secret scan in CI—overlap with [README non-goals](../README.md#non-goals) (ship with tests and observability, not tutorial clones).

## Testing approach (lab)

**Primary:** **Reproduction-driven** checks documented in the lab README: show **before/after** for SQLi (unsafe vs parameterized), XSS (unsafe render vs encoded/CSP), CSRF (forged POST rejected), session reuse after logout—align with [application-security-web-owasp checklist](../checklists/application-security-web-owasp.md).

**Secondary:** Optional **automated** checks (e.g. security-focused integration test that expects 403 on CSRF; dependency audit in CI). Many teams still rely on scripted manual **curl** + browser steps for OWASP demos—make them repeatable.

**Compare:** Snapshot-testing HTML for XSS is brittle; **behavioral** tests (“script does not execute”, “parameterized query path returns only intended rows”) plus checklist walk is the right balance.

**Example asks for AI (optional):**  
“Generate a minimal PHPUnit/Jest/pytest file that posts CSRF-free form to [route] and expects 4xx after middleware enabled—reference framework’s token field name from docs I paste.”  
“List five SQLi payloads for local testing only; for each, show expected safe behavior after bind parameters.”

**Shared patterns:** [Per-project testing (labs + AI)](../docs/concepts/per-project-testing.md).

## Success criteria

- [ ] Small app runs locally with **database**, **at least one HTML form**, and **session-based login** (or documented alternative if you use token-only—still justify CSRF implications).
- [ ] **SQL injection:** unsafe pattern **documented and fixed**; all production paths use **safe** access (parameters / ORM-safe APIs).
- [ ] **XSS:** at least one user-controlled field rendered in HTML; **demonstrate** fix via encoding and/or **CSP** (document tradeoffs).
- [ ] **Authentication:** passwords hashed with **modern** defaults; session behavior **documented** (rotation, logout, cookie flags as applicable).
- [ ] **CSRF:** state-changing requests **protected** when using cookie session auth; show a **failed** forged request once protections exist.
- [ ] **Logging:** no passwords, session tokens, or sensitive PII in logs—note what you redact.
- [ ] **Dependencies / supply chain:** lockfile checked in; **automated or documented cadence** for known CVEs (e.g. Dependabot alerts, `composer audit` / `npm audit` / `pip-audit`); README notes **pinning policy** (ranges vs exact pins) for the lab so upgrades are deliberate, not accidental drift.
- [ ] Walk [application-security-web-owasp checklist](../checklists/application-security-web-owasp.md) before calling the milestone done.

## Exploration scenarios

Use these to drive **failure modes** after the happy path works. Capture **curl**, **screenshots**, or **short notes** in the lab README.

### 1 — SQLi: prove impact, then eliminate

- **Setup:** Local app + DB; one search or filter that **concatenates** input (fix branch or toggled demo).
- **Action:** Craft input that **changes** query structure (e.g. tautology or UNION-shaped—only against local/lab data).
- **Expected outcome:** Same logical feature uses **parameters** only; README cites **before/after** query shape.

### 2 — XSS: stored or reflected

- **Action:** Submit payload in a field that **renders** to another user or same user’s page.
- **Expected outcome:** **Without** fix, browser shows execution risk; **with** fix, safe rendering—note **encoding** context (body vs attribute vs JS).

### 3 — Session behavior

- **Action:** Login, note session cookie; logout; attempt reuse of old session identifier if your design allows testing.
- **Expected outcome:** Document **logout** semantics and any **rotation** on login per framework docs.

### 4 — CSRF

- **Action:** From a second “attacker” HTML page on another port/origin, POST to your app **without** CSRF token when protection is on.
- **Expected outcome:** Request **rejected**; document token or SameSite strategy used.

### 5 — Dependency / secrets

- **Action:** Run one **audit** command; introduce no secrets in git (use `.env.example` only for shape).
- **Expected outcome:** README lists **how** you’ll notice vulnerable deps on an ongoing basis.

### 6 — Optional API slice

- **Action:** If you expose JSON endpoints: add **mass-assignment** or over-posting guard example; link to OWASP **API** Top 10 as vocabulary.
- **Expected outcome:** One paragraph on **authorization** on resources, not only authentication.

## Stretch

- **CSP** tightened beyond `unsafe-inline` with a **nonce** or **hash** strategy for any inline scripts you still need.
- **Automated security tests** (e.g. CSRF test in CI, dependency audit gate on PR).
- Short **STRIDE** or “assets / adversaries / data flows” diagram in README **≤1 page**.

## When you're done

- Run tests: [Testing approach (lab)](#testing-approach-lab) · [per-project testing guide](../docs/concepts/per-project-testing.md)
- Checklist: [Application security checklist](../checklists/application-security-web-owasp.md)
- Log in [PROGRESS.md](../PROGRESS.md)
- **Next:** [Project 10 — Automation bot / workflow connector lab](10-automation-bot-lab.md)
