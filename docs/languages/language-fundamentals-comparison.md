# Language fundamentals comparison

**Purpose:** One reference for the same **ideas**—variables, operators, conditionals, loops, functions, classes, collections, modules, enums, generics, strings, scope, errors, nulls, async—across the **core stack** for **integration and AI engineers**: **JavaScript/TypeScript**, **PHP**, **Go**, **Python**, and **Rust** (second growth lane after Project 8 Go—see [Rust stack](rust.md)). Query syntax lives in [SQL stack](sql.md). **Start at [Cross-stack study map](#cross-stack-study-map)** for the full 20-concept index.

**Companion docs:** [Software engineering](../concepts/software-engineering.md) (patterns, concurrency ops) · [Algorithms and data structures](../concepts/algorithms-and-data-structures.md) (Big-O, trees, interview structures) · [Python stack](python.md) · [Rust stack](rust.md) · [SQL stack](sql.md)

---

## Cross-stack study map

**One entry point:** cross-language **examples** live in this file; **depth** links out to concept docs and project specs. Each row links **Examples here**, **Go deeper**, and **Related** concepts. Use during active labs—not a substitute for building.

| # | Concept | Examples here | Go deeper | Related |
|---|---------|---------------|-----------|---------|
| 1 | Immutability & value vs reference | [Immutability and value vs reference](#immutability-and-value-vs-reference) · [Variables and mutability](#variables-and-mutability) | [Memory and performance](../concepts/memory-and-performance.md) | → 5, 9 |
| 2 | Closures & variable capture | [Closures and capture gotchas](#closures-and-capture-gotchas) · [Closures (fundamentals)](#closures-functions-that-capture-surroundings) | [Programming paradigms](../concepts/software-engineering.md#programming-paradigms) | → 10 |
| 3 | Concurrency models | [Async fundamentals](#async-and-concurrency-fundamentals) · [Concurrency beyond syntax](#concurrency-beyond-syntax) | [Concurrency runtime model (Part 1)](../concepts/concurrency-runtime-model.md) · [Concurrency basics](../concepts/software-engineering.md#concurrency-basics) | → 7, 12 |
| 4 | Iterators, generators & lazy evaluation | [Lazy evaluation](#lazy-evaluation-generators-and-iterators) | [Algorithms study path](../concepts/algorithms-study-path.md) | → 9, 11 |
| 5 | Memory models & lifetimes | [Ownership and memory models](#ownership-borrowing-and-memory-models) | [Memory and performance](../concepts/memory-and-performance.md) | → 1, 10 |
| 6 | Error handling models | [Error handling](#error-handling) · [Error philosophy](#error-philosophy-and-control-flow) | [Cross-language concepts and gotchas](../concepts/software-engineering.md#cross-language-concepts-and-gotchas) | → 10 |
| 7 | Asynchronous programming | [Async and concurrency (fundamentals)](#async-and-concurrency-fundamentals) | [Integration — sync vs async](../concepts/software-engineering.md#integration-sync-async-and-messaging) | → 3, 12 |
| 8 | Type systems | [Generics](#generics-and-type-parameters) · [Type systems beyond annotations](#type-systems-beyond-annotations) | [Classes, structs, and interfaces](#classes-structs-and-interfaces) | → 10 |
| 9 | Data structures & their costs | [Built-in data structures](#built-in-data-structures) | [Algorithms and data structures](../concepts/algorithms-and-data-structures.md) · [Project 4](../../archive/v1-22-step/career-project-specs/04-sql-performance-lab.md) | → 1, 4 |
| 10 | Gotchas interviewers love | [Cross-language gotchas](#cross-language-gotchas-interview-favorites) · [Equality gotchas](#equality-gotchas) · [Language gotchas deep dive](language-gotchas-deep-dive.md) (mentor depth, PHP · Python · TS/JS) | [Null, optionals, equality, and truthiness](#null-optionals-equality-and-truthiness) | → 2, 6, 8 |
| 11 | Functional programming concepts | [Functional idioms](#functional-idioms-map-filter-reduce) | [Programming paradigms](../concepts/software-engineering.md#programming-paradigms) | → 4 |
| 12 | Parallelism vs concurrency | [Concurrency beyond syntax](#concurrency-beyond-syntax) | [Concurrency runtime model (Part 1)](../concepts/concurrency-runtime-model.md) · [Memory and performance](../concepts/memory-and-performance.md) · [Project 8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md) | → 3, 7 |
| 13 | Design patterns | [Patterns across languages](../concepts/software-engineering.md#patterns-across-languages-go-vs-php-vs-ts-vs-python) | [Design patterns](../concepts/software-engineering.md#design-patterns-gof-style-survey) | — |
| 14 | API & interface design | — (contract patterns in labs) | [Project 1](../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md) · [Project 5](../../archive/v1-22-step/career-project-specs/05-contract-first-api.md) · [Production readiness](../../checklists/production-readiness.md) | — |
| 15 | Testing & quality | — (per-project test plans) | [Per-project testing](../concepts/per-project-testing.md) · [Software engineering — Testing](../concepts/software-engineering.md#testing) | — |
| 16 | Performance concepts | [Ownership and memory models](#ownership-borrowing-and-memory-models) · [Built-in data structures](#built-in-data-structures) | [Algorithms and data structures](../concepts/algorithms-and-data-structures.md) · [Memory and performance](../concepts/memory-and-performance.md) · [Project 18](../../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md) | → 1, 5, 9 |
| 17 | Security fundamentals | — (integration patterns in labs) | [Project 9](../../archive/v1-22-step/career-project-specs/09-application-security-lab.md) · [Security for applications](../concepts/software-engineering.md#security-for-applications) | — |
| 18 | Build systems & tooling | [Modules, imports, and packages](#modules-imports-and-packages) | [Command-line tooling](../concepts/command-line-tooling.md) · per-language maps in [glossary](glossary.md) | — |
| 19 | Networking & IO | — (HTTP/streaming in labs) | [Servers and networking](../concepts/servers-and-networking.md) · [Project 17](../../career-project-specs/17-proxy-load-balancer-lab.md) | — |
| 20 | Architecture concepts | [domain-driven design (DDD)](../concepts/software-engineering.md#domain-driven-design-ddd) · [command query responsibility segregation (CQRS) & event sourcing](../concepts/software-engineering.md#cqrs-and-event-sourcing) | [Architecture framework](../concepts/architecture-framework.md) · [Architectural patterns](../concepts/software-engineering.md#architectural-patterns) · [Systems integration architect](../concepts/systems-integration-architect.md) | — |

---

## Table of contents

- [Cross-stack study map](#cross-stack-study-map)
- [How to use this doc](#how-to-use-this-doc)
- [Variables and mutability](#variables-and-mutability)
- [Functions](#functions)
- [Classes, structs, and interfaces](#classes-structs-and-interfaces)
- [Built-in data structures](#built-in-data-structures)
  - [Arrays and ordered lists](#arrays-and-ordered-lists)
  - [Maps and dictionaries](#maps-and-dictionaries)
  - [Sets](#sets)
  - [Tuples and fixed-size pairs](#tuples-and-fixed-size-pairs)
  - [Stack and queue idioms](#stack-and-queue-idioms)
  - [Choosing at a glance](#choosing-at-a-glance)
- [Operators and expressions](#operators-and-expressions)
- [Conditionals and branching](#conditionals-and-branching)
- [Loops and iteration](#loops-and-iteration)
- [Modules, imports, and packages](#modules-imports-and-packages)
- [Enums, unions, and pattern matching](#enums-unions-and-pattern-matching)
- [Generics and type parameters](#generics-and-type-parameters)
- [Strings, formatting, and destructuring](#strings-formatting-and-destructuring)
- [Scope, blocks, and casting](#scope-blocks-and-casting)
- [Error handling](#error-handling)
- [Null, optionals, equality, and truthiness](#null-optionals-equality-and-truthiness)
- [Async and concurrency (fundamentals)](#async-and-concurrency-fundamentals)
- [Advanced concepts (cross-stack)](#advanced-concepts-cross-stack)
  - [Immutability and value vs reference](#immutability-and-value-vs-reference)
  - [Closures and capture gotchas](#closures-and-capture-gotchas)
  - [Lazy evaluation: generators and iterators](#lazy-evaluation-generators-and-iterators)
  - [Ownership, borrowing, and memory models](#ownership-borrowing-and-memory-models)
  - [Type systems beyond annotations](#type-systems-beyond-annotations)
  - [Error philosophy and control flow](#error-philosophy-and-control-flow)
  - [Cross-language gotchas (interview favorites)](#cross-language-gotchas-interview-favorites)
  - [Functional idioms (map, filter, reduce)](#functional-idioms-map-filter-reduce)
  - [Metaprogramming: decorators, macros, traits](#metaprogramming-decorators-macros-traits)
  - [Concurrency beyond syntax](#concurrency-beyond-syntax)
- [Language-specific extras](#language-specific-extras)
- [Python (scripting lane)](#python-scripting-lane)
- [Quick reference index](#quick-reference-index)

---

## How to use this doc

0. **Browse the full list** — [Cross-stack study map](#cross-stack-study-map) links every high-value concept to examples here and depth elsewhere.
1. **Read** the section for the concept you are translating (e.g. “how do maps work in Go?”).
2. **Skim** the comparison table, then read the **multi-language snippet**.
3. **Apply** in your active project lab from [README.md](../../README.md#roadmap) when you want muscle memory—not a substitute for this page, but the best way to lock spelling in.
4. **Depth on complexity and classic data structures and algorithms (DS&A)** stays in [Algorithms and data structures](../concepts/algorithms-and-data-structures.md)—this file covers **literal syntax and everyday methods** (`push`, `len`, `get`, `has`) for lists, maps, and sets, not red-black tree theory.
5. **SQL** (queries, joins, transactions) is not a general-purpose language in this comparison—see [SQL stack](sql.md) for database work next to these services.
6. **Advanced language features** (generators, ownership, type-system edges) live in [Advanced concepts](#advanced-concepts-cross-stack)—read when translating between stacks during an active lab. Operational concurrency (thread pools, backpressure, queue workers) stays in [Software engineering — Concurrency basics](../concepts/software-engineering.md#concurrency-basics).

**Comment style note:** JavaScript, TypeScript, Go, Rust, and PHP use `//` for line comments. Python uses `#`. PHP block comments use `/* ... */` like JS.

---

## Variables and mutability

**What:** Binding a name to a value—constants, mutable locals, type annotations, and what other modules may import.

**Why:** Integration code passes config (URLs, timeouts, limits) through many layers. If you assume “const means frozen” or “Python UPPER_CASE is enforced,” you will mutate shared state by accident.

**When:** Reach for this section when porting config parsing, env defaults, or module exports from one stack to another.

Every language lets you bind a name to a value; they differ on **whether rebinding or mutation is allowed by default** and on **type syntax**. Skim the table first, then compare how each language spells the same config object.

| Idea | JavaScript | TypeScript | PHP | Go | Python | Rust |
|------|------------|------------|-----|-----|--------|------|
| Immutable binding | `const x = 1` | `const x: number = 1` | No `const` for vars; use `final` in classes sparingly | `x := 1` then no rebind with `:=` on same name in same scope; or `const` in Go 1.22+ block | Convention: `UPPER = 1` for constants; no enforced immutability | `let x = 1` immutable default; `const` compile-time |
| Mutable binding | `let s = ""` | `let s: string = ""` | `$s = ''` | `s := ""` then `s = "hi"` | `s = ""` | `let mut s = String::new()` |
| Type annotation | optional | `const url: string` | `string $name` (PHP 7.4+) | `var name string = "Ada"` | `name: str = "Ada"` (optional hints) | `name: String` · inference |
| Module-level export | `export const API = ...` | same | `namespace` + class constants | Capitalized name = exported in package | module-level names; `__all__` for public API | `pub const` · `pub fn` · `pub struct` |

The snippets below show the **same config shape** in each language—what each line does, why the default mutability model matters, and when you would use that spelling in a service.

**JavaScript** — `const` stops rebinding the variable, not mutation of object fields. Use `const` for bindings you will not reassign; use `let` when the reference changes.

```javascript
// What: const binding + mutable object innards
// Why: const is the default for config objects you still need to patch at runtime
// When: Node/ browser modules exporting shared limits or feature flags
const limits = { max: 10 };
limits.max = 20; // allowed — object innards still mutate
```

**PHP (PHP: Hypertext Preprocessor)** — every variable name starts with `$`. Arrays pull double duty as lists and maps (see [Built-in data structures](#built-in-data-structures)).

```php
<?php
// What: scalar and associative array bindings
// Why: $ prefix is mandatory; arrays are the default collection type
// When: Laravel config, request payloads, webhook field extraction
$url = 'https://example.com';
$limits = ['max' => 10];
```

**Go** — `:=` declares and assigns; `=` reassigns an existing variable. Exported names start with a capital letter.

```go
// What: short declare then reassignment
// Why: := vs = is a common porting mistake from other languages
// When: worker config, struct fields, function-local state in Project 8
name := "Ada"
name = "Bob"
```

**Python** — no language-level `const`; `UPPER_CASE` is a convention only. Dicts and lists stay mutable even when the name looks like a constant.

```python
# What: module-level "constant" that still allows dict mutation
# Why: Python will not stop you from mutating nested structures
# When: FastAPI settings, shared defaults—prefer frozen dataclasses for true immutability
API_BASE = "https://example.com"
limits = {"max": 10}
limits["max"] = 20  # dict is mutable even if name is "constant"
```

**Rust** — bindings are immutable unless `mut`; compile-time `const` for true constants. Explicit `mut` when you need in-place map updates.

```rust
// What: compile-time const + mutable HashMap binding
// Why: Rust separates "cannot rebind" from "can mutate through mut"
// When: hot-path config in Project 18—prefer immutability until profiling says otherwise
const API_BASE: &str = "https://example.com";
let mut limits = HashMap::from([("max", 10)]);
```

---

## Functions

**What:** Named blocks of logic, optional type annotations, visibility/export rules, and how each language returns errors or multiple values.

**Why:** The same “parse timeout from env with a default” appears in every project lab—but Go returns `(value, error)`, Python raises, TypeScript throws, and Rust uses `Result`.

**When:** Use this section when translating helpers between stacks or aligning error handling at HTTP boundaries.

Functions group logic; **methods** attach to types. Visibility and **multiple return values** vary widely. The shared example below is **`parseTimeoutMs`**—identical behavior, different failure spelling.

| Idea | JavaScript/TS | PHP | Go | Python | Rust |
|------|---------------|-----|-----|--------|------|
| Named function | `function add(a, b) { return a + b }` | `function add(int $a, int $b): int` | `func add(a, b int) int` | `def add(a: int, b: int) -> int:` | `fn add(a: i32, b: i32) -> i32` |
| Arrow / expression | `const add = (a, b) => a + b` | fn expr rare in PHP 8+ | — | `lambda x: x + 1` | closures `|x| x + 1` |
| Multiple returns | array/tuple destructuring | array or object; no native tuple | `(value, error)` idiomatic | `return a, b` → tuple | `Result<T,E>` · tuples |
| Export / visibility | `export function` | `public function` in class | Capitalized = exported | leading `_` convention for "private" | `pub fn` · module privacy |

**TypeScript** — exported helper with nullish default and thrown error on invalid input. Use at HTTP middleware boundaries in Project 7.

```typescript
// What: parse env string to positive milliseconds
// Why: throw at boundary so callers get a typed number or a single failure path
// When: Node/TS config modules (Project 7)
export function parseTimeoutMs(raw: string | undefined): number {
  const n = Number(raw ?? "3000");
  if (!Number.isFinite(n) || n <= 0) throw new Error("invalid timeout");
  return n;
}
```

**PHP** — nullable parameter type, default via `??`, domain exception on invalid values.

```php
<?php
// What: same timeout parser with PHP nullable types
// Why: InvalidArgumentException maps cleanly to HTTP 422 in Laravel handlers
// When: Project 1 webhook/config helpers
function parseTimeoutMs(?string $raw): int {
    $n = (int) ($raw ?? 3000);
    if ($n <= 0) {
        throw new InvalidArgumentException('invalid timeout');
    }
    return $n;
}
```

**Go** — idiomatic `(T, error)` even for trivial math—callers must check `err` every time.

```go
// What: value + error return pair (shown with add; same pattern as parse helpers)
// Why: forces explicit error handling—no hidden exceptions
// When: every Go worker and HTTP handler in Project 6/8
func add(a, b int) (int, error) {
    return a + b, nil
}
```

**Python** — type hints document intent; runtime ignores them unless you run mypy/pyright in CI.

```python
# What: parse with default and ValueError on bad input
# Why: exceptions bubble to FastAPI/Flask handlers unless you catch locally
# When: Project 2 service modules—pair with tests because hints are not enforced at runtime
def parse_timeout_ms(raw: str | None) -> int:
    n = int(raw or 3000)
    if n <= 0:
        raise ValueError("invalid timeout")
    return n
```

**Rust** — `Option` for absence, `Result` for failure, `?` to propagate parse errors up the call stack.

```rust
// What: parse optional string to u64 Result
// Why: caller must handle Err—no silent failure in worker hot paths
// When: Project 18 after sync path works; map Err to HTTP 500 or DLQ at boundary
fn parse_timeout_ms(raw: Option<&str>) -> Result<u64, String> {
    let n: u64 = raw.unwrap_or("3000").parse().map_err(|e| e.to_string())?;
    if n == 0 { return Err("invalid timeout".into()); }
    Ok(n)
}
```

### Closures (functions that capture surroundings)

**What:** Inner functions or lambdas that read variables from an enclosing scope.

**Why:** Factory patterns (`makeAdder`) and callbacks depend on capture semantics—loop bugs live here (see [Closures and capture gotchas](#closures-and-capture-gotchas)).

**When:** Event handlers, middleware factories, and deferred job callbacks in any stack.

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| Closure / lambda | `(x) => x + base` | `fn($x) => $x + $base` | `func(x int) int { return x + base }` | `lambda x: x + base` | `|x| x + base` · move/borrow rules |

Each snippet builds **`makeAdder(base)`** returning a function that adds `base`. Compare capture rules—especially in loops ([capture gotchas](#closures-and-capture-gotchas)).

```javascript
// What: outer function returns inner arrow that closes over `base`
// Why: lexical capture—`base` is read when add10 runs, not when makeAdder returns
// When: middleware factories, partial application in Node handlers
function makeAdder(base) {
  return (x) => x + base;
}
const add10 = makeAdder(10);
```

```python
# What: nested def with enclosing scope capture
# Why: same factory pattern as JS—watch late binding in loops (gotcha #6)
# When: FastAPI dependency factories, small decorators
def make_adder(base):
    def add(x):
        return x + base
    return add

add10 = make_adder(10)
```

```rust
// What: move closure takes ownership of captured `base`
// Why: `move` required when returning closure that outlives stack frame
// When: tokio callbacks and iterator adapters in Project 18
fn make_adder(base: i32) -> impl Fn(i32) -> i32 {
    move |x| x + base
}
```

---

## Classes, structs, and interfaces

Object-oriented (OO) languages like JavaScript, PHP, and Python center on **classes**—blueprints that bundle data and behavior. Go and Rust take a different route: **structs** hold data, and you attach behavior with separate **methods** (Go) or **`impl` blocks** (Rust). TypeScript adds explicit **interfaces** for typing; Python often uses **duck typing** ("if it has the methods I need, it works") with optional **`Protocol`** types when you want static checking.

The table below maps the same ideas across languages. Use it when you are translating a design from one stack to another—for example, a Laravel service class becomes a Go struct plus functions, not a Go "class."

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| Type definition | `class User { }` | `class User { }` | `type User struct { }` | `class User:` · `@dataclass` | `struct User` · `enum` |
| Interface / protocol | duck typing; `implements` in TS | `interface` + traits | implicit interfaces | `Protocol` / duck typing | `trait` · implicit impl |
| Inheritance | `extends` | `extends` | composition, no subclassing | `class Child(Parent):` | no inheritance — compose |
| Method on type | `method() { }` | `public function method()` | `func (u *User) Save()` | `def save(self):` | `impl User { fn save(&self) }` |

Each snippet below implements the same tiny **`Greeter`**—hold a name, return a greeting. Compare how each language attaches state to behavior.

**JavaScript** — a `class` with a constructor stores `name` on `this`. Methods live on the prototype. You would use this in Node or browser code when you want familiar OO syntax.

```javascript
// What: ## Classes, structs, and interfaces — class Greeter {
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
class Greeter {
  constructor(name) {
    this.name = name;       // instance field set at construction
  }
  hello() {
    return `hi ${this.name}`;  // method reads instance state
  }
}
// Usage: new Greeter("Ada").hello()  →  "hi Ada"
```

**PHP (PHP: Hypertext Preprocessor, 8+)** — **promoted constructor properties** declare and assign fields in one line inside `__construct`. Common in Laravel models and services.

```php
<?php
// What: ## Classes, structs, and interfaces — 
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
class Greeter {
    public function __construct(private string $name) {}  // promotes $name to a property
    public function hello(): string {
        return "hi {$this->name}";
    }
}
// Usage: (new Greeter("Ada"))->hello()
```

**Go** — no `class` keyword. A **struct** holds fields; a **method** is a function with a receiver `(g Greeter)`. Go favors composition over inheritance—embed other structs instead of extending classes.

```go
// What: ## Classes, structs, and interfaces — type Greeter struct {
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
type Greeter struct {
    Name string
}
func (g Greeter) Hello() string {   // method on Greeter value receiver
    return "hi " + g.Name
}
// Usage: Greeter{Name: "Ada"}.Hello()
```

**Python** — a **`@dataclass`** generates `__init__`, `__repr__`, and equality for simple record types. Use it for DTOs (Data Transfer Objects) and config objects instead of hand-writing boilerplate.

```python
# What: ## Classes, structs, and interfaces — from dataclasses import dataclass
# Why: compare spelling when translating between stacks
# When: active lab cross-stack translation
from dataclasses import dataclass

@dataclass
class Greeter:
    name: str

    def hello(self) -> str:
        return f"hi {self.name}"
# Usage: Greeter("Ada").hello()
```

**Rust** — a **struct** plus an **`impl` block** defines methods. `&self` is an immutable borrow of the instance (Rust's way of saying "method on self without taking ownership").

```rust
// What: ## Classes, structs, and interfaces — struct Greeter { name: String }
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
struct Greeter { name: String }
impl Greeter {
    fn hello(&self) -> String { format!("hi {}", self.name) }
}
// Usage: Greeter { name: "Ada".into() }.hello()
```

**When to pick which shape:** use classes or dataclasses when the type carries behavior and invariants (validation in `__init__`, methods that enforce rules). Use plain structs or dicts when you only need a bag of fields with no logic—especially in Go and Python service layers where functions operate on simple data.

---

## Built-in data structures

**What:** Ordered lists, key–value maps, sets, tuples, and everyday stack/queue patterns built into each language.

**Why:** Wrong structure choice (PHP array as vector, Go slice aliasing, JS `shift` on large arrays) shows up as prod bugs before Big-O theory does.

**When:** Picking storage for webhook payloads, user lists, dedup caches, or paginated API results.

**Lists/arrays**, **maps/dictionaries**, and **sets** exist everywhere. This section covers **how you create them**, **read and update elements**, and **common methods**—not when Big-O favors one over another ([Algorithms and data structures — Data structures](../concepts/algorithms-and-data-structures.md#data-structures)).

### Overview: literals and types

**What:** The shortest way to create a three-element ordered sequence in each language.

**Why:** Literal syntax is the first thing you translate when reading unfamiliar code.

**When:** Skimming a new codebase or writing test fixtures.

**Key takeaway:** Pick the right structure for the access pattern—list for order, map for lookup, set for uniqueness—and remember PHP arrays are ordered hash maps, not pure vectors.

**At a glance (Rust · Python · JavaScript · Go · PHP):** Each line creates a three-element ordered sequence—the most common literal in that language.

```rust
// What: growable Vec literal with three ints
// Why: `vec!` is the default dynamic array in Rust
// When: collecting results before returning from hot-path code
let mut v = vec![1, 2, 3];
```

```python
# What: list literal — dynamic array
# Why: default ordered mutable sequence in Python
# When: in-memory rows before ORM persistence
a = [1, 2, 3]  # dynamic array
```

```javascript
// What: array literal (object, not C array)
// Why: reference type—aliases share mutations
// When: JSON arrays in Node handlers
let a = [1, 2, 3]; // array object, not a fixed C array
```

```go
// What: slice literal of ints
// Why: slices are views with shared backing arrays
// When: batch IDs in Go workers
s := []int{1, 2, 3}
```

```php
<?php
// What: PHP array literal (ordered hash map)
// Why: not a dense vector—keys may have gaps after unset
// When: webhook payload lists in Project 1
$a = [1, 2, 3]; // ordered hash map (not a pure vector)
```

**Costs and Big-O:** [Algorithms and data structures — Data structures](../concepts/algorithms-and-data-structures.md#data-structures).

| Structure | JavaScript | PHP | Go | Python | Rust |
|-----------|------------|-----|-----|--------|------|
| Ordered list | `[1, 2, 3]` | `[0, 1]` indexed array | `[]int{1,2}` **slice** | `[1, 2, 3]` | `vec![1,2,3]` **Vec** |
| Map / dict | `{ k: "v" }` / `new Map()` | `['k' => 'v']` assoc array | `map[string]int{}` | `{"a": 1}` | `HashMap<K,V>` |
| Set | `new Set([1,2])` | no native `Set` (see [Sets](#sets)) | `map[T]struct{}` idiom | `{1, 2}` | `HashSet<T>` |
| String | immutable UTF-16 | `mbstring` for Unicode | immutable UTF-8 `string` | immutable `str` | `String` / `&str` |
| Mutable by default? | arrays/objects yes | arrays yes | slice/map yes if variable mutable | list/dict/set yes | `let mut` for mutable |
| Iterate | `for...of`, `.forEach` | `foreach` | `for range` | `for x in items:` | `for x in &items` |

Loop spellings: [Loops and iteration](#loops-and-iteration). String interpolation: [Strings, formatting, and destructuring](#strings-formatting-and-destructuring).

**Related:** [Immutability and value vs reference](#immutability-and-value-vs-reference) · [Lazy evaluation](#lazy-evaluation-generators-and-iterators)

### Arrays and ordered lists

Ordered sequences with **integer indices** (0-based in JS, PHP, Python). **Go:** prefer growable **slices** `[]T` over fixed **arrays** `[N]T`. **PHP:** indexed `[a, b]` and associative `['k' => v]` share the same `array` type.

| Operation | JavaScript | PHP | Go | Python | Rust |
|-----------|------------|-----|-----|--------|------|
| Create empty | `[]` | `[]` | `make([]int, 0)` or `nil` slice | `[]` | `Vec::new()` |
| Index read | `arr[i]` | `$arr[$i]` | `s[i]` | `arr[i]` | `v[i]` |
| Length | `.length` | `count($arr)` | `len(s)` | `len(arr)` | `v.len()` |
| Append | `.push(x)` | `array_push($arr, $x)` | `append(s, x)` | `.append(x)` | `v.push(x)` |
| Pop last | `.pop()` | `array_pop($arr)` | `s = s[:len(s)-1]` | `.pop()` | `v.pop()` |
| Slice / subrange | `arr.slice(1, 3)` | `array_slice($arr, 1, 2)` | `s[low:high]` | `arr[1:3]` | `&v[1..3]` |
| Sort | `.sort()` (in place) | `sort($arr)` | `sort.Ints(s)` | `.sort()` / `sorted(arr)` | `v.sort()` |
| Copy | `[...arr]` | `[...$a]` (spread 7.4+) | `slices.Clone(s)` | `arr.copy()` / `list(arr)` | `v.clone()` |

Each block performs the same list operations (push/append, pop, slice, sort). **When:** normalizing webhook list fields or batch IDs.—append, pop, slice/subrange, sort—so you can compare method names.

```javascript
// What: push, pop, slice, sort on a number array
// Why: in-place sort mutates—copy first if immutability matters
// When: in-memory batch processing in Node
// JavaScript — array ops
const nums = [1, 2, 3];
nums.push(4);
const last = nums.pop();
const mid = nums.slice(1, 3); // [2, 3]
nums.sort((a, b) => a - b);
```

```php
<?php
// PHP — indexed array (0, 1, 2 …)
$nums = [1, 2, 3];
array_push($nums, 4);
$last = array_pop($nums);
$mid = array_slice($nums, 1, 2);
sort($nums);
```

```go
// What: slice literal, append, sub-slice, sort
// Why: sub-slices alias backing array—copy if independent mutation needed
// When: batch chunk lists in retrieval workers
// Go — slice (growable); array [3]int has fixed length
nums := []int{1, 2, 3}
nums = append(nums, 4)
nums = nums[1:3] // sub-slice
sort.Ints(nums)
```

```python
# What: list append, pop, slice, in-place sort
# Why: lists are reference types—copy with list() or slice[:] if sharing is unsafe
# When: in-memory row batches in FastAPI services
# Python — list is the default ordered mutable sequence
nums = [1, 2, 3]
nums.append(4)
last = nums.pop()
mid = nums[1:3]
nums.sort()
```

```rust
let mut nums = vec![1, 2, 3];
nums.push(4);
nums.pop();
let mid = &nums[1..3];
nums.sort();
```

### Maps and dictionaries

Key–value lookup. **Missing keys:** JavaScript `undefined`; Go returns **zero value** + `ok`; PHP `null` or notice depending on config—prefer `isset` / `array_key_exists`; Python raises `KeyError`—prefer `.get()`.

| Operation | JavaScript | PHP | Go | Python | Rust |
|-----------|------------|-----|-----|--------|------|
| Literal | `{ id: 1 }` | `['id' => 1]` | `map[string]int{"a": 1}` | `{"a": 1}` | `HashMap::from([...])` |
| Set | `m[k] = v` | `$m['k'] = $v` | `m[k] = v` | `m[k] = v` | `m.insert(k, v)` |
| Get | `m[k]` / `m.get(k)` | `$m['k']` | `v := m[k]` | `m[k]` / `m.get(k, default)` | `m.get(&k)` → `Option` |
| Has key | `k in m` / `m.has(k)` | `isset($m['k'])` | `_, ok := m[k]` | `"k" in m` | `m.contains_key(&k)` |
| Delete | `delete m[k]` | `unset($m['k'])` | `delete(m, k)` | `del m["k"]` | `m.remove(&k)` |
| Keys | `Object.keys(m)` | `array_keys($m)` | `for k := range m` | `m.keys()` | `m.keys()` |

```javascript
// What: plain object vs Map for key lookup
// Why: Map preserves insertion order and any key type; objects coerce keys to strings
// When: dedup caches (Set) vs lookup tables (Map/object)
// JavaScript — object or Map
const byId = { u1: { name: "Ada" } };
byId.u2 = { name: "Bob" };
const map = new Map([["a", 1]]);
map.set("b", 2);
if (map.has("a")) {
  const v = map.get("a");
}
```

```php
<?php
// What: nested associative array for id lookup
// Why: isset before read avoids notices in strict configs
// When: webhook payload maps in Project 1
// PHP — associative array as map
$byId = ['u1' => ['name' => 'Ada']];
$byId['u2'] = ['name' => 'Bob'];
if (isset($byId['u1'])) {
    $name = $byId['u1']['name'];
}
$names = array_column($users, 'name');
```

```go
// What: map insert, comma-ok read, delete
// Why: missing keys return zero value—comma-ok distinguishes absent from zero
// When: score tables, id lookups in Project 8
// Go — comma-ok for missing keys
scores := map[string]int{"ada": 10}
scores["bob"] = 5
v, ok := scores["missing"]
if !ok {
    v = 0
}
delete(scores, "bob")
```

```python
# What: nested dict access with .get defaults
# Why: KeyError crashes request handlers—.get chains safely
# When: optional nested webhook fields
# Python — dict; .get avoids KeyError
by_id = {"u1": {"name": "Ada"}}
by_id["u2"] = {"name": "Bob"}
name = by_id.get("u1", {}).get("name")
if "u1" in by_id:
    del by_id["u1"]
```

```rust
use std::collections::HashMap;
let mut by_id: HashMap<&str, &str> = HashMap::new();
by_id.insert("u1", "Ada");
```

### Sets

**What:** Collections that enforce uniqueness. **Why:** Dedup caches and membership tests. **When:** Tracking seen webhook IDs or correlation tokens.

Unordered **unique** values. **PHP** has no first-class `Set`; use `array_unique`, `in_array`, or SPL `SplObjectStorage` for objects.

| Operation | JavaScript | PHP | Go | Python | Rust |
|-----------|------------|-----|-----|--------|------|
| Create | `new Set([1,2])` | `(array) array_unique($a)` | `map[int]struct{}{}` | `{1, 2}` | `HashSet::from([...])` |
| Add | `.add(x)` | `$seen[$x] = true` idiom | `s[x] = struct{}{}` | `.add(x)` | `s.insert(x)` |
| Has | `.has(x)` | `isset($seen[$x])` | `_, ok := s[x]` | `x in s` | `s.contains(&x)` |
| Delete | `.delete(x)` | `unset($seen[$x])` | `delete(s, x)` | `.discard(x)` / `.remove(x)` | `s.remove(&x)` |

```javascript
const seen = new Set(["a", "b"]);
seen.add("c");
if (seen.has("a")) {
  seen.delete("b");
}
```

```php
<?php
$unique = array_values(array_unique([1, 2, 2, 3]));
$seen = [];
$seen['a'] = true;
if (isset($seen['a'])) { /* member */ }
```

```go
// Go — empty struct values; no extra memory per entry
seen := make(map[string]struct{})
seen["a"] = struct{}{}
if _, ok := seen["a"]; ok { /* member */ }
delete(seen, "a")
```

```python
seen = {"a", "b"}
seen.add("c")
if "a" in seen:
    seen.discard("b")
```

```rust
use std::collections::HashSet;
let mut seen: HashSet<&str> = ["a", "b"].into_iter().collect();
seen.insert("c");
```

### Tuples and fixed-size pairs

**What:** Fixed-size groupings without defining a class. **Why:** Lightweight return pairs from functions. **When:** `(status, body)` rows or TypeScript `[code, label]` pairs.

Fixed-arity groupings without defining a class. **PHP:** use a small array `[id, name]` or a class/`readonly` DTO. **Go:** no tuple type—use a small struct.

| Idea | TypeScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| Pair | `[string, number]` | `[$id, $name]` | small struct `{ID string; N int}` | `(id, name)` tuple | `(String, i32)` or struct |
| Destructure | `const [a, b] = pair` | `[$id, $name] = $row` | explicit fields | `a, b = pair` | `let (a, b) = pair` |

```typescript
type StatusPair = [number, string];
const row: StatusPair = [200, "ok"];
const [code, label] = row;
```

```python
row = (200, "ok")
code, label = row
id, name = "u1", "Ada"  # also valid tuple unpacking
```

### Stack and queue idioms

**What:** Last-in-first-out (LIFO) stack and first-in-first-out (FIFO) queue patterns using lists. **Why:** Many languages lack dedicated stack types. **When:** Small in-memory buffers—not hot-path production queues.

Many languages use **array/list methods** instead of separate `Stack`/`Queue` types for simple cases.

| Pattern | JavaScript | PHP | Go | Python | Rust |
|---------|------------|-----|-----|--------|------|
| Stack (LIFO) | `push` / `pop` | `array_push` / `array_pop` | `append` / trim last | `.append` / `.pop()` | `Vec::push` / `pop` |
| Queue (FIFO) | `push` / `shift` | `array_push` / `array_shift` | slice + copy front (or channel) | `collections.deque` | `VecDeque` |

```javascript
// What: array-as-stack and array-as-queue
// Why: shift() is O(n)—use deque pattern in hot paths
// When: small in-memory buffers only
// Stack
const stack = [];
stack.push(1);
stack.pop();

// Queue (FIFO) — shift is O(n) on array; Deque in production
const queue = [];
queue.push(1);
queue.shift();
```

```php
<?php
array_push($stack, 1);
array_pop($stack);
array_push($queue, 1);
array_shift($queue);
```

```python
from collections import deque

stack = []
stack.append(1)
stack.pop()

queue = deque()
queue.append(1)
queue.popleft()
```

### Choosing at a glance

| You need | Reach for | Example |
|----------|-----------|---------|
| Stable **order**, index access | Array / list / slice | `[users[0], users[1]]` |
| Fast **lookup by key** | Map / dict | `byId[userId]` |
| **Unique** membership | Set / map keys | `seen.has(id)` |

For **time/space tradeoffs** and interview structures (heap, tree, graph), see [Algorithms and data structures](../concepts/algorithms-and-data-structures.md#data-structures). For **relational data**, see [SQL stack](sql.md).

---

## Operators and expressions

**What:** Arithmetic, comparison, logical, assignment, null-safe access, and increment idioms.

**Why:** `==` vs `===`, PHP juggling, Python `//`, and JS `??` vs `||` cause integration bugs at validation boundaries.

**When:** Writing conditionals, default values, and config parsing in any stack.

Operators combine values into expressions. Watch **integer division**, **null-safe access**, and languages that **forbid** `++` on primitives (Go, Python).

| Category | JavaScript | TypeScript | PHP | Go | Python | Rust |
|----------|------------|------------|-----|-----|--------|------|
| Arithmetic | `+ - * / % **` | same | same | same | same; `//` floor div | same |
| Compare | `===` `!==` `<` | same | `==` loose · `===` strict | `==` `!=` (typed) | `==` value · `is` identity | `==` via `PartialEq` |
| Logical | `&&` `\|\|` `!` | same | `and` `or` `!` (also `&&`) | `&&` `\|\|` `!` | `and` `or` `not` | `&&` `\|\|` `!` |
| Assign | `=` `+=` | same | `.=` | `=` `:=` (declare) | `=` `+=` | `=` · `let mut` |
| Null-safe | `?.` `??` | same | `?->` `??` (since 7.0) | — (explicit checks) | — (explicit checks) | `Option` + `match` |
| Increment | `++` `--` | same | `++` `--` | none (`i++` invalid) | none (`+= 1`) | none (`+= 1`) |

**JavaScript** — nullish coalescing (`??`) only replaces `null`/`undefined`; logical OR (`||`) treats all falsy values as missing.

```javascript
// What: defaults and optional chaining
// Why: ?? avoids treating 0 or "" as "missing" when they are valid
// When: config/env parsing in Project 7
// JavaScript — nullish coalescing vs logical OR
const timeout = config.ms ?? 3000; // only null/undefined
const label = user.name || "guest"; // any falsy triggers default
const city = user.address?.city;
```

**PHP** — use `===` in integration conditionals; null coalesce and nullsafe operator reduce nested isset checks.

```php
<?php
// What: strict status check and safe nested access
// Why: == juggling breaks webhook validation
// When: Project 1 payload guards
// PHP — strict compare for safety in conditionals
if ($status === 200) { }
$timeout = $config['ms'] ?? 3000;
$city = $user?->address?->city;
```

```go
// Go — no ternary; short-circuit && and ||
if n > 0 && total/n > limit { }
```

**Python** — no `++` operator; use `+= 1`. Floor division `//` for integer division.

```python
# What: integer half and default timeout
# Why: or vs get(key, default) differ when 0 is valid
// When: batch sizing and config in Project 2
# Python — no ++; floor division with //
half = count // 2
timeout = config.get("ms") or 3000  # or: config.get("ms", 3000)
```

---

## Conditionals and branching

**What:** `if`/`else`, `switch`, `match`, ternary (where supported), and default-value patterns.

**Why:** Fall-through `switch`, PHP `match` strictness, and Go’s lack of ternary all affect how you spell status-code dispatch.

**When:** HTTP status mapping, feature flags, and enum-like dispatch.

Branch when logic diverges. **`switch`** (C-family) often **falls through** unless you `break`; **`match`** (PHP 8+, Python 3.10+) is usually **expression-oriented** and strict.

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| if / else | `if (x) { } else { }` | `if ($x) { }` | `if x { }` (no parens required) | `if x:` / `elif` / `else:` | `if x { } else { }` |
| switch | `switch (x) { case 1: ... }` | `switch ($x)` · `match` (8.0+) | `switch x { case 1: }` | `match x:` (3.10+) | `match` exhaustive |
| Ternary | `a ? b : c` | `$a ? $b : $c` | no ternary — use `if` | `b if cond else c` | no ternary — `if` expr |
| Elvis / default | `??` | `?:` | — | `or` / `if not` patterns | `unwrap_or` · `Option` |

**JavaScript** — `switch` falls through without `break`; easy to accidentally run multiple cases.

```javascript
// What: HTTP status to label mapping
// Why: break prevents fall-through into the next case
// When: legacy JS handlers—prefer object maps or TS discriminated unions in new code
// JavaScript — switch needs break to avoid fall-through
switch (status) {
  case 200:
    return "ok";
  case 404:
    return "missing";
  default:
    return "other";
}
```

```php
<?php
// What: expression-oriented match on status code
// Why: match is strict—no fall-through bugs like switch
// When: mapping HTTP/partner status codes in Laravel
// PHP — match (8.0+) is expression-like and strict
$label = match ($status) {
    200 => 'ok',
    404 => 'missing',
    default => 'other',
};
```

```python
# What: structural match on status integer
# Why: cleaner than long if/elif chains for enums
# When: Python 3.10+ services
# Python — match (3.10+) for structural patterns for structural patterns
match status:
    case 200:
        label = "ok"
    case 404:
        label = "missing"
    case _:
        label = "other"
```

```rust
let label = match status {
    200 => "ok",
    404 => "missing",
    _ => "other",
};
```

---

## Loops and iteration

**What:** Index loops, foreach/for-in, `while`, and `break`/`continue` across languages.

**Why:** Manual indexing on sparse PHP arrays and `for...in` on JS objects are common footguns—prefer collection iterators when available.

**When:** Processing webhook batch rows, queue messages, or paginated API pages.

Loops repeat work over **ranges**, **conditions**, or **collections**. Prefer **foreach / for-in** over manual indexing when the language supports it—fewer off-by-one bugs.

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| C-style for | `for (let i=0; i<n; i++)` | `for ($i=0; $i<$n; $i++)` | `for i := 0; i < n; i++` | `for i in range(n):` | `for i in 0..n` |
| foreach / for-in | `for (const x of arr)` | `foreach ($arr as $x)` | `for _, v := range slice` | `for x in items:` | `for x in &items` |
| while | `while (cond)` | `while ($cond)` | `for cond { }` (only loop keyword) | `while cond:` | `while cond { }` |
| break / continue | `break` `continue` | same | same | same | `break` `continue` |

**JavaScript** — `for...of` iterates values; `for...in` on objects iterates keys (often not what you want on arrays).

```javascript
// What: skip flagged users and log names
// Why: for...of avoids manual index bugs
// When: processing webhook batch arrays in Node
// JavaScript — for...of (values) vs for...in (keys on objects)
for (const user of users) {
  if (user.skip) continue;
  console.log(user.name);
}
for (const key of Object.keys(map)) { /* ... */ }
```

```php
<?php
// PHP — foreach with key => value on associative arrays
foreach ($byId as $id => $row) {
    if ($row['skip'] ?? false) {
        continue;
    }
    echo $row['name'];
}
```

```go
// Go — for is the only loop; range over slice and map
for i, name := range names {
    _ = i
    _ = name
}
for k, v := range scores {
    _ = k
    _ = v
}
```

```python
# What: ## Loops and iteration — for user in users:
# Why: compare spelling when translating between stacks
# When: active lab cross-stack translation
for user in users:
    if user.get("skip"):
        continue
    print(user["name"])

for i, name in enumerate(names):
    pass

for key, value in scores.items():
    pass
```

```rust
// What: ## Loops and iteration — for user in &users {
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
for user in &users {
    if user.skip { continue; }
    println!("{}", user.name);
}
```

---

## Modules, imports, and packages

**What:** How code is split into files, how names are exported, and how imports resolve.

**Why:** ESM vs CommonJS (CJS), Go module paths, PHP PSR-4 autoload, and Python package layout break CI when cwd or `"type": "module"` is wrong.

**When:** Starting a lab, adding a shared helper, or fixing "cannot find module" errors.

**Modules** group code for reuse. Path rules differ: Node **file paths**, Go **module path in go.mod**, PHP **namespaces + Composer autoload**, Python **packages + `__init__.py`**.

| Idea | JavaScript / TS | PHP | Go | Python | Rust |
|------|-----------------|-----|-----|--------|------|
| Export | `export { fn }` · `export default` | `namespace` + autoload PSR-4 | Capitalized identifiers | module-level names; `__all__` | `pub fn` · `pub mod` |
| Import | `import { fn } from "./file.js"` | `use App\\Models\\User;` | `import "example.com/pkg"` | `from pkg import fn` | `use crate::...` |
| Entry | `package.json` `"type":"module"` | `composer.json` autoload | `package main` + `go.mod` | `if __name__ == "__main__":` | `fn main()` + `Cargo.toml` |

**JavaScript (ECMAScript modules / ESM)** — explicit `.js` extensions often required in Node ESM.

```javascript
// What: import and re-export a local helper
// Why: ESM resolution differs from CommonJS require
// When: Project 7 with "type": "module"
// JavaScript (ESM) — explicit .js extension often required in Node
import { parseTimeoutMs } from "./parse.js";
export { parseTimeoutMs };
```

```php
<?php
// What: namespace declaration and use imports
// Why: PSR-4 autoload maps namespace to directory
// When: any Laravel controller or job class
namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
```

```go
// What: package main with stdlib imports
// Why: import path comes from go.mod module path
// When: every Go binary entry in Project 8
// Go — module path + package name per directory
package main

import (
    "fmt"
    "net/http"
)
```

```python
from dataclasses import dataclass
from pathlib import Path

# Relative imports within a package:
# from .utils import parse_timeout_ms
```

```rust
mod utils;
use crate::utils::parse_timeout_ms;
```

---

## Enums, unions, and pattern matching

**What:** Named constant sets, union/sealed types, and dispatch with `switch`/`match`.

**Why:** Go uses `iota` constants—not sum types—while Rust and modern PHP/Python prefer exhaustive `match`.

**When:** Modeling webhook status, job state, or API result variants.

**Enums** name a fixed set of variants. **Union types** (TS) and **match** (PHP, Python) model “one of several shapes” and dispatch safely.

| Idea | JavaScript / TS | PHP | Go | Python | Rust |
|------|-----------------|-----|-----|--------|------|
| Named constants | `const enum`-like objects | `enum Status: string` (8.1+) | `const` + `iota` | `class Status(Enum):` | `enum Status { Ok, Failed }` |
| Union / sealed | `type R = A \| B` | limited | interface + types | `Union` / `TypedDict` | `enum` variants |
| Dispatch | `switch` / `if` | `match` | `switch` | `match` / `if`/`elif` | `match` preferred |

**TypeScript** — discriminated unions let the compiler narrow types after an `if` check.

```typescript
// What: Result-shaped union with ok flag
// Why: invalid states become unrepresentable at compile time
// When: API client responses in Project 7
// TypeScript — union + narrowing
type Result = { ok: true; data: string } | { ok: false; error: string };

function handle(r: Result) {
  if (r.ok) {
    return r.data;
  }
  return r.error;
}
```

```php
<?php
enum Status: string {
    case Ok = 'ok';
    case Failed = 'failed';
}
```

```go
// Go — iota for consecutive constants (not a sum type)
const (
    StatusPending = iota
    StatusOK
    StatusFailed
)
```

```python
from enum import Enum

class Status(str, Enum):
    OK = "ok"
    FAILED = "failed"
```

---

## Generics and type parameters

**What:** Type parameters (`<T>`) so one function or struct works for many types safely.

**Why:** Static stacks catch misuse at compile time; PHP has no reified generics; Python generics are mainly for checkers.

**When:** Shared list helpers, repositories, or containers before copy-pasting per-type code.

**Generics** let one implementation work for many types while staying type-safe. PHP has **no reified generics** in the application language; Go added generics in **1.18+**; Python generics are primarily for static checkers.

**Key takeaway:** Statically typed stacks catch type errors before deploy; dynamic stacks rely on tests and optional checkers (mypy, TypeScript `strict`).

**At a glance (Rust · Python · JavaScript · Go · PHP):** Each line creates a three-element ordered sequence—the most common literal in that language.

```rust
// What: ## Generics and type parameters — fn add(a: i32, b: i32) -> i32 { a + b }
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
fn add(a: i32, b: i32) -> i32 { a + b }
```

```python
# What: ## Generics and type parameters — def add(a, b):
# Why: compare spelling when translating between stacks
# When: active lab cross-stack translation
def add(a, b):
    return a + b
```

```javascript
// What: ## Generics and type parameters — function add(a, b) {
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
function add(a, b) {
  return a + b;
}
```

```go
// What: ## Generics and type parameters — func add(a int, b int) int { return a + b }
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
func add(a int, b int) int { return a + b }
```

```php
<?php
// What: ## Generics and type parameters — 
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
function add(int $a, int $b): int { return $a + $b; }
```

**TypeScript:** `function add(a: number, b: number): number { return a + b; }` — see [Type systems beyond annotations](#type-systems-beyond-annotations) for `strictNullChecks` and generics.

| Idea | TypeScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| Parameter | `<T>` on fn/type | — | `[T any]` | `def first[T](items: list[T])` (3.12+) | `<T>` on fn/struct |
| Constraint | `extends` / `keyof` | — | `comparable`, interfaces | `TypeVar` with bound | trait bounds · `where` |
| Erasure | types erased at emit | — | monomorphized at compile | erased at runtime | monomorphized at compile |

```typescript
// What: generic function returning first element or undefined
// Why: reuse one helper for any element type
// When: shared array utilities in strict TS
function first<T>(items: T[]): T | undefined {
  return items[0];
}
```

```go
// What: generic First with zero value on empty slice
// Why: (T, bool) mirrors comma-ok map pattern
// When: reusable slice helpers post–Go 1.18
// Go 1.18+ — type parameters on functions and types
func First[T any](items []T) (T, bool) {
    if len(items) == 0 {
        var zero T
        return zero, false
    }
    return items[0], true
}
```

```python
from typing import TypeVar

T = TypeVar("T")

def first(items: list[T]) -> T | None:
    return items[0] if items else None
```

**Related:** [Type systems beyond annotations](#type-systems-beyond-annotations)

---

## Strings, formatting, and destructuring

**What:** String templates, slicing, and unpacking objects/arrays into bindings.

**Why:** UTF-8 byte slicing in Go, PHP `$var` interpolation, and JS spread/destructure appear in every log line and DTO mapping.

**When:** Building log messages, merging config objects, or unpacking API rows.

**Interpolation** embeds values in strings; **destructuring** pulls fields or elements into bindings in one step.

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| Interpolation | `` `hi ${name}` `` | `"hi $name"` · `"hi {$name}"` | `fmt.Sprintf("hi %s", name)` | `f"hi {name}"` | `format!("hi {}", name)` |
| Substring / slice | `s.slice(0, 3)` | `substr` / `mb_substr` | `s[0:3]` bytes (UTF-8 care) | `s[0:3]` | `&s[0..3]` |
| Destructure | `const { id } = user` | `[$a, $b] = $pair` · `list()` | explicit fields | `a, b = pair` · `**kwargs` | struct destructuring |

**JavaScript** — destructuring unpacks objects/arrays; spread merges shallow copies.

```javascript
// What: pull fields, rest, and merge config objects
// Why: concise DTO mapping at HTTP boundaries
// When: mapping partner JSON to internal shapes
// JavaScript — object and array destructuring + spread
const { id, name } = user;
const [head, ...rest] = ids;
const merged = { ...defaults, ...overrides };
```

```php
<?php
// What: array destructuring into variables
// Why: unpack CSV/API rows without manual index access
// When: Laravel jobs processing tabular partner data
// PHP — list destructuring; spread in arrays (7.4+)
[$first, $second] = $parts;
['id' => $id, 'name' => $name] = $row;
```

```python
# What: tuple unpack, starred rest, dict merge
# Why: `{**a, **b}` shallow-merges config layers
# When: merging defaults with request overrides
# Python — unpacking and dict merge
id, name = user.id, user.name
head, *rest = ids
merged = {**defaults, **overrides}
```

---

## Scope, blocks, and casting

**What:** Where names are visible, legacy hoisting, and runtime type conversion.

**Why:** JS `var` hoisting, TDZ (temporal dead zone) on `let`, and Go type assertions on `interface{}` values trip up refactors.

**When:** Refactoring legacy JS, parsing query params, or narrowing unknown JSON fields.

**Block scope** limits where a name is visible. **Casting** converts between types at runtime—prefer type-safe patterns (generics, guards, `isinstance`) when the language offers them.

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| Block scope | `{ let x = 1 }` | `{ $x = 1 }` | `{ x := 1 }` | indentation block | `{ let x = 1; }` |
| Hoisting | `var`/`function` hoisted | — | — | — | — |
| Cast / assert | `Number(x)` · `String(x)` | `(int)$x` | `v, ok := x.(Type)` | `int(x)` · `isinstance(x, str)` | `x as i32` · `downcast` |

**JavaScript** — `let`/`const` are block-scoped; `var` is function-scoped (legacy).

```javascript
// What: block-local binding and parseInt
// Why: var hoisting causes subtle bugs—prefer let/const
// When: any new JS/TS code in this playbook
// JavaScript — let/const block-scoped; var function-scoped (legacy)
function demo() {
  if (true) {
    let local = 1;
  }
  // local not visible here
}
const n = Number.parseInt(raw, 10);
```

```php
<?php
$count = (int) $raw;
$value = is_string($x) ? $x : (string) $x;
```

```go
// Go — type assertion on interface values
if s, ok := v.(string); ok {
    _ = s
}
```

```python
count = int(raw)
if isinstance(value, str):
    name = value
```

---

## Error handling

**What:** How each language signals expected failures—returned errors, exceptions, `Result`, and panics.

**Why:** Swallowed errors poison queues; boundaries must map failures to HTTP status, logs, or dead-letter queue (DLQ) policy.

**When:** Every HTTP handler, worker job, and CLI entrypoint—before shipping integration code.

Same lesson everywhere: distinguish **expected failures** (network down, bad user input) from **programmer bugs** (null deref). Spelling falls into **returned errors** or **exceptions**.

**Key takeaway:** Expected failures are explicit at the boundary—`Result` or checked `error` in Go/Rust, caught exceptions in JavaScript/Python/PHP—with no swallowed errors.

**At a glance (Rust · Python · JavaScript · Go · PHP):** Each line creates a three-element ordered sequence—the most common literal in that language.

```rust
// What: ## Error handling — fn div(a: i32, b: i32) -> Result<i32, String> {
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
fn div(a: i32, b: i32) -> Result<i32, String> {
    if b == 0 {
        Err("divide by zero".into())
    } else {
        Ok(a / b)
    }
}
```

```python
# What: ## Error handling — try:
# Why: compare spelling when translating between stacks
# When: active lab cross-stack translation
try:
    1 / 0
except ZeroDivisionError:
    print("nope")
```

```javascript
// What: ## Error handling — try {
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
try {
  throw new Error("nope");
} catch (e) {
  console.log(e);
}
```

```go
// What: ## Error handling — if err != nil {
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
if err != nil {
    return err
}
```

```php
<?php
// What: ## Error handling — 
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
try {
    throw new Exception("nope");
} catch (Exception $e) {
    // handle
}
```

**TypeScript:** use `catch (e: unknown)` and narrow before reading `.message`.

**PHP → Go hint:** Laravel exception handler maps to JSON; Go worker returns `(T, error)` up to the HTTP handler—same idempotency story, different spelling ([Project 6](../../archive/v1-22-step/career-project-specs/06-async-worker-stretch.md)).

### Comparison

| Style | Languages | Mental model |
|-------|-----------|--------------|
| Return + check | Go `(T, error)`, Rust `Result<T,E>` + `?` | Caller must handle every time |
| Exceptions | JS, PHP, Python | Throw up the stack; catch at boundary |
| Mixed | TypeScript (same as JS) | Typed catches; `unknown` in catch |
| Panic | Rust (libraries avoid) | Unwind on bug—use `Result` at service boundaries |

### Go — returned `error`

**What:** Check every `(T, error)` return before using `T`. **Why:** Ignored errors fail silently in workers. **When:** All Go HTTP and queue code.

```go
// What: HTTP client call with mandatory err check
// Why: network failures must not proceed with nil response
// When: Project 8 retrieval gateway
resp, err := client.Do(req)
if err != nil {
    fmt.Fprintf(os.Stderr, "request failed: %v\n", err)
    os.Exit(1)
}
defer resp.Body.Close()
```

### TypeScript — `try/catch` around `fetch`

**What:** Wrap async I/O that rejects on failure. **Why:** Unhandled rejections crash Node processes. **When:** Outbound partner calls with timeout.

```typescript
// What: fetch with AbortSignal timeout in try/catch
// Why: narrow err before reading .message
// When: Project 7 integration probes
try {
  const response = await fetch(url, { signal: AbortSignal.timeout(3000) });
} catch (err) {
  console.error(
    `request failed: ${err instanceof Error ? err.message : String(err)}`
  );
  process.exit(1);
}
```

### PHP — exceptions + HTTP helpers

**What:** Parse JSON with throw-on-error flag; catch at controller boundary. **Why:** Invalid payloads become 422, not 500. **When:** Project 1 webhook body parsing.

```php
// What: json_decode with JSON_THROW_ON_ERROR
// Why: catch JsonException and return structured 422
// When: Laravel API ingress
try {
    $payload = json_decode($json, true, flags: JSON_THROW_ON_ERROR);
} catch (JsonException $e) {
    report($e);
    return response()->json(['ok' => false], 422);
}
```

### Python — `try` / `except`

**What:** Catch specific exceptions; chain with `raise ... from e` for traceability. **Why:** Bare except hides root cause. **When:** FastAPI services parsing partner JSON.

```python
# What: json.loads with decode error handling
# Why: log and re-raise as domain ValueError
# When: Project 2 payload normalization
try:
    payload = json.loads(raw)
except json.JSONDecodeError as e:
    logger.exception("invalid json")
    raise ValueError("invalid payload") from e
```


### Rust — `Result` and `?`

**What:** `?` propagates `Err` up the call stack. **Why:** Same boundary discipline as Go—map to HTTP 500 or DLQ at the edge. **When:** Project 18 HTTP client code.

```rust
// What: async HTTP get with ? propagation
// Why: do not unwrap in workers—panics poison tasks
// When: after sync Rust path is green
let resp = client.get(url).send().await?;
let body = resp.text().await?;
// ? propagates Err; map to HTTP 500 or dead-letter queue (DLQ) at boundary
```

**Transferable takeaway:** Pick the boundary (HTTP handler, CLI `main`, worker job) where failures become **user-visible messages** or **logged errors**—regardless of language spelling.

**Related:** [Error philosophy and control flow](#error-philosophy-and-control-flow) · [Cross-language gotchas](#cross-language-gotchas-interview-favorites)

---

## Null, optionals, equality, and truthiness

**What:** Absent values (`null`, `None`, `nil`, `Option`), equality rules, and truthy/falsy checks.

**Why:** `"0"` is truthy in JS but falsy in PHP `empty()`; Go typed-nil interfaces; Python `is None` vs `== None`.

**When:** Validating webhook fields, optional config, and API query parameters.

### Null and optional patterns

| Language | Typical pattern |
|----------|-----------------|
| JavaScript | `null` vs `undefined`; optional chaining `obj?.x` |
| TypeScript | `strictNullChecks`: `string \| undefined`, props `url?` |
| PHP | `null`; coalesce `??`; typed `?string` |
| Go | Pointer `nil`; no generic optional type |
| Python | `None`; test with `is None` (not `== None`) |
| Rust | `Option<T>` (`Some`/`None`); no null in safe code |

**TypeScript** — optional properties need explicit guards when `strictNullChecks` is on.

```typescript
// What: require url when property is optional on type
// Why: strictNullChecks catches missing fields at compile time
// When: Project 7 request DTO validation
// TypeScript — optional property + guard
type Probe = { url?: string };
function endpoint(p: Probe): string {
  if (!p.url) throw new Error("url required");
  return p.url;
}
```

```python
# Python — None is a singleton; use `is`
def endpoint(url: str | None) -> str:
    if url is None:
        raise ValueError("url required")
    return url
```

### Equality gotchas

| Language | Gotcha |
|----------|--------|
| **JavaScript** | `===` vs `==` (coercion)—prefer `===` |
| **PHP** | **Type juggling** with `==`; use `===` for strict |
| **Python** | `is` vs `==` (`is` for identity, e.g. `None`) |
| **Go** | `==` works on comparable types; slices/maps not comparable with `==` |
| **Rust** | `PartialEq`; no truthiness—use `match` / `if let` |

```javascript
// JavaScript
if (x === null) { }
if (a === b) { }
```

```php
<?php
// What: loose vs strict equality demonstration
// Why: == juggling is the #1 PHP integration footgun
// When: code review—replace with === in new code
var_dump("1" == 1);  // true  — juggling
var_dump("1" === 1); // false — strict
```

```python
# What: identity check for None and value equality
# Why: is None is correct; == for value comparison
# When: optional fields in FastAPI models
if x is None:
    pass
if a == b:
    pass
```

### Truthiness

Know each language’s **falsy** set before writing `if (value)`:

| Language | Falsy examples |
|----------|----------------|
| JavaScript | `0`, `""`, `NaN`, `null`, `undefined`, `false` |
| PHP | `false`, `0`, `0.0`, `""`, `"0"`, `[]`, `null` |
| Python | `False`, `None`, `0`, `""`, empty containers |
| Go | only `false` for booleans; `if` requires bool—no truthy ints |
| Rust | only `false` in `if`; explicit `Option`/`Result` handling |

---

## Async and concurrency (fundamentals)

**What:** Language syntax for overlapping work—Promises, goroutines, asyncio, Rust async, PHP queues.

**Why:** Wrong model (blocking CPU on the Node event loop, unbounded goroutines, sync work inside `async def`) collapses throughput under load.

**When:** HTTP fan-out, queue workers, and any lab touching Project 6/8/7 concurrency paths.

This section is **syntax and models** only. Operational concurrency (thread pools, backpressure, queue workers) lives in [Software engineering — Concurrency basics](../concepts/software-engineering.md#concurrency-basics) and [Concurrency beyond syntax](#concurrency-beyond-syntax).

**Key takeaway:** Match the concurrency model to the work—asynchronous I/O for network waits, bounded worker pools for CPU, queues when the HTTP response must return immediately.

**At a glance — concurrency models (compare how each runtime starts overlapping work): (Rust · Python · JavaScript · Go · PHP):**

```rust
// What: ## Async and concurrency (fundamentals) — use std::sync::mpsc;
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
use std::sync::mpsc;
use std::thread;

let (tx, rx) = mpsc::channel();
thread::spawn(move || tx.send(42).unwrap());
println!("{}", rx.recv().unwrap());
```

```python
# What: ## Async and concurrency (fundamentals) — import asyncio
# Why: compare spelling when translating between stacks
# When: active lab cross-stack translation
import asyncio

async def main():
    await asyncio.sleep(1)
    print("done")

asyncio.run(main())
```

```javascript
// What: ## Async and concurrency (fundamentals) — setTimeout(() => console.log("done"), 1000);
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
setTimeout(() => console.log("done"), 1000);
```

```go
// What: ## Async and concurrency (fundamentals) — ch := make(chan int)
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
ch := make(chan int)
go func() { ch <- 42 }()
fmt.Println(<-ch)
```

**PHP** — typical web requests run synchronously under PHP-FPM (FastCGI Process Manager); long work goes to Laravel queues.

```php
<?php
// What: dispatch job instead of in-request work
// Why: FPM request thread must return quickly to the client
// When: Project 1 webhook ack + async processing
// Playbook default: queue long work (Laravel Horizon)—not in-request async
dispatch(new ProcessWebhookJob($payload));
// Stretch: PHP 8 Fibers / Swoole—optional, not FPM default
```

**At a glance — async spelling (how each language writes async functions): (items 3 & 7):**

```rust
async fn fetch() { /* .await in tokio */ }
```

```python
async def fetch(): ...
```

```javascript
async function fetch() {}
```

```go
go doWork() // no async/await — goroutines + channels
```

```php
<?php
// What: ## Async and concurrency (fundamentals) — 
// Why: compare spelling when translating between stacks
// When: active lab cross-stack translation
dispatch(new ProcessWebhookJob($payload)); // async by queue, sync in FPM request
```

| Lang | Model | Typical spelling |
|------|--------|------------------|
| **JavaScript** | Event loop; Promises; `async`/`await` | `await fetch(url)` |
| **TypeScript** | Same as JS + typed `Promise<T>` | `async function run(): Promise<void>` |
| **PHP** | Often **sync per request** (PHP-FPM — FastCGI Process Manager); queues/Octane for async work | `dispatch(new Job($payload))` |
| **Go** | Goroutines + channels; `go fn()` | `go worker()` · `context` for cancel |
| **Python** | `asyncio` coroutines | `async def` · `await` · `asyncio.run()` |
| **Rust** | `async`/`await` + **tokio** (after sync path) | `async fn` · `.await` · `#[tokio::main]` |

**Integration note:** bounded HTTP with timeout—`await fetch(url, { signal: AbortSignal.timeout(3000) })` in Node/TS; `context.WithTimeout` in Go handlers.

**Related:** [Concurrency beyond syntax](#concurrency-beyond-syntax) · [Lazy evaluation](#lazy-evaluation-generators-and-iterators)

---

## Advanced concepts (cross-stack)

**What:** Deeper cross-stack topics—immutability, capture, generators, memory models, type edges, error philosophy, functional idioms, metaprogramming, production concurrency.

**Why:** These are the translation gaps senior reviews focus on when you move a pattern from Laravel to Go or FastAPI to TypeScript.

**When:** During an active lab when syntax tables are not enough—not as a first read before building.

**Purpose:** Curated **translation reference** for advanced language features—generators, ownership, type-system edges, error philosophy, metaprogramming—when you move between stacks during an active lab. Not a parallel language course—each topic ties to a playbook project.

**How to use:** Skim the comparison table for the concept you need, read the gotchas, then **apply** in your active project from [README.md](../../README.md#roadmap). data structures and algorithms (DS&A) theory stays in [Algorithms and data structures](../concepts/algorithms-and-data-structures.md); delivery patterns stay in [Software engineering](../concepts/software-engineering.md).

### Immutability and value vs reference

**What:** Whether assignment copies data, moves ownership, or creates an alias to shared storage.

**Why:** Accidental mutation through aliases causes cross-request bugs and stale slice views in workers.

**When:** Passing collections between functions, goroutines, or request handlers.

**Key takeaway:** Know whether an assignment copies, moves, or aliases shared data—accidental mutation of aliased collections causes cross-request bugs.

**At a glance (Rust · Python · JavaScript · Go · PHP):** Same aliasing demo—mutate through one binding and observe the other.

```rust
let x = 5;
// x = 6; // error: cannot assign to immutable variable
let mut y = 5;
y = 6; // ok
```

```python
a = [1, 2]
b = a
b.append(3)
print(a)  # [1, 2, 3] — same object
```

```javascript
let a = { x: 1 };
let b = a;
b.x = 2;
console.log(a.x); // 2 — object by reference
```

```go
s := []int{1, 2}
t := s
t[0] = 99
fmt.Println(s[0]) // 99 — slice shares backing array
```

```php
<?php
$a = [1, 2];
$b = $a;
$b[0] = 99;
print_r($a); // [1, 2] — copy-on-write until mutate
```

**TypeScript:** same reference semantics as JavaScript; `readonly` and `Readonly<T>` help at compile time.

**PHP → Go hint:** Laravel passes arrays by copy-on-write; Go slices always share backing storage until you copy—plan for aliasing in [Project 8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md).

| Lang | Default for objects/collections | Copy vs move | Shared state gotcha |
|------|--------------------------------|--------------|---------------------|
| **JavaScript** | Objects/arrays by **reference** | Shallow copy: `{...obj}`, `[...arr]` | Mutating nested fields affects all aliases |
| **TypeScript** | Same as JS | Same | Same |
| **PHP** | **Copy-on-write** on arrays (assign shares until one side mutates) | `array_merge`, spread `[...$a]` copies top level | `$a + $b` reindexes numeric keys—use `array_merge` |
| **Go** | Slices/maps are **reference headers** to backing store | Assignment copies header, not data | Sub-slices share backing array |
| **Python** | Names bind to objects; assignment **rebinds** | `copy.copy` / `copy.deepcopy` | Mutable default args share one list |
| **Rust** | **Move** by default; `Copy` types duplicate bits | `.clone()` explicit; borrow with `&` | No shared mutable state without `Arc<Mutex<_>>` etc. |

| Lang | Gotcha |
|------|--------|
| **JavaScript** | `const obj = {}` prevents rebinding, not inner mutation |
| **Go** | `append` may reallocate—old slice may still view stale backing |
| **Python** | `def f(x=[])` — one list reused across calls |
| **Rust** | Fighting borrow checker with `.clone()` everywhere—often wrong fix |
| **PHP** | `$a + $b` on arrays **reindexes** numeric keys; use `array_merge` for concat |

**Related:** [Ownership and memory models](#ownership-borrowing-and-memory-models) · [Built-in data structures](#built-in-data-structures)

**Apply in:** [Project 18](../../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md) (clone vs borrow) · [Project 8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md) (slice aliasing).

---

### Closures and capture gotchas

**What:** How closures capture loop variables—not just outer function parameters.

**Why:** Classic source of duplicate jobs, wrong indices, and goroutines printing the same value.

**When:** Spawning async work or timers inside loops.

**Key takeaway:** Closures capture their environment—loop variables and late binding fail unless you bind a fresh value each iteration.

Beyond [Closures (fundamentals)](#closures-functions-that-capture-surroundings)—how capture behaves in **loops** and **late binding**.

**At a glance (Rust · Python · JavaScript · Go · PHP):** Each line creates a three-element ordered sequence—the most common literal in that language.

```rust
let mut x = 10;
let add = |n| x + n;
println!("{}", add(5));
```

```python
funcs = []
for i in range(3):
    funcs.append(lambda: i)
print([f() for f in funcs])  # [2, 2, 2] — late binding
```

```javascript
// Fix — use let (block-scoped per iteration)
for (let i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 0); // 0, 1, 2
}
```

```go
// Wrong (pre-Go 1.22) — prints 3,3,3
for i := 0; i < 3; i++ {
    go func() { fmt.Println(i) }()
}
// Fix: i := i inside loop, or Go 1.22+ per-iteration scope
```

```php
<?php
$i = 10;
$fn = function () use ($i) { echo $i; };
$fn();
```

| Lang | Capture model | Loop gotcha |
|------|---------------|-------------|
| **JavaScript** | Lexical; `let` per iteration in `for` | `var` in loop → all closures share **final** `i` |
| **TypeScript** | Same as JS | Same |
| **PHP** | Copy-by-value in `foreach` (objects by handle) | `use ($i)` in closure—bind explicit vars |
| **Go** | Loop variable reused until Go 1.22 (`:=` in loop body fixes) | `go func() { fmt.Println(i) }()` sees last `i` pre-1.22 |
| **Python** | Late binding in lambdas in loops | `[lambda: i for i in range(3)]` — all return `2`; fix: `lambda i=i: i` |
| **Rust** | `move` closure takes ownership; borrow rules apply | Capture `i` by move in loop: `let i = i` per iter |

| Lang | Gotcha |
|------|--------|
| **JavaScript** | Classic **Wrong:** `for (var i=0; …)` + `setTimeout(() => i)` |
| **Go** | **Fix:** Pass `i := i` or use Go 1.22+ `for i := range` scope |
| **Python** | Default arg trick: `lambda i=i: i` to bind early |
| **Rust** | `move \|\|` may force `.clone()` on captured data |

**Related:** [Cross-language gotchas](#cross-language-gotchas-interview-favorites)

**Apply in:** [Project 7](../../archive/v1-22-step/career-project-specs/07-node-typescript-lab.md) · [Project 8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md) (goroutines in loops).

---

### Lazy evaluation: generators and iterators

**What:** Producing values one at a time instead of building a full in-memory list.

**Why:** Bounded memory for paginated APIs and large ingest pipelines.

**When:** Walking partner pages, CSV rows, or RAG chunk streams.

**Key takeaway:** Stream or paginate large datasets instead of loading everything into memory—generators and iterators are single-pass unless you call `list()` or `.collect()` on purpose.

**At a glance (Rust · Python · JavaScript · Go · PHP):** Each line creates a three-element ordered sequence—the most common literal in that language.

```rust
(1..=5).map(|x| x * 2).for_each(|x| println!("{x}"));
```

```python
def gen():
    for i in range(5):
        yield i
```

```javascript
function* gen() {
  for (let i = 0; i < 5; i++) yield i;
}
```

```go
func Gen() <-chan int {
    ch := make(chan int)
    go func() {
        for i := 0; i < 5; i++ {
            ch <- i
        }
        close(ch)
    }()
    return ch
}
```

```php
<?php
function gen() {
    for ($i = 0; $i < 5; $i++) {
        yield $i;
    }
}
```

**Integration pattern:** paginated fetch without loading all pages.

| Lang | Mechanism | Typical use |
|------|-----------|-------------|
| **Python** | `yield` / generator expressions | Stream rows from DB or files; chunk RAG ingestion |
| **JavaScript** | `function*` / `yield` | Paginated API consumption; sync iterables |
| **TypeScript** | Same as JS; `AsyncGenerator` for async streams | Typed pagination; SSE/chunk readers |
| **Go** | `iter.Seq` (Go 1.23+) or channels | Worker pipelines; bounded fan-out |
| **Rust** | `Iterator` trait + adapters (`map`, `filter`, `take`) | Zero-copy transforms in hot paths |
| **PHP** | `yield` in user functions | Chunked CSV/HTTP reads in Laravel jobs |

| Lang | Gotcha |
|------|--------|
| **Python** | Generators are **single-pass**—exhaust once; `list(gen)` materializes and defeats laziness |
| **JavaScript** | Mixing sync iterables with **async iterables** (`for await`)—different protocols |
| **Go** | Channel **close/send rules**—send on closed channel panics; range until close |
| **Rust** | Iterators are **consume-once**; `.collect()` allocates; prefer `.take(n)` for bounds |
| **PHP** | Generators are single-pass like Python; cannot rewind without re-calling the function |

**Related:** [Functional idioms](#functional-idioms-map-filter-reduce) · [Built-in data structures](#built-in-data-structures)

```python
# What: generator yielding IDs page by page without loading all rows
# Why: bounded memory for large partner datasets
# When: RAG ingest and bulk API walks (Project 2)
# Python — paginated IDs (integration pattern)
def page_ids(url: str, page_size: int = 100):
    page = 0
    while True:
        rows = fetch_page(url, page, page_size)
        if not rows:
            break
        for row in rows:
            yield row["id"]
        page += 1
```

```javascript
// What: sync generator walking paginated API pages
// Why: consumer pulls one ID at a time—no giant array in memory
// When: Node clients calling paginated partner APIs (Project 7)
// JavaScript — sync generator for paginated API
function* pageIds(fetchPage, pageSize = 100) {
  let page = 0;
  while (true) {
    const rows = fetchPage(page, pageSize);
    if (!rows.length) break;
    for (const row of rows) yield row.id;
    page += 1;
  }
}
```

```go
// Go — iter.Seq (Go 1.23+) or channel pipeline
func pageIDs(ctx context.Context, fetch func(int) ([]Row, error)) iter.Seq[string] {
    return func(yield func(string) bool) {
        for page := 0; ; page++ {
            rows, err := fetch(page)
            if err != nil || len(rows) == 0 {
                return
            }
            for _, r := range rows {
                if !yield(r.ID) {
                    return
                }
            }
        }
    }
}
```

```rust
// Rust — Iterator adapters; lazy until consumed
fn page_ids(fetch: impl Fn(u32) -> Vec<Row>) -> impl Iterator<Item = String> {
    (0..).flat_map(move |page| {
        let rows = fetch(page);
        if rows.is_empty() {
            None
        } else {
            Some(rows.into_iter().map(|r| r.id))
        }
    })
    .flatten()
}
```

```php
<?php
// PHP — yield in user function (Laravel job chunking)
function pageIds(callable $fetchPage, int $pageSize = 100): Generator {
    for ($page = 0; ; $page++) {
        $rows = $fetchPage($page, $pageSize);
        if ($rows === []) {
            break;
        }
        foreach ($rows as $row) {
            yield $row['id'];
        }
    }
}
```

**Apply in:** [Project 2](../../archive/v1-22-step/career-project-specs/02-rag-llm-service.md) (Python RAG chunk ingestion) · [Project 7](../../archive/v1-22-step/career-project-specs/07-node-typescript-lab.md) (JS pagination) · [Project 8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md) (Go fan-out) · [Project 18](../../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md) (Rust hot-path iterators).

---

### Ownership, borrowing, and memory models

**What:** Who owns heap data and when it is freed—or how garbage collection (GC) reclaims it.

**Why:** Memory leaks and use-after-free still happen in GC languages via lingering references.

**When:** Long-running workers, closures holding large buffers, Rust hot paths.

**Key takeaway:** Know who frees memory and when—Rust enforces this at compile time; garbage-collected (GC) languages still leak when references or closures keep objects alive.

**At a glance (Rust · Python · JavaScript · Go · PHP):** Each line creates a three-element ordered sequence—the most common literal in that language.

```rust
let s = String::from("hi");
let t = s; // move
// println!("{s}"); // error: value moved
```

```python
import sys
a = []
print(sys.getrefcount(a))  # refcount hint (not exact in CPython)
```

```javascript
let a = { x: 1 };
a = null; // eligible for garbage collection (GC) when unreachable
```

```go
func f() *int {
    x := 10
    return &x // escapes to heap (escape analysis)
}
```

```php
<?php
// PHP-FPM: memory resets each request; queue workers need explicit cleanup
```

**Decode:** Rust `E0502` (“cannot borrow as mutable because it is also borrowed as immutable”) means two live references conflict—restructure scopes or use interior mutability sparingly.

| Lang | Model | Who frees? | Typical gotcha |
|------|-------|------------|----------------|
| **JavaScript** | Garbage collection (GC) + reference counting (some engines) | Runtime | Closures holding large objects; event listener leaks |
| **TypeScript** | Same as JS (types erased) | Runtime | Same as JS |
| **PHP** | Reference-counted garbage collection (GC) | Runtime per request (PHP-FPM) | Long-running workers accumulate if references linger |
| **Go** | Concurrent garbage collection (GC) | Runtime | Escape analysis hides allocations; slice backing arrays shared |
| **Python** | Refcount + cyclic GC | Runtime | Large lists in hot loops; `__slots__` for many small objects |
| **Rust** | **Ownership + borrow checker** | Compile-time rules; drop at scope | Fighting the borrow checker with `.clone()` everywhere |

| Lang | Gotcha |
|------|--------|
| **JavaScript** | **Closure captures** keep objects alive; remove listeners on teardown |
| **Go** | **Slice aliasing**—sub-slices share backing array; `append` may reallocate |
| **Python** | **Mutable default args** and shared list references across calls |
| **Rust** | **`&mut` exclusivity**—only one mutable borrow at a time; use interior mutability sparingly |
| **PHP** | Request-scoped memory is fine in FPM; **queue workers** need explicit unset/cycle breaks |

**Related:** [Immutability and value vs reference](#immutability-and-value-vs-reference) · [Cross-language gotchas](#cross-language-gotchas-interview-favorites)

**Apply in:** [Project 8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md) (Go slice/alloc awareness) · [Projects 17–19](../../career-project-specs/17-proxy-load-balancer-lab.md) (Rust ownership) · [Memory and performance](../concepts/memory-and-performance.md) (measure before tuning).

---

### Type systems beyond annotations

**What:** Structural vs nominal typing, nullability, and making invalid states unrepresentable.

**Why:** Annotations alone do not catch nil interface bugs or Python hints ignored at runtime.

**When:** Designing DTOs, optional config, and CI type gates.

**Key takeaway:** Use the type system to rule out invalid states—`Option` instead of null, strict equality (`===`), and CI type checkers (mypy, TypeScript `strict`) on Python and TypeScript.

Annotations are the surface; **structural vs nominal typing**, **nullability**, and **variance** are what senior reviews focus on.

| Lang | Typing style | Null / optional | Notable edge |
|------|--------------|-----------------|--------------|
| **JavaScript** | Dynamic | `null` / `undefined` | No compile-time checks without TS |
| **TypeScript** | Structural + erased | `T \| null`, `?.`, `strictNullChecks` | Excess property checks; `unknown` vs `any` |
| **PHP** | Gradual (8+) | `?Type`, nullable params | Union types; no generics until 8+ |
| **Go** | Structural interfaces | Pointers for optional (`*T`) | No sum types; use interfaces + type switches |
| **Python** | Gradual (hints) | `Optional[T]`, `\| None` (3.10+) | Runtime ignores most hints—enforce with mypy/pyright |
| **Rust** | Nominal + inferred | `Option<T>`—no null refs | Variance on lifetimes; trait bounds |

| Lang | Gotcha |
|------|--------|
| **TypeScript** | **`any` escape hatch** disables checking; prefer `unknown` + narrowing |
| **Go** | **`nil` interface** holds type+value—`if x == nil` fails when interface holds typed nil |
| **Python** | **`list` vs `List[str]`** at runtime identical; CI must run type checker |
| **Rust** | **`Option` vs `Result`**—don't use `unwrap()` at service boundaries |
| **PHP** | **`mixed`** and weak comparisons—prefer `===` and typed properties |

**Same scenario:** function accepts optional config; caller must handle absence.

```typescript
// TypeScript — strict null checks + narrowing
type Config = { timeoutMs: number };

function loadConfig(raw: Config | null): Config {
  if (raw === null) {
    return { timeoutMs: 3000 };
  }
  return raw;
}
```

```rust
// Rust — Option<T> forces explicit branch
fn load_config(raw: Option<Config>) -> Config {
    raw.unwrap_or(Config { timeout_ms: 3000 })
}
```

```go
// Go — pointer for optional; nil means absent
func loadConfig(raw *Config) Config {
    if raw == nil {
        return Config{TimeoutMs: 3000}
    }
    return *raw
}
```

```python
# Python — Optional with runtime None check
def load_config(raw: Config | None) -> Config:
    return raw if raw is not None else Config(timeout_ms=3000)
```

```php
<?php
// PHP — nullable type hint
function loadConfig(?Config $raw): Config {
    return $raw ?? new Config(timeoutMs: 3000);
}
```

**Apply in:** [Project 7](../../archive/v1-22-step/career-project-specs/07-node-typescript-lab.md) (TS strict mode) · [Project 12](../../archive/v1-22-step/career-project-specs/12-multi-tenant-auth-lab.md) (typed DTOs) · [Project 2](../../archive/v1-22-step/career-project-specs/02-rag-llm-service.md) (Python typing at scale) · [Project 18](../../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md) (`Option`/`Result`).

**Related:** [Generics and type parameters](#generics-and-type-parameters) · [Cross-language gotchas](#cross-language-gotchas-interview-favorites)

---

### Error philosophy and control flow

**What:** Choosing return values vs exceptions at service boundaries.

**Why:** Middle layers that swallow errors poison queues and hide partner failures.

**When:** HTTP handlers, worker jobs, and CLI `main` functions.

**Key takeaway:** Errors are values or exceptions—but always handled at a boundary with logging, HTTP status, or dead-letter queue (DLQ) policy, never swallowed in the middle.

Fundamentals live in [Error handling](#error-handling). This section is **how senior engineers choose** between styles at service boundaries.

| Lang | Default idiom | Boundary pattern | Review red flag |
|------|---------------|------------------|-----------------|
| **Go** | `(T, error)` | Wrap with `%w`; return up; log at HTTP handler | Ignored `err`; `panic` in libraries |
| **Rust** | `Result<T, E>` + `?` | Map to HTTP status at axum/actix layer | `unwrap()` / `expect()` in worker hot path |
| **TypeScript** | `try/catch` + typed `unknown` | Catch at route middleware; never swallow | Empty `catch {}` |
| **Python** | Exceptions | Custom hierarchy; catch at FastAPI handlers | Bare `except:` |
| **PHP** | Exceptions (`Throwable`) | Laravel exception handler maps to JSON | `@` suppression |
| **JavaScript** | Promises reject / `try/catch` | Unhandled rejection handlers in Node | Floating promises |

| Lang | Gotcha |
|------|--------|
| **Go** | **`errors.Is` / `errors.As`** for wrapped errors—not `==` on sentinel |
| **Rust** | **`?` only in functions returning `Result`**—use `match` or `map_err` at boundaries |
| **TypeScript** | **`catch (e: unknown)`**—narrow before accessing `.message` |
| **Python** | **Exception hierarchy**—catch specific types, not `Exception` at inner layers |
| **PHP** | **`Error` vs `Exception`**—catch `Throwable` in modern code |

**Same scenario:** propagate a not-found error to HTTP 404 at the boundary.

```go
// Go — sentinel error + wrap
var ErrNotFound = errors.New("not found")

func findUser(id string) (*User, error) {
    u, ok := store[id]
    if !ok {
        return nil, fmt.Errorf("find user %s: %w", id, ErrNotFound)
    }
    return u, nil
}

// Handler: if errors.Is(err, ErrNotFound) { w.WriteHeader(404) }
```

```rust
// Rust — enum or thiserror; ? propagates
#[derive(Debug)]
enum AppError {
    NotFound(String),
    Upstream(reqwest::Error),
}

fn find_user(id: &str) -> Result<User, AppError> {
    store.get(id).cloned().ok_or_else(|| AppError::NotFound(id.into()))
}
```

```typescript
// TypeScript — Result-like pattern or throw at boundary
class NotFoundError extends Error {
  constructor(public readonly id: string) {
    super(`user not found: ${id}`);
  }
}

function findUser(id: string): User {
  const u = store.get(id);
  if (!u) throw new NotFoundError(id);
  return u;
}
```

```python
# Python — exception per domain error
class NotFoundError(Exception):
    def __init__(self, id: str):
        self.id = id

def find_user(id: str) -> User:
    if id not in store:
        raise NotFoundError(id)
    return store[id]
```

```php
<?php
// PHP — domain exception; map in handler
final class NotFoundException extends RuntimeException {}

function findUser(string $id): User {
    if (!isset($store[$id])) {
        throw new NotFoundException("user not found: {$id}");
    }
    return $store[$id];
}
```

**Apply in:** every project—especially [Project 18](../../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md) (`Result` propagation, no `unwrap` in hot path).

**Related:** [Error handling](#error-handling) · [Cross-language gotchas](#cross-language-gotchas-interview-favorites)

---

### Cross-language gotchas (interview favorites)

**What:** The highest-frequency semantic traps when moving between stacks.

**Why:** These show up in code review and production incidents—not trick questions.

**When:** Before merging cross-stack ports or during incident postmortems.

**Key takeaway:** Use strict equality, explicit nil/`None` checks, and understand the Go typed-nil interface trap and Rust borrow conflicts.

Consolidated **tripwires**—see also [Equality gotchas](#equality-gotchas), [Null, optionals, equality, and truthiness](#null-optionals-equality-and-truthiness), and [Language gotchas deep dive](language-gotchas-deep-dive.md) (20 mentor-depth sections for Python · TS/JS · PHP + interview prep).

**At a glance (Rust · Python · JavaScript · Go · PHP):** Each line creates a three-element ordered sequence—the most common literal in that language.

```rust
let mut x = 5;
let r = &x;
// x = 6; // error E0502: cannot borrow as mutable
```

```python
def f(x=[]):  # mutable default — shared across calls
    pass
```

```javascript
console.log(0 == "0");   // true
console.log(0 === "0");  // false
```

```go
var err error = (*MyError)(nil)
fmt.Println(err == nil) // false — typed nil in interface
```

```php
<?php
var_dump("0" == 0);  // true — type juggling
var_dump("0" === 0); // false
```

| Lang | Gotcha | Safe habit |
|------|--------|------------|
| **JavaScript** | `==` coerces types (`"1" == 1`) | Prefer `===` / `!==` |
| **PHP** | `==` type juggling; `$a + $b` on arrays reindexes keys | `===`; `array_merge` not `+` for concat |
| **Go** | **Nil interface trap**: typed nil in interface ≠ `nil` | Check concrete type or use pointer receivers consistently |
| **Python** | `is` vs `==`; mutable default args | `x is None`; no mutable defaults |
| **Rust** | Borrow checker errors on shared mutation | One `&mut` at a time; `Arc<Mutex<_>>` when shared |
| **All** | Loop closure capture | See [Closures and capture gotchas](#closures-and-capture-gotchas) |

**Related:** [Closures and capture gotchas](#closures-and-capture-gotchas) · [Error handling](#error-handling) · [Type systems beyond annotations](#type-systems-beyond-annotations)

**Apply in:** every project—especially [Project 7](../../archive/v1-22-step/career-project-specs/07-node-typescript-lab.md) and [Project 18](../../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md).

---

### Functional idioms (map, filter, reduce)

**What:** Expressing list transforms without manual index loops.

**Why:** Clearer data pipelines; easier to test when side effects stay at the edges.

**When:** Shaping API responses, filtering active records, aggregating metrics.

**Key takeaway:** Express transforms with map/filter/reduce or iterator chains—keep side effects at the edges (I/O, logging), not inside pure transforms.

Cross-language spellings—theory (pure functions, HOF) in [Programming paradigms](../concepts/software-engineering.md#programming-paradigms).

**At a glance (Rust · Python · JavaScript · Go · PHP):** Each line creates a three-element ordered sequence—the most common literal in that language.

```rust
let doubled: Vec<_> = (1..=5).map(|x| x * 2).collect();
```

```python
doubled = [x * 2 for x in range(1, 6)]
```

```javascript
const doubled = [1, 2, 3, 4, 5].map((x) => x * 2);
```

```go
var doubled []int
for _, x := range []int{1, 2, 3, 4, 5} {
    doubled = append(doubled, x*2)
}
```

```php
<?php
$doubled = array_map(fn($x) => $x * 2, [1, 2, 3, 4, 5]);
```

| Lang | Map | Filter | Reduce / fold |
|------|-----|--------|---------------|
| **JavaScript** | `arr.map(f)` | `arr.filter(f)` | `arr.reduce(f, init)` |
| **TypeScript** | same + typed callbacks | same | same |
| **PHP** | `array_map(f, $arr)` | `array_filter($arr, f)` | `array_reduce($arr, f, init)` |
| **Go** | loop or `slices` helpers | loop | loop; no std reduce |
| **Python** | `map(f, xs)` · list comp | `filter(f, xs)` · comp | `functools.reduce(f, xs, init)` |
| **Rust** | `.iter().map(f)` | `.filter(f)` | `.fold(init, f)` |

**Related:** [Lazy evaluation](#lazy-evaluation-generators-and-iterators)

**Pipeline example:** active user IDs doubled.

```javascript
// What: filter active users then map ids
// Why: keep side effects out of map/filter—pure transforms
// When: shaping data before a downstream API call
const ids = users.filter((u) => u.active).map((u) => u.id * 2);
```

```python
ids = [u.id * 2 for u in users if u.active]
```

```rust
let ids: Vec<_> = users.iter().filter(|u| u.active).map(|u| u.id * 2).collect();
```

```go
// What: filter/map spelled as explicit for loop
// Why: Go stdlib favors loops over chained helpers
// When: hot paths where clarity beats cleverness
// Go — explicit loop (idiomatic)
var ids []int
for _, u := range users {
    if u.Active {
        ids = append(ids, u.ID*2)
    }
}
```

```php
<?php
$ids = array_map(
    fn($u) => $u->id * 2,
    array_filter($users, fn($u) => $u->active)
);
```

**Apply in:** [Project 2](../../archive/v1-22-step/career-project-specs/02-rag-llm-service.md) (Python pipelines) · [Project 7](../../archive/v1-22-step/career-project-specs/07-node-typescript-lab.md) · [Project 18](../../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md) (iterator chains).

---

### Metaprogramming: decorators, macros, traits

Spelling differs widely at this level: **runtime decoration** (Python/PHP), **compile-time macros** (Rust), **structural traits** (Rust/Go interfaces).

| Lang | Mechanism | Typical use |
|------|-----------|-------------|
| **Python** | `@decorator` | FastAPI routes, retries, timing, auth |
| **JavaScript** | Higher-order functions; limited decorators (stage 3) | Middleware patterns; manual wrapping |
| **TypeScript** | Decorators (experimental) + HOF | NestJS-style; prefer explicit middleware in playbook labs |
| **PHP** | Attributes (`#[...]`) PHP 8+ | Laravel route/model metadata |
| **Go** | Code generation (`go:generate`) | sqlc, mockgen—no runtime decorators |
| **Rust** | Traits + `derive` macros + `macro_rules!` | Serde JSON, axum extractors, custom DSLs |

| Lang | Gotcha |
|------|--------|
| **Python** | Decorators **hide call signature**—use `functools.wraps` |
| **Rust** | **`derive` macro failures** show cryptic errors—check trait bounds |
| **Go** | **Generated code** must be committed or CI must run `go generate` |
| **PHP** | Attributes are **reflection-readable**—framework discovers them at boot |
| **TypeScript** | Experimental decorators change semantics—pin TS version in CI |

**Same scenario:** wrap a handler to log duration.

```python
# What: timing decorator with functools.wraps
# Why: preserves function metadata for logs and OpenAPI
# When: FastAPI route wrappers and retry helpers (Project 2)
# Python — decorator
import functools
import time

def timed(fn):
    @functools.wraps(fn)
    def wrapper(*args, **kwargs):
        start = time.perf_counter()
        try:
            return fn(*args, **kwargs)
        finally:
            elapsed = time.perf_counter() - start
            log.info("%s took %.3fs", fn.__name__, elapsed)
    return wrapper
```

```rust
// Rust — trait extension or wrapper fn (no runtime decorator)
trait Timed {
    fn timed(self) -> impl FnOnce() -> Self::Output;
}
// Or: middleware layer in axum—preferred for HTTP
```

```go
// What: HTTP middleware measuring request duration
// Why: Go has no runtime decorators—explicit wrapper functions
// When: Project 8 gateway logging
// Go — explicit middleware wrapper (idiomatic)
func timed(next http.HandlerFunc) http.HandlerFunc {
    return func(w http.ResponseWriter, r *http.Request) {
        start := time.Now()
        next(w, r)
        log.Printf("%s %s took %v", r.Method, r.URL.Path, time.Since(start))
    }
}
```

```php
<?php
// PHP 8 — attribute (framework reads via reflection)
#[Route('/webhook', methods: ['POST'])]
class WebhookController {
    public function __invoke(Request $request): JsonResponse { /* ... */ }
}
```

```typescript
// TypeScript — higher-order function (explicit, no magic)
function timed<T extends (...args: unknown[]) => unknown>(fn: T): T {
  return ((...args: unknown[]) => {
    const start = performance.now();
    try {
      return fn(...args);
    } finally {
      console.log(`${fn.name} took ${performance.now() - start}ms`);
    }
  }) as T;
}
```

**Apply in:** [Project 2](../../archive/v1-22-step/career-project-specs/02-rag-llm-service.md) (FastAPI decorators) · [Project 1](../../archive/v1-22-step/career-project-specs/01-integration-webhook-receiver.md) (Laravel attributes) · [Project 18](../../archive/v1-22-step/career-project-specs/19-rust-hot-path-lab.md) (traits + derive).

---

### Concurrency beyond syntax

**What:** Production concurrency—bounded pools, backpressure, and CPU vs I/O split—not just async spelling.

**Why:** Unbounded goroutines or blocking the event loop fail under real load.

**When:** Queue workers (Project 6/8), Node fan-out (Project 7), realtime labs.

**Layers first:** [Concurrency runtime model (Part 1)](../concepts/concurrency-runtime-model.md). **Deep dives:** [Go scheduler, Node scale, CPU pipeline (Part 2)](../concepts/concurrency-deep-dives.md).

**Key takeaway:** Concurrency overlaps work; parallelism uses multiple CPUs—bound I/O with async and pools; never spawn unbounded goroutines on CPU-heavy loops.

[Async and concurrency (fundamentals)](#async-and-concurrency-fundamentals) covers **spelling**. Production work adds **models, backpressure, and failure modes**—detailed in [Software engineering — Concurrency basics](../concepts/software-engineering.md#concurrency-basics).

**At a glance (Rust · Python · JavaScript · Go · PHP):** Each line creates a three-element ordered sequence—the most common literal in that language.

```rust
// IO-bound: tokio tasks with Semaphore cap
// CPU-bound: rayon or dedicated worker pool — not unbounded tasks
```

```python
# IO: asyncio + httpx
# CPU: ProcessPoolExecutor for heavy work — not blocking asyncio loop
```

```javascript
// IO: Promise.all with bounded concurrency + AbortSignal.timeout
// CPU: worker_threads for heavy sync work — don't block event loop
```

```go
// IO: goroutines + context cancel + worker pool
// CPU: fixed worker pool — not go func() per item on hot loop
```

```php
<?php
// IO: dispatch queue job — scale Horizon workers horizontally
// CPU: queue chunking — not parallel threads in FPM request
```

**Parallelism vs concurrency:** **Concurrency** = structuring work so progress can overlap (goroutines, async tasks, event loop). **Parallelism** = work literally runs at the same time on multiple CPUs.

| Workload | Prefer | Avoid |
|----------|--------|-------|
| **IO-bound** (HTTP fan-out, queue drain) | Async/await, goroutines with bounds, connection pools | Blocking the event loop; unbounded `go` spam |
| **CPU-bound** (embeddings, crypto, parsing) | Process pool, `WorkerPool` cap, `rayon` / dedicated workers | Thousands of goroutines on CPU-heavy loops |
| **Mixed** | Split: async ingress + worker pool for CPU stage | Same thread doing sync CPU + async I/O without bounds |

| Lang | Concurrency unit | Coordination | Playbook default |
|------|------------------|--------------|------------------|
| **JavaScript** | Event loop + microtasks | `Promise`, `AbortSignal` | Bounded parallel `fetch` with timeout |
| **TypeScript** | Same as JS | Typed promises | Same |
| **PHP** | Sync per FPM request | Queues (Horizon) for async | Offload long I/O to queue jobs |
| **Go** | Goroutines (cheap) | `context`, channels, `sync.WaitGroup` | Bounded worker pool + `context` cancel |
| **Python** | `asyncio` tasks OR threads for I/O | `asyncio.Semaphore`, `TaskGroup` | Async HTTP; CPU work in process pool |
| **Rust** | `tokio` tasks | `JoinHandle`, channels, `select!` | Same patterns as Go; ownership adds constraints |

| Lang | Gotcha |
|------|--------|
| **JavaScript** | **Blocking the event loop** with sync CPU work stalls all I/O |
| **Go** | **Unbounded `go` spam**—always cap with worker pool or semaphore |
| **Python** | **`asyncio` + blocking calls**—use thread pool or truly async library |
| **Rust** | **`Send + Sync` bounds** on spawned tasks—closure must own data correctly |
| **PHP** | **No threads in typical FPM**—scale workers horizontally, not in-request parallel |

**Work stealing / parallel iterators:** Go scheduler and Rust `rayon` use work-stealing internally—know they exist; playbook labs use **bounded pools** first. See [Memory and performance](../concepts/memory-and-performance.md).

**Bridge, don't duplicate:** thread pools, queue at-least-once semantics, idempotent workers, and backpressure patterns are in [Software engineering](../concepts/software-engineering.md#concurrency-basics) and [Memory and performance](../concepts/memory-and-performance.md).

**Related:** [Async and concurrency (fundamentals)](#async-and-concurrency-fundamentals)

**Apply in:** [Project 6](../../archive/v1-22-step/career-project-specs/06-async-worker-stretch.md) · [Project 8](../../archive/v1-22-step/career-project-specs/08-go-retrieval-worker-lab.md) · [Project 13](../../archive/v1-22-step/career-project-specs/13-realtime-dashboard-lab.md) (realtime) · [Project 16](../../career-project-specs/16-k8s-controller-lab.md).

---

## Language-specific extras

Short list of **non-obvious** items worth knowing when you move between core-stack languages—not full courses.

### JavaScript / TypeScript

- **ESM vs CommonJS** — `import`/`export` vs `require()`; mixing breaks without tooling (`"type": "module"`, bundler). See [Modules](#modules-imports-and-packages).
- **Truthy `if`** — see [Null, optionals, equality, and truthiness](#null-optionals-equality-and-truthiness).
- **TypeScript** — structural typing; `strict` flags; types erased at emit.

### PHP

- **`$` on all variables**; `->` for instance, `::` for static.
- **`Throwable`** — catch both `Error` and `Exception` in modern code.
- **Associative arrays** — everyday maps; JSON `json_encode`/`json_decode`.

### Go

- **Zero values** — unset vars become `0`, `""`, `nil` automatically.
- **Interfaces** — implicit satisfaction (no `implements` keyword).
- **No inheritance** — compose with struct embedding.
- **`defer`** — run cleanup when function returns.


### Rust

- **`let` vs `let mut`** — bindings immutable by default.
- **Ownership / borrow** — see [Rust stack](rust.md); not duplicated here.
- **`Result<T,E>` / `Option<T>` / `?`** — expected failures as values.
- **`match` / `if let`** — exhaustive dispatch for enums.
- **`pub`** — export at crate boundary.
- Stack map: [Rust stack](rust.md).

### Python

- **Indentation is syntax** — blocks defined by colons and consistent indent, not braces.
- **Comprehensions** — `[x*2 for x in nums]`, `{k: v for k, v in pairs}` for concise transforms.
- **Virtual environments** — isolate dependencies per project (`venv`, `uv`, `poetry`).
- **Typing is optional at runtime** — use mypy/pyright in CI for integration services.
- Stack map: [Python stack](python.md).

---

## Python (scripting lane)

Python is common in AI pipelines, glue scripts, and backend services. It has **no dedicated exploration sandbox** in this repo—most syntax appears in the tables above. Use this lane for **Python-only idioms** when reading Python next to JS/PHP/Go services.

| Idiom | Python |
|-------|--------|
| Comprehensions | `[x*2 for x in nums]` · `{k: v for k, v in pairs}` · `{x for x in nums if x > 0}` |
| Context managers | `with open(path) as f:` · `async with session:` |
| Unpacking | `a, *rest, z = row` · `**kwargs` in function calls |
| Identity vs value | `x is None` (not `== None`) · `==` for values |
| Typing at scale | `mypy` / `pyright` in CI; runtime ignores most hints |

**Python** — common script layout: dataclass models, list comprehension filter, `if __name__ == "__main__"` guard.

```python
# What: load active users from raw dict rows
# Why: dataclass + comprehension keeps glue readable
# When: one-off ingest scripts beside Project 2 services
# Python — typical glue script shape
from dataclasses import dataclass

@dataclass
class User:
    id: str
    name: str

def load_users(raw: list[dict]) -> list[User]:
    return [User(**row) for row in raw if row.get("active")]

if __name__ == "__main__":
    doubled = [x * 2 for x in range(10)]
```

Stack map: [Python stack](python.md). Database queries: [SQL stack](sql.md).

---

## Quick reference index

| Concept | Section |
|---------|---------|
| **20-concept study map** | [Cross-stack study map](#cross-stack-study-map) |
| `const` / `let` / `$var` | [Variables and mutability](#variables-and-mutability) |
| `export` / `public` / module API | [Functions](#functions) |
| Closures / lambdas | [Functions — Closures](#closures-functions-that-capture-surroundings) · [Capture gotchas](#closures-and-capture-gotchas) |
| `class` vs `struct` | [Classes, structs, and interfaces](#classes-structs-and-interfaces) |
| `arr[i]`, `.push`, `len` | [Arrays and ordered lists](#arrays-and-ordered-lists) |
| `map[k]`, `isset`, `"k" in d` | [Maps and dictionaries](#maps-and-dictionaries) |
| `Set`, `.has`, unique keys | [Sets](#sets) |
| `(a, b)` tuple / pair | [Tuples and fixed-size pairs](#tuples-and-fixed-size-pairs) |
| LIFO / FIFO idioms | [Stack and queue idioms](#stack-and-queue-idioms) |
| list vs map vs set | [Choosing at a glance](#choosing-at-a-glance) |
| `+` `===` `??` `?.` | [Operators and expressions](#operators-and-expressions) |
| `if` / `switch` / `match` | [Conditionals and branching](#conditionals-and-branching) |
| `for` / `foreach` / `range` | [Loops and iteration](#loops-and-iteration) |
| `import` / `namespace` / `package` | [Modules, imports, and packages](#modules-imports-and-packages) |
| `enum` / union / `match` | [Enums, unions, and pattern matching](#enums-unions-and-pattern-matching) |
| `<T>` generics | [Generics and type parameters](#generics-and-type-parameters) |
| `` `${}` `` / destructuring | [Strings, formatting, and destructuring](#strings-formatting-and-destructuring) |
| `let` scope / casts | [Scope, blocks, and casting](#scope-blocks-and-casting) |
| `(T, error)` vs `try/catch` | [Error handling](#error-handling) |
| `===` vs `==`, `None`, `?.` | [Null, optionals, equality, and truthiness](#null-optionals-equality-and-truthiness) |
| `async`/`await`, goroutines | [Async and concurrency (fundamentals)](#async-and-concurrency-fundamentals) |
| Generators / lazy iterators | [Lazy evaluation](#lazy-evaluation-generators-and-iterators) |
| Value vs reference / copy vs move | [Immutability and value vs reference](#immutability-and-value-vs-reference) |
| Interview gotchas (`==`, nil interface) | [Cross-language gotchas](#cross-language-gotchas-interview-favorites) |
| `map` / `filter` / `reduce` | [Functional idioms](#functional-idioms-map-filter-reduce) |
| Ownership / borrow / GC | [Ownership and memory models](#ownership-borrowing-and-memory-models) |
| Structural vs nominal types | [Type systems beyond annotations](#type-systems-beyond-annotations) |
| `Result` / `?` vs exceptions at boundary | [Error philosophy](#error-philosophy-and-control-flow) · [Error handling](#error-handling) |
| Decorators / traits / macros | [Metaprogramming](#metaprogramming-decorators-macros-traits) |
| Backpressure / worker pools | [Concurrency beyond syntax](#concurrency-beyond-syntax) · [Software engineering](../concepts/software-engineering.md#concurrency-basics) |
| ESM, traits, comprehensions | [Language-specific extras](#language-specific-extras) |
| `Option<T>` / `Result<T,E>` | [Error handling](#error-handling) · [Null, optionals](#null-optionals-equality-and-truthiness) |
| `match` / `if let` | [Conditionals](#conditionals-and-branching) · [Enums](#enums-unions-and-pattern-matching) |
| `Vec` / `HashMap` | [Arrays](#arrays-and-ordered-lists) · [Maps](#maps-and-dictionaries) |
| `pub` / `crate::` | [Modules](#modules-imports-and-packages) |

| SQL queries | [SQL stack](sql.md) |

---

**Next:** Return to [Software engineering](../concepts/software-engineering.md) for delivery, testing, and observability patterns, or open your active project spec from [README.md](../../README.md#roadmap).
