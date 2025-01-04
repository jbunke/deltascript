[**< Language Specification**](./lang-spec.md)

# Glossary

This page provides succinct definitions for terms used throughout the documentation. Links appended with the symbol ![](../assets/definition.png) will lead to glossary entries on this page.

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

## B

### Base language

The core specification of *DeltaScript* and its implementations, in contrast to extensions of the language.

## C

## D

## E

## F

## G

### Global function

<!-- TODO -->

## H

## I

## J

## K

## L

### Length

The number of characters in a string or the number of elements in an array. When referring to the number of elements in a list or a set, the term [size![](../assets/definition.png)](#size) is used instead.

The length/size operator in *DeltaScript* is `#|`.

**Example:**

```js
() {
    string word = "foo";
    print(#|word); // Prints "3"
}
```

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

### Property

A constant attribute of an [object![](../assets/definition.png)](#object) defined by its type.

**Example:**

```js
() {
    color c = #ffffff; // assigns c to the color white (hex code #ffffff)
    print(c.red); // Prints the value of the "red" property of c (255 in this case)
}
```

In this example, [`red`](./color-sl.md#red) is a property defined by the type [`color`](./color-sl.md). Thus, the property can be referenced on all objects of the type.

## Q

## R

## S

### Semantic equivalence

Two or more expressions that have the same **meaning** and **behaviour** under the hood.

### Size

The number of elements in a list or a set. When referring to the number of elements in an array, or the number of characters in a `string`, the term [length![](../assets/definition.png)](#length) is used instead.

The size/length operator in *DeltaScript* is `#|`.

**Example:**

```js
() {
    string<> words = < "quick", "brown" >; // initializes a list of strings
    print(#|words); // Prints "2"
    words.add("A", 0);
    words.add("fox");
    print(#|words); // Prints "4"
}
```

## T

## U

## V

## W

## X

## Y

## Z
