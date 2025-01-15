[**< Language Specification**](./lang-spec.md)

# Chapter 6 – Functions

## Contents

* [**6.1**](#61--functions) – Functions
* [**6.2**](#62--type-signatures) – Type signatures
  * [**6.2.1**](#621--value-returning-functions) – Value-returning functions
  * [**6.2.2**](#622--void-functions) – Void functions
* [**6.3**](#63--types-of-functions) – Types of functions
  * [**6.3.1**](#631--header-functions) – Header functions
  * [**6.3.2**](#632--helper-functions) – Helper functions
  * [**6.3.3**](#633--anonymous-functions) – Anonymous functions
  * [**6.3.4**](#634--global-functions) – Global functions
  * [**6.3.5**](#635--member-functions) – Member functions
  * [**6.3.6**](#636--extension-functions) – Extension functions
* [**6.4**](#64--function-objects) – Function objects
  * [**6.4.1**](#641--call) – `call()`
* [**6.5**](#65--function-semantics) – Function semantics
  * [**6.5.1**](#651--parameters-and-arguments) – Parameters and arguments
  * [**6.5.2**](#652--return-path-completeness) – Return path completeness

---

<!-- TODO -->

## 6.1 – Functions

<!-- TODO -->

## 6.2 – Type signatures

<!-- TODO -->

### 6.2.1 – Value-returning functions

<!-- TODO -->

### 6.2.2 – Void functions

<!-- TODO -->

## 6.3 – Types of functions

<!-- TODO -->

### 6.3.1 – Header functions

<!-- TODO -->

### 6.3.2 – Helper functions

<!-- TODO -->

### 6.3.3 – Anonymous functions

<!-- TODO -->

### 6.3.4 – Global functions

<!-- TODO -->

### 6.3.5 – Member functions

**Member functions** are functions that are defined as callable on objects of a particular type.

For example, the `string` type defines the following member functions:

* [`at(int index -> char)`](./string-sl.md#at)
* [`has(char character -> bool)`](./string-sl.md#has)
* [`has(string substring -> bool)`](./string-sl.md#has)
* [`sub(int beg, int end_ex)`](./string-sl.md#sub)

Member functions of built-in types are defined by the [standard library](./std-lib.md). Extension types<sup>[§TODO - extension type]()</sup> may also define 

<!-- TODO -->

<!-- TODO - properties -->

### 6.3.6 – Extension functions

<!-- TODO -->

<!-- TODO - namespace functions -->

<!-- TODO - extension member functions -->

## 6.4 – Function objects

<!-- TODO -->

### 6.4.1 – `call()`

<!-- TODO -->

## 6.5 – Function semantics

<!-- TODO -->

### 6.5.1 – Parameters and arguments

<!-- TODO -->

### 6.5.2 – Return path completeness

<!-- TODO -->

---

## Footnotes

* <sup id="fn-a">a</sup> - Here
