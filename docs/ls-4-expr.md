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
  * [**4.3.7**](#437--escape-sequences) – Escape sequences
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

Consider the following expression:

```cpp
(int) 12f * 2 + 14
```

This is the [parse tree![](../assets/external.png)](https://en.wikipedia.org/wiki/Parse_tree) for the expression according to the [precedence![](../assets/external.png)](https://en.wikipedia.org/wiki/Order_of_operations) order of the productions of &lt;expr&gt;:

![](../assets/expression-parse-tree.png)

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
> Negative numbers (e.g. `-2`) are not treated as literals by *DeltaScript*, but rather as an application of the arithmetic negation operator<sup>[§4.5.1](#arith-neg)</sup> to a positive number literal. This is also true for `float` literals (e.g. `-2.0` or `-2f`).

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

**Operators** are syntactical tokens that accept one or more expressions of certain types as **operands**, and produce a return value of a certain type. This specification categorizes operators based on how many operands they accept:

* Unary operators<sup>[§4.5.1](#451--unary-operators)</sup> - 1 operand
* Binary operators<sup>[§4.5.2](#452--binary-operators)</sup> - 2 operands
* The ternary operator<sup>[§4.5.3](#453--ternary-operator)</sup> - 3 operands

### 4.5.1 – Unary operators

Unary operators consist of one of the **unary operators** `!`, `-`, `#|` followed by an expression of a valid type.

From the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... prior productions)
> * ( `-` | `!` | `#|` ) &lt;expr&gt;
> * (... following productions)

<br>

[**Logical negation**![](../assets/external.png)](https://en.wikipedia.org/wiki/Negation) or **not** is represented by the operator `!`. It can only be applied to expressions that evaluate to values of the type `bool`<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup>.

This is the [truth table![](../assets/external.png)](https://en.wikipedia.org/wiki/Truth_table) for `!` operations with an arbitrary operand `P` of type `bool`:

| Value of `P` | Value of `!P` |
| :----------: | :-----------: |
| `true` | `false` |
| `false` | `true` |

<br>

<b id="arith-neg">Arithmetic negation</b> is represented by the operator `-`. It can only be applied to expressions that evaluate to values of a numeric type: either `float`<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup> or `int`<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup>.

Applying `-` to an arbitrary numeric type expression `P` yields the [additive inverse![](../assets/external.png)](https://en.wikipedia.org/wiki/Additive_inverse) of `P`. For `P` of type `float`, `-P` can be conceptualized as `0.0 - P`, while for `P` of type `int`, `-P` can be conceptualized as `0 - P`. The return type of the operation `-P` will be the same type as the operand `P`.

<br>

The `#|` operator represents **length** or **size**. It can be applied to expressions of types `string`<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup>, array<sup>[§2.3.1](./ls-2-types.md#231--arrays)</sup> `T[]`, list<sup>[§2.3.2](./ls-2-types.md#232--lists)</sup> `T<>`, set<sup>[§2.3.3](./ls-2-types.md#233--sets)</sup> `T{}` and map<sup>[§2.3.4](./ls-2-types.md#234--mapsdictionaries)</sup> `{K:V}`.

The [length![](../assets/definition.png)](./glossary.md#length) of a `string` is the **number of characters in the string**.

The length of an array `T[]`<sup>[a](#fn-a)</sup> is the **number of elements allotted to the array**.

The [size![](../assets/definition.png)](./glossary.md#size) of a list `T<>`<sup>[a](#fn-a)</sup> or set `T{}`<sup>[a](#fn-a)</sup> is the **number of elements in the collection**.

The size of a map `{K:V}`<sup>[b](#fn-b)</sup> is the **number of mappings or key-value pairs contained in the map**.

> **Example:**
> 
> ```js
> () {
>   ~ color BLACK = #000000;
>   ~ color PINK = #f5a0a0;
> 
>   color{} cs = { BLACK, PINK };
> 
>   print(#|"Test phrase"); // prints "11"
>   print(#|[ 1, 2, 3, 4, 5 ]); // prints "5"
>   print(#|{ 'a' : 1, 'j' : 10, 'z' : 26 }); // prints "3"
> 
>   print(#|cs); // prints "2"
>   cs.add(rgb(0, 0, 0));
>   print(#|cs); // prints "2" again; cs already contained the color defined by rgb(0, 0, 0)
>   cs.add(rgb(0xff, 0, 0));
>   print(#|cs); // prints "3"
>   cs.remove(BLACK);
>   cs.remove(PINK);
>   print(#|cs); // prints "1"
> }
> ```
> 
> This script will produce the following output:
> 
> ```
> 11
> 5
> 3
> 2
> 2
> 3
> 1
> ```

### 4.5.2 – Binary operators

Binary operations consist of two operand expressions separated by a **binary operator**. Binary operators can be categorized into the following categories based on their precedence in the [order of operations![](../assets/external.png)](https://en.wikipedia.org/wiki/Order_of_operations):

* Exponent (`^`) - highest precedence, **deprecated**
* **Multiplicative operators** (`*`, `/`, `%`)
* **Additive operators** (`+`, `-`)
* **Comparison operators** (`==`, `!=`, `>` `>=`, `<=`, `<`)
* **Logic operators** (`&&`, `||`) - lowest precedence

From the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... prior productions)
> * &lt;expr&gt; `^` &lt;expr&gt;
> * &lt;expr&gt; ( `*` | `/` | `%` ) &lt;expr&gt;
> * &lt;expr&gt; ( `+` | `-` ) &lt;expr&gt;
> * &lt;expr&gt; ( `==` | `!=` | `>` | `<` | `>=` | `<=` ) &lt;expr&gt;
> * &lt;expr&gt; ( `||` | `&&` ) &lt;expr&gt;
> * (... following productions)

<br>

The operator `+` represents both **addition** and [**concatenation**![](../assets/external.png)](https://en.wikipedia.org/wiki/Concatenation).

The operator performs an **addition** operation when both of its operands are of a numeric type. If both operands are of type `int`<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup>, `+` performs an integer addition operation and returns the result as an `int` value. If both operands are of type `float`<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup>, `+` performs a floating-point number addition operation and returns the result as a `float` value. If one of the operands is of type `float` and the other is of type `int`, the `int` operand is implicitly converted<sup>[§2.5.1](./ls-2-types.md#251--implicit-type-conversion)</sup> to its `float` value, and `+` performs a floating-point number addition operation, returning the result as a `float` value.

If either operand is of a non-numeric type, both operands are implicitly converted to `string` values (if they are not already `string` values), and `+` performs a **concatenation** operation, returning the result as a `string` value.

> **Examples:**
> 
> | Operation | Return value | Return type |
> | :-------: | :----------: | :---------: |
> | `1 + 3` | `4` | `int` |
> | `1.0 + 3` | `4.0` | `float` |
> | `1 + 3.5` | `4.5` | `float` |
> | `"stage" + "coach"` | `"stagecoach"` | `string` |
> | `"race" + 's'` | `"races"` | `string` |
> | `"It is " + true` | `"It is true"` | `string` |

<br>

**Subtraction** is represented by the operator `-`. Its behaviour follows from the behaviour of the addition `+` operator. However, note that the subtraction operator `-` does not double as a `string` operator.

Its operand and return types can be expressed as follows:

* `int - int => int`
* `float - float => float`
* `int - float => float`
* `float - int => float`

<br>

**Multiplication** is represented by the operator `*`. 

Its operand and return types can be expressed as follows:

* `int * int => int`
* `float * float => float`
* `int * float => float`
* `float * int => float`

<br>

**Division** is represented by the operator `/`, while the **[modulo![](../assets/external.png)](https://en.wikipedia.org/wiki/Modulo) operation** is represented by the operator `%`.

For the arbitrary numeric operands `a`, `b`, the expression `a % b` returns the [remainder![](../assets/external.png)](https://en.wikipedia.org/wiki/Remainder) of the division operation `a / b` (`a` is the dividend, `b` is the divisor).

The behaviour of the modulo operator varies across programming languages in its handling of negative operands. *DeltaScript* leaves this to the discretion of implementers, but recommends an adherence to the following axiom:

* `(a / b) * b + (a % b) == a`

For both the division `/` and modulo `%` operators, attempting to divide by zero (a [RHS![](../assets/definition.png)](./glossary.md#rhs) operand with a value of `0` or `0.0`) will result in a runtime error<sup>[§TODO - runtime error]()</sup>.

The operand and return types of the division `/` and modulo `%` operators can be expressed as follows:

* `int OP int => int`
* `float OP float => float`
* `int OP float => float`
* `float OP int => float`

> **Note:**
> 
> This is in contrast to many other programming languages, which perform an integer or floating-point division operation based purely on the type of the divisor.

<br>

<!-- TODO - Exponent (`^`) -->

<!-- TODO - feature is deprecated -->

<br>

<!-- TODO - Equality (`==`) -->

<br>

<!-- TODO - Inequality (`!=`) -->

<br>

<!-- TODO - Greater than (`>`) -->

<br>

<!-- TODO - Greater than or equal to (`>=`) -->

<br>

<!-- TODO - Less than or equal to (`<=`) -->

<br>

<!-- TODO - Less than (`<`) -->

<br>

<!-- TODO - And (`&&`)-->

<br>

<!-- TODO - Or (`||`) -->

### 4.5.3 – Ternary operator

<!-- TODO -->

### 4.5.4 – Compound assignment operators

<!-- TODO -->

<br>

<!-- TODO - Increment and decrement -->

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

<br>

<!-- TODO - Member function calls -->

<br>

<!-- TODO - Properties -->

<br>

<!-- TODO - Namespace function function calls -->

<br>

<!-- TODO - Namespace constants -->

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

* <sup id="fn-a">a</sup> - `T` represents an arbitrary element type
* <sup id="fn-b">b</sup> - `K` represents an arbitrary type for keys of the map, while `V` represents an arbitrary type for values of the map
