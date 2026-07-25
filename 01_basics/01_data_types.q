// =============================================================
// Module 01 – Basics | 01 – Data Types and Atoms
// =============================================================
// In Q everything is a list.  The simplest list is an *atom*:
// a single scalar value.  Q has a rich set of built-in types.
//
// Run this file in a Q session:
//   q 01_basics/01_data_types.q -p 0
// Or paste individual blocks into the Q REPL (q).
// =============================================================


// -------------------------------------------------------------
// 1. Integers
// -------------------------------------------------------------
// Q has three integer widths: long (8-byte), int (4-byte), short (2-byte).
// The default undecorated integer literal is a *long* (type 7h / -7h).

a: 42          // long  (64-bit signed integer)
b: 42i         // int   (32-bit signed integer)  – suffix 'i'
c: 42h         // short (16-bit signed integer)  – suffix 'h'

show a         // 42
show b         // 42i
show c         // 42h

// Type introspection: `type` returns a short integer
//  Positive  → atom type
//  Negative  → list type (covered in module 02)
show type a    // -7h  (long atom)
show type b    // -6h  (int  atom)
show type c    // -5h  (short atom)

// Null & infinity for longs
show 0N        // null long
show 0W        // positive infinity (long)
show -0W       // negative infinity (long)


// -------------------------------------------------------------
// 2. Floating-point numbers
// -------------------------------------------------------------
// The default decimal literal is a *float* (double precision, 64-bit).
// Use suffix 'e' for a real (32-bit float).

f: 3.14        // float (type -9h)
r: 3.14e       // real  (type -8h)

show f
show r
show type f    // -9h
show type r    // -8h

show 0n        // null float (NaN)
show 0w        // positive float infinity
show -0w       // negative float infinity


// -------------------------------------------------------------
// 3. Booleans
// -------------------------------------------------------------
// Suffix 'b'.  1b = true, 0b = false.

t: 1b
f2: 0b
show t         // 1b
show f2        // 0b
show type t    // -1h


// -------------------------------------------------------------
// 4. Characters and Strings
// -------------------------------------------------------------
// A *character* atom is wrapped in double quotes: "a"
// A *string* in Q is simply a *list of characters* (type 10h / -10h).

ch: "x"        // character atom  (type -10h)
s:  "hello"    // character list  (type 10h)

show ch
show s
show type ch   // -10h
show type s    //  10h

// Character operations
show upper ch  // "X"  – upper-case
show ch = "x"  // 1b  – comparison


// -------------------------------------------------------------
// 5. Symbols
// -------------------------------------------------------------
// Symbols are interned strings, written with a backtick prefix.
// They are very efficient for repeated categorical values.

sym: `apple
show sym           // `apple
show type sym      // -11h

// A symbol list (most common in table columns):
fruits: `apple`banana`cherry
show fruits        // `apple`banana`cherry
show type fruits   // 11h   (positive = list)


// -------------------------------------------------------------
// 6. Date and Time types
// -------------------------------------------------------------
// Q stores date/time as integers internally (days/milliseconds from epoch).

d:  2024.01.15        // date  (type -14h)
dt: 2024.01.15T09:30:00.000  // datetime (type -15h)
t2: 09:30:00.000      // time  in milliseconds (type -19h)
t3: 09:30             // minute (type -17h)

show d
show dt
show t2
show t3
show type d    // -14h


// -------------------------------------------------------------
// 7. Null values (per type)
// -------------------------------------------------------------
// Every type has a null; use it to represent missing data.

show 0N        // null long
show 0n        // null float
show 0Nd       // null date
show 0Nt       // null time
show `         // null symbol  (empty symbol)

// Test for null with `null`
show null 0N   // 1b
show null 42   // 0b


// -------------------------------------------------------------
// 8. Type casting
// -------------------------------------------------------------
// Use backtick + type name as a cast function.

show `long$ 3.7     // 3  (truncates, does NOT round)
show `float$ 5      // 5f
show `int$ 100      // 100i
show `boolean$ 0    // 0b
show `boolean$ 1    // 1b
show `char$ 65      // "A"  (ASCII)
show `symbol$ "hello" // `hello


// =============================================================
// Summary of common type codes
// -1h  boolean   |  -5h  short    |  -8h  real
// -6h  int       |  -7h  long     |  -9h  float
// -10h char      |  -11h symbol
// -14h date      |  -15h datetime |  -17h minute
// -18h second    |  -19h time
// =============================================================
