[**< Home**](../README.md)

# *DeltaScript* – Language Specification

<!-- TODO - link to a Delta Time release -->

| Version | Published | Author | Implementation |
| :-----: | :-------: | :----: | :------------: |
| alpha-0.1 | January 6, 2025 | Jordan Bunke | [Link![](../assets/external.png)]() |

<!-- TODO -->

## Contents

### Introduction
* Motivation

### 1 – Syntax and grammar
* Notation
* Grammar
* Notes on syntax
  * Shorthands

### 2 – Types
* Simple types
  * Built-in types
* Collection types
  * Arrays
  * Lists
  * Sets
  * Maps/dictionaries
* Functional types

### 3 – Variables and declarations
* Declarations
  * Scope
  * Initialization
  * Immutability
* Variable names
* Variable scope

### 4 – Expressions
* Precedence
* Function calls
* Helper function references
* Operators
  * Unary operators
  * Binary operators
  * Ternary operator
  * Compound assignment operators
* Variables and other assignables
* Literals
  * `bool` literals
  * `char` literals
  * `color` literals
  * `int` literals
    * Decimal literals
    * Hexadecimal literals
  * `float` literals
    * Decimal point notation
    * `f` notation
  * `string` literals

<!-- TODO -->

### 5 – Statements
* Declaration statements
* Assignments
* Void function calls
* Conditional statements
  * `if`
  * `when`
* Loops
  * `while`
  * `do`...`while`
  * `for`
  * enhanced `for` / iterator
* `return`
  * Value `return`
  * Void `return`

### 6 – Functions
* Header functions
* Helper functions
* Type signatures
  * Value-returning functions
  * Void functions
* Anonymous functions
* Referencing functions

### 7 – Execution
* Type checking
* Errors
  * Syntax errors
  * Semantic errors
  * Runtime errors

<!-- TODO -->

### ? – Official implementation

### ? – Extensions
* Types
  * New types
  * Extending built-in types
* Namespaces
* Extending the official implementation
  * Interpreter
    * Overriding I/O functions
  * Visitor
  * AST nodes

### [Glossary](./glossary.md)
