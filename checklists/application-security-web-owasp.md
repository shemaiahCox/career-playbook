# Checklist — application security (Open Web Application Security Project (OWASP) foundations, web)

Use this before calling the [Project 9](../career-project-specs/09-application-security-lab.md) milestone **done**. This complements [integration-hardening.md](integration-hardening.md) (inbound integrations and webhooks) — here the focus is **browser, forms, sessions, and application SQL**.

## Scope reminder

This section clarifies what this checklist covers and what belongs elsewhere.

- **In scope:** Concrete mitigations for common web risks (injection, cross-site scripting (XSS), session/auth, cross-site request forgery (CSRF), dependency hygiene) in **your lab repo**.
- **Out of scope for this checklist:** Partner webhook signatures and dead-letter queue (DLQ) paths — see [integration-hardening.md](integration-hardening.md).

## Injection (SQL and friends)

These items stop untrusted input from becoming executable code in your database or shell.

- [ ] No **string concatenation** of untrusted input into SQL (or SQL identifiers) on paths you ship; **parameters** / safe ORM APIs only.
- [ ] If you document a **vulnerable** pattern for learning, it lives in a **clearly marked** branch or appendix — not the default run configuration.

## XSS and browser context

These items stop attacker-controlled data from running scripts in another user's browser.

- [ ] User-controlled data is **encoded or escaped** for the **correct context** (HTML body, attribute, JavaScript, CSS — not one escape for all).
- [ ] **Content Security Policy (CSP)** considered: at minimum document why `unsafe-inline` is or is not present; prefer **narrowing** CSP when you stretch the lab.

## Authentication and session management

These items protect passwords and session tokens from theft and misuse.

- [ ] Passwords stored with **modern** hashing (framework defaults or established slow algorithms — **not** MD5/SHA1 for passwords).
- [ ] **Session fixation** considered: session id behavior on **login** documented per framework.
- [ ] Session cookies use **appropriate** flags where applicable: `HttpOnly`, `Secure` (in TLS environments), `SameSite` aligned with CSRF strategy.
- [ ] **Logout** invalidates server-side session (or equivalent) and is **documented**.

## CSRF (when cookies carry session)

These items stop a malicious site from triggering state-changing actions while the user is logged in.

- [ ] State-changing requests (**POST**/PUT/DELETE or relevant) use **CSRF tokens**, framework CSRF protection, or a **documented** alternative (e.g. double-submit cookie with tradeoffs).
- [ ] **SameSite** strategy documented if relied on as partial mitigation.

## Access control

These items ensure users can only access resources they are allowed to see.

- [ ] Protected routes **check authorization**, not only “is logged in” — **document** one resource-level rule (e.g. user A cannot read user B’s row by id).

## Secrets, logging, and dependencies

These items keep credentials out of git and out of logs, and track vulnerable packages.

- [ ] Secrets only via **environment variables** / secret manager; `.env` **gitignored**; `.env.example` has **placeholders** only.
- [ ] Logs avoid **passwords**, **session tokens**, and unnecessary **personally identifiable information (PII)**.
- [ ] **Lockfile** committed; process noted for **dependency vulnerability** alerts (`audit`, Dependabot, etc.).

## Documentation

These items capture how to run the lab and what security tradeoffs you accepted.

- [ ] README lists **how to run** locally, **threat exercise** outcomes (SQL injection / XSS / CSRF) at a high level, and **one** tradeoff you accepted (e.g. CSP strictness vs template engine).
