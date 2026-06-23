# Template — concept doc (learning-first)

Use this outline for every file in [`docs/concepts/`](../concepts/). **Learning body first; dense reference at the bottom.**

**Reference example:** [Concurrency runtime model (Part 1)](../concepts/concurrency-runtime-model.md)

**Depth:** Teach in plain English. Define every jargon term on first use in the body. Put acronyms, commands, and cheat sheets in **Technical reference**.

---

## Section order

### 1. Title

`# Topic name`

### 2. Use this

One sentence: who should read this and when (plain English trigger, not jargon).

```markdown
**Use this:** When [plain situation]—before [Project N](../../career-project-specs/NN-....md).
```

### 3. Reading order

Numbered path through related docs and labs.

```markdown
**Reading order:**

1. **You are here** — [one phrase]
2. [Next doc](path.md) — why next
3. Ship [Project N](../../career-project-specs/NN-....md)
```

### 4. Companion

Links to glossary, pillar docs, checklists.

```markdown
**Companion:** [Glossary](software-engineering-glossary.md) · [Related doc](path.md)
```

---

### 5. Why this matters (H2)

Motivation in plain English. No acronyms in the first paragraph.

Optional mermaid if it clarifies structure.

---

### 6. Topic sections (H2 / H3)

Rules for the learning body:

- **Bold term** = plain definition on first use; put acronym in parentheses after if needed.
- Prefer tables: **What you notice** | **Likely cause** | **First thing to try**.
- Link to glossary for depth; do not dump acronym lists in prose.
- One diagram beats five bullet fragments when showing flow.

Preserve existing `#anchor-ids` when rewriting docs that are already linked.

---

### 7. Where to practice (H2)

Project map table with plain labels in the first column.

Optional **Read next** line pointing to the next doc in the reading order.

---

### 8. Technical reference (H2) — required footer

Dense lookup only. No teaching prose here.

```markdown
## Technical reference

### Jargon quick lookup

| Term | One line |
|------|----------|
| **p95** | 95% of requests finished within this latency |

### Commands and tools

\`\`\`bash
hey -n 1000 -c 50 http://localhost:8080/health
\`\`\`

### Glossary links

- [Term](software-engineering-glossary.md#anchor)

### Interview one-liners (optional)

- "One sentence summary for whiteboard."
```

---

## Checklist before merge

- [ ] **Use this** and **Reading order** at top
- [ ] Learning body readable without opening Technical reference
- [ ] Every acronym used in body defined in plain English first
- [ ] **Technical reference** section at bottom
- [ ] Existing anchor headings preserved (if doc was linked elsewhere)
- [ ] Project links verified
