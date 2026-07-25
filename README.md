# KDB+ / Q Language Learning

A step-by-step guide to learning **KDB+**, the **Q programming language**, and **qSQL** — from absolute basics to advanced features and queries.

---

## Table of Contents

| Module | Topic |
|--------|-------|
| [01 – Basics](01_basics/) | Data types, atoms, arithmetic, variables, strings, booleans |
| [02 – Lists & Dictionaries](02_lists_and_dicts/) | Lists, indexing, operations, dictionaries |
| [03 – Tables](03_tables/) | Creating tables, keyed tables, table manipulation |
| [04 – qSQL](04_qsql/) | `select`, `where`, `by`, `update`, `delete`, joins |
| [05 – Advanced](05_advanced/) | Functions, lambdas, adverbs (`each`, `over`, `scan`), file I/O |

---

## Prerequisites

- **KDB+ 4.0+** (free 32-bit edition available at [kx.com](https://kx.com/developers/download-licenses/))
- Basic command-line familiarity

### Quick Start

```bash
# Start a Q session
q

# Load and run any script in this repo
q 01_basics/01_data_types.q
```

Each `.q` file is self-contained with inline comments explaining every concept.  
Run files top-to-bottom in a Q session, or paste snippets directly into the REPL.

---

## Learning Path

```
01_basics  ──►  02_lists_and_dicts  ──►  03_tables  ──►  04_qsql  ──►  05_advanced
```

Start with **01_basics** if you are new to Q.  
Jump to **04_qsql** if you are already comfortable with the language and want to focus on queries.

---

## Module Summaries

### 01 – Basics
Core building blocks: atoms, numeric types, booleans, characters, symbols, date/time types, arithmetic operators, comparison operators, and variable assignment.

### 02 – Lists & Dictionaries
Creating and indexing lists (uniform and mixed), list operators (`count`, `sum`, `avg`, `min`, `max`, `reverse`, `distinct`, `til`), and building/querying dictionaries.

### 03 – Tables
Tables as collections of equal-length lists, creating tables with `flip`, keyed tables with `!`, inserting and upserting rows, and basic table introspection (`meta`, `cols`, `count`).

### 04 – qSQL
The SQL-like query language built into Q: `select`, `from`, `where`, `by`, `update`, `delete`, and all join types (`lj`, `ij`, `aj`, `uj`).

### 05 – Advanced
First-class functions (lambdas), higher-order adverbs (`each` `/`, `\`, `'`), iterators, error handling (`.Q.trp`), and reading/writing data to disk.

---

## Resources

- [KX Documentation](https://code.kx.com/q/)
- [Q for Mortals (free online book)](https://code.kx.com/q4m3/)
- [KX Academy](https://learninghub.kx.com/)
