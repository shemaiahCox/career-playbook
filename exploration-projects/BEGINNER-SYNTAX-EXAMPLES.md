# Side-by-side syntax you will see today

Comments use `//`; full-file teaching comments also use `//!` **at top of Rust files** (documents the module, not a single line).

## Variables

| Idea | Go | Rust | C# (Unity-style) |
|------|-----|------|-------------------|
| Immutable binding | `x := 1` **or** `var x int = 1` | `let x = 1;` | `var x = 1;` (still reassignable unless paired with constraints) · prefer `readonly` fields |
| Explicit mutable | N/A (`:=` with `=` reuse) · use `=` for reassignment | `let mut s = String::from("");` | Change field in Inspector or assign in code |
| Type annotation | `var name string = "Ada"` | `let name: String = String::from("Ada");` | `string name = "Ada";` |

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
| C# | Nullable reference types (`string?`), `UnityEngine.Object` overloads `==` with fake null |

## Next step

Return to [README.md](README.md) for ordering and tooling links.
