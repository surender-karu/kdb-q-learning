// =============================================================
// Module 04 – qSQL | 04 – Advanced qSQL Patterns
// =============================================================
// Real-world patterns: running aggregates, VWAP, top-N per group,
// time bucketing, pivots, and performance tips.
// =============================================================


// -----------------------------------------------------------------
// Sample tick data
// -----------------------------------------------------------------

ticks: ([]
  time:  09:30:00.000 09:30:15.000 09:30:30.000 09:31:00.000
         09:31:30.000 09:32:00.000 09:32:30.000 09:33:00.000;
  sym:   `AAPL`AAPL`GOOG`AAPL`GOOG`AAPL`GOOG`MSFT;
  price: 189.3 189.5 140.2 189.8 140.5 190.0 141.0 372.5;
  qty:   100 50 200 150 100 200 300 50
 )

show ticks


// -----------------------------------------------------------------
// 1. VWAP (Volume-Weighted Average Price)
// -----------------------------------------------------------------

// Overall VWAP
show select vwap:(sum price*qty)%sum qty from ticks

// VWAP per symbol
show select vwap:(sum price*qty)%sum qty by sym from ticks


// -----------------------------------------------------------------
// 2. Time Bucketing  (bar / xbar)
// -----------------------------------------------------------------
// `xbar[n; t]`  rounds t DOWN to the nearest multiple of n.
// Use it to bucket timestamps into fixed intervals.

// 1-minute bars
show select
  open:  first price,
  high:  max   price,
  low:   min   price,
  close: last  price,
  volume: sum  qty
  by sym, time: 00:01:00.000 xbar time
  from ticks

// 30-second bars
show select count i by sym, time: 00:00:30.000 xbar time from ticks


// -----------------------------------------------------------------
// 3. Running / Cumulative Aggregates (sums, maxs, etc.)
// -----------------------------------------------------------------
// Running functions: sums, prds, maxs, mins, avgs, deltas, ratios

// Cumulative qty per row (sorted by time)
show select time, sym, qty, cumQty: sums qty from ticks

// Running maximum price per sym using `fby`
show select time, sym, price, runMax: maxs price by sym from ticks


// -----------------------------------------------------------------
// 4. Top-N rows per group  (rank with `iasc` / `idesc`)
// -----------------------------------------------------------------
// Top 2 prices per sym

// Method: select + rank within group using `rank` equivalent
topN: {[t; n; col; grp]
  grouped: select i by grp from t;
  idxList: raze {[rows; n] n # rows idesc t[col][rows]} [;n] each value grouped;
  t[asc idxList]
 }

show topN[ticks; 2; `price; `sym]


// -----------------------------------------------------------------
// 5. Pivoting a Table  (manual)
// -----------------------------------------------------------------
// Q doesn't have built-in PIVOT, but exec + flip does the job.

// Distinct symbols
syms: distinct ticks`sym

// Build a pivot: rows=time-bucket, cols=sym, values=avg price
pivot: exec avg price by time: 00:01:00.000 xbar time, sym from ticks
show pivot


// -----------------------------------------------------------------
// 6. Lag / Lead  (prev / next values)
// -----------------------------------------------------------------

priceCol: select time, sym, price from ticks where sym=`AAPL

show update
  prevPrice: prev price,
  nextPrice: next price,
  priceChange: price - prev price
  from priceCol


// -----------------------------------------------------------------
// 7. Moving Averages with `mavg`
// -----------------------------------------------------------------
// `mavg[n; list]` computes n-period moving average.

prices: (select price from ticks where sym=`AAPL)`price

show prices
show 3 mavg prices    // 3-period moving average
show 3 msum prices    // 3-period moving sum
show 3 mmax prices    // 3-period moving max
show 3 mmin prices    // 3-period moving min
show 3 mdev prices    // 3-period moving standard deviation


// -----------------------------------------------------------------
// 8. Distinct / Unique Row Count
// -----------------------------------------------------------------

show count distinct ticks`sym     // number of unique symbols
show select count distinct sym from ticks   // same, inline


// -----------------------------------------------------------------
// 9. String Matching with `like`
// -----------------------------------------------------------------
// `like` supports basic wildcards: * (any chars), ? (single char)

symsTable: ([] sym:`AAPL`GOOG`GOOGL`MSFT`AMZN; price:100 200 210 150 120f)

show select from symsTable where sym like "GOO*"    // GOOG, GOOGL
show select from symsTable where sym like "????"    // 4-char syms


// -----------------------------------------------------------------
// 10. Performance Tips
// -----------------------------------------------------------------
// ┌─────────────────────────────────────────────────────────────┐
// │ 1. Filter early (WHERE before BY): narrow data first        │
// │ 2. Use `p# or `g# attributes on frequently-filtered cols   │
// │ 3. For partitioned HDB: ensure date/sym in WHERE to prune   │
// │ 4. Use `i` (row index) rather than count on large scans     │
// │ 5. `exec` is faster than `select` for single-column results │
// └─────────────────────────────────────────────────────────────┘


// =============================================================
// Key Points
//  * VWAP: (sum price*qty) % sum qty
//  * xbar: time bucketing – round down to interval
//  * sums/maxs/mins/avgs: running (cumulative) versions
//  * prev / next: lag / lead a column
//  * mavg / msum / mmax: moving window functions
//  * `like` for wildcard string matching in WHERE
// =============================================================
