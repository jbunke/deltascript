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

A **variable declaration** is a type of statement<sup>[§5.2](./ls-5-stat.md#52--statements)</sup> in *DeltaScript* that appoints a particular name as a storage location for values of a particular type.

Referring back to the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>, variable declarations are matched by the following production rules:

> **_&lt;var_def&gt;_:** &lt;declaration&gt; | &lt;var_init&gt;
> 
> **_&lt;var_init&gt;_:** &lt;declaration&gt; `=` &lt;expr&gt;
> 
> **_&lt;declaration&gt;_:** &lt;FINAL&gt;? &lt;type&gt; &lt;ident&gt;

From left to right, a declaration consists of an optional immutability<sup>[§3.2.3](#323--immutability)</sup> modifier, a type identifier, and a variable name. A declaration statement may also be an initialization statement, in which case the variable name will be followed by the assignment operator `=` and an expression<sup>[§4](./ls-4-expr.md)</sup> representing the variable's initial value.

After its initialization, a variable's name can be used as an expression to retrieve its associated value. A **mutable** variables can also be assigned<sup>[§5.4](./ls-5-stat.md#54--assignments)</sup> a new value.

### 3.2.1 – Variable names

Variable names in *DeltaScript* must be valid [identifiers![](../assets/definition.png)](./glossary.md#identifier). An identifier must match the following rule<sup>[a](#fn-a)</sup> from the lexical grammar<sup>[§1.2.1](./ls-1-syntax.md#121--lexical-grammar)</sup>:

> **_&lt;IDENTIFIER&gt;_:** &lt;LEADOFF&gt; &lt;FOLLOWING&gt;\*
> 
> **_&lt;LEADOFF&gt;_:** `_` | `A..Z` | `a..z`
> 
> **_&lt;FOLLOWING&gt;_:** &lt;LEADOFF&gt; | `0..9`

Simply put, variable names must **contain only alphanumeric characters or underscores**, **contain no spaces**, and **cannot begin with a number**.

*DeltaScript* uses the **special identifier** `_` (a single underscore) to represent the **scope variable**. Certain control structures make use of a control expression. Inside the scope<sup>[§3.4](#34--variable-scope)</sup> of such a structure, the special identifier `_` acts as a stand-in for the control expression. Presently, `when` statements<sup>[§5.6.2](./ls-5-stat.md#562--when-statements)</sup> are the only such structure in *DeltaScript*.

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
> * `a` is declared, but not initialized. During program execution<sup>[§7.4](./ls-7-exec.md#74--runtime-execution)</sup>, after its declaration and before any assignment of `a`, `a` is considered uninitialized.
> * `b` is declared and initialized with a value of 10.
> * `c` is declared and initialized with a value of a random number between 0 and 11<sup>[b](#fn-b)</sup>.

Provided they were not declared as immutable, uninitialized variables can be initialized after their declaration with an assignment<sup>[§5.4](./ls-5-stat.md#54--assignments)</sup>.

Attempting to access the value of an uninitialized variable by using the variable name as an expression will lead to a runtime error<sup>[§7.5.3](./ls-7-exec.md#753--runtime-errors)</sup>.

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

Variables, including function parameters, can optionally be declared as **immutable**. An **immutable** variable cannot be reassigned a new value. For variables declared in the body of a function, this means that they can only be assigned a value in an initialization statement. For function parameters, this means that they can only be assigned a value by the arguments that are passed into the function when it is called<sup>[§4.7](./ls-4-expr.md#47--function-calls)</sup>.

A variable is declared as immutable by [prepending![](../assets/definition.png)](./glossary.md#prepend) the type identifier in the declaration with the keyword<sup>[§1.3.3](./ls-1-syntax.md#133--keywords)</sup> `final`<sup>[c](#fn-c)</sup>.

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

**Function parameters** are special types of variables. Rather than being declared with statements in the bodies of functions<sup>[§6.1](./ls-6-func.md#61--functions)</sup>, they are defined in the function's signature. Function parameters receive their values from the arguments passed to the function when it is called. These parameters can be either mutable or immutable, depending on whether the `final` keyword<sup>[c](#fn-c)</sup> is used in their declaration. That is to say, mutable parameters can be assigned new values in the bodies of the functions they are defined with.

**Example:**

```js
backwards(~ string word -> string) {
  string assembled = "";

  for (letter in word)
    assembled = letter + assembled;

  return assembled;
}
```

The function `backwards(string) -> string` has a single parameter `word`, which is immutable and of type `string`.

## 3.4 – Variable scope

The **scope** of a variable is the section of a program's source code in which the name of the variable can be used to as a reference to its associated value. Scopes are associated with a language structure, whether it is a function<sup>[§6.1](./ls-6-func.md#61--functions)</sup>, or a [control flow![](../assets/definition.png)](./glossary.md#control-flow) structure like an `if` statement<sup>[§5.6.1](./ls-5-stat.md#561--if-statements)</sup> or a loop<sup>[§5.7](./ls-5-stat.md#57--loops)</sup>.

> **Note:**
> 
> This specification uses the terms **reference** and **use** of a variable to mean the invocation of a variable's name as an expression to represent its value.

Variables cannot be referenced outside of the scope in which their are declared. Nor can they be referenced in their declaration scope prior to their declaration. Attempting to do so will lead to a compile error<sup>[§7.5.2](./ls-7-exec.md#752--semantic-errors)</sup> that will prevent the script from being executed.

Scopes can be **nested**. A variable defined in the outermost scope of a function can still be referenced inside control flow structures within that function, as long as they follow the variable's declaration.

> **Example 1: Reference in nested scope**
> 
> ```js
> () {
>   ~ string a = "Aussie!";
>   ~ string b = "Oi!"
>   ~ int reps = 3;
> 
>   for (int i = 0; i < reps; i++) {
>     print(a);
>   }
> 
>   for (int i = 0; i < reps; i++) {
>     print(b);
>   }
> }
> ```
> 
> The outermost scope of this script is the header function body, i.e. everything between the outermost curly brackets `() {...}`. Each of the `for` loops<sup>[§5.7.3](./ls-5-stat.md#573--for-loops)</sup> defines a nested scope within the function body scope. The variables `a` and `b` are declared in the function body scope. The `print()` statements inside each loop are part of the scopes of the respective loops. Because the loop scopes are **nested within the function scope**, variables declared in the function scope can be referenced from within the nested scopes.

> **Example 2: Out of scope**
> 
> ```js
> () {
>   if (true) {
>     int b = 1;
>     print(b);
>   }
> 
>   int c = b + 1; // compile error - script is not executed
>   print(c);
> }
> ```
> 
> The variable `b` is defined in the body of the `if` statement, which comprises its scope. So, when `b` is referenced outside of its scope in the initialization of `c`, a compile error is triggered.

> **Example 3: Reference before declaration**
> 
> ```js
> () {
>   print(d); // compile error - script is not executed
>   int d = 1;
> }
> ```
> 
> A variable cannot be referenced before its declaration. Although the `print()` statement and the declaration of `d` are in the same scope, the fact that the use of `d` as an expression precedes its declaration will trigger a compile error.

> **Example 4: Reuse of variable name in nested scope**
> 
> ```js
> () {
>   int e = 1;
> 
>   if (true) {
>     int e = 2;
>     print(e); // prints "2"
> 
>     e = 3;
>     print(e); // prints "3"
>   }
> 
>   print(e); // prints "1"
> }
> ```
> 
> This script will result in the output
> 
> ```
> 2
> 3
> 1
> ```
> 
> This script initially declares a variable `e` in the function scope, and then declares another variable with the same name in the `if` statement's scope. The first `print()` statement, which is in the `if` statement's scope, matches the expression `e` to the **most immediate** variable matching that name. This is the variable that is the fewest outer scopes removed from the scope of the expression.
> 
> The same goes for the use of `e` in the assignment `e = 3;`. Here, the `e` in the assignment refers to the variable declared in the `if` statement's scope, not the one in the function scope. The final `print()` statement outside the `if` statement demonstrates how variable names can be reused in nested scopes without affecting variables in outer scopes, as the outer `e` still retains the value from its initial declaration.

> **Example 5: Nested scope without reuse of variable name**
> 
> ```js
> () {
>   int e = 1;
> 
>   if (true) {
>     print(e);
> 
>     e = 3;
>     print(e);
>   }
> 
>   print(e);
> }
> ```
> 
> This script will result in the output
> 
> ```
> 1
> 3
> 3
> ```
> 
> This is because the variable `e` declared in the function scope is accessible within the nested `if` statement's scope. The assignment `e = 3;` modifies the value of `e` in the function scope, which is then reflected in the subsequent `print(e);` statements both inside and outside the `if` statement's scope.

---

## Footnotes

* <sup id="fn-a">a</sup> - Production rule is collapsed for the sake of brevity and clarity
* <sup id="fn-b">b</sup> - `11` is an exclusive upper bound in `rand(0, 11)`. The function has an equal probability of returning 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 or 10. For more information, you can read about the behaviour of [`rand(int min, int max_ex) -> int`](./functions-sl.md#rand) in the standard library.
* <sup id="fn-c">c</sup> - `final` or its shorthand<sup>[§1.3.4](./ls-1-syntax.md#134--shorthands)</sup> equivalent `~`
