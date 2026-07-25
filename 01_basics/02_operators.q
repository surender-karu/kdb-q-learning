// =============================================================
// Module 01 – Basics | 02 – Arithmetic and Operators
// =============================================================
// Q supports standard arithmetic, comparison, and logical operators.
// Most operators are *atomic* – they automatically work on lists.
// =============================================================


// -------------------------------------------------------------
// 1. Basic Arithmetic
// -------------------------------------------------------------

show 10 + 3    // 13
show 10 - 3    // 7
show 10 * 3    // 30
show 10 % 3    // 3.333333  ← division uses %, NOT /
show 10 mod 3  // 1         ← modulo uses `mod`
show 2 xexp 8  // 256f      ← exponentiation

// Integer arithmetic preserves type
show 7 + 2     // 9    (long)
show 7.0 + 2   // 9f   (float – Q promotes when mixing types)

// Negation
show neg 5     // -5
show neg -5    // 5


// -------------------------------------------------------------
// 2. Comparison Operators
// -------------------------------------------------------------
// All comparisons return booleans (1b = true, 0b = false).

show 5 = 5     // 1b  equal
show 5 <> 3    // 1b  not equal
show 5 > 3     // 1b  greater than
show 5 < 3     // 0b  less than
show 5 >= 5    // 1b  greater than or equal
show 5 <= 3    // 0b  less than or equal


// -------------------------------------------------------------
// 3. Logical (Boolean) Operators
// -------------------------------------------------------------
// & = AND,  | = OR,  not = NOT

show 1b & 0b   // 0b
show 1b | 0b   // 1b
show not 1b    // 0b
show not 0b    // 1b


// -------------------------------------------------------------
// 4. Atomic extension – operators on lists
// -------------------------------------------------------------
// Applying an operator to a list applies it to every element.

nums: 1 2 3 4 5

show nums + 10       // 11 12 13 14 15
show nums * 2        // 2 4 6 8 10
show nums mod 2      // 1 0 1 0 1   (odd/even test)
show nums > 3        // 0 0 0 1 1
show nums = 3        // 0 0 1 0 0

// Two lists of the same length → element-wise operation
a: 1 2 3
b: 10 20 30
show a + b     // 11 22 33
show a * b     // 10 40 90


// -------------------------------------------------------------
// 5. Useful Math Functions
// -------------------------------------------------------------

show sqrt 16      // 4f
show abs -7       // 7
show ceiling 3.2  // 4
show floor 3.9    // 3
show signum -5    // -1
show signum 0     // 0
show signum 5     // 1

// Min / Max between two atoms
show 3 & 5        // 3  (& = min for numbers)
show 3 | 5        // 5  (| = max for numbers)

// Aggregate functions over a list
show sum  1 2 3 4 5    // 15
show prd  1 2 3 4 5    // 120  (product)
show min  1 2 3 4 5    // 1
show max  1 2 3 4 5    // 5
show avg  1 2 3 4 5    // 3f
show med  1 2 3 4 5    // 3f   (median)
show dev  1 2 3 4 5    // 1.414214  (standard deviation)
show var  1 2 3 4 5    // 2f   (variance)


// -------------------------------------------------------------
// 6. String / Symbol Operations
// -------------------------------------------------------------

// Concatenate character lists with ,
show "hello" , " " , "world"    // "hello world"

// Convert symbol to string and back
show string `apple       // "apple"
show `$"apple"           // `apple

// Upper / lower case
show upper "hello"       // "HELLO"
show lower "WORLD"       // "world"

// Trim whitespace
show ltrim "  hello"     // "hello"
show rtrim "hello  "     // "hello"
show trim  "  hello  "   // "hello"


// -------------------------------------------------------------
// 7. Variable Assignment and Updating
// -------------------------------------------------------------
// Assignment uses :  (colon)
// Global assignment inside a function uses :: (double colon)

x: 5
show x           // 5

x: x + 1        // re-assign
show x           // 6

// Conditional expression: $[condition; true-result; false-result]
show $[x > 5; `big; `small]    // `big


// =============================================================
// Key Points
//  * Division is % (not /)
//  * Modulo is mod keyword
//  * Most operators extend automatically to lists (atomic)
//  * & and | mean AND/OR for booleans, min/max for numbers
// =============================================================
