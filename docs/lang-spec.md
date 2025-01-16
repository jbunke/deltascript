[**< Home**](../README.md)

# *DeltaScript* – Language Specification

<!-- TODO - link to a Delta Time release -->

| Version | Published | Author | Implementation |
| :-----: | :-------: | :----: | :------------: |
| 0.1.0 | January 16, 2025 | Jordan Bunke | [Link![](../assets/external.png)]() |

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
* [**4.1**](./ls-4-expr.md#41--precedence) – Precedence
* [**4.2**](./ls-4-expr.md#42--nested-expressions) – Nested expressions
* [**4.3**](./ls-4-expr.md#43--literals) – Literals
  * [**4.3.1**](./ls-4-expr.md#431--bool-literals) – `bool` literals
  * [**4.3.2**](./ls-4-expr.md#432--char-literals) – `char` literals
  * [**4.3.3**](./ls-4-expr.md#433--color-literals) – `color` literals
  * [**4.3.4**](./ls-4-expr.md#434--int-literals) – `int` literals
  * [**4.3.5**](./ls-4-expr.md#435--float-literals) – `float` literals
  * [**4.3.6**](./ls-4-expr.md#436--string-literals) – `string` literals
  * [**4.3.7**](./ls-4-expr.md#437--escape-sequences) – Escape sequences
* [**4.4**](./ls-4-expr.md#44--variables-as-expressions) – Variables as expressions
* [**4.5**](./ls-4-expr.md#45--operators) – Operators
  * [**4.5.1**](./ls-4-expr.md#451--unary-operators) – Unary operators
  * [**4.5.2**](./ls-4-expr.md#452--binary-operators) – Binary operators
  * [**4.5.3**](./ls-4-expr.md#453--ternary-operator) – Ternary operator
  * [**4.5.4**](./ls-4-expr.md#454--compound-assignment-operators) – Compound assignment operators
* [**4.6**](./ls-4-expr.md#46--cast-expressions) – Cast expressions
* [**4.7**](./ls-4-expr.md#47--function-calls) – Function calls
  * [**4.7.1**](./ls-4-expr.md#471--global-function-calls) – Global function calls
  * [**4.7.2**](./ls-4-expr.md#472--helper-function-calls) – Helper function calls
  * [**4.7.3**](./ls-4-expr.md#473--scoped-function-calls) – Scoped function calls
* [**4.8**](./ls-4-expr.md#48--helper-function-references) – Helper function references
* [**4.9**](./ls-4-expr.md#49--anonymous-functions) – Anonymous functions
* [**4.10**](./ls-4-expr.md#410--array-and-list-elements) – Array and list elements
* [**4.11**](./ls-4-expr.md#411--explicit-collections) – Explicit collections
* [**4.12**](./ls-4-expr.md#412--collection-initializers) – Collection initializers

### [5 – Statements](./ls-5-stat.md)
* [**5.1**](./ls-5-stat.md#51--imperative-programming) – Imperative programming
* [**5.2**](./ls-5-stat.md#52--statements) – Statements
* [**5.3**](./ls-5-stat.md#53--declarations) – Declarations
* [**5.4**](./ls-5-stat.md#54--assignments) – Assignments
* [**5.5**](./ls-5-stat.md#55--void-function-calls) – Void function calls
* [**5.6**](./ls-5-stat.md#56--conditional-statements) – Conditional statements
  * [**5.6.1**](./ls-5-stat.md#561--if-statements) – `if` statements
  * [**5.6.2**](./ls-5-stat.md#562--when-statements) – `when` statements
* [**5.7**](./ls-5-stat.md#57--loops) – Loops
  * [**5.7.1**](./ls-5-stat.md#571--while-loops) – `while` loops
  * [**5.7.2**](./ls-5-stat.md#572--dowhile-loops) – `do`...`while` loops
  * [**5.7.3**](./ls-5-stat.md#573--for-loops) – `for` loops
  * [**5.7.4**](./ls-5-stat.md#574--iterator-loops) – Iterator loops
* [**5.8**](./ls-5-stat.md#58--return-statements) – `return` statements
  * [**5.8.1**](./ls-5-stat.md#581--value-return) – Value `return`
  * [**5.8.2**](./ls-5-stat.md#582--void-return) – Void `return`

### [6 – Functions](./ls-6-func.md)
* [**6.1**](./ls-6-func.md#61--functions) – Functions
* [**6.2**](./ls-6-func.md#62--type-signatures) – Type signatures
  * [**6.2.1**](./ls-6-func.md#621--value-returning-functions) – Value-returning functions
  * [**6.2.2**](./ls-6-func.md#622--void-functions) – Void functions
* [**6.3**](./ls-6-func.md#63--types-of-functions) – Types of functions
  * [**6.3.1**](./ls-6-func.md#631--header-functions) – Header functions
  * [**6.3.2**](./ls-6-func.md#632--helper-functions) – Helper functions
  * [**6.3.3**](./ls-6-func.md#633--anonymous-functions) – Anonymous functions
  * [**6.3.4**](./ls-6-func.md#634--global-functions) – Global functions
  * [**6.3.5**](./ls-6-func.md#635--member-functions) – Member functions
  * [**6.3.6**](./ls-6-func.md#636--extension-functions) – Extension functions
* [**6.4**](./ls-6-func.md#64--function-objects) – Function objects
  * [**6.4.1**](./ls-6-func.md#641--call) – `call()`
* [**6.5**](./ls-6-func.md#65--function-semantics) – Function semantics
  * [**6.5.1**](./ls-6-func.md#651--parameters-and-arguments) – Parameters and arguments
  * [**6.5.2**](./ls-6-func.md#652--return-path-completeness) – Return path completeness

### [7 – Execution](./ls-7-exec.md)
* [**7.1**](./ls-7-exec.md#71--general) – General
* [**7.2**](./ls-7-exec.md#72--parsing) – Parsing
* [**7.3**](./ls-7-exec.md#73--semantic-analysis) – Semantic analysis
* [**7.4**](./ls-7-exec.md#74--runtime-execution) – Runtime execution
* [**7.5**](./ls-7-exec.md#75--errors) – Errors
  * [**7.5.1**](./ls-7-exec.md#751--syntax-errors) – Syntax errors
  * [**7.5.2**](./ls-7-exec.md#752--semantic-errors) – Semantic errors
  * [**7.5.3**](./ls-7-exec.md#753--runtime-errors) – Runtime errors

### [8 – Extensions](./ls-8-ext.md)
* [**8.1**](./ls-8-ext.md#81--extensions-philosophy) – Extensions philosophy
* [**8.2**](./ls-8-ext.md#82--extensions) – Extensions
* [**8.3**](./ls-8-ext.md#83--types-in-extensions) – Types in extensions
  * [**8.3.1**](./ls-8-ext.md#831--new-types) – New types
  * [**8.3.2**](./ls-8-ext.md#832--extending-built-in-types) – Extending built-in types
* [**8.4**](./ls-8-ext.md#84--namespaces) – Namespaces

### [Standard Library](./std-lib.md)
* Built-in types
  * [`color`](./color-sl.md)
  * [`image`](./image-sl.md)
  * [`string`](./string-sl.md)
* [Collection types](./collections-sl.md)
  * [Array – `T[]`](./collections-sl.md#array)
  * [List – `T<>`](./collections-sl.md#list)
  * [Set – `T{}`](./collections-sl.md#set)
  * [Map/dictionary – `{K:V}`](./collections-sl.md#mapdictionary)
* [Global functions](./functions-sl.md)

### [Glossary](./glossary.md)
