// =============================================================
// Module 05 – Advanced | 01 – Functions and Lambdas
// =============================================================
// Q treats functions as first-class values.
// This module covers advanced function patterns:
//   - closures, projections (partial application), composition,
//     and higher-order functions.
// =============================================================


// -----------------------------------------------------------------
// 1. First-class Functions
// -----------------------------------------------------------------
// Functions can be stored in variables, passed as arguments,
// and returned from other functions.

double: {x * 2}
apply:  {[f; x] f x}      // higher-order: takes a function as arg

show apply[double; 5]      // 10
show apply[sqrt;  25]      // 5f   (built-ins are first-class too)


// -----------------------------------------------------------------
// 2. Projection (Partial Application)
// -----------------------------------------------------------------
// Omit argument(s) with :: to create a projection.
// A projection remembers the supplied arguments.

// Two-arg function
power: {[base; exp] base xexp exp}

// Fix the exponent to create specialised functions
square: power[; 2]     // base is still open
cube:   power[; 3]

show square 4          // 16f
show cube   3          // 27f

// With built-ins
add10: (+) [10]        // add 10 to any number
show add10 5           // 15
show add10 each 1 2 3  // 11 12 13


// -----------------------------------------------------------------
// 3. Function Composition with `@`
// -----------------------------------------------------------------
// f @ g = apply f to (apply g to x)  [right-to-left, like math]
// Or chain using `'` (each-both) for lists.

negate:   {neg x}
absolute: {abs x}

// Apply two functions in sequence
show negate absolute -5    // -5  (abs then neg)

// Using @ to compose
show (negate @ absolute) -5   // -5


// -----------------------------------------------------------------
// 4. Closures
// -----------------------------------------------------------------
// Inner functions capture variables from their enclosing scope.

makeAdder: {[n] {x + n}}   // returns a function that closes over n

add5:  makeAdder 5
add10b: makeAdder 10

show add5  3    // 8
show add10b 3   // 13


// -----------------------------------------------------------------
// 5. Recursion via .z.s
// -----------------------------------------------------------------
// `.z.s` refers to the current function, enabling anonymous recursion.

fib: {[n] $[n <= 1; n; .z.s[n-1] + .z.s[n-2]]}
show fib each 0 1 2 3 4 5 6 7 8 9 10
// 0 1 1 2 3 5 8 13 21 34 55


// -----------------------------------------------------------------
// 6. Namespaces
// -----------------------------------------------------------------
// Use dot notation to organise functions into namespaces.

.myLib.square: {x * x}
.myLib.cube:   {x * x * x}
.myLib.pow:    {[b;e] b xexp e}

show .myLib.square 5    // 25
show .myLib.cube   4    // 64f
show .myLib.pow[2;8]    // 256f

// List all keys in a namespace
show key `.myLib         // `cube`pow`square


// -----------------------------------------------------------------
// 7. apply / @ and . (dot-apply)
// -----------------------------------------------------------------
// `@[f; x]`   apply f to a single argument x (same as f x)
// `.[f; args]` apply f to a list of arguments (like f[a;b;c])

add: {[a;b] a + b}

show @[add; (3;4)]      // same as add[3;4]  = 7  (amend notation)
show .[add; (3;4)]      // apply with argument list = 7


// -----------------------------------------------------------------
// 8. Protected Evaluation (Try/Catch)
// -----------------------------------------------------------------
// @[f; arg; errorHandler]  – catch errors from f[arg]
// .[f; args; errorHandler] – multi-arg version

safeDiv: {[a;b] @[%; (a;b); {"Error: ", x}]}
show safeDiv[10; 2]     // 5f
show safeDiv[10; 0]     // "Error: ..."

// Multi-arg trap
safeSqrt: {.[sqrt; enlist x; {"negative: ", string x}]}
show safeSqrt  25    // 5f
show safeSqrt -1     // "negative: -1"


// =============================================================
// Key Points
//  * Functions are first-class values in Q
//  * Projection (partial application): f[; y] fixes y, leaves x open
//  * Closures: inner {x + n} captures n from outer scope
//  * `.z.s` = self-reference for recursion
//  * Namespaces: `.ns.fn: {}`  (dot-separated prefix)
//  * `.[f; argList; handler]` = multi-arg protected eval
// =============================================================
