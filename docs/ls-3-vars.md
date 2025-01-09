[**< Language Specification**](./lang-spec.md)

# Chapter 3 – Variables and declarations

## Contents

* [**3.1**](#31--variables) – Variables
* [**3.2**](#32--declarations) – Declarations
  * [**3.2.1**](#321--variable-names) – Variable names
  * [**3.2.2**](#322--initialization) – Initialization
  * [**3.2.3**](#323--immutability) – Immutability
* [**3.3**](#33--function-parameters) – Function parameters
* [**3.4**](#34--variable-scope) – Variable scope

## 3.1 – Variables

In *DeltaScript*, a **variable** is a storage location associated with a particular name, in a particular scope<sup>[§3.4](#34--variable-scope)</sup> of the program. Variables are either **declared** in the body of a function, or are **parameters** of the function itself.

A variable stores a value of a particular type<sup>[§2](./ls-2-types.md)</sup>, which is stated in the variable's declaration<sup>[§3.2](#32--declarations)</sup>.

A variable may or may not be assigned a value when it is declared. The assignment of a value to a variable upon its declaration is known as initialization<sup>[§3.2.2](#322--initialization)</sup>.

## 3.2 – Declarations

A **variable declaration** is a type of statement<sup>[§TODO - statements]()</sup> in *DeltaScript* that appoints a particular name as a storage location for values of a particular type.

Referring back to the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>, variable declarations are matched by the following production rules:

> **_&lt;var_def&gt;_:** &lt;declaration&gt; | &lt;var_init&gt;
> 
> **_&lt;var_init&gt;_:** &lt;declaration&gt; `=` &lt;expr&gt;
> 
> **_&lt;declaration&gt;_:** &lt;FINAL&gt;? &lt;type&gt; &lt;ident&gt;

From left to right, a declaration consists of an optional immutability<sup>[§3.2.3](#323--immutability)</sup> modifier, a type identifier, and a variable name. A declaration statement may also be an initialization statement, in which case the variable name will be followed by the assignment operator `=` and an expression<sup>[§TODO - expressions]()</sup> representing the variable's initial value.

After its initialization, a variable's name can be used as an expression to retrieve its associated value. A **mutable** variables can also be assigned<sup>[§TODO - assignment]()</sup> a new value.

### 3.2.1 – Variable names

Variable names in *DeltaScript* must be valid [identifiers![](../assets/definition.png)](./glossary.md#identifier). An identifier must match the following rule<sup>[a](#fn-a)</sup> from the lexical grammar<sup>[§1.2.1](./ls-1-syntax.md#121--lexical-grammar)</sup>:

> **_&lt;IDENTIFIER&gt;_:** &lt;LEADOFF&gt; &lt;FOLLOWING&gt;\*
> 
> **_&lt;LEADOFF&gt;_:** `_` | `A..Z` | `a..z`
> 
> **_&lt;FOLLOWING&gt;_:** &lt;LEADOFF&gt; | `0..9`

Simply put, variable names must **contain only alphanumeric characters or underscores**, **contain no spaces**, and **cannot begin with a number**.

### 3.2.2 – Initialization

An **initialization statement** is a single statement that declares a variable and assigns it an initial value. Variables that were declared without an initialization are called **uninitialized**.

> **Example:**
> 
> ```js
> () {
>   int a;
>   int b = 10;
>   int c = rand(0, 11);
> }
> ```
> 
> * `a` is declared, but not initialized. During program execution<sup>[§TODO - execution]()</sup>, after its declaration and before any assignment of `a`, `a` is considered uninitialized.
> * `b` is declared and initialized with a value of 10.
> * `c` is declared and initialized with a value of a random number between 0 and 11<sup>[b](#fn-b)</sup>.

Provided they were not declared as immutable, uninitialized variables can be initialized after their declaration with an assignment<sup>[§TODO - assignment]()</sup>.

Attempting to access the value of an uninitialized variable by using the variable name as an expression will lead to a runtime error<sup>[§TODO - runtime error]()</sup>.

> **Example:**
> 
> ```js
> () {
>   int a;
>   int b = a + 5; // runtime error - script stops executing here
>   print(b);
> }
> ```
> 
> `a` is uninitialized, so attempting to access the value of `a` in the initialization of `b` will result in a runtime error.

### 3.2.3 – Immutability

Variables, including function parameters, can optionally be declared as **immutable**. An **immutable** variable cannot be reassigned a new value. For variables declared in the body of a function, this means that they can only be assigned a value in an initialization statement. For function parameters, this means that they can only be assigned a value by the arguments that are passed into the function when it is called<sup>[§TODO - function call]()</sup>.

A variable is declared as immutable by prepending the type identifier in the declaration with the keyword<sup>[§TODO - keyword]()</sup> `final` (or its shorthand<sup>[§TODO - shorthand]()</sup> equivalent `~`).

Contrastingly, a variable that **can** have its value reassigned is called **mutable**.

Immutability in *DeltaScript* is **shallow**. This means that, for variables representing arrays<sup>[§2.3.1](./ls-2-types.md#231--arrays)</sup> or lists<sup>[§2.3.2](./ls-2-types.md#232--lists)</sup>, while the entire collection cannot be reassigned, indices of the collection can be reassigned with new elements.

> **Example:**
> 
> ```js
> () {
>   final int[] nums = [ 1, 2, 3, 4 ]; // nums is declared as immutable
> 
>   nums[0] = 5; // permitted
> 
>   for (int i = 0; i < #|nums; i++)
>     nums[i] *= 2; // permitted
> 
>   nums = [ 10, 9, 8, 7 ]; // runtime error - script stops executing here
> 
>   print(nums);
> }
> ```
> 
> `nums` is declared as immutable. Assignments with a [LHS![](../assets/definition.png)](./glossary.md#lhs) of the form `nums[I]`, where `I` is an arbitrary expression that evaluates to a value of type `int`, are permitted. However, direct assignments to `nums` (`nums = ...`) are not.

## 3.3 – Function parameters

<!-- TODO -->

## 3.4 – Variable scope

<!-- TODO -->

---

## Footnotes

* <sup id="fn-a">a</sup> - Production rule is collapsed for the sake of brevity and clarity
* <sup id="fn-b">b</sup> - `11` is an exclusive upper bound in `rand(0, 11)`. The function has an equal probability of returning 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 or 10. For more information, you can read about the behaviour of [`rand(int min, int max_ex) -> int`](./functions-sl.md#rand) in the standard library.
