# Module 03 – Tables

| File | Topic |
|------|-------|
| [01_creating_tables.q](01_creating_tables.q) | Table syntax, `flip`, `meta`, column/row access, `insert`, `upsert`, keyed tables, sorting |
| [02_table_operations.q](02_table_operations.q) | Computed columns, `xcol`/`xcols`, column projection, attributes, `fby`, cross product, pivoting |

## Key Takeaways

- A table is a **flipped dictionary**: `flip (col1:list1; col2:list2; ...)`
- `meta t` shows the **schema** (column names + type codes)
- A **keyed table** is `n!t` — the first `n` columns form the primary key (type 99h)
- **Attributes** (`` `s ``, `` `u ``, `` `p ``, `` `g ``) are added to columns to enable faster lookups
- `fby` is powerful for "filter where metric equals per-group aggregate" patterns
