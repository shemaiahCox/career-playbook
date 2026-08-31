# Ecosystem map: Bash / shell automation

**Use this:** **Bash** is your **ops glue** lane—CI smoke tests, deploy hooks, cron jobs, and reviewer demos—alongside **Go** (production CLIs) and application languages in the playbook.

**Companion:** [docs README](../README.md) · [Project 14 shell automation lab](../../archive/v1-22-step/career-project-specs/14-shell-automation-lab.md) · [Command-line tooling — Bash scripting](../concepts/command-line-tooling.md#bash-scripting-patterns-and-safety)

**New here?** [Plain language (bottom)](#plain-language-terms-used-on-this-page) · [Stacks glossary](glossary.md)

---

## Best for, alternatives, and playbook fit

| Best for | Use instead when | Primary projects |
|----------|------------------|------------------|
| CI smoke tests, deploy preflight, cron wrappers, log grep helpers, `demo.sh` orchestration | Subcommands, structured config, dead-letter queue (DLQ) replay CLI, long-lived ops tools | [Project 1](../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md)–[4](../../archive/v1-22-step/career-project-specs/04-sql-performance-lab.md) milestones, **[Project 14](../../archive/v1-22-step/career-project-specs/14-shell-automation-lab.md)**, [Project 16](../../archive/v1-22-step/career-project-specs/16-cloud-deploy-lab.md), [Project 22 capstone](../../archive/v1-22-step/career-project-specs/22-integrated-platform-capstone.md) |

**In scope vs defer** (playbook filter):

| Bash is used for (in scope) | Practice in | Defer (not playbook spine) |
|-----------------------------|-------------|----------------------------|
| Strict-mode scripts in `scripts/` | P1–P13 milestones, P14, P16, P22 | Full application logic in bash |
| `curl`/`jq` API probes | P1 webhook smoke, P14 toolkit | Complex parsers—use Go/Python |
| Deploy and smoke glue | P16 `deploy.sh`, P22 `demo.sh` | Production dead-letter queue (DLQ) replay CLI (use [Project 15 Go CLI](../../archive/v1-22-step/career-project-specs/15-devops-cli-lab.md)) |
| CI lint of shell | P14 `shellcheck` + bats | Rewriting Go/Rust services in shell |

**Easy follow path:** [Project catalog](../../README.md#roadmap) · Per-project [Bash scripting milestone](../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md#bash-scripting-milestone) sections · [Project 15 DevOps CLI](../../archive/v1-22-step/career-project-specs/15-devops-cli-lab.md) after P14.

---

## How it runs

| Execution | Typing | Memory / concurrency |
|-----------|--------|----------------------|
| **Interpreted** by `/bin/bash` or `#!/usr/bin/env bash` | Untyped strings; `"$var"` quoting is your type system | One process per script; parallelize with `xargs -P` or background jobs—prefer Go for heavy concurrency |

---

## Environment setup

1. Verify bash: `bash --version` (5+ on Linux/macOS; Git Bash on Windows).
2. Install **shellcheck**: `brew install shellcheck` or your distro package manager.
3. Install **bats**: `npm install -g bats` or clone [bats-core](https://github.com/bats-core/bats-core).
4. Optional: **shfmt** for formatting; **jq** for JSON in probes.
5. Project 14 lab clone under [`career-projects/`](../../career-projects/) per spec.

---

## Project layout

```
shell-automation-lab/
├── lib/
│   └── common.sh        # strict mode, log(), die()
├── scripts/
│   ├── webhook-smoke.sh
│   ├── queue-depth.sh
│   ├── logs-request-id.sh
│   └── preflight.sh
├── test/
│   └── common.bats
├── .github/workflows/
│   └── shellcheck.yml
└── README.md            # env vars, run order, exit codes
```

---

## Commands you'll use often

| Intent | Command | Notes |
|--------|---------|-------|
| Lint | `shellcheck scripts/*.sh lib/*.sh` | CI gate; fix all warnings |
| Test | `bats test/` | From repo root |
| Strict run | `bash -euo pipefail scripts/foo.sh` | Match shebang behavior |
| Debug | `bash -x scripts/foo.sh` | Trace expansion (dev only) |
| JSON probe | `curl -sf ... \| jq -e '.status == "ok"'` | Fail pipeline on bad JSON |

**Strict mode starter** (every script):

```bash
#!/usr/bin/env bash
# What: strict mode flags for every playbook script
# Why: -e exits on error; -u catches typos; pipefail surfaces curl|jq failures
# When: start of every script in Project 14 and milestone smoke tests
set -euo pipefail
```

---

## How concepts show up

**Exit codes**

- **0** — success; **1** — runtime or usage error; **2** — missing config/env. Document in README so CI and cron can branch.

**Idempotency**

- Cron-safe scripts: check state before mutating; support `--dry-run` for destructive paths (same discipline as [Project 1](../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md) webhooks).

**Observability**

- Log to stderr; reserve stdout for machine-readable output (JSON lines). Include timestamps in `lib/common.sh`.

**Secrets**

- Read from env (`"${WEBHOOK_SECRET:?}"`); never echo secrets; avoid argv leakage in `ps`.

---

## Footguns

- **Unquoted expansions** — `cp $src $dst` breaks on spaces; always `"$var"`.
- **Missing `pipefail`** — pipeline succeeds if last stage succeeds while `curl` failed mid-pipe.
- **Ignoring `grep` exit 1** — use `grep -q ... \|\| true` or `if grep ...; then` when no match is OK.
- **Secrets in logs** — redact tokens in script output.
- **Reimplementing CLIs in bash** — use Go ([Project 15](../../archive/v1-22-step/career-project-specs/15-devops-cli-lab.md)) for subcommands and dead-letter queue (DLQ) replay.

---

## Plain language: terms used on this page

| Term | Meaning |
|------|---------|
| **Shebang** | First line `#!/usr/bin/env bash` — tells OS which interpreter runs the file |
| **Strict mode** | `set -euo pipefail` — exit on error, unset vars, and pipeline failures |
| **shellcheck** | Static analyzer for shell scripts; catches quoting and portability bugs |
| **bats** | Bash Automated Testing System — unit tests for shell scripts |
| **Exit code** | Integer 0–255 returned to caller; CI uses non-zero as failure |
| **Glue script** | Short bash that wraps binaries (`docker`, `curl`, your Go CLI)—not business logic |

---

## See also

- [Command-line tooling](../concepts/command-line-tooling.md) — streams, Git, curl, full bash scripting section
- [Go ecosystem map](go.md) — when to ship a compiled CLI instead
- [Portfolio artifacts](../templates/portfolio-artifacts.md) — `scripts/demo.sh` bar
- [Per-project testing](../concepts/per-project-testing.md) — P14 bats + shellcheck row
