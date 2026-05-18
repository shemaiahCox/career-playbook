# Side-by-side syntax you will see today

Comments use `//`; full-file teaching comments also use `//!` **at top of Rust files** (documents the module, not a single line).

## Variables

| Idea | Go | Rust | C# (Unity-style) |
|------|-----|------|-------------------|
| Immutable binding | `x := 1` **or** `var x int = 1` | `let x = 1;` | `var x = 1;` (still reassignable unless paired with constraints) · prefer `readonly` fields |
| Explicit mutable | N/A (`:=` with `=` reuse) · use `=` for reassignment | `let mut s = String::from("");` | Change field in Inspector or assign in code |
| Type annotation | `var name string = "Ada"` | `let name: String = String::from("Ada");` | `string name = "Ada";` |

### JavaScript / TypeScript (Node sandbox)

| Idea | JavaScript | TypeScript |
|------|------------|------------|
| Binding | `const url = "https://example.com";` | Same — types annotate intent: `const url: string = "..."` |
| Module exports | `export function helper() {}` | Identical spelling — `.ts` adds compile-time checks |
| Async call | `const res = await fetch(url);` | Same — failures surface as thrown errors unless you `catch` |

### PHP (Laravel slice)

| Idea | Typical spelling |
|------|------------------|
| Variables | `$url = 'https://example.com';` |
| Arrays | `['ok' => true]` (“associative array” maps) |
| Namespaces | `namespace App\Http\Controllers;` |

### Java vs Kotlin (HTTP CLI pair)

| Idea | Java | Kotlin |
|------|------|--------|
| Entry point | `public static void main(String[] args)` | `fun main(args: Array<String>)` |
| Null handling | References may be `null` — guard explicitly | Nullable types `String?`, safe calls `?.`, defaults `?:` |
| String concat | `"status: " + code` | `"status: $code"` or templates |

### Swift (SwiftPM CLI)

| Idea | Typical spelling |
|------|------------------|
| Constants | `let endpoint = URL(string: cli.url)!` (prefer `guard let` in real code) |
| Optionals | `guard let http = response as? HTTPURLResponse else { … }` |
| Async entry | `@main` `enum`/`struct` with `static func main() async { … }` |

## Functions

| Idea | Go | Rust | C# |
|------|-----|------|-----|
| Return one value | `func add(a, b int) int { return a + b }` | `fn add(a: i32, b: i32) -> i32 { a + b }` | `int Add(int a, int b) => a + b;` |
| Multiple returns | `(int, error)` idiomatic | `Result<i32, ParseIntError>` or tuples | Prefer `Try` patterns or tuples for small stuff |

## Error handling snapshot

### Go — returned `error`

```go
resp, err := client.Do(req)
if err != nil {
    fmt.Fprintf(os.Stderr, "request failed: %v\n", err)
    os.Exit(1)
}
defer resp.Body.Close()
```

### Rust — `Result` + `?`

```rust
let file = File::open(&path)?;
// `?` is syntax sugar: unwrap Ok or return Err early to the caller
```

### TypeScript — `try/catch` around `fetch`

```ts
try {
  const response = await fetch(url, { signal: AbortSignal.timeout(3000) });
} catch (err) {
  console.error(`request failed: ${err instanceof Error ? err.message : String(err)}`);
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

### Java / Kotlin — checked exceptions at the HTTP boundary

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

### Swift — `throws` + `do/catch`

```swift
do {
    let (data, response) = try await URLSession.shared.data(for: request)
} catch {
    fputs("request failed: \(error.localizedDescription)\n", stderr)
    exit(1)
}
```

### C# — exceptions (`try/catch`)

```csharp
try {
    var text = File.ReadAllText(path);
}
catch (IOException ex) {
    Debug.LogError(ex);
}
```

**Transferable takeaway:** Different **spelling**, same lesson—decide whether a failure is **expected** (file missing) vs **bug** (logic error).

## Null / optional values

| Language | Typical pattern |
|----------|----------------|
| Go | Pointer `nil`, or sentinel values (less ideal) |
| Rust | **No null** — use `Option<T>` (`Some`/`None`) |
| TypeScript | `strictNullChecks`: unions with `undefined`, optional props `url?` |
| PHP | `null` coalesce `??`, typed properties (`?string`) |
| Java | Nullable references — explicit checks |
| Kotlin | `T?`, Elvis `?:`, safe calls |
| Swift | `Optional<T>` (`if let`, `guard let`, `?.`) |
| C# | Nullable reference types (`string?`), `UnityEngine.Object` overloads `==` with fake null |

## Next step

Return to [README.md](README.md) for ordering and tooling links.
