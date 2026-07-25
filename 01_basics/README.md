# Module 01 – Basics

This module covers the fundamental building blocks of the Q language.

| File | Topic |
|------|-------|
| [01_data_types.q](01_data_types.q) | Atoms: integers, floats, booleans, chars, symbols, date/time; type codes; null values; casting |
| [02_operators.q](02_operators.q) | Arithmetic (`%` for division), comparison, logical, atomic extension, math functions, string ops |
| [03_control_flow.q](03_control_flow.q) | Conditionals (`$[]`), defining functions (`{[]}`), implicit args (`x y z`), recursion, loops, error trapping |

## How to Run

```bash
# Load a specific file
q 01_basics/01_data_types.q

# Or start Q and load interactively
q
\l 01_basics/01_data_types.q
```

## Key Takeaways

- Q is **type-rich**: integers come in three widths (long/int/short); always check `type` to confirm
- Division uses **`%`** (not `/`); `/` is an adverb (covered in module 05)
- Most operators are **atomic**: applying `+ 10` to a list adds 10 to every element automatically
- A **symbol** (`` `name ``) is an interned string — much faster than a character list for lookups
- Functions are **lambdas**: `{[a;b] a+b}` — the last expression is the return value
