# Language fundamentals comparison

**Purpose:** One reference for the same **ideas**—variables, operators, conditionals, loops, functions, classes, collections, modules, enums, generics, strings, scope, errors, nulls, async—across the **core stack** for **integration and AI engineers**: **JavaScript/TypeScript**, **PHP**, **Go**, **Python**, and **Rust** (Tier-2 after Project 8 Go—see [Rust stack](rust.md)). Query syntax lives in [SQL stack](sql.md).

**Companion docs:** [Software engineering](../concepts/software-engineering.md) (patterns, concurrency ops) · [Algorithms and data structures](../concepts/algorithms-and-data-structures.md) (Big-O, trees, interview structures) · [Python stack](python.md) · [Rust stack](rust.md) · [SQL stack](sql.md)

---

## Table of contents

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
- [Intermediate and advanced concepts (cross-stack)](#intermediate-and-advanced-concepts-cross-stack)
  - [Lazy evaluation: generators and iterators](#lazy-evaluation-generators-and-iterators)
  - [Ownership, borrowing, and memory models](#ownership-borrowing-and-memory-models)
  - [Type systems beyond annotations](#type-systems-beyond-annotations)
  - [Error philosophy and control flow](#error-philosophy-and-control-flow)
  - [Metaprogramming: decorators, macros, traits](#metaprogramming-decorators-macros-traits)
  - [Concurrency beyond syntax](#concurrency-beyond-syntax)
- [Language-specific extras](#language-specific-extras)
- [Python (scripting lane)](#python-scripting-lane)
- [Quick reference index](#quick-reference-index)

---

## How to use this doc

1. **Read** the section for the concept you are translating (e.g. “how do maps work in Go?”).
2. **Skim** the comparison table, then read the **multi-language snippet**.
3. **Apply** in your active project lab from [README.md](../../README.md#progression-step-1--21) when you want muscle memory—not a substitute for this page, but the best way to lock spelling in.
4. **Depth on complexity and classic DS&A** stays in [Algorithms and data structures](../concepts/algorithms-and-data-structures.md)—this file covers **literal syntax and everyday methods** (`push`, `len`, `get`, `has`) for lists, maps, and sets, not red-black tree theory.
5. **SQL** (queries, joins, transactions) is not a general-purpose language in this comparison—see [SQL stack](sql.md) for database work next to these services.
6. **Senior-depth language features** (generators, ownership, type-system edges) live in [Intermediate and advanced concepts](#intermediate-and-advanced-concepts-cross-stack)—read when translating between stacks during an active lab. Operational concurrency (thread pools, backpressure, queue workers) stays in [Software engineering — Concurrency basics](../concepts/software-engineering.md#concurrency-basics).

**Comment style note:** JavaScript, TypeScript, Go, Rust, and PHP use `//` for line comments. Python uses `#`. PHP block comments use `/* ... */` like JS.

---

## Variables and mutability

Every language lets you bind a name to a value; they differ on **whether rebinding or mutation is allowed by default** and on **type syntax**.

| Idea | JavaScript | TypeScript | PHP | Go | Python | Rust |
|------|------------|------------|-----|-----|--------|------|
| Immutable binding | `const x = 1` | `const x: number = 1` | No `const` for vars; use `final` in classes sparingly | `x := 1` then no rebind with `:=` on same name in same scope; or `const` in Go 1.22+ block | Convention: `UPPER = 1` for constants; no enforced immutability | `let x = 1` immutable default; `const` compile-time |
| Mutable binding | `let s = ""` | `let s: string = ""` | `$s = ''` | `s := ""` then `s = "hi"` | `s = ""` | `let mut s = String::new()` |
| Type annotation | optional | `const url: string` | `string $name` (PHP 7.4+) | `var name string = "Ada"` | `name: str = "Ada"` (optional hints) | `name: String` · inference |
| Module-level export | `export const API = ...` | same | `namespace` + class constants | Capitalized name = exported in package | module-level names; `__all__` for public API | `pub const` · `pub fn` · `pub struct` |

```javascript
// JavaScript — const = no rebinding; object innards can still mutate
const limits = { max: 10 };
limits.max = 20; // allowed
```

```php
<?php
// PHP — variables always start with $
$url = 'https://example.com';
$limits = ['max' => 10];
```

```go
// Go — short declare := , assign with =
name := "Ada"
name = "Bob"
```

```python
# Python — no const keyword; UPPER_CASE signals intent
API_BASE = "https://example.com"
limits = {"max": 10}
limits["max"] = 20  # dict is mutable even if name is "constant"
```

```rust
// Rust — immutable by default
const API_BASE: &str = "https://example.com";
let mut limits = HashMap::from([("max", 10)]);
```

---

## Functions

Functions group logic; **methods** attach to types. Visibility and **multiple return values** vary widely.

| Idea | JavaScript/TS | PHP | Go | Python | Rust |
|------|---------------|-----|-----|--------|------|
| Named function | `function add(a, b) { return a + b }` | `function add(int $a, int $b): int` | `func add(a, b int) int` | `def add(a: int, b: int) -> int:` | `fn add(a: i32, b: i32) -> i32` |
| Arrow / expression | `const add = (a, b) => a + b` | fn expr rare in PHP 8+ | — | `lambda x: x + 1` | closures `|x| x + 1` |
| Multiple returns | array/tuple destructuring | array or object; no native tuple | `(value, error)` idiomatic | `return a, b` → tuple | `Result<T,E>` · tuples |
| Export / visibility | `export function` | `public function` in class | Capitalized = exported | leading `_` convention for "private" | `pub fn` · module privacy |

```typescript
// TypeScript — export + typed params (Node sandbox: node-ts-http-probe)
export function parseTimeoutMs(raw: string | undefined): number {
  const n = Number(raw ?? "3000");
  if (!Number.isFinite(n) || n <= 0) throw new Error("invalid timeout");
  return n;
}
```

```php
<?php
// PHP — visibility + return types (Laravel slice: laravel-route-slice)
function parseTimeoutMs(?string $raw): int {
    $n = (int) ($raw ?? 3000);
    if ($n <= 0) {
        throw new InvalidArgumentException('invalid timeout');
    }
    return $n;
}
```

```go
// Go — multiple return: value + error
func add(a, b int) (int, error) {
    return a + b, nil
}
```

```python
# Python — type hints optional at runtime; enforced by checkers (mypy/pyright)
def parse_timeout_ms(raw: str | None) -> int:
    n = int(raw or 3000)
    if n <= 0:
        raise ValueError("invalid timeout")
    return n
```

```rust
fn parse_timeout_ms(raw: Option<&str>) -> Result<u64, String> {
    let n: u64 = raw.unwrap_or("3000").parse().map_err(|e| e.to_string())?;
    if n == 0 { return Err("invalid timeout".into()); }
    Ok(n)
}
```

### Closures (functions that capture surroundings)

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| Closure / lambda | `(x) => x + base` | `fn($x) => $x + $base` | `func(x int) int { return x + base }` | `lambda x: x + base` | `|x| x + base` · move/borrow rules |

```javascript
// JavaScript — arrow function closes over `base`
function makeAdder(base) {
  return (x) => x + base;
}
const add10 = makeAdder(10);
```

```python
# Python — nested def captures enclosing scope
def make_adder(base):
    def add(x):
        return x + base
    return add

add10 = make_adder(10)
```

```rust
fn make_adder(base: i32) -> impl Fn(i32) -> i32 {
    move |x| x + base
}
```

---

## Classes, structs, and interfaces

**OOP** languages center on **classes**; **Go** favors **structs** + behavior attached separately. **TypeScript** adds structural interfaces; **Python** uses duck typing with optional `Protocol` types.

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| Type definition | `class User { }` | `class User { }` | `type User struct { }` | `class User:` · `@dataclass` | `struct User` · `enum` |
| Interface / protocol | duck typing; `implements` in TS | `interface` + traits | implicit interfaces | `Protocol` / duck typing | `trait` · implicit impl |
| Inheritance | `extends` | `extends` | composition, no subclassing | `class Child(Parent):` | no inheritance — compose |
| Method on type | `method() { }` | `public function method()` | `func (u *User) Save()` | `def save(self):` | `impl User { fn save(&self) }` |

```javascript
// JavaScript — class + constructor field shorthand
class Greeter {
  constructor(name) {
    this.name = name;
  }
  hello() {
    return `hi ${this.name}`;
  }
}
```

```php
<?php
// PHP — promoted constructor properties (PHP 8+)
class Greeter {
    public function __construct(private string $name) {}
    public function hello(): string {
        return "hi {$this->name}";
    }
}
```

```go
// Go — struct + methods; no class keyword
type Greeter struct {
    Name string
}
func (g Greeter) Hello() string {
    return "hi " + g.Name
}
```

```python
# Python — dataclass for simple records
from dataclasses import dataclass

@dataclass
class Greeter:
    name: str

    def hello(self) -> str:
        return f"hi {self.name}"
```

```rust
struct Greeter { name: String }
impl Greeter {
    fn hello(&self) -> String { format!("hi {}", self.name) }
}
```

---

## Built-in data structures

**Lists/arrays**, **maps/dictionaries**, and **sets** exist everywhere. This section covers **how you create them**, **read and update elements**, and **common methods**—not when Big-O favors one over another ([Algorithms and data structures — Data structures](../concepts/algorithms-and-data-structures.md#data-structures)).

### Overview: literals and types

| Structure | JavaScript | PHP | Go | Python | Rust |
|-----------|------------|-----|-----|--------|------|
| Ordered list | `[1, 2, 3]` | `[0, 1]` indexed array | `[]int{1,2}` **slice** | `[1, 2, 3]` | `vec![1,2,3]` **Vec** |
| Map / dict | `{ k: "v" }` / `new Map()` | `['k' => 'v']` assoc array | `map[string]int{}` | `{"a": 1}` | `HashMap<K,V>` |
| Set | `new Set([1,2])` | no native `Set` (see [Sets](#sets)) | `map[T]struct{}` idiom | `{1, 2}` | `HashSet<T>` |
| String | immutable UTF-16 | `mbstring` for Unicode | immutable UTF-8 `string` | immutable `str` | `String` / `&str` |
| Mutable by default? | arrays/objects yes | arrays yes | slice/map yes if variable mutable | list/dict/set yes | `let mut` for mutable |
| Iterate | `for...of`, `.forEach` | `foreach` | `for range` | `for x in items:` | `for x in &items` |

Loop spellings: [Loops and iteration](#loops-and-iteration). String interpolation: [Strings, formatting, and destructuring](#strings-formatting-and-destructuring).

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

```javascript
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
// Go — slice (growable); array [3]int has fixed length
nums := []int{1, 2, 3}
nums = append(nums, 4)
nums = nums[1:3] // sub-slice
sort.Ints(nums)
```

```python
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
// PHP — associative array as map
$byId = ['u1' => ['name' => 'Ada']];
$byId['u2'] = ['name' => 'Bob'];
if (isset($byId['u1'])) {
    $name = $byId['u1']['name'];
}
$names = array_column($users, 'name');
```

```go
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

Many languages use **array/list methods** instead of separate `Stack`/`Queue` types for simple cases.

| Pattern | JavaScript | PHP | Go | Python | Rust |
|---------|------------|-----|-----|--------|------|
| Stack (LIFO) | `push` / `pop` | `array_push` / `array_pop` | `append` / trim last | `.append` / `.pop()` | `Vec::push` / `pop` |
| Queue (FIFO) | `push` / `shift` | `array_push` / `array_shift` | slice + copy front (or channel) | `collections.deque` | `VecDeque` |

```javascript
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

Operators combine values into expressions. Watch **integer division**, **null-safe access**, and languages that **forbid** `++` on primitives (Go, Python).

| Category | JavaScript | TypeScript | PHP | Go | Python | Rust |
|----------|------------|------------|-----|-----|--------|------|
| Arithmetic | `+ - * / % **` | same | same | same | same; `//` floor div | same |
| Compare | `===` `!==` `<` | same | `==` loose · `===` strict | `==` `!=` (typed) | `==` value · `is` identity | `==` via `PartialEq` |
| Logical | `&&` `\|\|` `!` | same | `and` `or` `!` (also `&&`) | `&&` `\|\|` `!` | `and` `or` `not` | `&&` `\|\|` `!` |
| Assign | `=` `+=` | same | `.=` | `=` `:=` (declare) | `=` `+=` | `=` · `let mut` |
| Null-safe | `?.` `??` | same | `?->` `??` (since 7.0) | — (explicit checks) | — (explicit checks) | `Option` + `match` |
| Increment | `++` `--` | same | `++` `--` | none (`i++` invalid) | none (`+= 1`) | none (`+= 1`) |

```javascript
// JavaScript — nullish coalescing vs logical OR
const timeout = config.ms ?? 3000; // only null/undefined
const label = user.name || "guest"; // any falsy triggers default
const city = user.address?.city;
```

```php
<?php
// PHP — strict compare for safety in conditionals
if ($status === 200) { }
$timeout = $config['ms'] ?? 3000;
$city = $user?->address?->city;
```

```go
// Go — no ternary; short-circuit && and ||
if n > 0 && total/n > limit { }
```

```python
# Python — no ++; floor division with //
half = count // 2
timeout = config.get("ms") or 3000  # or: config.get("ms", 3000)
```

---

## Conditionals and branching

Branch when logic diverges. **`switch`** (C-family) often **falls through** unless you `break`; **`match`** (PHP 8+, Python 3.10+) is usually **expression-oriented** and strict.

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| if / else | `if (x) { } else { }` | `if ($x) { }` | `if x { }` (no parens required) | `if x:` / `elif` / `else:` | `if x { } else { }` |
| switch | `switch (x) { case 1: ... }` | `switch ($x)` · `match` (8.0+) | `switch x { case 1: }` | `match x:` (3.10+) | `match` exhaustive |
| Ternary | `a ? b : c` | `$a ? $b : $c` | no ternary — use `if` | `b if cond else c` | no ternary — `if` expr |
| Elvis / default | `??` | `?:` | — | `or` / `if not` patterns | `unwrap_or` · `Option` |

```javascript
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
// PHP — match (8.0+) is expression-like and strict
$label = match ($status) {
    200 => 'ok',
    404 => 'missing',
    default => 'other',
};
```

```python
# Python — match (3.10+) for structural patterns
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

Loops repeat work over **ranges**, **conditions**, or **collections**. Prefer **foreach / for-in** over manual indexing when the language supports it—fewer off-by-one bugs.

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| C-style for | `for (let i=0; i<n; i++)` | `for ($i=0; $i<$n; $i++)` | `for i := 0; i < n; i++` | `for i in range(n):` | `for i in 0..n` |
| foreach / for-in | `for (const x of arr)` | `foreach ($arr as $x)` | `for _, v := range slice` | `for x in items:` | `for x in &items` |
| while | `while (cond)` | `while ($cond)` | `for cond { }` (only loop keyword) | `while cond:` | `while cond { }` |
| break / continue | `break` `continue` | same | same | same | `break` `continue` |

```javascript
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
for user in &users {
    if user.skip { continue; }
    println!("{}", user.name);
}
```

---

## Modules, imports, and packages

**Modules** group code for reuse. Path rules differ: Node **file paths**, Go **module path in go.mod**, PHP **namespaces + Composer autoload**, Python **packages + `__init__.py`**.

| Idea | JavaScript / TS | PHP | Go | Python | Rust |
|------|-----------------|-----|-----|--------|------|
| Export | `export { fn }` · `export default` | `namespace` + autoload PSR-4 | Capitalized identifiers | module-level names; `__all__` | `pub fn` · `pub mod` |
| Import | `import { fn } from "./file.js"` | `use App\\Models\\User;` | `import "example.com/pkg"` | `from pkg import fn` | `use crate::...` |
| Entry | `package.json` `"type":"module"` | `composer.json` autoload | `package main` + `go.mod` | `if __name__ == "__main__":` | `fn main()` + `Cargo.toml` |

```javascript
// JavaScript (ESM) — explicit .js extension often required in Node
import { parseTimeoutMs } from "./parse.js";
export { parseTimeoutMs };
```

```php
<?php
namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
```

```go
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

**Enums** name a fixed set of variants. **Union types** (TS) and **match** (PHP, Python) model “one of several shapes” and dispatch safely.

| Idea | JavaScript / TS | PHP | Go | Python | Rust |
|------|-----------------|-----|-----|--------|------|
| Named constants | `const enum`-like objects | `enum Status: string` (8.1+) | `const` + `iota` | `class Status(Enum):` | `enum Status { Ok, Failed }` |
| Union / sealed | `type R = A \| B` | limited | interface + types | `Union` / `TypedDict` | `enum` variants |
| Dispatch | `switch` / `if` | `match` | `switch` | `match` / `if`/`elif` | `match` preferred |

```typescript
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

**Generics** let one implementation work for many types while staying type-safe. PHP has **no reified generics** in the application language; Go added generics in **1.18+**; Python generics are primarily for static checkers.

| Idea | TypeScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| Parameter | `<T>` on fn/type | — | `[T any]` | `def first[T](items: list[T])` (3.12+) | `<T>` on fn/struct |
| Constraint | `extends` / `keyof` | — | `comparable`, interfaces | `TypeVar` with bound | trait bounds · `where` |
| Erasure | types erased at emit | — | monomorphized at compile | erased at runtime | monomorphized at compile |

```typescript
function first<T>(items: T[]): T | undefined {
  return items[0];
}
```

```go
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

---

## Strings, formatting, and destructuring

**Interpolation** embeds values in strings; **destructuring** pulls fields or elements into bindings in one step.

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| Interpolation | `` `hi ${name}` `` | `"hi $name"` · `"hi {$name}"` | `fmt.Sprintf("hi %s", name)` | `f"hi {name}"` | `format!("hi {}", name)` |
| Substring / slice | `s.slice(0, 3)` | `substr` / `mb_substr` | `s[0:3]` bytes (UTF-8 care) | `s[0:3]` | `&s[0..3]` |
| Destructure | `const { id } = user` | `[$a, $b] = $pair` · `list()` | explicit fields | `a, b = pair` · `**kwargs` | struct destructuring |

```javascript
// JavaScript — object and array destructuring + spread
const { id, name } = user;
const [head, ...rest] = ids;
const merged = { ...defaults, ...overrides };
```

```php
<?php
// PHP — list destructuring; spread in arrays (7.4+)
[$first, $second] = $parts;
['id' => $id, 'name' => $name] = $row;
```

```python
# Python — unpacking and dict merge
id, name = user.id, user.name
head, *rest = ids
merged = {**defaults, **overrides}
```

---

## Scope, blocks, and casting

**Block scope** limits where a name is visible. **Casting** converts between types at runtime—prefer type-safe patterns (generics, guards, `isinstance`) when the language offers them.

| Idea | JavaScript | PHP | Go | Python | Rust |
|------|------------|-----|-----|--------|------|
| Block scope | `{ let x = 1 }` | `{ $x = 1 }` | `{ x := 1 }` | indentation block | `{ let x = 1; }` |
| Hoisting | `var`/`function` hoisted | — | — | — | — |
| Cast / assert | `Number(x)` · `String(x)` | `(int)$x` | `v, ok := x.(Type)` | `int(x)` · `isinstance(x, str)` | `x as i32` · `downcast` |

```javascript
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

Same lesson everywhere: distinguish **expected failures** (network down, bad user input) from **programmer bugs** (null deref). Spelling falls into **returned errors** or **exceptions**.

### Comparison

| Style | Languages | Mental model |
|-------|-----------|--------------|
| Return + check | Go `(T, error)`, Rust `Result<T,E>` + `?` | Caller must handle every time |
| Exceptions | JS, PHP, Python | Throw up the stack; catch at boundary |
| Mixed | TypeScript (same as JS) | Typed catches; `unknown` in catch |
| Panic | Rust (libraries avoid) | Unwind on bug—use `Result` at service boundaries |

### Go — returned `error`

```go
resp, err := client.Do(req)
if err != nil {
    fmt.Fprintf(os.Stderr, "request failed: %v\n", err)
    os.Exit(1)
}
defer resp.Body.Close()
```

### TypeScript — `try/catch` around `fetch`

```typescript
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

```php
try {
    $payload = json_decode($json, true, flags: JSON_THROW_ON_ERROR);
} catch (JsonException $e) {
    report($e);
    return response()->json(['ok' => false], 422);
}
```

### Python — `try` / `except`

```python
try:
    payload = json.loads(raw)
except json.JSONDecodeError as e:
    logger.exception("invalid json")
    raise ValueError("invalid payload") from e
```


### Rust — `Result` and `?`

```rust
let resp = client.get(url).send().await?;
let body = resp.text().await?;
// ? propagates Err; map to HTTP 500 or DLQ at boundary
```

**Transferable takeaway:** Pick the boundary (HTTP handler, CLI `main`, worker job) where failures become **user-visible messages** or **logged errors**—regardless of language spelling.

---

## Null, optionals, equality, and truthiness

### Null and optional patterns

| Language | Typical pattern |
|----------|-----------------|
| JavaScript | `null` vs `undefined`; optional chaining `obj?.x` |
| TypeScript | `strictNullChecks`: `string \| undefined`, props `url?` |
| PHP | `null`; coalesce `??`; typed `?string` |
| Go | Pointer `nil`; no generic optional type |
| Python | `None`; test with `is None` (not `== None`) |
| Rust | `Option<T>` (`Some`/`None`); no null in safe code |

```typescript
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
var_dump("1" == 1);  // true  — juggling
var_dump("1" === 1); // false — strict
```

```python
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

This section is **syntax and models** only. Operational concurrency (thread pools, backpressure, queue workers) lives in [Software engineering — Concurrency basics](../concepts/software-engineering.md#concurrency-basics).

| Lang | Model | Typical spelling |
|------|--------|------------------|
| **JavaScript** | Event loop; Promises; `async`/`await` | `await fetch(url)` |
| **TypeScript** | Same as JS + typed `Promise<T>` | `async function run(): Promise<void>` |
| **PHP** | Often **sync per request** (FPM); queues/Octane for async work | `dispatch(new Job($payload))` |
| **Go** | Goroutines + channels; `go fn()` | `go worker()` · `context` for cancel |
| **Python** | `asyncio` coroutines | `async def` · `await` · `asyncio.run()` |
| **Rust** | `async`/`await` + **tokio** (after sync path) | `async fn` · `.await` · `#[tokio::main]` |

```javascript
// JavaScript — Promise + await (Node probe)
const res = await fetch(url, { signal: AbortSignal.timeout(3000) });
```

```php
<?php
// PHP — typical Laravel request: synchronous unless you opt into queues/Octane
// Long I/O belongs in a queue job, not blocking the worker indefinitely.
dispatch(new ProcessWebhookJob($payload));
```

```go
// Go — goroutine + context cancel (conceptual)
ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
defer cancel()
```

```python
import asyncio

async def fetch(url: str) -> bytes:
    # use httpx/aiohttp in real code
    ...

asyncio.run(fetch("https://example.com"))
```

```rust
#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let _body = reqwest::get("https://example.com").await?.text().await?;
    Ok(())
}
```

---

## Intermediate and advanced concepts (cross-stack)

**Purpose:** Curated **translation reference** for senior-level language features—generators, ownership, type-system edges, error philosophy, metaprogramming—when you move between stacks during an active lab. Not a parallel language course or interview cram sheet; each topic ties to a playbook project.

**How to use:** Skim the comparison table for the concept you need, read the gotchas, then **apply** in your active project from [README.md](../../README.md#progression-step-1--21). DS&A theory stays in [Algorithms and data structures](../concepts/algorithms-and-data-structures.md); delivery patterns stay in [Software engineering](../concepts/software-engineering.md).

### Lazy evaluation: generators and iterators

Senior engineers use **lazy sequences** for streaming I/O, pagination, and memory-bounded pipelines—without loading entire datasets into RAM.

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

**Same scenario:** yield IDs from a paginated source without loading all pages.

```python
# Python — generator for paginated fetch
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

**Apply in:** [Project 2](../../career-project-specs/02-rag-llm-service.md) (Python RAG chunk ingestion) · [Project 7](../../career-project-specs/07-node-typescript-lab.md) (JS pagination) · [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) (Go fan-out) · [Project 18](../../career-project-specs/18-rust-hot-path-lab.md) (Rust hot-path iterators).

---

### Ownership, borrowing, and memory models

Senior engineers know **who owns memory** and **when it is freed**—this differs more across languages than syntax does.

| Lang | Model | Who frees? | Typical gotcha |
|------|-------|------------|----------------|
| **JavaScript** | GC + reference counting (some engines) | Runtime | Closures holding large objects; event listener leaks |
| **TypeScript** | Same as JS (types erased) | Runtime | Same as JS |
| **PHP** | Reference-counted GC | Runtime per request (FPM) | Long-running workers accumulate if references linger |
| **Go** | Concurrent GC | Runtime | Escape analysis hides allocations; slice backing arrays shared |
| **Python** | Refcount + cyclic GC | Runtime | Large lists in hot loops; `__slots__` for many small objects |
| **Rust** | **Ownership + borrow checker** | Compile-time rules; drop at scope | Fighting the borrow checker with `.clone()` everywhere |

| Lang | Gotcha |
|------|--------|
| **JavaScript** | **Closure captures** keep objects alive; remove listeners on teardown |
| **Go** | **Slice aliasing**—sub-slices share backing array; `append` may reallocate |
| **Python** | **Mutable default args** and shared list references across calls |
| **Rust** | **`&mut` exclusivity**—only one mutable borrow at a time; use interior mutability sparingly |
| **PHP** | Request-scoped memory is fine in FPM; **queue workers** need explicit unset/cycle breaks |

**Same scenario:** pass a buffer into a function without copying when possible.

```rust
// Rust — borrow (&) vs owned (String); compiler enforces lifetimes
fn parse_header(line: &str) -> Option<&str> {
    line.strip_prefix("X-Request-Id: ")
}

fn process(mut buf: Vec<u8>) {
    // buf owned here; freed when process returns
    buf.clear();
}
```

```go
// Go — slices are views; copying slice header, not always data
func trimSpace(b []byte) []byte {
    return bytes.TrimSpace(b) // may share backing array with b
}
```

```python
# Python — references everywhere; no borrow checker
def parse_header(line: str) -> str | None:
    prefix = "X-Request-Id: "
    return line[len(prefix):] if line.startswith(prefix) else None
```

```javascript
// JavaScript — objects passed by reference; primitives copied
function parseHeader(line) {
  const prefix = "X-Request-Id: ";
  return line.startsWith(prefix) ? line.slice(prefix.length) : null;
}
```

```php
<?php
// PHP — arrays/objects by reference unless copied explicitly
function parseHeader(string $line): ?string {
    $prefix = 'X-Request-Id: ';
    return str_starts_with($line, $prefix) ? substr($line, strlen($prefix)) : null;
}
```

**Apply in:** [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) (Go slice/alloc awareness) · [Projects 17–19](../../career-project-specs/17-proxy-load-balancer-lab.md) (Rust ownership) · [Memory and performance](../concepts/memory-and-performance.md) (measure before tuning).

---

### Type systems beyond annotations

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

**Apply in:** [Project 7](../../career-project-specs/07-node-typescript-lab.md) (TS strict mode) · [Project 12](../../career-project-specs/12-multi-tenant-auth-lab.md) (typed DTOs) · [Project 2](../../career-project-specs/02-rag-llm-service.md) (Python typing at scale) · [Project 18](../../career-project-specs/18-rust-hot-path-lab.md) (`Option`/`Result`).

---

### Error philosophy and control flow

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

**Apply in:** every project—especially [Project 18](../../career-project-specs/18-rust-hot-path-lab.md) (`Result` propagation, no `unwrap` in hot path).

---

### Metaprogramming: decorators, macros, traits

Senior spelling differs wildly: **runtime decoration** (Python/PHP), **compile-time macros** (Rust), **structural traits** (Rust/Go interfaces).

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

**Apply in:** [Project 2](../../career-project-specs/02-rag-llm-service.md) (FastAPI decorators) · [Project 1](../../career-project-specs/01-integration-webhook-receiver.md) (Laravel attributes) · [Project 18](../../career-project-specs/18-rust-hot-path-lab.md) (traits + derive).

---

### Concurrency beyond syntax

[Async and concurrency (fundamentals)](#async-and-concurrency-fundamentals) covers **spelling**. Senior work adds **models, backpressure, and failure modes**—detailed in [Software engineering — Concurrency basics](../concepts/software-engineering.md#concurrency-basics).

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

**Bridge, don't duplicate:** thread pools, queue at-least-once semantics, idempotent workers, and backpressure patterns are in [Software engineering](../concepts/software-engineering.md#concurrency-basics) and [Memory and performance](../concepts/memory-and-performance.md).

**Apply in:** [Project 6](../../career-project-specs/06-async-worker-stretch.md) · [Project 8](../../career-project-specs/08-go-retrieval-worker-lab.md) · [Project 13](../../career-project-specs/13-realtime-dashboard-lab.md) (realtime) · [Project 16](../../career-project-specs/16-k8s-controller-lab.md).

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

```python
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
| `const` / `let` / `$var` | [Variables and mutability](#variables-and-mutability) |
| `export` / `public` / module API | [Functions](#functions) |
| Closures / lambdas | [Functions — Closures](#closures-functions-that-capture-surroundings) |
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

**Next:** Return to [Software engineering](../concepts/software-engineering.md) for delivery, testing, and observability patterns, or open your active project spec from [README.md](../../README.md#progression-step-1--21).
