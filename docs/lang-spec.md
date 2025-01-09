[**< Home**](../README.md)

# *DeltaScript* – Language Specification

<!-- TODO - link to a Delta Time release -->

| Version | Published | Author | Implementation |
| :-----: | :-------: | :----: | :------------: |
| 0.1.0 | January 6, 2025 | Jordan Bunke | [Link![](../assets/external.png)]() |

*DeltaScript* is a lightweight scripting language skeleton that is designed to be easily extended for the specification and implementation of [domain-specific languages![](../assets/external.png)](https://en.wikipedia.org/wiki/Domain-specific_language).

The language is in active development. As it is already in production as the scripting language used by [*Stipple Effect*![](../assets/external.png)](https://github.com/stipple-effect/stipple-effect), it became necessary to publish a specification for the language.

*DeltaScript* is technically **platform-agnostic**. It can be implemented as a compiled language, or an interpreted language that targets any other programming language. However, the official implementation (latest version linked above) is an **interpreter that targets Java**.

This specification aims to provide an exhaustive description of how the language is designed, including its **syntax**, **semantics**, **execution**, and **extension possibilities**. Parts of this document employ advanced mathematical concepts, alongside formal mathematical notation and language. However, thorough explanations and external resources linked from within should ensure that the content remains accessible to non-experts. A strong mathematics and/or computer science background is helpful, but not required.

For a more beginner-friendly overview of the language, please see the [guides section](./guides.md) of the documentation.

## Contents

### [Introduction](./ls-intro.md)
* [Motivation](./ls-intro.md#motivation)
* [About the specification](./ls-intro.md#about-the-specification)
  * [Notation and conventions](./ls-intro.md#notation-and-conventions)
  * [Language status and compatibility](./ls-intro.md#language-status-and-compatibility)
  * [Overview of the specification](./ls-intro.md#overview-of-the-specification)

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
  * [**1.3.3**](./ls-1-syntax.md#133--keywords) – Keywords
  * [**1.3.4**](./ls-1-syntax.md#134--shorthands) – Shorthands

### [2 – Types](./ls-2-types.md)
* [**2.1**](./ls-2-types.md#21--type-system) – Type system
  * [**2.1.1**](./ls-2-types.md#211--type-safety) – Type safety
  * [**2.1.2**](./ls-2-types.md#212--type-inference) – Type inference
  * [**2.1.3**](./ls-2-types.md#213--extensibility) – Extensibility
* [**2.2**](./ls-2-types.md#22--simple-types) – Simple types
  * [**2.2.1**](./ls-2-types.md#221--built-in-types) – Built-in types
  * [**2.2.2**](./ls-2-types.md#222--primitive-vs-composite-types) – Primitive vs. composite types
* [**2.3**](./ls-2-types.md#23--collection-types) – Collection types
  * [**2.3.1**](./ls-2-types.md#231--arrays) – Arrays
  * [**2.3.2**](./ls-2-types.md#232--lists) – Lists
  * [**2.3.3**](./ls-2-types.md#233--sets) – Sets
  * [**2.3.4**](./ls-2-types.md#234--mapsdictionaries) – Maps/dictionaries
* [**2.4**](./ls-2-types.md#24--functional-types) – Functional types
  * [**2.4.1**](./ls-2-types.md#241--parsing-complex-types) – Parsing complex types
* [**2.5**](./ls-2-types.md#25--type-conversion) – Type conversion
  * [**2.5.1**](./ls-2-types.md#251--implicit-type-conversion) – Implicit type conversion
  * [**2.5.2**](./ls-2-types.md#252--explicit-type-conversion-casting) – Explicit type conversion (casting)

### [3 – Variables and declarations](./ls-3-vars.md)
* [**3.1**](./ls-3-vars.md#31--variables) – Variables
* [**3.2**](./ls-3-vars.md#32--declarations) – Declarations
  * [**3.2.1**](./ls-3-vars.md#321--variable-names) – Variable names
  * [**3.2.2**](./ls-3-vars.md#322--initialization) – Initialization
  * [**3.2.3**](./ls-3-vars.md#323--immutability) – Immutability
* [**3.3**](./ls-3-vars.md#33--function-parameters) – Function parameters
* [**3.4**](./ls-3-vars.md#34--variable-scope) – Variable scope

### [4 – Expressions](./ls-4-expr.md)
* Precedence
* Function calls
* Helper function references
* Lambda expressions
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

### [5 – Statements](./ls-5-stat.md)
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

### [6 – Functions](./ls-6-func.md)
* Type signatures
  * Value-returning functions
  * Void functions
* Types of functions
  * Header functions
  * Helper functions
  * Anonymous functions
* Function references

### [7 – Execution](./ls-7-exec.md)
* Type checking
* Errors
  * Syntax errors
  * Semantic errors
  * Runtime errors

<!-- TODO -->

### [8 – Extensions](./ls-8-ext.md)
* Types
  * New types
  * Extending built-in types
* Namespaces

### [9 – Official implementation](./ls-9-impl.md)

### [Standard Library](./std-lib.md)

### [Glossary](./glossary.md)
