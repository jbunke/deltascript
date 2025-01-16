[**< Language Specification**](./lang-spec.md)

# Chapter 2 – Types

## Contents

* [**2.1**](#21--type-system) – Type system
  * [**2.1.1**](#211--type-safety) – Type safety
  * [**2.1.2**](#212--type-inference) – Type inference
  * [**2.1.3**](#213--extensibility) – Extensibility
* [**2.2**](#22--simple-types) – Simple types
  * [**2.2.1**](#221--built-in-types) – Built-in types
  * [**2.2.2**](#222--primitive-vs-composite-types) – Primitive vs. composite types
* [**2.3**](#23--collection-types) – Collection types
  * [**2.3.1**](#231--arrays) – Arrays
  * [**2.3.2**](#232--lists) – Lists
  * [**2.3.3**](#233--sets) – Sets
  * [**2.3.4**](#234--mapsdictionaries) – Maps/dictionaries
* [**2.4**](#24--functional-types) – Functional types
  * [**2.4.1**](#241--parsing-complex-types) – Parsing complex types
* [**2.5**](#25--type-conversion) – Type conversion
  * [**2.5.1**](#251--implicit-type-conversion) – Implicit type conversion
  * [**2.5.2**](#252--explicit-type-conversion-casting) – Explicit type conversion (casting)

---

This chapter describes how *DeltaScript* handles types and their values.

## 2.1 – Type system

A **type** is a classification that specifies the kind of value a variable can hold and the operations that can be performed on it. In programming languages, types are used to enforce constraints on the values that can be represented by expressions<sup>[§4](./ls-4-expr.md)</sup>, ensuring that operations on these expressions and their values are semantically correct.

A sequence of characters written in the code to refer to a type is known as a **type identifier**. For example, the type identifier for an integer is `int`, while the type identifier for a set of characters is `char{}`.

Types in *DeltaScript* can be broadly categorized into three main groups: **simple types**<sup>[§2.2](#22--simple-types)</sup>, **collection types**<sup>[§2.3](#23--collection-types)</sup>, and **functional types**<sup>[§2.4](#24--functional-types)</sup>.

### 2.1.1 – Type safety

*DeltaScript* is type-safe and statically typed, meaning that type checking<sup>[§7.3](./ls-7-exec.md#73--semantic-analysis)</sup> is performed at compile-time<sup>[a](#fn-a)</sup> rather than at runtime. This ensures that type errors are caught early in the development process, leading to more reliable and maintainable code.

### 2.1.2 – Type inference

While *DeltaScript* requires explicit type declarations in many cases, it also supports type inference in certain contexts. This allows the language to deduce the type of a variable or expression based on the context in which it is used, reducing the need for redundant type annotations.

An example of this is in iterator loops<sup>[§5.7.4](./ls-5-stat.md#574--iterator-loops)</sup>. The iterator variable can be declared without a type, as its type can be inferred from the collection.

> **Example 1:**
> 
> ```js
> () {
>     string aretharized = "";
>     
>     for (letter in "RESPECT")
>         aretharized += letter + ".";
> 
>     print(aretharized);
> }
> ```
> 
> The iterator variable `letter` is inferred to be of type `char`, because the collection is a `string`.

> **Example 2:**
> 
> ```js
> () {
>     color[] cs = [ #ff0000, #28283c, rgba(169, 75, 0x80, 0x3b) ];
> 
>     for (c in cs)
>         print("Value: " + value(c));
> }
> 
> value(color c -> int) -> max([ c.red, c.green, c.blue ])
> ```
> 
> This script calculates the [value![](../assets/external.png)](https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_RGB) of each color in the array `cs` on an integer scale from 0 to 255. The iterator variable `c` is inferred to be of type `color`, because the collection is an array of colors `color[]`.

### 2.1.3 – Extensibility

The type system in *DeltaScript* is designed to be extensible, allowing for the addition of new types<sup>[§8.3.1](./ls-8-ext.md#831--new-types)</sup> and the extension of built-in types<sup>[§8.3.2](./ls-8-ext.md#832--extending-built-in-types)</sup> through language extensions. This makes *DeltaScript* highly adaptable to various application domains and use cases.

## 2.2 – Simple types

Simple types are types whose identifiers consist of a single word and no punctuation. These types are **simple** in contrast to collection types and functional types, which are considered complex. Simple types comprise [built-in![](../assets/definition.png)](./glossary.md#built-in) types like `bool` and `int`, as well as new types defined by extensions to *DeltaScript*<sup>[§8.3.1](./ls-8-ext.md#831--new-types)</sup>.

### 2.2.1 – Built-in types

The following simple types are built into the [base language![](../assets/definition.png)](./glossary.md#base-language):
* `bool` - one of two possible [truth values![](../assets/external.png)](https://en.wikipedia.org/wiki/Truth_value): true or false
* `char` - a [UTF-8![](../assets/external.png)](https://en.wikipedia.org/wiki/UTF-8) character
* `color` - a 32-bit [RGBA color![](../assets/external.png)](https://en.wikipedia.org/wiki/RGBA_color_model)
* `float` - [a 64-bit (double precision) floating-point number![](../assets/external.png)](https://en.wikipedia.org/wiki/Double-precision_floating-point_format)
* `image` - a [bitmap![](../assets/external.png)](https://en.wikipedia.org/wiki/Bitmap); a [matrix![](../assets/external.png)](https://en.wikipedia.org/wiki/Matrix_(mathematics)) of pixels represented as colors
* `int` - a 32-bit signed [integer![](../assets/external.png)](https://en.wikipedia.org/wiki/Integer_(computer_science))
* `string` - [a sequence of zero or more characters![](../assets/external.png)](https://en.wikipedia.org/wiki/String_(computer_science))

### 2.2.2 – Primitive vs. composite types

Simple types can be further subdivided into **primitive types** and **composite types**.

**Primitive types** (`bool`, `char`, `float`, and `int`) represent primitive data values; they cannot be broken down into smaller units.

**Composite types** (`image`, `string`) represent **objects**, which are composed of multiple primitive data values. Objects have mutable states, meaning their internal data can change without altering the object's identity. For example, an object of the type `image` can have one of its pixels change color without becoming a different `image` object. Extension types are also usually composite.

Many composite types will also define [member functions![](../assets/definition.png)](./glossary.md#member-functions) and [properties![](../assets/definition.png)](./glossary.md#properties). The member functions and properties of the built-in composite types are detailed in *DeltaScript*'s [standard library](./std-lib.md).

`color` does not fall neatly into either category. Fundamentally, `color` represents a 32-bit integer. However, the type defines additional behaviours in the form of properties that give it the characteristics of a composite type.

## 2.3 – Collection types

Collection types represent collections of elements. They allow for the storage and manipulation of multiple values in a structured manner.

A collection's elements must all be of the same type<sup>[b](#fn-b)</sup>. A collection's elements mustn't be of a simple type; functions and collections themselves can also be grouped into collections.

The basic collection types in *DeltaScript* are **arrays**, **lists**, and **sets**. Each of these collection types contains elements of a single type, and is constrained by different rules determining how its elements can be accessed, arranged, added, or removed.

**Maps**, also known as **dictionaries**, are a special type of collection that represent associations between **keys** and **values**.

The member functions of collection types are detailed in the standard library [here](./collections-sl.md).

### 2.3.1 – Arrays

An **array** is an ordered collection of fixed [length![](../assets/definition.png)](./glossary.md#length).

**Ordered** means that elements in an array are arranged in a certain order, and that individual elements can be accessed via their **index** - their position in the array. *DeltaScript* uses [zero-based numbering![](../assets/external.png)](https://en.wikipedia.org/wiki/Zero-based_numbering), which means that the initial<sup>[c](#fn-c)</sup> element in an ordered collection has an index of 0.

> **Example:**
> 
> ```js
> () {
>     int[] squares = [ 1, 4, 9, 16, 25, 36, 49, 64, 81, 100 ];
> 
>     print(squares[0]); // prints "1"
>     print(squares[1]); // prints "4"
>     print(squares[9]); // prints "100"
> }
> ```

**Fixed length** means that an array can neither grow, nor shrink. It will always have the same number of allocated elements, even if some indices do not contain elements. <!-- TODO - How does the language currently handle attempting to access indices of collections of elements of a composite type that are empty? -->

Arrays are represented by **square brackets** `[]`. An array of elements of an arbitrary type `T` would be declared with the type identifier `T[]`.

### 2.3.2 – Lists

Like an array<sup>[§2.3.1](#231--arrays)</sup>, a **list** is an ordered collection. However, unlike an array, the [size![](../assets/definition.png)](./glossary.md#size) of a list is dynamic. This means that it can grow and shrink: elements can be added and removed.

Lists are represented by **angle brackets** `[]`. A list of elements of an arbitrary type `T` would be declared with the type identifier `T<>`.

### 2.3.3 – Sets

Like a list, a **set** is a collection of dynamic size. However, unlike a list, a set is **unordered**. Elements in a set have no order, and thus cannot be retrieved from an index.

Unlike arrays and lists, each element in a [set![](../assets/external.png)](https://en.wikipedia.org/wiki/Set_(mathematics)) is unique; a set cannot contain two elements of the same value or object.

Sets are represented by **curly brackets / braces** `{}`. A set of elements of an arbitrary type `T` would be declared with the type identifier `T{}`.

### 2.3.4 – Maps/dictionaries

A **map**, or **dictionary**, is a collection of associations, or **mappings**, between **keys** and **values**. Like lists and sets, the size of a **map** is dynamic. They are also unordered. A value can be retrieved from the map by providing the corresponding key.

Maps are represented by **curly brackets / braces** and a **colon** separating their key and value types. A map of keys of an arbitrary type `K` and values of an arbitrary type `V` would be declared with the type identifier `{K:V}`.

## 2.4 – Functional types

Functional types represent value-returning functions<sup>[§6.2.1](./ls-6-func.md#621--value-returning-functions)</sup>, including both named helper functions and anonymous functions. They enable the definition and invocation of reusable code blocks.

Functional type identifiers consist of **optional comma-separated parameter types**, followed by an **arrow**, followed by a **return type**, all **enclosed in parentheses**. A functional type with the arbitrary parameter types `P1`, `P2`, etc. and the arbitrary return type `R` would be declared with the type identifier `(P1, P2, ... -> R)`.

**Examples:**

* `(int -> string)` - a function that accepts an integer as a parameter and returns a string
* `(float, float -> bool)` - a function that accepts two floating-point numbers as parameters and returns a boolean
* `(-> int)` - a function with no parameters that returns an integer
* `((float -> int), float[] -> int[])` - a function that accepts a floating-point number to integer function and an array of floating-point numbers as parameters and returns an array of integers

> **Planned:**
> 
> Future language versions may support functional types for void functions<sup>[§6.2.2](./ls-6-func.md#622--void-functions)</sup>.

### 2.4.1 – Parsing complex types

It is important for *DeltaScript* programmers to be able to parse complex type identifiers<sup>[§2.1](#21--type-system)</sup> in order to correctly conceptualize what they represent.

In these examples, the "outermost" type is bolded:

* `int[]` - **an array** of integers
* `char{}[]` - **an array** of sets of characters
* `char[]{}` - **a set** of arrays of characters
* `{string:int}<>` - **a list** of maps mapping strings to integers
* `{bool[]:bool}` - **a map** mapping arrays of booleans to booleans
* `(float, float -> int)[]` - **an array** of functions that accept two floating-point numbers as parameters and return integers
* `(int, int, bool -> int[])` - **a function** that accepts an integer, an integer, and a boolean as parameters and returns an array of integers

## 2.5 – Type conversion

**Type conversion** is when a value of a certain type is converted to a correspondent value of another type, either implicitly or explicitly.

*DeltaScript* supports both implicit and explicit type conversion. Implicit type conversion occurs automatically when it is safe to do so, while explicit type conversion (casting) requires the programmer to specify the desired type. Type conversion is not universal; only certain types can be converted to certain other types.

These are all the type conversions that are possible in *DeltaScript*:

| From |  To  | Value conversion |
| :--- | :--- | :--------------- |
| `bool` | `string` | `true` values converted to `"true"`, `false` values to `"false"` |
| `char` | `int` | Converts a character to its [Unicode![](../assets/external.png)](https://en.wikipedia.org/wiki/List_of_Unicode_characters) decimal (base-10) value |
| `char` | `string` | Converts a character to the equivalent one-character string |
| `float` | `int` | Truncates a `float` to its integer component |
| `float` | `string` | Represents a `float` as a string in decimal point notation |
| `int` | `char` | Derives a character from its Unicode decimal value |
| `int` | `float` | Trivial |
| `int` | `string` | Trivial |

### 2.5.1 – Implicit type conversion

**Implicit type conversion** usually occurs when operands of different types are operated on by a (binary) operator<sup>[§4.5.2](./ls-4-expr.md#452--binary-operators)</sup>.

> **Example:**
> 
> ```js
> () {
>     print(27.25 + 12); // prints "39.25"
> }
> ```
> 
> The operand `27.25` is a `float`, and the operand `12` is an `int`. Before this addition operation is performed, `12` is converted to the equivalent `float` (`12f` / `12.0`). That way, the operation is an addition of `float` rather than an addition of `int`. An addition of `float` preserves the fractional component of `27.25` (`0.25`), which would have been truncated had `27.25` been converted into an integer (`27`) instead.

**Any value of any type** can be implicitly converted to a `string` value.

### 2.5.2 – Explicit type conversion (casting)

**Explicit type conversion**, or **casting**, is when a programmer specifies in the source code that the value of an expression should be converted to another type. This is achieved with a cast expression<sup>[§4.6](./ls-4-expr.md#46--cast-expressions)</sup>, where the desired type is enclosed in parentheses before the expression whose value is to be converted.

> **Example:**
> 
> ```js
> () {
>     print((int) 27.25 + 12); // prints "39"
> }
> ```
> 
> The precedence of the expression `(int) 27.25 + 12` looks like this: `((int) 27.25) + 12`. The cast operation is performed first; the `float` `27.25` is truncated to an `int` with a value of `27`. Now, as both operands of the addition operation (`27` and `12`) are `int`, the operation is an addition of `int`.

---

## Footnotes

* <sup id="fn-a">a</sup> - The term "compile-time" is used here, however, depending on the language implementation, *DeltaScript* code may be either compiled or interpreted. Either way, type checking is performed prior to runtime – the execution of the script.
* <sup id="fn-b">b</sup> - This applies to arrays, lists, and sets. Maps/dictionaries have two element types: one for keys and one for values. All keys in a map must be of the same type, and all values must be of the same type. However, keys and values mustn't be of the same type.
* <sup id="fn-c">c</sup> - Because the ordinal number "first" doesn't correspond with the index 0, some people refer to the initial element of an ordered collection in a zero-based language as the "zeroth" element. However, this specification uses "first" to mean initial, i.e. at index 0.
