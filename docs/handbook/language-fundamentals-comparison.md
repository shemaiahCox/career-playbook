# Language fundamentals comparison

**Purpose:** One reference for the same **ideas**—variables, operators, conditionals, loops, functions, classes, collections, modules, enums, generics, strings, scope, errors, nulls, async—across languages you are likely to meet. Anchored on **JavaScript/TypeScript** and **PHP**, compared to **Go**, **Rust**, **C#**, **Java**, **Kotlin**, and **Swift**.

**Companion docs:** [Software engineering](software-engineering.md) (patterns, concurrency ops) · [Algorithms and data structures](algorithms-and-data-structures.md) (Big-O, trees, interview structures) · [Exploration projects](../../exploration-projects/README.md) (runnable sandboxes)

---

## Table of contents

- [How to use this doc](#how-to-use-this-doc)
- [Variables and mutability](#variables-and-mutability)
- [Functions](#functions)
- [Classes, structs, and interfaces](#classes-structs-and-interfaces)
- [Built-in data structures](#built-in-data-structures)
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
- [Language-specific extras](#language-specific-extras)
- [Python (scripting lane)](#python-scripting-lane)
- [Quick reference index](#quick-reference-index)
- [Runnable sandboxes in this repo](#runnable-sandboxes-in-this-repo)

---

## How to use this doc

1. **Read** the section for the concept you are translating (e.g. “how do maps work in Go?”).
2. **Skim** the comparison table, then read the **multi-language snippet**.
3. **Run** the matching sandbox under [exploration-projects](../../exploration-projects/README.md) when you want muscle memory—not a substitute for this page, but the best way to lock spelling in.
4. **Depth on complexity and classic DS&A** stays in [Algorithms and data structures](algorithms-and-data-structures.md)—this file covers **language spellings** of lists/maps/sets, not red-black tree theory.

**Comment style note:** Most languages use `//` for line comments. Rust also uses `//!` at the **top of a file** for module-level docs (not the same as `//` on one line).

---

## Variables and mutability

Every language lets you bind a name to a value; they differ on **whether rebinding or mutation is allowed by default** and on **type syntax**.

| Idea | JavaScript | TypeScript | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|------|------------|------------|-----|-----|------|------|--------|-------|-----|
| Immutable binding | `const x = 1` | `const x: number = 1` | No `const` for vars; use `final` in classes sparingly | `x := 1` then no rebind with `:=` on same name in same scope; or `const` in Go 1.22+ block | `let x = 1;` | `final int x = 1` (refs can still mutate object) | `val x = 1` | `let x = 1` | `readonly` fields; locals `var` unless you discipline |
| Mutable binding | `let s = ""` | `let s: string = ""` | `$s = ''` | `s := ""` then `s = "hi"` | `let mut s = String::from("");` | `int n = 0` | `var n = 0` | `var n = 0` | `string s = ""` |
| Type annotation | optional | `const url: string` | `string $name` (PHP 7.4+) | `var name string = "Ada"` | `let name: String = ...` | `String name = "Ada"` | `val name: String` | `let name: String` | `string name = "Ada"` |
| Module-level export | `export const API = ...` | same | `namespace` + class constants | Capitalized name = exported in package | `pub const` | `public static final` | `@JvmField` / companion | `public` / `internal` | `public const` |

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

```rust
// Rust — immutable by default; mut only when needed
let count = 0;
let mut buffer = String::from("");
```

```swift
// Swift — let vs var (prefer let)
let endpoint = "https://example.com"
var retries = 0
```

---

## Functions

Functions group logic; **methods** attach to types. Visibility and **multiple return values** vary widely.

| Idea | JavaScript/TS | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|------|---------------|-----|-----|------|------|--------|-------|-----|
| Named function | `function add(a, b) { return a + b }` | `function add(int $a, int $b): int` | `func add(a, b int) int` | `fn add(a: i32, b: i32) -> i32` | `int add(int a, int b)` | `fun add(a: Int, b: Int): Int` | `func add(_ a: Int, _ b: Int) -> Int` | `int Add(int a, int b)` |
| Arrow / expression | `const add = (a, b) => a + b` | fn expr rare in PHP 8+ | — | closures `\|x\| x + 1` | lambdas `x -> x + 1` | `{ a, b -> a + b }` | `{ $0 + $1 }` | `=>` expression-bodied |
| Multiple returns | array/tuple destructuring | array or object; no native tuple | `(value, error)` idiomatic | `Result` or tuples | overloads/exceptions | `Pair` / data class | tuple `(Int, String)` | `out` params or tuples |
| Export / visibility | `export function` | `public function` in class | Capitalized = exported | `pub fn` | `public` | `public` / `internal` | `public` / `internal` | `public` |

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

```rust
// Rust — last expression can be return value; Result for failure
fn add(a: i32, b: i32) -> i32 {
    a + b
}
```

```java
// Java — static entry for CLI probes
public static void main(String[] args) { }
```

```kotlin
// Kotlin — same probe, less ceremony
fun main(args: Array<String>) { }
```

### Closures (functions that capture surroundings)

| Idea | JavaScript | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|------|------------|-----|-----|------|------|--------|-------|-----|
| Closure / lambda | `(x) => x + base` | `fn($x) => $x + $base` | `func(x int) int { return x + base }` | `\|x\| x + base` | `x -> x + base` | `{ x -> x + base }` | `{ $0 + base }` | `x => x + base` |

```javascript
// JavaScript — arrow function closes over `base`
function makeAdder(base) {
  return (x) => x + base;
}
const add10 = makeAdder(10);
```

```rust
// Rust — closures can borrow or move captured values; types inferred
fn make_adder(base: i32) -> impl Fn(i32) -> i32 {
    move |x| x + base
}
```

---

## Classes, structs, and interfaces

**OOP** languages center on **classes**; **Go/Rust** favor **structs** + behavior attached separately; **Swift** splits **struct** (value) vs **class** (reference).

| Idea | JavaScript | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|------|------------|-----|-----|------|------|--------|-------|-----|
| Type definition | `class User { }` | `class User { }` | `type User struct { }` | `struct User { }` | `class User { }` | `class User` / `data class` | `struct User` / `class User` | `class User { }` |
| Interface / protocol | duck typing; `implements` in TS | `interface` + traits | implicit interfaces | `trait` | `interface` | `interface` | `protocol` | `interface` |
| Inheritance | `extends` | `extends` | composition, no subclassing | no inheritance; traits | `extends` | `:` | `class Child: Parent` | `:` |
| Method on type | `method() { }` | `public function method()` | `func (u *User) Save()` | `impl User { fn save() }` | `void save()` | `fun save()` | `func save()` | `void Save()` |

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
// PHP — traits mix behavior into classes
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

```rust
// Rust — struct + impl block + trait for polymorphism
struct Greeter { name: String }
impl Greeter {
    fn hello(&self) -> String {
        format!("hi {}", self.name)
    }
}
```

```java
// Java — explicit visibility
public class Greeter {
    private final String name;
    public Greeter(String name) { this.name = name; }
    public String hello() { return "hi " + name; }
}
```

```swift
// Swift — struct default for small value types
struct Greeter {
    let name: String
    func hello() -> String { "hi \(name)" }
}
```

```csharp
// C# — properties common in app/server code
public class Greeter {
    public string Name { get; init; }
    public string Hello() => $"hi {Name}";
}
```

---

## Built-in data structures

**Lists/arrays**, **maps/dictionaries**, and **sets** exist everywhere; **literal syntax** and **mutability** differ. For when to pick which structure at algorithm level, see [Algorithms and data structures](algorithms-and-data-structures.md).

| Structure | JavaScript | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|-----------|------------|-----|-----|------|------|--------|-------|-----|
| Ordered list | `[1, 2, 3]` | `[1, 2, 3]` indexed + `array_values` | `[]int{1,2}` slice | `vec![1, 2]` | `List.of(1,2)` / `int[]` | `listOf(1, 2)` | `[1, 2, 3]` | `new[] {1,2}` / `List<int>` |
| Map / dict | `{ key: "v" }` / `Map` | `['k' => 'v']` assoc array | `map[string]int{"a":1}` | `HashMap::from([...])` | `Map.of("a", 1)` | `mapOf("a" to 1)` | `["a": 1]` dict | `Dictionary<string,int>` |
| Set | `new Set([1,2])` | `array_unique` / no native set until extensions | `map[T]struct{}` idiom | `HashSet::from([...])` | `Set.of(1,2)` | `setOf(1, 2)` | `Set([1,2])` | `HashSet<int>` |
| String | immutable UTF-16 JS string | byte-safe concerns; mbstring | `string` immutable UTF-8 | `String` owned UTF-8 | `String` immutable | `String` | `String` UTF-8 | `string` immutable |
| Iterate collection | `for...of`, `.forEach`, iterators | `foreach` on arrays/objects | `for range` on slice/map | `for x in iter` (`IntoIterator`) | enhanced `for` | `for (x in list)` | `for x in arr` | `foreach` |

```javascript
// JavaScript — array methods + object literal as map
const byId = { u1: { name: "Ada" } };
const ids = Object.keys(byId);
const users = [{ id: "u1", name: "Ada" }];
```

```php
<?php
// PHP — associative array is the everyday map
$byId = ['u1' => ['name' => 'Ada']];
$names = array_column($users, 'name');
```

```go
// Go — slice + map; zero value for missing key is typed zero
scores := map[string]int{"ada": 10}
v, ok := scores["bob"] // ok false if missing
_ = v
```

```rust
// Rust — Vec + HashMap; explicit Option for missing keys
use std::collections::HashMap;
let mut scores = HashMap::new();
scores.insert("ada", 10);
```

```java
// Java — List + Map interfaces; prefer immutable factories in modern code
var scores = Map.of("ada", 10);
```

```swift
// Swift — Array + Dictionary; value types copy by default
var scores = ["ada": 10]
scores["bob"] = nil // removes key
```

Loop and foreach spellings: [Loops and iteration](#loops-and-iteration).

---

## Operators and expressions

Operators combine values into expressions. Watch **integer division**, **null-safe access**, and languages that **forbid** `++` on primitives (Rust).

| Category | JavaScript | TypeScript | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|----------|------------|------------|-----|-----|------|------|--------|-------|-----|
| Arithmetic | `+ - * / % **` | same | same | same | same; `/` truncates ints in other langs | same | same | same | same |
| Compare | `===` `!==` `<` | same | `==` loose · `===` strict | `==` `!=` (typed) | `==` (PartialEq) | `==` objects use `.equals()` | `==` | `==` | `==` |
| Logical | `&&` `\|\|` `!` | same | `and` `or` `!` (also `&&`) | `&&` `\|\|` `!` | `&&` `\|\|` `!` | `&&` `\|\|` `!` | `&&` `\|\|` `!` | `&&` `\|\|` `!` | `&&` `\|\|` `!` |
| Assign | `=` `+=` | same | `.=` | `=` `:=` (declare) | `=` | `=` | `=` | `=` | `=` |
| Null-safe | `?.` `??` | same | `?->` `??` (since 7.0) | — (explicit checks) | — | `Optional` | `?.` `?:` | `?.` | `?.` `??` |
| Increment | `++` `--` | same | `++` `--` | none (`i++` invalid) | none | `++` `--` | `++` `--` | none (`+= 1`) | `++` `--` |

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

```rust
// Rust — no ++; integer ops explicit
let mut n = 0;
n += 1;
let half = count / 2; // truncates for integers
```

---

## Conditionals and branching

Branch when logic diverges. **`switch`** (C-family) often **falls through** unless you `break`; **`match`** (Rust/Swift) is usually **exhaustive** and expression-oriented.

| Idea | JavaScript | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|------|------------|-----|-----|------|------|--------|-------|-----|
| if / else | `if (x) { } else { }` | `if ($x) { }` | `if x { }` (no parens required) | `if x { }` | `if (x) { }` | `if (x) { }` | `if x { }` | `if (x) { }` |
| switch | `switch (x) { case 1: ... }` | `switch ($x) { case 1: ...}` | `switch x { case 1: }` | `match x { ... }` | `switch (x)` | `when (x)` | `switch x` | `switch (x)` |
| Ternary | `a ? b : c` | `$a ? $b : $c` | no ternary — use `if` | `if cond { a } else { b }` as expr | `a ? b : c` | `if (c) a else b` | `cond ? a : b` | `a ? b : c` |
| Elvis / default | `??` | `?:` | — | — | — | `?:` | `??` | `??` |

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

```rust
// Rust — match must cover all cases (compiler-checked)
let label = match status {
    200 => "ok",
    404 => "missing",
    _ => "other",
};
```

```swift
// Swift — switch must be exhaustive (default or all cases)
switch status {
case 200: label = "ok"
case 404: label = "missing"
default: label = "other"
}
```

```kotlin
// Kotlin — when replaces switch; smart casts after checks
when (status) {
    200 -> "ok"
    404 -> "missing"
    else -> "other"
}
```

---

## Loops and iteration

Loops repeat work over **ranges**, **conditions**, or **collections**. Prefer **foreach / for-in** over manual indexing when the language supports it—fewer off-by-one bugs.

| Idea | JavaScript | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|------|------------|-----|-----|------|------|--------|-------|-----|
| C-style for | `for (let i=0; i<n; i++)` | `for ($i=0; $i<$n; $i++)` | `for i := 0; i < n; i++` | `for i in 0..n` | `for (int i=0; i<n; i++)` | `for (i in 0 until n)` | `for i in 0..<n` | `for (int i=0; i<n; i++)` |
| foreach / for-in | `for (const x of arr)` | `foreach ($arr as $x)` | `for _, v := range slice` | `for x in vec` | `for (var x : list)` | `for (x in list)` | `for x in arr` | `foreach (var x in list)` |
| while | `while (cond)` | `while ($cond)` | `for cond { }` (only loop keyword) | `while cond { }` | `while (cond)` | `while (cond)` | `while cond { }` | `while (cond)` |
| break / continue | `break` `continue` | same | same | same + `'label` | same | same | same | same |

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

```rust
// Rust — for uses IntoIterator; consume or borrow depends on iter
for score in scores.iter() {
    println!("{score}");
}
```

```java
// Java — enhanced for over arrays and Iterable
for (var entry : scores.entrySet()) {
    System.out.println(entry.getKey());
}
```

---

## Modules, imports, and packages

**Modules** group code for reuse. Path rules differ: Node **file paths**, Go **module path in go.mod**, Java **packages mirror folders**, PHP **namespaces + Composer autoload**.

| Idea | JavaScript / TS | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|------|-----------------|-----|-----|------|------|--------|-------|-----|
| Export | `export { fn }` · `export default` | `namespace` + autoload PSR-4 | Capitalized identifiers | `pub fn` · `pub mod` | `public class` | `public` | `public` | `public` |
| Import | `import { fn } from "./file.js"` | `use App\\Models\\User;` | `import "example.com/pkg"` | `use crate::module;` | `import java.util.List;` | `import package.Class` | `import Foundation` | `using System;` |
| Entry | `package.json` `"type":"module"` | `composer.json` autoload | `package main` + `go.mod` | `Cargo.toml` + `src/lib.rs` | `public static void main` | `@JvmStatic fun main` | `@main` | `static void Main` |

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

```rust
// Rust — mod tree in crate root; use brings names into scope
mod http_probe;

use std::fs::File;
```

```java
// Java — package declaration matches directory layout
package exploration.httpprobe;

import java.net.http.HttpClient;
```

---

## Enums, unions, and pattern matching

**Enums** name a fixed set of variants. **Union types** (TS) and **sealed hierarchies** (Kotlin) model “one of several shapes.” **Pattern matching** dispatches on those shapes safely.

| Idea | JavaScript / TS | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|------|-----------------|-----|-----|------|------|--------|-------|-----|
| Named constants | `const enum`-like objects | `enum Status: string` (8.1+) | `const` + `iota` | `enum Status { Ok, Err }` | `enum Status { OK, ERR }` | `enum class Status` | `enum Status` | `enum Status` |
| Union / sealed | `type R = A \| B` | limited | interface + types | `enum` variants with data | subclasses | `sealed class` | `enum` associated values | discriminated unions via records |
| Dispatch | `switch` / `if` | `match` | `switch` | `match` (exhaustive) | `switch` | `when` | `switch` | `switch` / pattern matching (modern) |

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

```rust
// Rust — enum variants can carry data; match must be exhaustive
enum Response {
    Ok(String),
    Err(u16),
}

fn label(r: Response) -> &'static str {
    match r {
        Response::Ok(_) => "ok",
        Response::Err(404) => "missing",
        Response::Err(_) => "error",
    }
}
```

```swift
// Swift — associated values on enum cases
enum Response {
    case ok(String)
    case err(Int)
}
```

```kotlin
// Kotlin — sealed class + when with smart casts
sealed class Response {
    data class Ok(val body: String) : Response()
    data class Err(val code: Int) : Response()
}
```

---

## Generics and type parameters

**Generics** let one implementation work for many types while staying type-safe. PHP has **no reified generics** in the application language; Go added generics in **1.18+**.

| Idea | TypeScript | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|------|------------|-----|-----|------|------|--------|-------|-----|
| Parameter | `<T>` on fn/type | — | `[T any]` | `<T>` + trait bounds | `<T>` | `<T>` | `<T>` | `<T>` |
| Constraint | `extends` / `keyof` | — | `comparable`, interfaces | `T: Trait` | `extends Bound` | `:` bound | `:` protocol | `where T : IFace` |
| Erasure | types erased at emit | — | monomorphized at compile | monomorphized | erased at runtime | erased on JVM | reified in Swift | reified in .NET |

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

```rust
fn first<T>(items: &[T]) -> Option<&T> {
    items.first()
}
```

```java
public static <T> T first(List<T> items) {
    return items.isEmpty() ? null : items.get(0);
}
```

```csharp
public static T? First<T>(IList<T> items) =>
    items.Count == 0 ? default : items[0];
```

---

## Strings, formatting, and destructuring

**Interpolation** embeds values in strings; **destructuring** pulls fields or elements into bindings in one step.

| Idea | JavaScript | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|------|------------|-----|-----|------|------|--------|-------|-----|
| Interpolation | `` `hi ${name}` `` | `"hi $name"` · `"hi {$name}"` | `fmt.Sprintf("hi %s", name)` | `format!("hi {}", name)` | text blocks + `.formatted` (21+) | `"hi $name"` | `"hi \(name)"` | `$"hi {name}"` |
| Substring / slice | `s.slice(0, 3)` | `substr` / `mb_substr` | `s[0:3]` bytes (UTF-8 care) | `&s[0..3]` | `s.substring(0, 3)` | `s.substring(0, 3)` | `String(s.prefix(3))` | `s[0..3]` |
| Destructure | `const { id } = user` | `[$a, $b] = $pair` · `list()` | — (explicit fields) | `let (a, b) = pair` | — | `val (a, b) = pair` | `let (a, b) = pair` | `var (a, b) = pair` |

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

```rust
// Rust — pattern destructuring in let, match, and function args
let (code, message) = (404, "missing");
let User { id, name } = user;
```

```kotlin
// Kotlin — data class component functions
val (id, name) = user
```

---

## Scope, blocks, and casting

**Block scope** limits where a name is visible. **Casting** converts between types at runtime—prefer type-safe patterns (generics, `Option`, `as?`) when the language offers them.

| Idea | JavaScript | PHP | Go | Rust | Java | Kotlin | Swift | C# |
|------|------------|-----|-----|------|------|--------|-------|-----|
| Block scope | `{ let x = 1 }` | `{ $x = 1 }` | `{ x := 1 }` | `{ let x = 1 }` | `{ int x = 1 }` | `{ val x = 1 }` | `{ let x = 1 }` | `{ int x = 1 }` |
| Hoisting | `var`/`function` hoisted | — | — | — | — | — | — | — |
| Cast / assert | `Number(x)` · `String(x)` | `(int)$x` | `v, ok := x.(Type)` | `x as i32` | `(String) obj` | `as?` / `as` | `x as? String` | `x as string` · `is` |

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

```rust
// Rust — as for primitives; TryFrom for fallible conversion
let n: i32 = s.parse()?; // str -> number via Result
let byte = ch as u8;
```

```swift
// Swift — conditional cast as?
if let name = value as? String {
    print(name)
}
```

```csharp
// C# — as returns null on failure; is for type tests
var name = value as string;
if (value is int n) { }
```

---

## Error handling

Same lesson everywhere: distinguish **expected failures** (network down, bad user input) from **programmer bugs** (null deref). Spelling falls into **returned errors**, **`Result`**, or **exceptions**.

### Comparison

| Style | Languages | Mental model |
|-------|-----------|--------------|
| Return + check | Go `(T, error)` | Caller must handle every time |
| `Result` + `?` | Rust | Encode failure in type; propagate with `?` |
| Exceptions | JS, PHP, Java, Kotlin, Swift, C# | Throw up the stack; catch at boundary |
| Mixed | Kotlin `Result`, Swift `throws` | Language offers more than one style |

### Go — returned `error`

```go
resp, err := client.Do(req)
if err != nil {
    fmt.Fprintf(os.Stderr, "request failed: %v\n", err)
    os.Exit(1)
}
defer resp.Body.Close()
```

Runnable: [go-cli-http-probe](../../exploration-projects/go-cli-http-probe/README.md).

### Rust — `Result` + `?`

```rust
let file = File::open(&path)?;
// `?` returns Err early to the caller; Ok value continues
```

Runnable: [rust-text-pipeline](../../exploration-projects/rust-text-pipeline/README.md).

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

Runnable: [node-ts-http-probe](../../exploration-projects/node-ts-http-probe/README.md).

### PHP — exceptions + HTTP helpers

```php
try {
    $payload = json_decode($json, true, flags: JSON_THROW_ON_ERROR);
} catch (JsonException $e) {
    report($e);
    return response()->json(['ok' => false], 422);
}
```

Runnable: [laravel-route-slice](../../exploration-projects/laravel-route-slice/README.md).

### Java / Kotlin — checked exceptions at boundaries

```java
try {
    var response = client.send(request, BodyHandlers.ofInputStream());
} catch (IOException | InterruptedException e) {
    System.err.println("request failed: " + e.getMessage());
    System.exit(1);
}
```

```kotlin
try {
    client.send(request, BodyHandlers.ofInputStream())
} catch (e: IOException) {
    System.err.println("request failed: ${e.message}")
    exitProcess(1)
}
```

Runnable: [java-http-cli](../../exploration-projects/java-http-cli/README.md) · [kotlin-http-cli](../../exploration-projects/kotlin-http-cli/README.md).

### Swift — `throws` + `do/catch`

```swift
do {
    let (_, response) = try await URLSession.shared.data(for: request)
} catch {
    fputs("request failed: \(error.localizedDescription)\n", stderr)
    exit(1)
}
```

Runnable: [swift-http-cli](../../exploration-projects/swift-http-cli/README.md).

### C# — exceptions

```csharp
try {
    var text = File.ReadAllText(path);
} catch (IOException ex) {
    Debug.LogError(ex);
}
```

Runnable: [unity-game-loop-intro](../../exploration-projects/unity-game-loop-intro/README.md) (C# game loop context).

**Transferable takeaway:** Pick the boundary (HTTP handler, CLI `main`, UI action) where failures become **user-visible messages** or **logged errors**—regardless of language spelling.

---

## Null, optionals, equality, and truthiness

### Null and optional patterns

| Language | Typical pattern |
|----------|-----------------|
| JavaScript | `null` vs `undefined`; optional chaining `obj?.x` |
| TypeScript | `strictNullChecks`: `string \| undefined`, props `url?` |
| PHP | `null`; coalesce `??`; typed `?string` |
| Go | Pointer `nil`; no generic optional type |
| Rust | **No null** — `Option<T>` (`Some` / `None`) |
| Java | Nullable references; `Optional` for return values (not fields) |
| Kotlin | `T?`, safe call `?.`, Elvis `?:` |
| Swift | `Optional<T>` — `if let`, `guard let`, `?.` |
| C# | `null`; nullable reference types `string?` warn on use |

```typescript
// TypeScript — optional property + guard
type Probe = { url?: string };
function endpoint(p: Probe): string {
  if (!p.url) throw new Error("url required");
  return p.url;
}
```

```kotlin
// Kotlin — nullable type drives the type checker
fun endpoint(url: String?): String = url ?: throw IllegalArgumentException("url required")
```

```swift
// Swift — prefer guard let over force-unwrap !
guard let url = URL(string: raw) else { fatalError("bad url") }
```

### Equality gotchas

| Language | Gotcha |
|----------|--------|
| **JavaScript** | `===` vs `==` (coercion)—prefer `===` |
| **PHP** | **Type juggling** with `==`; use `===` for strict |
| **Python** | `is` vs `==` (`is` for identity, e.g. `None`) |
| **C#** | Value vs reference equality; override `Equals`/`GetHashCode` for custom types |
| **Java** | `.equals()` vs `==` on objects |
| **Go** | `==` works on comparable types; slices/maps not comparable with `==` |
| **Rust** | `==` via `PartialEq`; no implicit coercion |

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

```csharp
// C# — reference types may compare by reference unless overridden
object a = "x";
object b = "x";
Console.WriteLine(a == b); // often true for interned strings; don't rely on it for all types
```

### Truthiness

Know each language’s **falsy** set before writing `if (value)`:

| Language | Falsy examples |
|----------|----------------|
| JavaScript | `0`, `""`, `NaN`, `null`, `undefined`, `false` |
| PHP | `false`, `0`, `0.0`, `""`, `"0"`, `[]`, `null` |
| Python | `False`, `None`, `0`, `""`, empty containers |
| Go | only `false` for booleans; `if` requires bool—no truthy ints |
| Rust | no truthy `if` on non-bool |
| Java/Kotlin/Swift/C# | generally bool-only conditions in `if` |

---

## Async and concurrency (fundamentals)

This section is **syntax and models** only. Operational concurrency (thread pools, backpressure, UI main thread) lives in [Software engineering — Concurrency basics](software-engineering.md#concurrency-basics).

| Lang | Model | Typical spelling |
|------|--------|------------------|
| **JavaScript** | Event loop; Promises; `async`/`await` | `await fetch(url)` |
| **TypeScript** | Same as JS + typed `Promise<T>` | `async function run(): Promise<void>` |
| **PHP** | Often **sync per request** (FPM); fibers/ReactPHP/Swoole for async servers | `await` in Amp/ReactPHP ecosystems |
| **Go** | Goroutines + channels; `go fn()` | `go worker()` · `context` for cancel |
| **Rust** | `async`/`await` + runtime (Tokio) | `async fn` · `.await` |
| **Java** | `ExecutorService`, virtual threads (21+) | `CompletableFuture` |
| **Kotlin** | Coroutines | `suspend fun` · `launch` |
| **Swift** | Structured concurrency | `async let` · `Task` · `await` |
| **C#** | `Task` + `async`/`await` | `async Task<T>` |

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

```swift
// Swift — async entry (@main CLI probe)
@main
struct App {
    static func main() async throws {
        let (data, _) = try await URLSession.shared.data(from: url)
    }
}
```

---

## Language-specific extras

Short list of **non-obvious** items worth knowing when you leave JS/PHP—not full courses.

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

- **Ownership / borrow checker** — one mutable borrow OR many immutable borrows.
- **`trait`** — shared behavior; no inheritance.
- **Crate ecosystem** — `cargo` · `Cargo.toml` lockfile. Pattern matching: [Enums, unions, and pattern matching](#enums-unions-and-pattern-matching).

### Java

- **Checked exceptions** — some APIs force `throws` or `try/catch` at compile time.
- **Generics erasure** — runtime type info limited.
- **Maven/Gradle** — JAR packaging; `java.net.http` in modern JDK.

### Kotlin

- **Null safety in types** — `String` vs `String?`.
- **Data classes** — `data class User(val id: String)` for DTOs.
- **Coroutines** — preferred async story on Android and Ktor.

### Swift

- **Struct vs class** — prefer struct for small value models.
- **Optionals** — avoid `!` force-unwrap in production paths.
- **ARC** — reference cycles on classes; `weak`/`unowned`.
- **Actors / MainActor** — UI isolation on Apple platforms.

### C#

- **Properties** — `get; set;` instead of Java-style getters only.
- **Nullable reference types** — `string?` warnings.
- **async Task** — library I/O standard on .NET.
- **Unity** — `MonoBehaviour` lifecycle vs server ASP.NET (same language, different framework).

---

## Python (scripting lane)

Python is common in backends and ML but has **no dedicated exploration sandbox** in this repo. Use this subsection when you read Python next to JS/PHP services.

| Idea | Python |
|------|--------|
| Binding | `name = "Ada"` · no `const`; convention `UPPER` for constants |
| Operators | `and` `or` `not` · `//` floor div · `**` pow · no `++` |
| Conditionals | `if`/`elif`/`else` · `match` (3.10+) |
| Loops | `for x in items:` · `while cond:` · `break`/`continue` |
| Functions | `def add(a: int, b: int) -> int:` · `lambda x: x + 1` |
| Classes | `class User:` · `@dataclass` for records |
| Maps / lists | `{"a": 1}` · `[1, 2]` · comprehensions `[x*2 for x in nums]` |
| Imports | `import os` · `from pathlib import Path` |
| Null | `None` · test with `is None` |
| Equality | `==` value · `is` identity |
| Async | `async def` · `await` · `asyncio` |
| Errors | `try` / `except` · raise `ValueError` |

```python
# Python — conditionals and loops
if status == 200:
    label = "ok"
elif status == 404:
    label = "missing"
else:
    label = "other"

for user in users:
    if user.get("skip"):
        continue
    print(user["name"])

# Identity vs value
if x is None:
    pass
if a == b:
    pass
```

```python
# Python — imports and destructuring
from dataclasses import dataclass

@dataclass
class User:
    id: str
    name: str

user = User("u1", "Ada")
id, name = user.id, user.name  # or manual fields
```

Stack map: [docs/stacks/python.md](../stacks/python.md).

---

## Quick reference index

| Concept | Section |
|---------|---------|
| `const` / `let` / `$var` / `let mut` | [Variables and mutability](#variables-and-mutability) |
| `export` / `public` / `pub fn` | [Functions](#functions) |
| Closures / lambdas | [Functions — Closures](#closures-functions-that-capture-surroundings) |
| `class` vs `struct` vs `trait` | [Classes, structs, and interfaces](#classes-structs-and-interfaces) |
| Arrays, maps, sets | [Built-in data structures](#built-in-data-structures) |
| `+` `===` `??` `?.` | [Operators and expressions](#operators-and-expressions) |
| `if` / `switch` / `match` | [Conditionals and branching](#conditionals-and-branching) |
| `for` / `foreach` / `range` | [Loops and iteration](#loops-and-iteration) |
| `import` / `namespace` / `package` | [Modules, imports, and packages](#modules-imports-and-packages) |
| `enum` / union / `when` | [Enums, unions, and pattern matching](#enums-unions-and-pattern-matching) |
| `<T>` generics | [Generics and type parameters](#generics-and-type-parameters) |
| `` `${}` `` / destructuring | [Strings, formatting, and destructuring](#strings-formatting-and-destructuring) |
| `let` scope / casts | [Scope, blocks, and casting](#scope-blocks-and-casting) |
| `(T, error)` vs `Result` vs `try/catch` | [Error handling](#error-handling) |
| `===` vs `==`, `Option`, `?.` | [Null, optionals, equality, and truthiness](#null-optionals-equality-and-truthiness) |
| `async`/`await`, goroutines | [Async and concurrency (fundamentals)](#async-and-concurrency-fundamentals) |
| Ownership, traits, ESM | [Language-specific extras](#language-specific-extras) |

---

## Runnable sandboxes in this repo

| Language | Sandbox |
|----------|---------|
| TypeScript / Node | [node-ts-http-probe](../../exploration-projects/node-ts-http-probe/README.md) |
| Next.js (App Router) | [nextjs-health-route](../../exploration-projects/nextjs-health-route/README.md) |
| PHP / Laravel patterns | [laravel-route-slice](../../exploration-projects/laravel-route-slice/README.md) |
| Go | [go-cli-http-probe](../../exploration-projects/go-cli-http-probe/README.md) |
| Rust | [rust-text-pipeline](../../exploration-projects/rust-text-pipeline/README.md) |
| Java | [java-http-cli](../../exploration-projects/java-http-cli/README.md) |
| Kotlin | [kotlin-http-cli](../../exploration-projects/kotlin-http-cli/README.md) |
| Swift | [swift-http-cli](../../exploration-projects/swift-http-cli/README.md) |
| C# (Unity loop) | [unity-game-loop-intro](../../exploration-projects/unity-game-loop-intro/README.md) |

**Next:** Pick a lane in [exploration-projects/README.md](../../exploration-projects/README.md), or return to [Software engineering](software-engineering.md) for delivery, testing, and observability patterns.
