// =============================================================
// Module 04 – qSQL | 03 – Joins
// =============================================================
// Q supports several join types, each with different semantics.
// All joins operate on tables (plain or keyed).
//
// Join        | Description
// ------------|------------------------------------------------
// lj          | Left join (keyed right table)
// ij          | Inner join (keyed right table)
// pj          | Plus join (adds matching numeric cols; keyed rt)
// uj          | Union join (merges two tables; no key needed)
// aj          | Asof join (time-series prevailing-value join)
// aj0         | Asof join (returns exact match time, not lookup)
// wj / wj1    | Window join (aggregate over time windows)
// =============================================================


// -----------------------------------------------------------------
// Sample tables
// -----------------------------------------------------------------

// Trades table
trades: ([]
  time: 09:30:00.000 09:31:00.000 09:32:00.000 09:33:00.000 09:34:00.000;
  sym:  `AAPL`GOOG`AAPL`MSFT`GOOG;
  qty:  100 200 150 50 300
 )

// Quotes table (bid/ask, keyed by sym)
quotes: ([sym:`AAPL`GOOG`MSFT`IBM]
  bid:  189.2 140.1 372.0 145.0;
  ask:  189.4 140.3 373.0 146.0
 )

// Employee + department tables
emps: ([] id:1 2 3 4; name:`Alice`Bob`Carol`Dave; deptId:10 20 10 30)
depts: ([deptId:10 20 30] deptName:`Engineering`HR`Sales)


// -----------------------------------------------------------------
// 1. Left Join  (lj)
// -----------------------------------------------------------------
// Returns all rows from the LEFT table.
// Matches are looked up in the RIGHT (keyed) table.
// Unmatched rows get null values for right-table columns.

show trades lj quotes
// All trade rows; bid/ask added from quotes where sym matches.
// AAPL → 189.2 / 189.4,  IBM trades (none) → 0n


// -----------------------------------------------------------------
// 2. Inner Join  (ij)
// -----------------------------------------------------------------
// Returns only rows that have a match in both tables.

show trades ij quotes
// Only AAPL, GOOG, MSFT rows (IBM has no trade rows here)
// Unlike lj, unmatched rows are dropped.


// -----------------------------------------------------------------
// 3. Union Join  (uj)
// -----------------------------------------------------------------
// Combines two tables with potentially different schemas.
// Missing columns are filled with nulls.

t1: ([] a:1 2; b:10 20)
t2: ([] a:3 4; c:30 40)
show t1 uj t2
// a b  c
// ------
// 1 10 0N
// 2 20 0N
// 3 0N 30
// 4 0N 40


// -----------------------------------------------------------------
// 4. Plus Join  (pj)
// -----------------------------------------------------------------
// Like lj but ADDS the numeric columns rather than replacing them.
// Right table must be keyed.

base:   ([] sym:`AAPL`GOOG; pnl:100 200f)
adjust: ([sym:`AAPL`GOOG] pnl:50 -30f)

show base pj adjust
// sym  pnl
// ---------
// AAPL 150f   (100 + 50)
// GOOG 170f   (200 + -30)


// -----------------------------------------------------------------
// 5. Asof Join  (aj)
// -----------------------------------------------------------------
// The most important join in time-series / tick data.
// For each row in the LEFT table, it finds the LAST row in the
// RIGHT table where the key columns match AND the time column
// is <= the left-table time.  (Prevailing/last-value join.)
//
// Syntax:  aj[`colList; leftTable; rightTable]
//   - colList must include the time column LAST

// Bid/ask quotes over time (right table – NOT keyed)
quotesTime: ([]
  time: 09:29:00.000 09:30:30.000 09:31:15.000 09:33:30.000;
  sym:  `AAPL       `AAPL        `AAPL         `AAPL;
  bid:  188.9       189.1        189.3         189.6;
  ask:  189.1       189.3        189.5         189.8
 )

tradesAAPL: ([]
  time: 09:30:00.000 09:31:00.000 09:32:00.000 09:34:00.000;
  sym:  `AAPL`AAPL`AAPL`AAPL;
  qty:  100 200 150 50
 )

// For each trade, find the prevailing (most recent prior) bid/ask
show aj[`sym`time; tradesAAPL; quotesTime]
// trade at 09:30 picks up 09:29 quote (bid=188.9)
// trade at 09:31 picks up 09:30:30 quote (bid=189.1)
// trade at 09:32 picks up 09:31:15 quote (bid=189.3)


// -----------------------------------------------------------------
// 6. Window Join  (wj / wj1)
// -----------------------------------------------------------------
// Aggregates over a time window around each left-table row.
//
// Syntax: wj[windows; `cols; leftTable; (rightTable; aggFuncs)]
//   windows = list of (startOffset; endOffset) pairs (in ms)

// For each trade, sum qty in the 60-second window BEFORE the trade
windows: -60000 0 +\: tradesAAPL`time    // 60s before each trade time

show wj[windows; `sym`time; tradesAAPL; (quotesTime; (::;`bid))]
// Retrieves bid values that fall within the window before each trade


// -----------------------------------------------------------------
// 7. Employee-Department lj example (SQL equivalent)
// -----------------------------------------------------------------
// SQL equivalent:
//   SELECT e.id, e.name, d.deptName
//   FROM emps e LEFT JOIN depts d ON e.deptId = d.deptId

show emps lj depts
// id name  deptName
// ------------------
//  1 Alice Engineering
//  2 Bob   HR
//  3 Carol Engineering
//  4 Dave  Sales


// =============================================================
// Key Points
//  * lj  – left join (all left rows; nulls for unmatched right)
//  * ij  – inner join (matched rows only)
//  * uj  – union join (any schema; missing cols → null)
//  * pj  – plus join (adds numeric cols instead of replacing)
//  * aj  – asof join (last matching record up to a time)
//  * wj  – window join (aggregate over time windows per row)
//  * Right table must be KEYED for lj / ij / pj
//  * Right table must be PLAIN (unkeyed) for aj / wj
// =============================================================
