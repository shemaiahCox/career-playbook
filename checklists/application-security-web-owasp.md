# Checklist — application security (OWASP foundations, web)

Use before calling the [Project 8](../project-specs/08-application-security-lab.md) milestone **done**. This complements [integration-hardening.md](integration-hardening.md) (inbound integrations / webhooks)—here the focus is **browser, forms, sessions, and application SQL**.

## Scope reminder

- **In scope:** Concrete mitigations for common web risks (injection, XSS, session/auth, CSRF, dependency hygiene) in **your lab repo**.
- **Out of scope for this checklist:** Partner webhook signatures and DLQ paths—see [integration-hardening.md](integration-hardening.md).

## Injection (SQL and friends)

- [ ] No **string concatenation** of untrusted input into SQL (or SQL identifiers) on paths you ship; **parameters** / safe ORM APIs only.
- [ ] If you document a **vulnerable** pattern for learning, it lives in a **clearly marked** branch or appendix—not the default run configuration.

## XSS and browser context

- [ ] User-controlled data is **encoded or escaped** for the **correct context** (HTML body, attribute, JS, CSS—not one escape for all).
- [ ] **CSP** considered: at minimum document why `unsafe-inline` is or isn’t present; prefer **narrowing** CSP when you stretch the lab.

## Authentication and session management

- [ ] Passwords stored with **modern** hashing (framework defaults or established slow algorithms—**not** MD5/SHA1 for passwords).
- [ ] **Session fixation** considered: session id behavior on **login** documented per framework.
- [ ] Session cookies use **appropriate** flags where applicable: `HttpOnly`, `Secure` (in TLS environments), `SameSite` aligned with CSRF strategy.
- [ ] **Logout** invalidates server-side session (or equivalent) and is **documented**.

## CSRF (when cookies carry session)

- [ ] State-changing requests (**POST**/PUT/DELETE or relevant) use **CSRF tokens**, framework CSRF protection, or an **documented** alternative (e.g. double-submit cookie with tradeoffs).
- [ ] **SameSite** strategy documented if relied on as partial mitigation.

## Access control

- [ ] Protected routes **check authorization**, not only “is logged in”—**document** one resource-level rule (e.g. user A cannot read user B’s row by id).

## Secrets, logging, and dependencies

- [ ] Secrets only via **env** / secret manager; `.env` **gitignored**; `.env.example` has **placeholders** only.
- [ ] Logs avoid **passwords**, **session tokens**, and unnecessary **PII**.
- [ ] **Lockfile** committed; process noted for **dependency vulnerability** alerts (`audit`, Dependabot, etc.).

## Documentation

- [ ] README lists **how to run** locally, **threat exercise** outcomes (SQLi / XSS / CSRF) at a high level, and **one** tradeoff you accepted (e.g. CSP strictness vs template engine).
