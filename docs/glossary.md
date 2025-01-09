[**< Language Specification**](./lang-spec.md)

# Glossary

This page provides succinct definitions for terms used throughout the documentation. Links followed by the symbol ![](../assets/definition.png) will lead to glossary entries on this page.

## Sections

* [A](#a)
* [B](#b)
* [C](#c)
* [D](#d)
* [E](#e)
* [F](#f)
* [G](#g)
* [H](#h)
* [I](#i)
* [J](#j)
* [K](#k)
* [L](#l)
* [M](#m)
* [N](#n)
* [O](#o)
* [P](#p)
* [Q](#q)
* [R](#r)
* [S](#s)
* [T](#t)
* [U](#u)
* [V](#v)
* [W](#w)
* [X](#x)
* [Y](#y)
* [Z](#z)

## A

### Append

To insert/attach after or at the end.

> **Example:**
> 
> **Appending** the letter "s" to the word "farm" results in the word "farms".

> **See also:**
> * [Prepend](#prepend)

## B

### Base language

The core specification of *DeltaScript* and its implementations, in contrast to extensions of the language.

### Built-in

Included in the [base language![](../assets/definition.png)](#base-language).

## C

### C-like syntax

A programming language that uses many of the syntactical conventions pioneered by and/or associated with [C![](../assets/external.png)](https://en.wikipedia.org/wiki/C_(programming_language)), such as: 
* semicolons `;` as statement terminators
* function parameters delimited by parentheses `()`
* code blocks / scopes delimited by curly brackets `{}`

A list of such languages can be found [here![](../assets/external.png)](https://en.wikipedia.org/wiki/List_of_C-family_programming_languages).

### Control flow

<!-- TODO -->

## D

## E

## F

## G

### Global function

<!-- TODO -->

## H

## I

### Identifier

The name of a variable, helper function, function parameter, extension type, extension type property, member function, or extension namespace.

## J

## K

## L

### Length

The number of characters in a string or the number of elements in an array. When referring to the number of elements in a list or a set, the term [size![](../assets/definition.png)](#size) is used instead.

The length/size operator in *DeltaScript* is `#|`.

> **Example:**
> 
> ```js
> () {
>     string word = "foo";
>     print(#|word); // Prints "3"
> }
> ```

### LHS

An acronym for **left-hand side**.

Refers to the side of a statement<sup>[§5](./ls-5-stat.md)</sup> or expression<sup>[§4](./ls-4-expr.md)</sup> that lies to the left of an operator.

> **Example:**
> 
> ```js
> some_var = "Some " + "concatenated " + "string";
> ```
> 
> This assignment statement has an LHS of `some_var` and an [RHS![](../assets/definition.png)](#rhs) of `"Some " + "concatenated " + "string"`.

## M

### Member function

<!-- TODO -->

## N

## O

### Object

<!-- TODO -->

### Opacity

How **opaque** a color is. Opacity is the complementary property to transparency, just as darkness is to brightness.

## P

### Prepend

To insert/attach prior or at the beginning.

> **Example:**
> 
> **Prepending** the letter "a" to the word "blaze" results in the word "ablaze".

> **See also:**
> * [Append](#append)

### Property

A constant attribute of an [object![](../assets/definition.png)](#object) defined by its type.

> **Example:**
> 
> ```js
> () {
>     color c = #ffffff; // assigns c to the color white (hex code #ffffff)
>     print(c.red); // Prints the value of the "red" property of c (255 in this case)
> }
> ```
> 
> In this example, [`red`](./color-sl.md#red) is a property defined by the type [`color`](./color-sl.md). Thus, the property can be referenced on all objects of the type.

## Q

## R

### RHS

<!-- TODO -->

## S

### Semantic equivalence

Two or more expressions or units of code that have the same **meaning** and **behaviour** under the hood.

### Size

The number of elements in a list or a set. When referring to the number of elements in an array, or the number of characters in a `string`, the term [length![](../assets/definition.png)](#length) is used instead.

The size/length operator in *DeltaScript* is `#|`.

> **Example:**
> 
> ```js
> () {
>     string<> words = < "quick", "brown" >; // initializes a list of strings
>     print(#|words); // Prints "2"
>     words.add("A", 0);
>     words.add("fox");
>     print(#|words); // Prints "4"
> }
> ```

## T

## U

## V

## W

## X

## Y

## Z
