// =============================================================
// Module 05 – Advanced | 03 – File I/O and HDB (Historical DB)
// =============================================================
// Q can read and write data in several formats:
//   - Native binary files and splayed / partitioned tables
//   - CSV, text, and JSON
//   - IPC (inter-process communication)
// =============================================================


// -----------------------------------------------------------------
// 1. Writing and Reading Binary Files  (set / get)
// -----------------------------------------------------------------
// `set` saves any Q object to a file in native binary format.
// `get` (or @[get;path;::]) loads it back.

// Create sample data
myData: ([] sym:`AAPL`GOOG`MSFT; price:189.3 140.2 372.5)

// Save to disk
`:data/myData set myData

// Load from disk
loaded: get `:data/myData
show loaded


// -----------------------------------------------------------------
// 2. Splayed Tables
// -----------------------------------------------------------------
// A splayed table writes each column as a separate file,
// enabling per-column memory-mapping (very efficient).

// Write (splay)
`:data/trades/ set ([]
  sym:   `AAPL`GOOG`MSFT;
  price: 189.3 140.2 372.5;
  qty:   100 200 150
 )

// Read (loads lazily – columns are memory-mapped)
t: get `:data/trades/
show t


// -----------------------------------------------------------------
// 3. Partitioned Tables (HDB – Historical Database)
// -----------------------------------------------------------------
// Partition tables by date (or other column).  Each partition
// is stored in a subdirectory named after the partition value.
//
// Directory structure:
//   hdb/
//     2024.01.15/
//       trades/  (splayed table files)
//     2024.01.16/
//       trades/

hdbPath: `:hdb

// Write a day's worth of data
trades15: ([] sym:`AAPL`GOOG; price:189.3 140.2; qty:100 200)
trades16: ([] sym:`MSFT`AAPL; price:372.5 190.1; qty:50 150)

// Each partition directory: hdb/<date>/trades/
(hdbPath,`$"2024.01.15/trades/") set trades15
(hdbPath,`$"2024.01.16/trades/") set trades16

// Create the partition descriptor
// (In production, `.Q.dpft` handles this automatically.)

// Load the HDB
// \l hdb      ← run this in Q REPL to load the partitioned DB
// After loading, `trades` becomes a virtual partitioned table.
//
// select from trades where date=2024.01.15
// select from trades where date within 2024.01.15 2024.01.16


// -----------------------------------------------------------------
// 4. CSV / Text I/O
// -----------------------------------------------------------------
// `0:` handles text-based file I/O.

// Write a list of strings to a file (one per line)
`:data/output.csv 0: "sym,price,qty" , "," sv' flip (string trades15`sym; string trades15`price; string trades15`qty)

// Read a CSV file
// ("SSF";",") 0: `:data/output.csv
//   - "SSF" = column types (symbol, symbol, float); one char per col
//   - "," = delimiter
// (handles headers with 1_)

// Simple text read (all lines as strings)
raw: read0 `:data/output.csv
show raw


// -----------------------------------------------------------------
// 5. JSON I/O  (.j library)
// -----------------------------------------------------------------

// Serialize Q object to JSON
j: .j.j ([] name:`Alice`Bob; score:95 87)
show j          // "[{\"name\":\"Alice\",\"score\":95}...]"

// Parse JSON back to Q
show .j.k j


// -----------------------------------------------------------------
// 6. IPC – Connecting to Another Q Process
// -----------------------------------------------------------------
// Open a handle to a remote Q process:
//   h: hopen `:host:port
//   h "2+2"         ← synchronous call; returns result
//   h (neg h) expr  ← asynchronous call (fire and forget)
//   hclose h        ← close the connection

// Example (runs only if a Q process is listening on port 5000):
// h: hopen `:localhost:5000
// show h "select from trades where date=.z.d"
// hclose h


// -----------------------------------------------------------------
// 7. Useful .Q Utilities
// -----------------------------------------------------------------
// .Q namespace contains helper functions for HDB management.

show .Q.t    // type-to-char mapping dictionary
show .Q.ty   // reverse: char-to-type

// .Q.dpft – save a partitioned table
// .Q.dpft[dbDir; date; `sym; `tableName]
// (standard pattern to write a daily partition with sym enumeration)


// =============================================================
// Key Points
//  * `set` / `get`  – binary serialisation (fastest format)
//  * Splayed table: each column is a separate file (`:path/ set t`)
//  * Partitioned HDB: directories named by partition value
//  * `0:` handles CSV/text; `read0` reads raw lines
//  * `.j.j` / `.j.k`  – JSON encode / decode
//  * `hopen` / `hclose` – IPC to other Q processes
// =============================================================
