# Module 04 – qSQL

| File | Topic |
|------|-------|
| [01_select.q](01_select.q) | `select`, `where`, `by`, computed cols, `exec`, ordering, limiting |
| [02_update_delete.q](02_update_delete.q) | `update`, conditional update, `delete` rows/cols, `insert`, `upsert` |
| [03_joins.q](03_joins.q) | `lj`, `ij`, `uj`, `pj`, `aj` (asof), `wj` (window join) |
| [04_advanced_qsql.q](04_advanced_qsql.q) | VWAP, time bucketing (`xbar`), running aggregates, top-N, moving averages, `like` |

## qSQL Quick-Reference Syntax

```q
// SELECT
select [col:expr, ...] [by groupCol, ...] from table [where cond, ...]

// UPDATE
update col:expr [, col2:expr] from table [where cond, ...]

// DELETE rows
delete from table where condition

// DELETE column
delete colName from table

// INSERT
`table insert (val1; val2; ...)
`table insert ([] col1:list1; col2:list2)

// UPSERT (keyed table)
`keyedTable upsert ([] keyCol:vals; col2:vals)
```

## Join Cheatsheet

| Join | Right table | Returns |
|------|-------------|---------|
| `lj` | keyed | All left rows; null for unmatched |
| `ij` | keyed | Matched rows only |
| `pj` | keyed | Left rows; numeric cols are summed |
| `uj` | plain | All rows from both; missing cols → null |
| `aj` | plain | Left rows + prevailing right row at/before time |
| `wj` | plain | Left rows + aggregates over time window |

## Key Takeaways

- qSQL reads like SQL but uses **commas** to separate `where` conditions (not `AND`)
- `by` is GROUP BY — must aggregate all selected columns not in `by`
- `i` is a virtual column for the **row index** (use `count i` instead of `count *`)
- `xbar` is essential for **time-series bucketing** (OHLC bars)
- `aj` (asof join) is the workhorse for **tick data** — finds the last prior quote for each trade
