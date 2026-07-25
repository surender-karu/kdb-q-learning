// =============================================================
// Module 05 – Advanced | 02 – Adverbs (Iterators)
// =============================================================
// Adverbs transform functions to work on lists or accumulate
// results across iterations.  They replace most explicit loops.
//
// Adverb   | Syntax          | Description
// ---------|-----------------|-------------------------------------
// each     | f each list     | Apply f to each element
// each'    | f ' list        | Same as `each`
// each-left | f \: list      | Apply f[x; each y]
// each-right| f /: list      | Apply f[each x; y]
// over     | f/ list         | Fold/reduce: accumulate single result
// scan     | f\ list         | Running result at each step (prefix scan)
// =============================================================


// -----------------------------------------------------------------
// 1. each  (map)
// -----------------------------------------------------------------
// Apply a function to every element of a list.

show sqrt each 1 4 9 16 25      // 1 2 3 4 5f
show {x*x} each 1 2 3 4 5       // 1 4 9 16 25

// `each` also works element-wise on two lists
show {x + y} ' [1 2 3; 10 20 30]  // 11 22 33

// Short-circuit synonym: just use the atomic nature of most builtins
show sqrt 1 4 9 16 25           // same result, no `each` needed for atomic fns


// -----------------------------------------------------------------
// 2. each-left (\:) and each-right (/:)
// -----------------------------------------------------------------
// f \: y  →  apply f to each y with a FIXED first argument
// f /: x  →  apply f to each x with a FIXED second argument

// "Does each sym in the master list appear in each trade list?"
syms:   `AAPL`GOOG`MSFT
trades: `AAPL`GOOG`AAPL`MSFT`IBM

show syms in\: (trades; `GOOG`MSFT)
// AAPL| 1 0
// GOOG| 1 1
// MSFT| 1 1

// Concatenate each string in a list with a fixed suffix
show {x , ".csv"} each string `trades`quotes`orders
// "trades.csv" "quotes.csv" "orders.csv"

// \: vs /:  (cross-product style)
show 1 2 3 +\: 10 20    // each LEFT element + each RIGHT list
// 11 21
// 12 22
// 13 23

show 1 2 3 +/: 10 20    // each RIGHT element + each LEFT list
// 11 12 13
// 21 22 23


// -----------------------------------------------------------------
// 3. over  (/)  – Fold / Reduce
// -----------------------------------------------------------------
// f/ list  →  applies f cumulatively, producing a SINGLE result
// Think: reduce/fold in functional languages.

show (+/) 1 2 3 4 5       // 15   (sum)
show (*/) 1 2 3 4 5       // 120  (product)
show (max/) 5 3 8 2 9     // 9
show (,/) (1 2; 3 4; 5 6) // 1 2 3 4 5 6  (flatten one level)

// Two-arg seed form: seed f/ list
show 100 (+/) 1 2 3       // 106  (start from 100 and add each)


// -----------------------------------------------------------------
// 4. scan  (\)  – Running Fold
// -----------------------------------------------------------------
// Like `over`, but returns ALL intermediate results.

show (+\) 1 2 3 4 5       // 1 3 6 10 15   (cumulative sums = sums)
show (*\) 1 2 3 4 5       // 1 2 6 24 120  (running product)
show (max\) 5 3 8 2 9     // 5 5 8 8 9     (running maximum)

// With a seed
show 0 (+\) 1 2 3 4 5     // 0 1 3 6 10 15  (starts with seed 0)


// -----------------------------------------------------------------
// 5. Converge  (f/)  – Iterate Until Fixed Point
// -----------------------------------------------------------------
// When called with a SINGLE list (not a two-list form),
// f/ keeps applying f until the result stops changing.

show {x % 2}/ 1000000   // keep halving until < 1


// -----------------------------------------------------------------
// 6. N-times  (n f/ x  and  n f\ x)
// -----------------------------------------------------------------
// Apply f exactly n times.

show 5 {x * 2}/ 1     // 32   (double 5 times: 1→2→4→8→16→32)
show 5 {x * 2}\ 1     // 1 2 4 8 16 32  (running intermediate results)


// -----------------------------------------------------------------
// 7. each-parallel (':)  (Peach)
// -----------------------------------------------------------------
// In a multi-threaded Q process, ':  applies function in parallel.
// Syntax identical to each, but uses secondary threads.
// (Falls back to sequential in single-threaded sessions.)

show {x * x} peach 1 2 3 4 5   // 1 4 9 16 25  (parallel)


// -----------------------------------------------------------------
// 8. Practical Example: Running Aggregates on a Table
// -----------------------------------------------------------------

trades2: ([]
  sym:   `AAPL`AAPL`AAPL`GOOG`GOOG;
  qty:   100 200 150 300 50;
  price: 189.3 189.8 190.0 140.2 141.0
 )

// Cumulative qty per symbol (within each group)
show select sym, qty, cumQty: sums qty by sym from trades2


// -----------------------------------------------------------------
// 9. Combining Adverbs
// -----------------------------------------------------------------
// You can chain adverbs for powerful one-liners.

// Sum of squares
show (+/) {x*x} each 1 2 3 4 5   // 55

// Flatten a nested list with ,/
nested: (1 2; 3 4; 5 6)
show (,/) nested    // 1 2 3 4 5 6

// Max across rows of a nested structure
show max each nested             // 2 4 6


// =============================================================
// Key Points
//  * each / '  – map over a list
//  * \: /:      – each-left / each-right (binary fn, fix one side)
//  * f/         – fold (reduce to one value)
//  * f\         – scan (running results at each step)
//  * n f/ x     – apply f exactly n times
//  * f/ x (mono) – converge until fixed point
//  * peach       – parallel each (multi-threaded processes)
// =============================================================
