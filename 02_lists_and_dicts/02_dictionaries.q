// =============================================================
// Module 02 – Lists & Dictionaries | 02 – Dictionaries
// =============================================================
// A Q *dictionary* maps a list of keys to a list of values.
// It is written as  keys ! values
// Dictionaries are the foundation of Q tables.
// =============================================================


// -------------------------------------------------------------
// 1. Creating a Dictionary
// -------------------------------------------------------------
// Syntax:  keyList ! valueList  (both lists must have the same count)

d: `name`age`city ! ("Alice"; 30; "New York")
show d
// name| "Alice"
// age | 30
// city| "New York"

// Symbol keys with numeric values
prices: `AAPL`GOOG`MSFT ! 189.3 140.2 372.5
show prices


// -------------------------------------------------------------
// 2. Accessing Values
// -------------------------------------------------------------

show d[`name]          // "Alice"
show d `age            // 30     (same as d[`age])
show prices[`GOOG]     // 140.2

// Access multiple keys at once → returns a list
show prices[`AAPL`MSFT]   // 189.3 372.5


// -------------------------------------------------------------
// 3. Dictionary Metadata
// -------------------------------------------------------------

show key   d       // `name`age`city
show value d       // ("Alice"; 30; "New York")
show count d       // 3


// -------------------------------------------------------------
// 4. Updating and Adding Keys
// -------------------------------------------------------------

d[`age]: 31                // update existing key
show d[`age]               // 31

d[`country]: "USA"         // add a new key
show d


// -------------------------------------------------------------
// 5. Checking for Key Membership
// -------------------------------------------------------------

show `name in key d        // 1b
show `email in key d       // 0b


// -------------------------------------------------------------
// 6. Removing a Key  (using `_`)
// -------------------------------------------------------------

d2: `a`b`c ! 1 2 3
show `b _ d2              // `a`c!1 3  (key `b removed)


// -------------------------------------------------------------
// 7. Merging Dictionaries  (using ,)
// -------------------------------------------------------------
// Right-hand side wins on key conflicts.

d3: `a`b ! 1 2
d4: `b`c ! 20 3
show d3 , d4      // `a`b`c!1 20 3  (b updated by d4)


// -------------------------------------------------------------
// 8. Arithmetic on Dictionary Values
// -------------------------------------------------------------
// Arithmetic is atomic and applies key-by-key.

portfolio: `AAPL`GOOG`MSFT ! 100 50 200     // share counts
pricePer:  `AAPL`GOOG`MSFT ! 189.3 140.2 372.5

show portfolio * pricePer
// AAPL| 18930f
// GOOG|  7010f
// MSFT| 74500f

// Sum all values
show sum value (portfolio * pricePer)


// -------------------------------------------------------------
// 9. Group  –  build a dictionary from a list
// -------------------------------------------------------------
// `group` maps each distinct value to the indices where it occurs.

data: `a`b`a`c`b`a
show group data
// a| 0 2 5
// b| 1 4
// c| ,3


// -------------------------------------------------------------
// 10. xgroup / by-key grouping
// -------------------------------------------------------------
// `key!` applied to a table produces a keyed table (see module 03).
// Here we use a manual approach:

cities: `NYC`LA`NYC`CHI`LA`NYC
temps:  72 85 68 55 90 75

// Group temperature readings by city
g: group cities
show g
show avg each temps[g]
// NYC| 71.66667
// LA | 87.5
// CHI| 55f


// =============================================================
// Key Points
//  * Dictionary = keys ! values
//  * Access: d[`key]  or  d `key
//  * `key d` = key list,  `value d` = value list
//  * `,` merges (right wins on duplicates)
//  * `_` removes a key
//  * `group` creates a dictionary of indices by distinct value
// =============================================================
