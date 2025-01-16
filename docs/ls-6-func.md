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

This chapter describes the syntax, semantics and distinctions of the various types of functions in *DeltaScript*.

## 6.1 – Functions

**Functions** are reusable blocks of code that perform a specific task. Most functions can be repeatedly invoked. The invocation of a function is known as a **function call**. 

Functions may define inputs, called **parameters**<sup>[§3.3](./ls-3-vars.md#33--function-parameters)</sup>, and may produce an output, called a **return value**. The value is "returned" because functions with an output yield the value produced by the invocation of the function back to the place that invoked the function.

## 6.2 – Type signatures

A function's **type signature** comprises the types<sup>[§2](./ls-2-types.md)</sup> of its parameters, if any, and its return type, if present.

Two functions `a` and `b` have the same type signature [iff![](../assets/definition.png)](./glossary.md#iff):

* `a` and `b` have the same number of parameters *n* (including zero)
* For *i* from 1 to *n*, the type of parameter P<sub>`a`</sub>*i* is the same<sup>[a](#fn-a)</sup> as the type of parameter P<sub>`b`</sub>*i*
* `a` and `b` have the same return type (including no return type<sup>[§6.2.2](#622--void-functions)</sup>)

It is important for *DeltaScript* programmers to be able to parse type signatures in order to understand which types of arguments a function expects and what it returns.

| Example function header | As functional type<sup>[§2.4](./ls-2-types.md#24--functional-types)</sup> identifier<sup>[§2.1](./ls-2-types.md#21--type-system)</sup> | Explanation |
| :---------------------- | :----------------- | :----------- |
| `to_upper(string s -> string)` | `(string -> string)` | `to_upper` has a single parameter `s` of type `string` and returns a `string` |
| `alert()` | N/A<sup>1</sup> | `alert` has no parameters and returns nothing |
| `random_num(-> int)` | `(-> int)` | `random_num` has no parameters and returns an `int` |
| `display(image img, color tint)` | N/A<sup>1</sup> | `display` has two parameters: a parameter `img` of type `image` and a parameter `tint` of type `color`; `display` returns nothing |
| `similarity(color a, color b -> float)` | `(color, color -> float)` | `similarity` has two parameters, `a` and `b`, both of type `color`, and returns a `float` |

<sup>1</sup> - Void functions are not valid functional types.

Essentially, two value-returning functions<sup>[§6.2.1](#621--value-returning-functions)</sup> have the same type signature if their functional type identifier representations are the same.

Type signatures in function definitions are matched by the following production rule from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;signature&gt;_:**
> * `(` &lt;param_list&gt;? `)`
> * `(` &lt;param_list&gt;? `->` &lt;type&gt; `)`
> 
> **_&lt;param_list&gt;_:** &lt;declaration&gt; ( `,` &lt;declaration&gt; )\*
> 
> **_&lt;declaration&gt;_:** &lt;FINAL&gt;? &lt;type&gt; &lt;ident&gt;
> 
> **_&lt;type&gt;_:**
> * `bool`
> * `char`
> * `color`
> * `float`
> * `image`
> * `int`
> * `string`
> * &lt;type&gt; `[]`
> * &lt;type&gt; `<>`
> * &lt;type&gt; `{}`
> * `{` &lt;type&gt; `:` &lt;type&gt; `}`
> * `(` &lt;func_type&gt; `)`
> * &lt;ident&gt;
> 
> **_&lt;func_type&gt;_:** &lt;param_types&gt;? `->` &lt;type&gt;
> 
> **_&lt;param_types&gt;_:** &lt;type&gt; ( `,` &lt;type&gt; )\*

> **Example:**
> 
> ```js
> sum(int a, int b -> int) {
>   return a + b;
> }
> ```
> 
> For this helper function<sup>[§6.3.2](#632--helper-functions)</sup>, the syntax grammar rule &lt;signature&gt; is matched by `(int a, int b -> int)`, and the functional type identifier is `(int, int -> int)`.

### 6.2.1 – Value-returning functions

**Value-returning functions** return a value of a type specified by their type signatures.

Their type signatures are matched by the following production of &lt;signature&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> `(` &lt;param_list&gt;? `->` &lt;type&gt; `)`

Unlike void functions<sup>[§6.2.2](#622--void-functions)</sup>, which return nothing, value-returning functions can be converted to function objects<sup>[§6.4](#64--function-objects)</sup> and be used in expressions<sup>[§4](./ls-4-expr.md)</sup>.

### 6.2.2 – Void functions

**Void functions** do not return a value. They perform an action but do not produce a result that can be used. Thus, they can only be invoked<sup>[§5.5](./ls-5-stat.md#55--void-function-calls)</sup> as a statement<sup>[§5.2](./ls-5-stat.md#52--statements)</sup>, not an expression<sup>[§4](./ls-4-expr.md)</sup>.

The type signatures of void functions are matched by the following production of &lt;signature&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> `(` &lt;param_list&gt;? `)`

## 6.3 – Types of functions

Functions in *DeltaScript* can be split into several categories:

* Source code functions - functions defined in *DeltaScript* scripts by programmers
  * **Header functions**<sup>[§6.3.1](#631--header-functions)</sup>
  * **Helper functions**<sup>[§6.3.2](#632--helper-functions)</sup>
  * **Anonymous functions**<sup>[§6.3.3](#633--anonymous-functions)</sup>
* Standard library functions - functions defined as part of the [base language![](../assets/definition.png)](./glossary.md#base-language) in the [standard library](./std-lib.md)
  * **Global functions**<sup>[§6.3.4](#634--global-functions)</sup>
  * **Member functions**<sup>[§6.3.5](#635--member-functions)</sup>
* **Extension functions**<sup>[§6.3.6](#636--extension-functions)</sup>

### 6.3.1 – Header functions

**Header functions** are the [entry point![](../assets/external.png)](https://en.wikipedia.org/wiki/Entry_point) of a *DeltaScript* script's execution. They are akin to `main()` functions in languages like C, C++ and Java.

Header functions must be the **first function** in a *DeltaScript* file. They must also be **nameless**. This was a design decision that was made because the header function **cannot be invoked from within the script**.

A header function may have any type signature<sup>[§6.2](#62--type-signatures)</sup>. It may be void<sup>[§6.2.2](#622--void-functions)</sup> or return a value<sup>[§6.2.1](#621--value-returning-functions)</sup>, and may accept any number and types of parameters<sup>[§3.3](./ls-3-vars.md#33--function-parameters)</sup>, including none.

Header functions are matched as part of the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup> production rule &lt;head_rule&gt;. &lt;head_rule&gt; does not only match the header function, it matches the entire script. The contents of an entire *DeltaScript* file must match &lt;head_rule&gt; in order for the script to be syntactically correct.

> **_&lt;head_rule&gt;_:** &lt;signature&gt; &lt;func_body&gt; &lt;helper&gt;\*

### 6.3.2 – Helper functions

Named functions that follow the header function<sup>[§6.3.1](#631--header-functions)</sup> in a *DeltaScript* file are known as **helper functions**. They can be invoked repeatedly and turned into function objects<sup>[§6.4](#64--function-objects)</sup> with the reference<sup>[§4.8](./ls-4-expr.md#48--helper-function-references)</sup> operator `::`.

Helper functions are matched by the following production rule from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;helper&gt;_:** &lt;ident&gt; &lt;signature&gt; &lt;func_body&gt;
> 
> **_&lt;func_body&gt;_:**
> * &lt;body&gt;
> * `->` &lt;expr&gt;

Bodies of value-returning functions<sup>[§6.2.1](#621--value-returning-functions)</sup> may be complex and consist of zero or more statements<sup>[§1.2.2](./ls-5-stat.md#52--statements)</sup> enclosed in curly braces `{}`, or consist of an arrow `->` followed by a single expression. **Single expression function bodies** are a shorthand<sup>[§1.3.4](./ls-1-syntax.md#134--shorthands)</sup> for a function body consisting of a single value `return` statement<sup>[§5.8.1](./ls-5-stat.md#581--value-return)</sup>.

> **Note:**
> 
> Header functions may also have single expression function bodies.
> 
> The following is a valid *DeltaScript* script:
> 
> ```js
> (int a, int b -> int) -> a + b
> ```

> **Example:**
> 
> ```js
> () {
>   int[] nums = [ 6, 2, -5, 7, 18, -12, 4 ];
> 
>   ~ int method1 = array_sum(nums);
>   int method2 = nums[0];
> 
>   for (int i = 1; i < #|nums; i++)
>     method2 = a_b_sum(method2, nums[i]);
> 
>   if (method1 != method2)
>     print("Uh-oh!");
> }
> 
> array_sum(int[] arr -> int) {
>   int sum = 0;
> 
>   for (elem in arr)
>     sum += elem;
> 
>   return sum;
> }
> 
> a_b_sum(int a, int b -> int) -> a + b
> ```
> 
> The helper function `array_sum` has a complex body, while the helper function `a_b_sum` has a single expression body.

### 6.3.3 – Anonymous functions

[*see §4.9*](./ls-4-expr.md#49--anonymous-functions)

### 6.3.4 – Global functions

**Global functions** are defined by the [standard library](./functions-sl.md) and can be called from anywhere within the script.

> **Experimental:**
> 
> Due to the ambiguous type signatures of some global functions (e.g. [`prompt(T message) -> string`](./functions-sl.md#prompt)), as of this language version, global functions cannot be turned into function objects<sup>[§6.4](#64--function-objects)</sup> with the reference<sup>[§4.8](./ls-4-expr.md#48--helper-function-references)</sup> operator `::`. However, they can be composed or wrapped by anonymous functions<sup>[§6.3.3](#633--anonymous-functions)</sup> or helper functions<sup>[§6.3.2](#632--helper-functions)</sup> for the same effect.
> 
> **Example:**
> 
> ```js
> (int[] -> int) aux_max = arr -> max(arr);
> ```
> 
> The anonymous function `arr -> max(arr)` wraps the global function [`max(int[] collection) -> int`](./functions-sl.md#max) and assigns it to the variable `aux_max`<sup>[§3.1](./ls-3-vars.md#31--variables)</sup>.
> 
> Now via helper function `max_wrapper`:
> 
> ```js
> (int[] -> int) aux_max = ::max_wrapper;
> 
> /* code in between */
> 
> max_wrapper(int[] arr -> int) -> max(arr)
> ```

### 6.3.5 – Member functions

**Member functions** are functions that are defined as callable on expressions of a particular type.

For example, the `string` type defines the following member functions:

* [`at(int index -> char)`](./string-sl.md#at)
* [`has(char character -> bool)`](./string-sl.md#has)
* [`has(string substring -> bool)`](./string-sl.md#has)
* [`sub(int beg, int end_ex)`](./string-sl.md#sub)

Member functions of built-in types<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup> are defined by the [standard library](./std-lib.md). Extension types<sup>[§8.3.1](./ls-8-ext.md#831--new-types)</sup> may also define member functions.

Member functions can be called on any expression of a valid type, not just variables or literals.

> **Example:**
> 
> ```js
> () {
>   bool check = [ 1, 2, 3 ].has(1);
>   string middle = ("half" + "pipe").sub(2, 6);
> 
>   print(check);
>   print(middle);
> }
> ```
> 
> This script produces the output:
> 
> ```
> true
> lfpi
> ```

### 6.3.6 – Extension functions

Extension functions are functions that extend the capabilities of existing types or namespaces.

<!-- TODO - namespace functions -->

<!-- TODO - extension member functions -->

<!-- TODO - proofread -->

## 6.4 – Function objects

Function objects are instances of functions that can be passed around and invoked like any other object.

<!-- TODO -->

### 6.4.1 – `call()`

The function associated with a function object can be invoked with the special method `call()`.

<!-- TODO -->

## 6.5 – Function semantics

Function semantics define the behavior and rules of functions in DeltaScript.

<!-- TODO -->

### 6.5.1 – Parameters and arguments

Parameters are the inputs defined by a function, and arguments are the actual values passed to the function when it is called.

<!-- TODO -->

### 6.5.2 – Return path completeness

Return path completeness ensures that all possible execution paths in a function return a value if the function's type signature specifies a return type.

<!-- TODO -->

---

## Footnotes

* <sup id="fn-a">a</sup> - Sameness for two arbitrary types is defined as having the same type identifier<sup>[§2.1](./ls-2-types.md#21--type-system)</sup>.
