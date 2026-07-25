// =============================================================
// Module 04 – qSQL | 01 – SELECT Queries
// =============================================================
// qSQL is a superset of ANSI SQL built into Q.
// Syntax:  select [cols] [by groupCols] from table [where conditions]
// =============================================================


// -----------------------------------------------------------------
// Sample data used throughout this module
// -----------------------------------------------------------------

trades: ([]
  date:  2024.01.15 2024.01.15 2024.01.15 2024.01.16 2024.01.16 2024.01.16;
  time:  09:30:00.000 09:31:00.000 09:32:00.000 09:30:00.000 09:31:00.000 09:32:00.000;
  sym:   `AAPL`GOOG`AAPL`MSFT`GOOG`AAPL;
  side:  `buy`sell`buy`buy`sell`sell;
  price: 189.3 140.2 189.8 372.5 141.0 188.5;
  qty:   100 200 150 50 300 200
 )

show trades


// -----------------------------------------------------------------
// 1. Select All Columns
// -----------------------------------------------------------------

show select from trades


// -----------------------------------------------------------------
// 2. Select Specific Columns
// -----------------------------------------------------------------

show select sym, price, qty from trades


// -----------------------------------------------------------------
// 3. Computed Columns (Derived Columns)
// -----------------------------------------------------------------

show select sym, price, qty, value:price*qty from trades


// -----------------------------------------------------------------
// 4. WHERE Clause
// -----------------------------------------------------------------

// Single condition
show select from trades where sym=`AAPL

// Multiple conditions (each condition is a separate argument)
show select from trades where sym=`AAPL, side=`buy

// Range condition
show select from trades where price > 180

// Multiple symbols  (use `in`)
show select from trades where sym in `AAPL`MSFT

// Date range
show select from trades where date within 2024.01.15 2024.01.16

// Combining conditions
show select sym, price from trades where sym=`GOOG, price < 141


// -----------------------------------------------------------------
// 5. BY Clause (GROUP BY)
// -----------------------------------------------------------------
// `by` groups rows and applies aggregations per group.

// Count rows per sym
show select count i by sym from trades

// Average price per sym
show select avg price by sym from trades

// Multiple aggregations
show select
  totalQty:sum qty,
  avgPrice:avg price,
  maxPrice:max price,
  minPrice:min price
  by sym from trades

// Group by multiple columns
show select sum qty by sym, side from trades

// Group by date and sym
show select sum qty, avg price by date, sym from trades


// -----------------------------------------------------------------
// 6. Column Aliases in SELECT
// -----------------------------------------------------------------

show select ticker:sym, lastPrice:price from trades where date=2024.01.16


// -----------------------------------------------------------------
// 7. ORDER BY  (`xasc` / `xdesc` applied to query result)
// -----------------------------------------------------------------

// Sort result ascending by price
show `price xasc select sym, price from trades

// Sort descending by value
show `value xdesc select sym, price, qty, value:price*qty from trades


// -----------------------------------------------------------------
// 8. LIMIT  (take first n rows)
// -----------------------------------------------------------------

show 3 # select from trades     // first 3 rows
show -3 # select from trades    // last 3 rows


// -----------------------------------------------------------------
// 9. Aggregation Functions in SELECT
// -----------------------------------------------------------------

// Without `by` = single-row aggregate result
show select
  totalTrades: count i,
  totalQty:    sum qty,
  avgPrice:    avg price,
  vwap:        (sum price*qty) % sum qty
  from trades


// -----------------------------------------------------------------
// 10. exec vs select
// -----------------------------------------------------------------
// `exec` returns simpler structures than `select`:
//  - single column  → returns a list (not a table)
//  - multiple cols  → returns a dictionary
//  - with `by`      → returns a dictionary keyed by group

// Returns a list (not a 1-column table)
show exec sym from trades

// Returns a dictionary
show exec sym, price from trades

// Returns a dictionary per group
show exec price by sym from trades


// =============================================================
// Key Points
//  * Full syntax: select [cols] [by groups] from t [where conds]
//  * WHERE conditions are comma-separated boolean expressions
//  * `by` = GROUP BY; all non-aggregated cols must be listed in `by`
//  * `i` is the virtual row-index column (useful for count)
//  * `exec` unwraps the result to lists/dicts instead of a table
//  * Apply `xasc`/`xdesc` to the result for ORDER BY
// =============================================================
