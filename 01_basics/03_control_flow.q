// =============================================================
// Module 01 – Basics | 03 – Control Flow and Basic Functions
// =============================================================
// Q is an array language and most logic is expressed through
// atomic operations.  But conditional branching and simple
// functions are also available.
// =============================================================


// -------------------------------------------------------------
// 1. Conditional Expression  $[cond; true; false]
// -------------------------------------------------------------

x: 10

// Two-branch conditional
show $[x > 5; "big"; "small"]        // "big"
show $[x < 0; "negative"; "non-negative"]  // "non-negative"

// Multi-branch (cond pairs followed by a default)
grade: 72
show $[grade >= 90; "A";
       grade >= 80; "B";
       grade >= 70; "C";
       grade >= 60; "D";
       "F"]                          // "C"


// -------------------------------------------------------------
// 2. Defining Functions (Lambdas)
// -------------------------------------------------------------
// A function is written as   {[args] body}
// Arguments are separated by semicolons.
// The last expression is the return value (no explicit 'return').

// Zero-argument function
greet: {[] "hello world"}
show greet[]

// One-argument function
double: {[n] n * 2}
show double 5         // 10
show double 1 2 3     // 2 4 6  (atomic: works on lists too)

// Two-argument function
add: {[a; b] a + b}
show add[3; 4]        // 7

// Multi-expression function (separate with semicolons)
// Only the *last* expression is returned.
hypotenuse: {[a; b]
  a2: a * a;
  b2: b * b;
  sqrt a2 + b2
 }
show hypotenuse[3; 4]  // 5f


// -------------------------------------------------------------
// 3. Implicit Arguments  x, y, z
// -------------------------------------------------------------
// When a function has no declared arguments it may use the
// implicit names x (1st), y (2nd), z (3rd).

square: {x * x}
show square 7         // 49

multiply: {x * y}
show multiply[6; 7]   // 42


// -------------------------------------------------------------
// 4. Recursion
// -------------------------------------------------------------
// Use `.z.s` to refer to the current function from within itself.

factorial: {[n] $[n <= 1; 1; n * .z.s[n - 1]]}
show factorial 5      // 120
show factorial 10     // 3628800


// -------------------------------------------------------------
// 5. if / while Statements
// -------------------------------------------------------------
// `if` and `while` are control statements (not expressions).
// They do not return a value.

// if[condition; statements...]
if[x > 5; show "x is greater than 5"]

// if/else pattern using $[]
show $[x > 5; "x > 5"; "x <= 5"]

// while[condition; body]
i: 0
while[i < 3;
  show i;
  i: i + 1
 ]
// prints 0, 1, 2


// -------------------------------------------------------------
// 6. do  (fixed-count loop)
// -------------------------------------------------------------
// do[count; body]

do[3; show "looping"]   // prints "looping" three times


// -------------------------------------------------------------
// 7. Error Handling with @  (protected evaluation / trap)
// -------------------------------------------------------------
// @[function; arg; error-handler] – trap errors gracefully

safeDivide: {[a; b] @[%; (a; b); {"division error: ", x}]}
show safeDivide[10; 2]    // 5f
show safeDivide[10; 0]    // "division error: ..."


// =============================================================
// Key Points
//  * Conditional: $[cond; true; false]  (can chain conditions)
//  * Functions: {[args] body}
//  * Implicit args: x, y, z
//  * Recursion via .z.s
//  * Loops: while[cond; body]  and  do[n; body]
//  * Error trapping: @[fn; arg; handler]
// =============================================================
