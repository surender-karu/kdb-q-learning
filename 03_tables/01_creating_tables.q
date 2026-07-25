// =============================================================
// Module 03 – Tables | 01 – Creating and Inspecting Tables
// =============================================================
// A Q *table* is a list of dictionaries that all share the same keys.
// Equivalently, it is a flipped dictionary of equal-length lists.
// Tables are the primary data structure used with qSQL.
// =============================================================


// -------------------------------------------------------------
// 1. Creating a Table with  ([]  ...)
// -------------------------------------------------------------

// The most common form: column definitions inside []
t: ([] name:`Alice`Bob`Carol; age:25 30 28; city:`NYC`LA`Chicago)
show t
// name  age city
// -----------------------
// Alice  25 NYC
// Bob    30 LA
// Carol  28 Chicago

// Column types are inferred from the data
show meta t
// c   | t f a
// ----| -----
// name| s
// age | j
// city| s


// -------------------------------------------------------------
// 2. Creating a Table with `flip` (dictionary → table)
// -------------------------------------------------------------

d: `name`age ! (`Alice`Bob`Carol; 25 30 28)
t2: flip d
show t2


// -------------------------------------------------------------
// 3. Table Metadata
// -------------------------------------------------------------

show cols t          // `name`age`city  (column names)
show count t         // 3               (number of rows)
show meta t          // schema: column name, type char, foreign key, attribute
show type t          // 98h             (tables are type 98h)


// -------------------------------------------------------------
// 4. Accessing Columns and Rows
// -------------------------------------------------------------

// Column access – returns a list
show t[`name]         // `Alice`Bob`Carol
show t`age            // 25 30 28  (same syntax as dict access)

// Row access – returns a dictionary
show t[0]             // name| `Alice  age| 25  city| `NYC

// Row range
show t[0 1]           // first two rows as a table


// -------------------------------------------------------------
// 5. Adding / Removing Columns
// -------------------------------------------------------------

// Add a new column by updating the table variable
t: update salary: 80000 90000 75000 from t
show t

// Drop a column using `_`
t3: delete salary from t
show t3


// -------------------------------------------------------------
// 6. Inserting Rows  (`insert`)
// -------------------------------------------------------------

employees: ([] name:`symbol$(); age:`long$(); city:`symbol$())

// Single row
`employees insert (`David; 35; `Boston)

// Multiple rows
`employees insert ([] name:`Eve`Frank; age:22 40; city:`Miami`Seattle)

show employees
show count employees   // 3


// -------------------------------------------------------------
// 7. Upsert  (`,` or `upsert`)
// -------------------------------------------------------------
// For plain (unkeyed) tables, `upsert` is the same as `,`:

t4: ([] x:1 2 3)
t4 upsert ([] x:4 5)
show t4


// -------------------------------------------------------------
// 8. Keyed Tables
// -------------------------------------------------------------
// A keyed table maps a primary-key table to a value table.
// Created with: n!t  (n = number of key columns)

kt: 1!([] id:1 2 3; name:`Alice`Bob`Carol; score:95 87 92)
show kt
// id| name  score
// --|------------
//  1| Alice    95
//  2| Bob      87
//  3| Carol    92

show type kt           // 99h  (keyed table = dictionary type)
show keys kt           // `id
show cols kt           // `id`name`score (all columns including keys)

// Lookup a row by key
show kt[enlist 1]      // name| Alice  score| 95

// Upsert by key (update if key exists, insert if not)
`kt upsert ([] id:enlist 4; name:enlist `Dave; score:enlist 88)
show kt


// -------------------------------------------------------------
// 9. Sorting a Table
// -------------------------------------------------------------

data: ([] name:`c`a`b; score:30 10 20)
show `score xasc data     // ascending by score
show `score xdesc data    // descending by score


// =============================================================
// Key Points
//  * Table syntax: ([] col1:list1; col2:list2; ...)
//  * `meta` gives the schema (column types)
//  * `count` = row count,  `cols` = column names
//  * Keyed table: n!table  (n = # of key columns)
//  * `insert` adds rows; `upsert` inserts or updates
//  * `xasc` / `xdesc` sort by column
// =============================================================
