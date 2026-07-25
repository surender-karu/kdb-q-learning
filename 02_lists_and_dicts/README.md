# Module 02 – Lists & Dictionaries

| File | Topic |
|------|-------|
| [01_lists.q](01_lists.q) | Creating lists, `til`, indexing (`#` / `_`), common functions, joining, searching, nested lists |
| [02_dictionaries.q](02_dictionaries.q) | Creating dicts (`!`), access, metadata, update/add/delete keys, merging, arithmetic, `group` |

## Key Takeaways

- `til n` produces `0 1 … n-1` — the most common way to generate a range
- Indexing out-of-bounds returns a **null** value (no exception thrown)
- `#` (take) and `_` (drop) are the primary slicing tools
- A **dictionary** is `keyList ! valueList` — the foundation of every Q table
- `group list` maps each distinct value to the list of indices where it appears
