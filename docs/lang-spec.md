[**< Home**](../README.md)

# *DeltaScript* – Language Specification

<!-- TODO - link to a Delta Time release -->

| Version | Published | Author | Implementation |
| :-----: | :-------: | :----: | :------------: |
| alpha-0.1 | January 6, 2025 | Jordan Bunke | [Link![](../assets/external.png)]() |

*DeltaScript* is a lightweight scripting language skeleton that is designed to be easily extended for the specification and implementation of [domain-specific languages![](../assets/external.png)](https://en.wikipedia.org/wiki/Domain-specific_language).

The language is in active development. As it is already in production as the scripting language used by [*Stipple Effect*](https://github.com/jbunke/stipple-effect), it became necessary to publish a specification for the language.

*DeltaScript* is technically **platform-agnostic**. It can be implemented as a compiled language, or an interpreted language that targets any other programming language. However, the official implementation (latest version linked above) is an **interpreter that targets Java**.

This specification aims to provide an exhaustive description of how the language is designed, including its **syntax**, **semantics**, **execution**, and **extension possibilities**. Parts of this document employ advanced mathematical concepts, alongside formal mathematical notation and language. However, thorough explanations and external resources linked from within should ensure that it is still comprehensible for a layperson. A strong mathematics and/or computer science background is certainly helpful, but not required.

For a more beginner-friendly overview of the language, please see the [guides section](./guides.md) of the documentation.

## Contents

### Introduction
* Motivation
* About the specification
  * Notation and conventions
  * Overview of the specification

### [1 – Syntax and grammar](./ls-1-syntax.md)
* [**1.1**](./ls-1-syntax.md#11--notation-and-terminology) – Notation and terminology
  * [**1.1.1**](./ls-1-syntax.md#111--extended-backusnaur-form) – Extended Backus–Naur Form
  * [**1.1.2**](./ls-1-syntax.md#112--terminology) – Terminology
  * [**1.1.3**](./ls-1-syntax.md#113--notation) – Notation
* [**1.2**](./ls-1-syntax.md#12--grammars) – Grammars
  * [**1.2.1**](./ls-1-syntax.md#121--lexical-grammar) – Lexical grammar
  * [**1.2.2**](./ls-1-syntax.md#122--syntax-grammar) – Syntax grammar
* [**1.3**](./ls-1-syntax.md#13--notes-on-syntax) – Notes on syntax
  * [**1.3.1**](./ls-1-syntax.md#131--comments) – Comments
  * [**1.3.2**](./ls-1-syntax.md#132--whitespace) – Whitespace
  * [**1.3.3**](./ls-1-syntax.md#133--shorthands) – Shorthands

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
* Type signatures
  * Value-returning functions
  * Void functions
* Types of functions
  * Header functions
  * Helper functions
  * Anonymous functions
* Function references

### 7 – Execution
* Type checking
* Errors
  * Syntax errors
  * Semantic errors
  * Runtime errors

<!-- TODO -->

### ? – Extensions
* Types
  * New types
  * Extending built-in types
* Namespaces

### ? – Official implementation

### [Glossary](./glossary.md)
