// =============================================================
// Module 03 – Tables | 02 – Table Operations
// =============================================================
// Common operations: column manipulation, sorting, grouping,
// attributes (for performance), and basic table functions.
// =============================================================


// -----------------------------------------------------------------
// Sample table used throughout this file
// -----------------------------------------------------------------
trades: ([]
  time:  09:30:00.000 09:31:00.000 09:31:30.000 09:32:00.000 09:33:00.000;
  sym:   `AAPL`GOOG`AAPL`MSFT`GOOG;
  side:  `buy`sell`buy`buy`sell;
  price: 189.3 140.2 189.8 372.5 141.0;
  qty:   100 200 150 50 300
 )

show trades


// -----------------------------------------------------------------
// 1. Adding a Computed Column
// -----------------------------------------------------------------

// Use `update` to add/modify a column
trades: update value: price * qty from trades
show trades


// -----------------------------------------------------------------
// 2. Column Arithmetic
// -----------------------------------------------------------------

show trades`value        // all values as a list
show sum trades`value    // total traded value


// -----------------------------------------------------------------
// 3. Sorting
// -----------------------------------------------------------------

show `price xasc  trades    // ascending by price
show `price xdesc trades    // descending by price
show `sym`price xasc trades // sort by sym, then price


// -----------------------------------------------------------------
// 4. Renaming Columns  (`xcol`)
// -----------------------------------------------------------------

// Rename qty → quantity
show `time`sym`side`price`quantity xcol trades


// -----------------------------------------------------------------
// 5. Reordering Columns  (`xcols`)
// -----------------------------------------------------------------

show `sym`price`qty xcols trades    // sym first, then price, qty (rest follow)


// -----------------------------------------------------------------
// 6. Selecting Specific Columns
// -----------------------------------------------------------------

// Pure column projection using #
show `sym`price # trades             // only sym and price columns


// -----------------------------------------------------------------
// 7. Enumerating / Applying Attributes
// -----------------------------------------------------------------
// Attributes can dramatically speed up queries on large tables.
//
//  `s  – sorted   (enables binary search for = and > queries)
//  `u  – unique   (hash-map index; column values must be unique)
//  `p  – parted   (groups of equal values; fast for group/by)
//  `g  – grouped  (general index; any order)
//
// Apply with: `attr$list

sortedSyms: `p#`AAPL`AAPL`GOOG`MSFT`MSFT
show attr sortedSyms    // `p

// On a table column:
trades: update sym:`g#sym from trades
show attr trades`sym    // `g


// -----------------------------------------------------------------
// 8. fby  (filter-by: aggregate in where clause)
// -----------------------------------------------------------------
// fby lets you filter rows based on a per-group aggregate.
// Syntax:  (aggregate;col) fby groupCol

// Rows where the price equals the max price for their sym
show select from trades where price = (max;price) fby sym


// -----------------------------------------------------------------
// 9. Cross product  (`cross`)
// -----------------------------------------------------------------

show `a`b cross 1 2 3
// a 1
// a 2
// a 3
// b 1
// b 2
// b 3


// -----------------------------------------------------------------
// 10. Pivoting  (manual)
// -----------------------------------------------------------------
// Q does not have a built-in pivot; use exec + xkey + flip.

// Total qty per sym per side
aggr: select qty by sym, side from trades
show aggr

// Pivot: sym as rows, side values as columns
pivot: exec qty by sym:sym from trades
show pivot


// =============================================================
// Key Points
//  * `update col:expr from t` adds/modifies a column
//  * `xcol` renames columns, `xcols` reorders them
//  * `#` projects (keeps) named columns
//  * Attributes (`s`, `u`, `p`, `g`) speed up lookups
//  * `fby` enables aggregate-based row filtering
//  * `xasc` / `xdesc` accept a list of column names for multi-key sort
// =============================================================
