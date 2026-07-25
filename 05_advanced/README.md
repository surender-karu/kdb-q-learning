# Module 05 – Advanced

| File | Topic |
|------|-------|
| [01_functions.q](01_functions.q) | First-class functions, projections, closures, composition, namespaces, protected eval |
| [02_adverbs.q](02_adverbs.q) | `each`, `each-left`/`each-right`, `over` (fold), `scan` (running), converge, `peach` |
| [03_file_io.q](03_file_io.q) | `set`/`get`, splayed tables, partitioned HDB, CSV (`0:`), JSON (`.j`), IPC (`hopen`) |

## Adverb Quick Reference

| Adverb | Syntax | Meaning |
|--------|--------|---------|
| each | `f each list` | Map f over every element |
| each-left | `f \: y` | f[x; each y] for fixed x |
| each-right | `f /: x` | f[each x; y] for fixed y |
| over | `f/ list` | Fold – single accumulated result |
| scan | `f\ list` | Running fold – result at every step |
| n-times | `n f/ x` | Apply f exactly n times |
| converge | `f/ x` (single arg) | Apply until fixed point |
| peach | `f peach list` | Parallel each |

## Key Takeaways

- **Projections** (`f[; y]`) are Q's partial application — great for creating specialised functions on the fly
- **`over` (`/`) and `scan` (`\`)** replace most imperative loops — prefer them over `while`
- `peach` gives free parallelism in multi-threaded Q processes
- Native binary `set`/`get` is the fastest serialisation; use it for inter-process or cached data
- A **partitioned HDB** stores each day's data in its own directory; KDB+ memory-maps columns on demand
