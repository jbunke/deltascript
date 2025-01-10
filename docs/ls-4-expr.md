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

A **nested expression** is merely an expression enclosed in parentheses `()`. This is useful for explicitly redefining the evaluation order of a compound expression.

> **Example:**
> 
> ```js
> 4 + 5 * 6 // evaluates to 34
> ```
> 
> ```js
> (4 + 5) * 6 // evaluates to 54
> ```

## 4.3 – Literals

A **literal expression** or simply **literal** is an expression whose evaluation is trivial. Its textual representation in the source code reveals its value.

Literal expressions are matched by the follow production rule from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;literal&gt;_:**
> * &lt;STRING_LIT&gt;
> * &lt;CHAR_LIT&gt;
> * &lt;COLOR_HEX_LIT&gt;
> * &lt;int_literal&gt;
> * &lt;FLOAT_LIT&gt;
> * &lt;bool_literal&gt;
> 
> **_&lt;int_literal&gt;_:** &lt;HEX_LIT&gt; | &lt;DEC_LIT&gt;
> 
> **_&lt;bool_literal&gt;_:** `true` | `false`

### 4.3.1 – `bool` literals

The literals for type<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup> `bool` consist of the keywords<sup>[§1.3.3](./ls-1-syntax.md#133--keywords)</sup> `true` and `false`, which represent the two possible [truth values![](../assets/external.png)](https://en.wikipedia.org/wiki/Truth_value).

### 4.3.2 – `char` literals

A **`char` literal** is consists of opening and closing single quotation marks `'`, with a single character or escape sequence<sup>[§4.3.7](#437--escape-sequences)</sup> in between. A char literal is matched by the following lexical grammar<sup>[§1.2.1](./ls-1-syntax.md#121--lexical-grammar)</sup> production rule:

> **_&lt;CHAR_LIT&gt;_:** `'` &lt;CHARACTER&gt; `'`
> 
> **_&lt;CHARACTER&gt;_:** &lt;RESTRICTED_CHARSET&gt; | &lt;ESCAPE_CHAR&gt;
> 
> **_&lt;RESTRICTED_CHARSET&gt;_:** ~( `\` | `'` | `"` )
> 
> **_&lt;ESCAPE_CHAR&gt;_:** `\` ( `0` | `b` | `t` | `n` | `f` | `r` | `"` | `'` | `\` )

Some characters can only be represented by a `char` literal by using an escape sequence. For example, representing a tab character, which is not printed, requires the escape sequence `\t`.

**Examples:**

* `'n'` - a `char` literal representing the lowercase letter `n`
* `'\n'` - a `char` literal representing a [newline / line break character![](../assets/external.png)](https://en.wikipedia.org/wiki/Newline)

### 4.3.3 – `color` literals

Colors in *DeltaScript* can be represented as [hex codes![](../assets/external.png)](https://en.wikipedia.org/wiki/Web_colors#Hex_triplet). They consist of a hash `#` followed by three or four two-digit [hexadecimal![](../assets/external.png)](https://en.wikipedia.org/wiki/Hexadecimal) numbers representing channels of a [32-bit RGBA color![](../assets/external.png)](https://en.wikipedia.org/wiki/RGBA_color_model).

They are matched by the following production rule from the lexical grammar<sup>[§1.2.1](./ls-1-syntax.md#121--lexical-grammar)</sup>:

> **_&lt;COLOR_HEX_LIT&gt;_:** `#` &lt;CHANNEL&gt; &lt;CHANNEL&gt; &lt;CHANNEL&gt; &lt;CHANNEL&gt;?
> 
> **_&lt;CHANNEL&gt;_:** &lt;HEX_DIGIT&gt; &lt;HEX_DIGIT&gt;
> 
> **_&lt;HEX_DIGIT&gt;_:** &lt;DIGIT&gt; | `a..f` | `A..F`
> 
> **_&lt;DIGIT&gt;_:** `0..9`

The optional fourth color channel represents the alpha/[opacity![](../assets/definition.png)](./glossary.md#opacity) channel. If it is ommitted, the color is assigned an opacity of `255` / `0xff` (fully opaque).

> **Examples:**
> 
> * `#287de2` = `rgb(40, 125, 226)`
> * `#03ffa044` = `rgba(3, 255, 160, 68)`

### 4.3.4 – `int` literals

> **Note:**
> 
> Negative numbers (e.g. `-2`) are not treated as literals by *DeltaScript*, but rather as an application of the negation operator<sup>[§4.5.1](#arithmetic-negation--)</sup> to a positive number literal. This is also true for `float` literals (e.g. `-2.0` or `-2f`).

`int` literals take two forms: decimal (base 10) literals and hexadecimal (base 16) literals. They are matched by the following production rules.

> * From the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:
>   
>   **_&lt;int_literal&gt;_:** &lt;HEX_LIT&gt; | &lt;DEC_LIT&gt;
> * From the lexical grammar<sup>[§1.2.1](./ls-1-syntax.md#121--lexical-grammar)</sup>:
> 
>   **_&lt;DEC_LIT&gt;_:** &lt;DIGIT&gt;\+
>   
>   **_&lt;HEX_LIT&gt;_:** `0x` &lt;HEX_DIGIT&gt;\+
> 
>   **_&lt;HEX_DIGIT&gt;_:** &lt;DIGIT&gt; | `a..f` | `A..F`
> 
>   **_&lt;DIGIT&gt;_:** `0..9`

> **Planned:**
> 
> Future language versions may support binary (base 2) integer literals of the form `0b` ( `0` | `1` )\+.

**Decimal literals** consist of some non-empty sequence of the digits `0`-`9`.

**Hexadecimal literals** are alphanumeric. They are prefixed by `0x` and consist of the digits `0`-`9` and the letters `a`-`f` (`A`-`F`). Uppercase and lowercase letters can be used interchangeably.

In a [hexadecimal number![](../assets/external.png)](https://en.wikipedia.org/wiki/Hexadecimal), the [radix/base![](../assets/external.png)](https://en.wikipedia.org/wiki/Radix) is 16, so the values one through fifteen must be represented as a single digit each. Like with the conventional base 10 numbering system, `0` is a placeholder, and the digits `1`-`9` represent their expected digit values. The letters are used to represent the values ten through fifteen, starting with `a`/`A` as ten and culminating with `f`/`F` as fifteen.

In base 10 numbers, each place represents a power of 10, whereas in hexadecimal numbers, each place represents a power of 16.

> **Examples:**
> 
> * `0x3c`
>   
>   = `(3 * 16^1) + (12 * 16^0)`
>   
>   = `(3 * 16) + 12` = `60`
> * `0x2d5`
>   
>   = `(2 * 16^2) + (13 * 16^1) + (5 * 16^0)`
>   
>   = `(2 * 256) + (13 * 16) + 5` 
>   
>   = `512 + 208 + 5` = `725`

### 4.3.5 – `float` literals

`float` literals also have two formats. They are matched by the following production rules from the lexical grammar<sup>[§1.2.1](./ls-1-syntax.md#121--lexical-grammar)</sup>:

> **_&lt;FLOAT_LIT&gt;_:**
> * &lt;DIGIT&gt;\+ `.` &lt;DIGIT&gt;\+
> * &lt;DIGIT&gt;\+ `f`
> 
> **_&lt;DIGIT&gt;_:** `0..9`

A `float` literal in **decimal point notation** consists of a non-empty sequence of the digits `0`-`9` preceding a decimal point `.` and followed by another non-empty sequence of the digits `0`-`9`.

**`f` notation** is used to express an integer quantity as a floating-point number. A `float` literal using `f` notation consists of some non-empty sequence of the digits `0`-`9` followed by `f` (must be lowercase).

> **Note:**
> 
> Unlike some other programming languages, where `1.5f` is a valid floating-point number literal, "f" notation in *DeltaScript* is exclusively used to specify that an integer quantity should be treated as a floating-point number. Literals with a fractional component must be expressed in decimal point notation without a trailing `f`.

### 4.3.6 – `string` literals

A **`string` literal** is bounded by opening and closing double quotation marks `"`. Within the quotation marks, zero or more characters define the contents of the string represented. Formally, they are matched by the following production rule from the lexical grammar<sup>[§1.2.1](./ls-1-syntax.md#121--lexical-grammar)</sup>:

> **_&lt;STRING_LIT&gt;_:** `"` ( &lt;CHARACTER&gt; | `'` ) `"`
> 
> **_&lt;CHARACTER&gt;_:** &lt;RESTRICTED_CHARSET&gt; | &lt;ESCAPE_CHAR&gt;
> 
> **_&lt;RESTRICTED_CHARSET&gt;_:** ~( `\` | `'` | `"` )
> 
> **_&lt;ESCAPE_CHAR&gt;_:** `\` ( `0` | `b` | `t` | `n` | `f` | `r` | `"` | `'` | `\` )

Some characters can only be represented inside a `string` literal by using escape sequences<sup>[§4.3.7](#437--escape-sequences)</sup>. For example, representing a quotation mark inside a `string` literal requires the escape sequence `\"`. This is because the mere use of `"` without the preceding `\` would be parsed as the end of the `string` literal.

### 4.3.7 – Escape sequences

**Escape sequences** are sequences of characters beginning with `\` that are used as stand-ins for a single character that could otherwise not be represented in source code, either due to the context of its use clashing with the language's syntax or the character being a non-printing character.

This is the full set of escape sequences supported by *DeltaScript*:
* `\t` - [Tab![](../assets/external.png)](https://en.wikipedia.org/wiki/Tab_key#Tab_characters)
* `\n` - [Newline / line break![](../assets/external.png)](https://en.wikipedia.org/wiki/Newline)
* `\r` - [Carriage return![](../assets/external.png)](https://en.wikipedia.org/wiki/Carriage_return#Computers)
* `\"` - Double quotation mark `"`
* `\'` - Apostrophe / single quotation mark `'`
* `\\` - Backslash `\`

## 4.4 – Variables as expressions

**Variables**<sup>[§3.1](./ls-3-vars.md#31--variables)</sup> can be invoked as expressions by simply typing their names, provided they are defined in the current scope<sup>[§3.4](./ls-3-vars.md#34--variable-scope)</sup> and have been declared prior to the invocation statement that contains the expression.

## 4.5 – Operators

<!-- TODO -->

### 4.5.1 – Unary operators

<!-- TODO -->

#### Logical negation (not) (`!`)

<!-- TODO -->

#### Arithmetic negation (`-`)

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
