// =============================================================
// Module 04 – qSQL | 02 – UPDATE and DELETE
// =============================================================
// `update` modifies values in-place (returns a new table by default).
// `delete` removes rows or columns.
// =============================================================


// -----------------------------------------------------------------
// Sample tables
// -----------------------------------------------------------------

employees: ([]
  id:     1 2 3 4 5;
  name:   `Alice`Bob`Carol`Dave`Eve;
  dept:   `Eng`HR`Eng`Sales`HR;
  salary: 90000 60000 95000 70000 55000
 )

inventory: ([]
  item:  `apple`banana`cherry`date;
  qty:   100 50 200 30;
  price: 1.2 0.5 3.0 5.5
 )

show employees
show inventory


// -----------------------------------------------------------------
// 1. UPDATE – Modify Column Values
// -----------------------------------------------------------------

// Update all rows (add 5000 to every salary)
show update salary:salary+5000 from employees

// Update with a WHERE clause
show update salary:salary*1.1 from employees where dept=`Eng

// Add a new column
show update bonus:salary*0.1 from employees

// Update multiple columns at once
show update
  salary:salary+3000,
  dept:`Engineering
  from employees where dept=`Eng


// -----------------------------------------------------------------
// 2. UPDATE in-place using backtick table name
// -----------------------------------------------------------------
// To modify the table variable itself, prefix with backtick:

`employees update salary:salary+1000 from employees   // ← modifies in memory
show employees`salary   // all salaries increased by 1000

// Equivalently, just reassign:
employees: update salary:salary-1000 from employees   // revert


// -----------------------------------------------------------------
// 3. UPDATE with Computed Values
// -----------------------------------------------------------------

show update value:qty*price from inventory

// Conditional update using $[]
show update discount:$[price > 2.0; price*0.9; price] from inventory


// -----------------------------------------------------------------
// 4. DELETE Rows (WHERE clause)
// -----------------------------------------------------------------

// Delete rows matching a condition
show delete from employees where dept=`HR

// Delete multiple conditions
show delete from employees where dept=`HR, salary < 60000


// -----------------------------------------------------------------
// 5. DELETE Columns
// -----------------------------------------------------------------

// Remove one column
show delete salary from employees

// Remove multiple columns
show delete salary, dept from employees


// -----------------------------------------------------------------
// 6. In-place DELETE
// -----------------------------------------------------------------
// Same pattern – use backtick table name to modify in place.

temp: ([] x:1 2 3 4 5; y:10 20 30 40 50)
delete from `temp where x > 3
show temp     // only rows where x <= 3


// -----------------------------------------------------------------
// 7. INSERT – Adding Rows
// -----------------------------------------------------------------

// `insert` appends rows to an existing table variable
`employees insert (6; `Frank; `Sales; 72000)
show employees

// Insert a table (multiple rows)
newEmps: ([] id:7 8; name:`Grace`Hank; dept:`Eng`HR; salary:88000 58000)
`employees insert newEmps
show employees
show count employees    // 8


// -----------------------------------------------------------------
// 8. UPSERT (insert-or-update by key)
// -----------------------------------------------------------------
// On a keyed table, upsert updates matching keys and inserts new ones.

ktable: 1!([] id:1 2 3; name:`Alice`Bob`Carol; score:95 87 92)
show ktable

// Update existing key (id=2) + insert new key (id=4)
`ktable upsert ([] id:2 4; name:`Bob`Dave; score:90 80)
show ktable


// =============================================================
// Key Points
//  * `update col:expr from t`         – returns updated table
//  * `update col:expr from t where c` – conditional update
//  * `update ... from \`t`             – in-place update (modifies variable)
//  * `delete from t where c`          – delete matching rows
//  * `delete col from t`              – delete a column
//  * `insert` appends; `upsert` inserts-or-updates (keyed tables)
// =============================================================
