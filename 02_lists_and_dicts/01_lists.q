// =============================================================
// Module 02 – Lists & Dictionaries | 01 – Lists
// =============================================================
// In Q *everything* is a list.  An atom is a degenerate list.
// Understanding lists is the key to writing idiomatic Q.
// =============================================================


// -------------------------------------------------------------
// 1. Creating Lists
// -------------------------------------------------------------

// Space-separated atoms create a uniform list
ints:   1 2 3 4 5
floats: 1.1 2.2 3.3
syms:   `a`b`c
chars:  "hello"         // character list (string)
bools:  1001b           // boolean list

show ints
show syms
show chars
show type ints    // 7h  (long list)
show type syms    // 11h (symbol list)

// A list that mixes types is a *general list* (type 0h)
mixed: (1; 2.0; "three"; `four)
show mixed
show type mixed   // 0h


// -------------------------------------------------------------
// 2. til – generate a range
// -------------------------------------------------------------
// `til n` produces 0 1 2 ... n-1  (like range(n) in Python)

show til 5        // 0 1 2 3 4
show til 0        // empty long list

// Shift the range
show 1 + til 5    // 1 2 3 4 5


// -------------------------------------------------------------
// 3. Indexing and Slicing
// -------------------------------------------------------------
// Q uses square brackets for indexing; indices start at 0.

nums: 10 20 30 40 50

show nums[0]          // 10  (first element)
show nums[4]          // 50  (last element)
show nums[-1]         // 0N  (out-of-bounds → null, not an error!)

// Index with a list of indices → sub-list
show nums[0 2 4]      // 10 30 50
show nums[til 3]      // 10 20 30  (first three)

// `last` and `first` shortcuts
show first nums       // 10
show last  nums       // 50

// `_` (drop) removes elements from the front or back
show 2 _ nums         // 30 40 50  (drop first 2)
show -2 _ nums        // 10 20 30  (drop last 2)

// `#` (take) keeps elements from the front or back
show 3 # nums         // 10 20 30
show -3 # nums        // 30 40 50
show 7 # nums         // 10 20 30 40 50 10 20  (wraps!)


// -------------------------------------------------------------
// 4. Common List Functions
// -------------------------------------------------------------

nums2: 5 3 1 4 2

show count nums2      // 5    – number of elements
show sum   nums2      // 15
show prd   nums2      // 120  – product
show min   nums2      // 1
show max   nums2      // 5
show avg   nums2      // 3f
show med   nums2      // 3f
show dev   nums2      // 1.414214f

show reverse nums2    // 2 4 1 3 5
show asc     nums2    // 1 2 3 4 5  (sorted ascending)
show desc    nums2    // 5 4 3 2 1  (sorted descending)
show iasc    nums2    // 2 4 1 3 0  (grade-up: indices that sort ascending)
show idesc   nums2    // 0 3 1 4 2  (grade-down)

show distinct 1 2 2 3 3 3   // 1 2 3  (unique values)
show where 0010b             // ,2     (indices of 1b in a boolean list)


// -------------------------------------------------------------
// 5. Joining Lists
// -------------------------------------------------------------

a: 1 2 3
b: 4 5 6

show a , b             // 1 2 3 4 5 6  (join / catenate)
show (a , b) , 7 8     // 1 2 3 4 5 6 7 8


// -------------------------------------------------------------
// 6. Searching in Lists
// -------------------------------------------------------------

haystack: `a`b`c`d`e

show haystack ? `c        // 2  (index of first match; `?` = find)
show haystack ? `z        // 5  (not found → count of list = past-end index)

// `in` – test membership (returns boolean)
show `c in haystack       // 1b
show `z in haystack       // 0b

// `in` with a list of needles → list of booleans
show `a`z`b in haystack   // 1 0 1


// -------------------------------------------------------------
// 7. Nested Lists
// -------------------------------------------------------------

nested: (1 2 3; 4 5 6; 7 8 9)
show nested
show nested[0]       // 1 2 3
show nested[1][2]    // 6  (row 1, col 2)
show nested[1;2]     // 6  (same, using multi-index form)


// =============================================================
// Key Points
//  * `til n` generates 0..n-1
//  * Indexing: list[i], out-of-bounds → null (no exception)
//  * `#` = take,  `_` = drop
//  * `,` = join (catenate) lists
//  * `?` = find (returns index; past-end if not found)
//  * `in` = membership test
//  * `where` = indices of true elements in a boolean list
// =============================================================
