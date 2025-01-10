[**< Language Specification**](./lang-spec.md)

# Chapter 4 – Expressions

## Contents

* [**4.1**](#41--precedence) – Precedence
* [**4.2**](#42--nested-expressions) – Nested expressions
* [**4.3**](#43--literals) – Literals
  * [**4.3.1**](#431--bool-literals) – `bool` literals
  * [**4.3.2**](#432--char-literals) – `char` literals
  * [**4.3.3**](#433--color-literals) – `color` literals
  * [**4.3.4**](#434--int-literals) – `int` literals
  * [**4.3.5**](#435--float-literals) – `float` literals
  * [**4.3.6**](#436--string-literals) – `string` literals
* [**4.4**](#44--variables-as-expressions) – Variables as expressions
* [**4.5**](#45--operators) – Operators
  * [**4.5.1**](#451--unary-operators) – Unary operators
  * [**4.5.2**](#452--binary-operators) – Binary operators
  * [**4.5.3**](#453--ternary-operator) – Ternary operator
  * [**4.5.4**](#454--compound-assignment-operators) – Compound assignment operators
* [**4.6**](#46--cast-expressions) – Cast expressions
* [**4.7**](#47--function-calls) – Function calls
  * [**4.7.1**](#471--global-function-calls) – Global function calls
  * [**4.7.2**](#472--helper-function-calls) – Helper function calls
  * [**4.7.3**](#473--scoped-function-calls) – Scoped function calls
* [**4.8**](#48--helper-function-references) – Helper function references
* [**4.9**](#49--anonymous-functions) – Anonymous functions
* [**4.10**](#410--array-and-list-elements) – Array and list elements
* [**4.11**](#411--explicit-collections) – Explicit collections
* [**4.12**](#412--collection-initializers) – Collection initializers

---

This chapter details the various forms expressions in *DeltaScript* can take.

An **expression** is a section of source code that, when reached in the program's execution, **can be evaluated** to a single value of a certain type<sup>[§2](./ls-2-types.md)</sup>.

Expressions can consist of single syntactic tokens, like a numeric literal (e.g. `12`) or a variable (e.g. `item`), or be composed of various smaller expressions (e.g. `max(12 - 5, rand(2, 15))`).

## 4.1 – Precedence

Expressions are matched in this order by the following production rule from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * &lt;literal&gt;
> * &lt;assignable&gt;
> * &lt;lambda_params&gt; &lt;lambda_body&gt;
> * &lt;ident&gt; &lt;args&gt;
> * &lt;namespace_ident&gt; &lt;args&gt;
> * &lt;namespace_ident&gt;
> * `::` &lt;ident&gt;
> * &lt;expr&gt; &lt;sub_ident&gt; &lt;args&gt;
> * &lt;expr&gt; &lt;sub_ident&gt;
> * ( `-` | `!` | `#|` ) &lt;expr&gt;
> * `(` &lt;type&gt; `)` &lt;expr&gt;
> * &lt;expr&gt; `^` &lt;expr&gt;
> * &lt;expr&gt; ( `*` | `/` | `%` ) &lt;expr&gt;
> * &lt;expr&gt; ( `+` | `-` ) &lt;expr&gt;
> * &lt;expr&gt; ( `==` | `!=` | `>` | `<` | `>=` | `<=` ) &lt;expr&gt;
> * &lt;expr&gt; ( `||` | `&&` ) &lt;expr&gt;
> * &lt;expr&gt; `?` &lt;expr&gt; `:` &lt;expr&gt;
> * `{` &lt;kv_pairs&gt; `}`
> * `[` &lt;elements&gt;? `]`
> * `<` &lt;elements&gt;? `>`
> * `{` &lt;elements&gt;? `}`
> * `new` &lt;type&gt; `[` &lt;expr&gt; `]`
> * `new` `{` &lt;type&gt; `:` &lt;type&gt; `}`
> * `(` &lt;expr&gt; `)`

> **Note:**
> 
> Definitions for production rules with occurrences in &lt;expr&gt; may be provided in later sections of the chapter.

> **Example:**
> 
> Consider the following expression:
> 
> ```cpp
> (int) 12f * 2 + 14
> ```
> 
> This is the [parse tree![](../assets/external.png)](https://en.wikipedia.org/wiki/Parse_tree) for the expression according to the [precedence![](../assets/external.png)](https://en.wikipedia.org/wiki/Order_of_operations) order of the productions of &lt;expr&gt;:
> 
> ![](../assets/expression-parse-tree.png)

## 4.2 – Nested expressions

<!-- TODO -->

## 4.3 – Literals

<!-- TODO -->

### 4.3.1 – `bool` literals

<!-- TODO -->

### 4.3.2 – `char` literals

<!-- TODO -->

### 4.3.3 – `color` literals

<!-- TODO -->

### 4.3.4 – `int` literals

<!-- TODO -->

#### Decimal literals

<!-- TODO -->

#### Hexadecimal literals

<!-- TODO -->

### 4.3.5 – `float` literals

<!-- TODO -->

#### Decimal point notation

<!-- TODO -->

#### `f` notation

<!-- TODO -->

### 4.3.6 – `string` literals

<!-- TODO -->

## 4.4 – Variables as expressions

<!-- TODO -->

## 4.5 – Operators

<!-- TODO -->

### 4.5.1 – Unary operators

<!-- TODO -->

#### Not (`!`)

<!-- TODO -->

#### Negative (`-`)

<!-- TODO -->

#### Length / size (`#|`)

<!-- TODO -->

### 4.5.2 – Binary operators

<!-- TODO -->

#### Additive operators

<!-- TODO -->

##### Addition / Concatenation (`+`)

<!-- TODO -->

<!-- TODO - doubles as concatenation operator -->

##### Subtraction (`-`)

<!-- TODO -->

#### Multiplicative operators

<!-- TODO -->

##### Multiplication (`*`)

<!-- TODO -->

##### Division (`/`)

<!-- TODO -->

<!-- TODO - divide by 0 results in RTE -->

##### Modulo (`%`)

<!-- TODO -->

<!-- TODO - divide by 0 results in RTE -->

<!-- TODO - handling of negative operands -->

#### Exponent (`^`)

<!-- TODO -->

<!-- TODO - feature is deprecated -->

#### Comparison operators

<!-- TODO -->

##### Equality (`==`)

<!-- TODO -->

##### Inequality (`!=`)

<!-- TODO -->

##### Greater than (`>`)

<!-- TODO -->

##### Greater than or equal to (`>=`)

<!-- TODO -->

##### Less than or equal to (`<=`)

<!-- TODO -->

##### Less than (`<`)

<!-- TODO -->

#### Logic operators

<!-- TODO -->

##### And (`&&`)

<!-- TODO -->

##### Or (`||`)

<!-- TODO -->

### 4.5.3 – Ternary operator

<!-- TODO -->

### 4.5.4 – Compound assignment operators

<!-- TODO -->

#### Increment and decrement

<!-- TODO -->

<!-- TODO - Unlike some other languages, i++ is not an expression -->

## 4.6 – Cast expressions

<!-- TODO -->

## 4.7 – Function calls

<!-- TODO -->

### 4.7.1 – Global function calls

<!-- TODO -->

### 4.7.2 – Helper function calls

<!-- TODO -->

### 4.7.3 – Scoped function calls

<!-- TODO -->

#### Member function calls

<!-- TODO -->

#### Properties

<!-- TODO -->

#### Namespace function function calls

<!-- TODO -->

#### Namespace constants

<!-- TODO -->

## 4.8 – Helper function references

<!-- TODO -->

## 4.9 – Anonymous functions

<!-- TODO -->

<!-- TODO - aka lambda expressions -->

## 4.10 – Array and list elements

<!-- TODO -->

## 4.11 – Explicit collections

<!-- TODO -->

## 4.12 – Collection initializers

<!-- TODO -->

---

## Footnotes

* <sup id="fn-a">a</sup> - Here
