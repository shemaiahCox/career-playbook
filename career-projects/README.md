# career-projects

Numbered lab workspaces. **The two-digit prefix is the progression step** — same number as the spec file and **Project N** in the path table.

| Step | Clone into | Spec |
|------|------------|------|
| 1 | `01-webhook-receiver-lab` | [01-integration-webhook-receiver.md](../career-project-specs/01-integration-webhook-receiver.md) |
| 2 | `02-rag-llm-lab` | [02-rag-llm-service.md](../career-project-specs/02-rag-llm-service.md) |
| 4 | `04-sql-perf-lab` | [04-sql-performance-lab.md](../career-project-specs/04-sql-performance-lab.md) |
| 21 | `21-platform-capstone-lab` | [21-integrated-platform-capstone.md](../career-project-specs/21-integrated-platform-capstone.md) |

**Optional (Big Tech benchmark — after P8 or P21):**

| ID | Clone into | Spec |
|----|------------|------|
| P22 | `22-rate-limiter-gateway-lab` | [22-rate-limiter-gateway-lab.md](../career-project-specs/22-rate-limiter-gateway-lab.md) |
| P23 | `23-notification-fanout-lab` | [23-notification-fanout-lab.md](../career-project-specs/23-notification-fanout-lab.md) |
| P24 | `24-search-autocomplete-lab` | [24-search-autocomplete-lab.md](../career-project-specs/24-search-autocomplete-lab.md) |

Each folder is normally a **nested git clone** — not duplicated in this parent repo unless you consciously vendor.

- **Path:** [README.md](../README.md#progression-step-1--21) (Step 1 → 21)
- **Specs:** [career-project-specs/](../career-project-specs/)

GitHub remote names may differ from folder names — see each spec's **Code repo** section for SSH URLs.

**Renamed from old numbering?** If you still have `04-rag-llm-lab` or `07-sql-perf-lab`, rename to `02-rag-llm-lab` and `04-sql-perf-lab` (git history stays inside each clone).

Separate commercial repos may live under **`~/Documents/dev/business-projects/`** — unrelated to playbook numbering.
