[**< Language Specification**](./lang-spec.md)

# Chapter 5 – Statements

## Contents

* [**5.1**](#51--imperative-programming) – Imperative programming
* [**5.2**](#52--statements) – Statements
* [**5.3**](#53--declarations) – Declarations
* [**5.4**](#54--assignments) – Assignments
* [**5.5**](#55--void-function-calls) – Void function calls
* [**5.6**](#56--conditional-statements) – Conditional statements
  * [**5.6.1**](#561--if-statements) – `if` statements
  * [**5.6.2**](#562--when-statements) – `when` statements
* [**5.7**](#57--loops) – Loops
  * [**5.7.1**](#571--while-loops) – `while` loops
  * [**5.7.2**](#572--dowhile-loops) – `do`...`while` loops
  * [**5.7.3**](#573--for-loops) – `for` loops
  * [**5.7.4**](#574--iterator-loops) – Iterator loops
* [**5.8**](#58--return-statements) – `return` statements
  * [**5.8.1**](#581--value-return) – Value `return`
  * [**5.8.2**](#582--void-return) – Void `return`

---

This chapter details the various forms statements in *DeltaScript* can take.

## 5.1 – Imperative programming

Statements are the building blocks of [imperative![](../assets/external.png)](https://en.wikipedia.org/wiki/Imperative_programming) programming languages like *DeltaScript*<sup>[a](#fn-a)</sup>. **Imperative programming** is a programming paradigm in which sequential instructions to change a program's state. These instructions are called statements.

## 5.2 – Statements

A **statement** is an instruction. In *DeltaScript*, statements can be conceptualized as any chunk of code that tells the program to do something. Expressions<sup>[§4](./ls-4-expr.md)</sup> are evaluated, whereas statements are **executed**.

Simple statements like assignments<sup>[§5.4](#54--assignments)</sup> or void function calls<sup>[§5.5](#55--void-function-calls)</sup> terminate with a semicolon `;` and often fit on a single line. Complex statements like control flow structures (conditionals and loops) define a nested scope<sup>[§3.4](./ls-3-vars.md#34--variable-scope)</sup> and may contain many statements themselves.

Statements are matched by the following production rule from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;stat&gt;_:**
> * &lt;loop_stat&gt;
> * &lt;if_stat&gt;
> * &lt;when_stat&gt;
> * &lt;var_def&gt; `;`
> * &lt;assignment&gt; `;`
> * &lt;return_stat&gt;
> * &lt;expr&gt; &lt;sub_ident&gt; &lt;args&gt; `;`
> * &lt;ident&gt; &lt;args&gt; `;`
> * &lt;namespace_ident&gt; &lt;args&gt; `;`

## 5.3 – Declarations

**Declarations**<sup>[§3.2](./ls-3-vars.md#32--declarations)</sup> are statements that introduce new variables<sup>[§3.1](./ls-3-vars.md#31--variables)</sup>. A declaration specifies the type and name of the variable, and optionally, its initial value. A declaration that defines the initial value of its variable is called an initialization<sup>[§3.2.2](./ls-3-vars.md#322--initialization)</sup>.

Declaration statements are matched by the following production of &lt;stat&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;stat&gt;_:**
> * (... higher precedence productions)
> * &lt;var_def&gt; `;`
> * (... lower precedence productions)
> 
> **_&lt;var\_def&gt;_:** &lt;declaration&gt; | &lt;var_init&gt;
> 
> **_&lt;var\_init&gt;_:** &lt;declaration&gt; `=` &lt;expr&gt;
> 
> **_&lt;declaration&gt;_:** &lt;FINAL&gt;? &lt;type&gt; &lt;ident&gt;

## 5.4 – Assignments

**Assignments** are statements that update the value of an assignable expression<sup>[§4](./ls-4-expr.md)</sup>.

An **assignable** can be:

* A variable<sup>[§4.4](./ls-4-expr.md#44--variables-as-expressions)</sup>
* An array element<sup>[§4.10](./ls-4-expr.md#410--array-and-list-elements)</sup> of a variable representing an array<sup>[§2.3.1](./ls-2-types.md#231--arrays)</sup>
* A list element<sup>[§4.10](./ls-4-expr.md#410--array-and-list-elements)</sup> of a variable representing a list<sup>[§2.3.2](./ls-2-types.md#232--lists)</sup>

Assignment statements can be split into standard assignments and compound assignments.

**Standard assignments** consist of an assignable [LHS![](../assets/definition.png)](./glossary.md#lhs), the assignment operator `=`, and the value to be assigned to the assignable as the [RHS![](../assets/definition.png)](./glossary.md#rhs).

**Compound assignments** are a shorthand syntax used to express assignments that reference the assignable's current value to define its updated value. They make use of one of the compound assignment operators<sup>[§4.5.4](./ls-4-expr.md#454--compound-assignment-operators)</sup>.

Assignments are matched by the following production of &lt;stat&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;stat&gt;_:**
> * (... higher precedence productions)
> * &lt;assignment&gt; `;`
> * (... lower precedence productions)
> 
> **_&lt;assignment&gt;_:**
> * &lt;assignable&gt; `=` &lt;expr&gt;
> * &lt;assignable&gt; `++`
> * &lt;assignable&gt; `--`
> * &lt;assignable&gt; `+=` &lt;expr&gt;
> * &lt;assignable&gt; `-=` &lt;expr&gt;
> * &lt;assignable&gt; `*=` &lt;expr&gt;
> * &lt;assignable&gt; `/=` &lt;expr&gt;
> * &lt;assignable&gt; `%=` &lt;expr&gt;
> * &lt;assignable&gt; `&=` &lt;expr&gt;
> * &lt;assignable&gt; `|=` &lt;expr&gt;
> 
> **_&lt;assignable&gt;_:**
> * &lt;ident&gt;
> * &lt;ident&gt; `<` &lt;expr&gt; `>`
> * &lt;ident&gt; `[` &lt;expr&gt; `]`

Attempting to assign a value to a variable declared as immutable<sup>[§3.2.3](./ls-3-vars.md#323--immutability)</sup> (`final`, `~`) causes a semantic error<sup>[§TODO - semantic error]()</sup>.

> **Example:**
> 
> ```js
> () {
>   int x;
>   x = 5; // assignment of the value 5 to x
>   x = rand(0, 10); // assigns a random integer between 0 and 10 to x
> 
>   final int y = 10;
>   y = 5; // semantic error - script cannot be executed
> }
> ```

## 5.5 – Void function calls

**Void function calls** in *DeltaScript* invoke functions that do not return a value<sup>[§TODO - void functions]()</sup>. These functions perform actions but do not produce a result that can be used in expressions.

Void function calls are matched by the following productions of &lt;stat&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;stat&gt;_:**
> * (... higher precedence productions)
> * &lt;expr&gt; &lt;sub_ident&gt; &lt;args&gt; `;`
> * &lt;ident&gt; &lt;args&gt; `;`
> * &lt;namespace_ident&gt; &lt;args&gt; `;`
> 
> **_&lt;args&gt;_:** `(` &lt;elements&gt;? `)`
> 
> **_&lt;elements&gt;_:** &lt;expr&gt; ( `,` &lt;expr&gt; )\*

> **Example:**
> 
> ```js
> () {
>   print("Hello, World!"); // void function call
> 
>   {string:color} named_colors = new {string:color};
>   named_colors.define("red", #ff0000); // void function call
> }
> ```
> 
> This script calls two different kinds of void functions: a global function<sup>[§TODO - global functions]()</sup> and a member function<sup>[§TODO - member functions]()</sup> of the type map<sup>[§2.3.4](./ls-2-types.md#234--mapsdictionaries)</sup> `{K:V}`.
> 
> * The global function [`print(T message);`](./functions-sl.md#print) prints a value to output, but returns nothing
> * The map function [`MAP.define(K key, V value);`](./collections-sl.md#define) adds a mapping from `key` to `value` to `MAP`, but returns nothing

## 5.6 – Conditional statements

**Conditional statements** allow the program to execute different code paths based on certain conditions. *DeltaScript*'s conditional statements are `if` and `when`.

### 5.6.1 – `if` statements

**`if` statements** execute a block of code if a specified condition is true. Optionally, subsequent `else if` branches may be used to specify alternative conditions and alternative behaviours if those conditions are met. Finally, an `if` statement may include an `else` branch for code to be executed if no prior condition from the `if` branch or any `else if` branches was met.

If the conditional expression of an `if` or `else if` branch is not of type `bool`<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup>, a semantic error<sup>[§TODO - semantic error]()</sup> is triggered.

`if` statements are matched by the following production of &lt;stat&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;stat&gt;_:**
> * (... higher precedence productions)
> * &lt;if_stat&gt;
> * (... lower precedence productions)
> 
> **_&lt;if_stat&gt;_:** &lt;if_def&gt; ( `else` &lt;if_def&gt; )\* ( `else` &lt;body&gt; )?
> 
> **_&lt;if_def&gt;_:** `if` `(` &lt;expr&gt; `)` &lt;body&gt;

> **Examples:**
> 
> 1.  A simple `if` statement
>     
>     ```js
>     (-> bool) {
>       int seed = rand(0, 11);
> 
>       if (seed == 0) {
>         print("Lucky you!");
>         return true;
>       }
> 
>       return false;
>     }
>     ```
> 
>     `Lucky you!` is only printed if `seed` evaluates to `0`.
> 
> 2.  An `if` statement with an `else if` branch and an `else` branch
> 
>     ```js
>     (int num -> bool) {
>       if (num <= 1)
>         return false;    // num is not prime if it is less than or equal to 1
>       else if (num % 2 == 0)
>         return num == 2; // if num is divisible by 2, num is prime iff num is 2
>       else {             // otherwise, num is prime if it has exactly 2 factors
>         int[] fs = factors(num);
>         return #|fs == 2;
>       }
>     }
> 
>     factors(int num -> int[]) { /* ... */ }
>     ```
> 
>     This script returns `true` [iff![](../assets/definition.png)](./glossary.md#iff) the argument supplied to its parameter `num` is a prime number. Note that the `if` and `else if` blocks in the example consist of a single statement each and are not enclosed in curly braces `{}`.

### 5.6.2 – `when` statements

**`when` statements** in *DeltaScript* are similar to [`switch` statements![](../assets/external.png)](https://en.wikipedia.org/wiki/Switch_statement) in other programming languages. They allow the program to execute different blocks of code based on the value of a **control expression**.

> **Experimental:**
> 
> The `when` statement is still an experimental feature in *DeltaScript*. As such, its syntax and implementation may change. Notably, the use of the keyword `otherwise` is still under review, and may be changed in favour of the reuse of the keyword `else`.

> **Planned:**
> 
> Future language versions may introduce a `when` expression structure that is analogous to the `when` statement.

`when` statements are matched by the following production of &lt;stat&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;stat&gt;_:**
> * (... higher precedence productions)
> * &lt;when_stat&gt;
> * (... lower precedence productions)
> 
> **_&lt;when_stat&gt;_:** `when` `(` &lt;expr&gt; `)` &lt;when_body&gt;
> 
> **_&lt;when_body&gt;_:** `{` &lt;when_case&gt;\+ &lt;otherwise_case&gt;? `}`
> 
> **_&lt;when_case&gt;_:**
> * `is` &lt;elements&gt; `->` &lt;body&gt;
> * `matches` &lt;expr&gt; `->` &lt;body&gt;
> * `passes` &lt;expr&gt; `->` &lt;body&gt;
> 
> **_&lt;otherwise_case&gt;_:** `otherwise` `->` &lt;body&gt;
> 
> **_&lt;elements&gt;_:** &lt;expr&gt; ( `,` &lt;expr&gt; )\*

Unlike traditional `switch` statements<sup>[b](#fn-b)</sup>, which consist of a series of cases that check the value of the control expression against literal expressions<sup>[§4.3](./ls-4-expr.md#43--literals)</sup>, the `when` statement is a powerful pattern matching structure that can be used for control expressions of any type.

A `when` statement consists of a control expression, one or more non-trivial cases, and optionally, an `otherwise` case. Cases are checked sequentially; the first case to be matched has its block of code executed. There is no fallthrough; subsequent cases to the first matched case are neither checked, nor is their code block executed. `when` statements are non-exhaustive; if no case is matched and the `when` statement does not contain an `otherwise` case, no constituent code block is executed.

> **Example:**
> 
> ```js
> (color c) {
>   ~ string pfx = "The color is ";
>   
>   when (c) {
>     matches _.alpha == 0 -> print(pfx + "transparent");
>     is #000000 -> print(pfx + "black");
>     is #ffffff -> print(pfx + "white");
>     matches _.r == _.g && _.r == _.b && opaque(_) -> 
>             print(pfx + "a shade of grey");
>     is #ff0000, #00ff00, #0000ff -> print(pfx + "an RGB primary color");
>     passes ::bright_opaque -> print("bright");
>     otherwise -> print(pfx + "not a match");
>   }
> }
> 
> bright_opaque(color c -> bool) {
>   int max = max([ c.r, c.g, c.b ]);
>   return max == 0xff && opaque(c);
> }
> 
> opaque(color c -> bool) -> c.alpha == 0xff
> ```

There are three types of non-trivial cases:

* `is` cases
* `matches` cases
* `passes` cases

These cases can be written in any order in a `when` statement.

<br>

The `is` keyword is used to specify a **case that matches a specific value**.

A value that is defined to be checked against the control expression in an `is` case is called a **match value**. An `is` case can consist of one or more comma-separated match values. Unlike traditional `switch` statements, match values in `is` cases do not have to be literals.

> **Note:**
> 
> [Under the hood![](../assets/definition.png)](./glossary.md#under-the-hood), an `is` case consisting of multiple match values is "unfolded" into multiple `is` cases consisting of a single match value each.

<br>

The `matches` keyword is used to specify a **case that matches a pattern**.

The **pattern** of a `matches` case must be an expression of type `bool`.

`matches` cases are designed to make use of the special identifier<sup>[§3.2.1](./ls-3-vars.md#321--variable-names)</sup> `_`, which replaces the control expression in pattern definitions. When the `matches` case is reached, the control expression is evaluated, and every use of `_` in the pattern is replaced by the control expression's value.

> **Example:**
> 
> ```js
> when ("Test string") {
>   matches _.has('T') -> { /* do something */ }
>   matches #|_ > 5 -> { /* do something */ }
> }
> ```
> 
> When replaced by the control expression, these patterns correspond to:
> 
> ```js
> "Test string".has('T')        // true
> #|"Test string" > 5           // true, as #|"Test string" == 11
> ```

`matches` patterns can avoid the special identifier `_` and the control expression entirely, though this likely indicates a poor use of the `matches` case.

> **Example:**
> 
> ```js
> when (rand(0, 10)) {
>   matches 5 > 3 -> { /* do something */ }
> }
> ```
> 
> Despite being nonsensical, this is valid *DeltaScript* code.

<br>

The `passes` keyword is used to specify a **case that passes a test**.

A test of a `passes` case must be an expression that evaluates to a function object<sup>[§TODO - function object]()</sup>. Such an expression can be a function reference<sup>[§4.8](./ls-4-expr.md#48--helper-function-references)</sup> (`::`) or an anonymous function<sup>[§4.9](./ls-4-expr.md#49--anonymous-functions)</sup>.

For a `when` statement with a control expression of an arbitrary type `T`, a test of a `passes` case must be of a functioal type<sup>[§2.4](./ls-2-types.md#24--functional-types)</sup> `(T -> bool)`. In other words, the test must be a function that accepts a single parameter of the same type as the control expression and returns a `bool` value. Such functions are called [predicates![](../assets/external.png)](https://en.wikipedia.org/wiki/Predicate_(mathematical_logic)).

> **Example:**
> 
> ```js
> () {
>   string[] words = [
>     "Racecar", "Pilot", "Madam", 
>     "Able was I ere I saw Elba", 
>     "Nurses run", "Highway 61", 
>     "A man, a plan, a canal - Panama"
>   ];
> 
>   (string -> bool) no_whitespace_palindrome = 
>           (s -> palindrome(no_whitespace(s)));
> 
>   for (word in words) {
>     when (word) {
>       passes ::palindrome -> print("\"" + _ + "\" is a pure palindrome!");
>       passes no_whitespace_palindrome -> 
>               print("\"" + _ + "\" is a palindrome if whitespace is ignored");
>       passes (s -> palindrome(only_letters(s))) -> 
>               print("\"" + _ + "\" is a palindrome if whitespace and punctuation are ignored");
>       otherwise -> print("\"" + _ + "\" is not a palindrome");
>     }
>   }
> }
> 
> palindrome(string s -> bool) {
>   string lc = lowercase(s);
>   return lc == reverse(lc);
> }
> 
> reverse(string s -> string) {
>   string res = "";
> 
>   for (c in s)
>     res = c + res;
> 
>   return res;
> }
> 
> lowercase(string s -> string) {
>   string res = "";
> 
>   for (c in s) {
>     int unicode = (int) c;
> 
>     if (uppercase_letter(c))
>       res += (char) ((int) 'a' + (unicode - (int) 'A'))
>     else
>       res += c;
>   }
> 
>   return res;
> }
> 
> no_whitespace(string s -> string) {
>   ~ char{} WHITESPACE = { ' ', '\t' '\n' };
>   string res = "";
> 
>   for (c in s)
>     if (!WHITESPACE.has(c))
>       res += c;
>   
>   return res;
> }
> 
> only_letters(string s -> string) {
>   string res = "";
> 
>   for (c in s)
>     if (uppercase_letter(c) || lowercase_letter(c))
>       res += c;
>   
>   return res;
> }
> 
> uppercase_letter(char c -> bool) {
>   int unicode = (int) c;
>   return unicode >= (int) 'A' && unicode <= (int) 'Z';
> }
> 
> lowercase_letter(char c -> bool) {
>   int unicode = (int) c;
>   return unicode >= (int) 'a' && unicode <= (int) 'z';
> }
> ```
> 
> This script produces the output:
> 
> ```
> "Racecar" is a pure palindrome!
> "Pilot" is not a palindrome
> "Madam" is a pure palindrome!
> "Able was I ere I saw Elba" is a pure palindrome!
> "Nurses run" is a palindrome if whitespace is ignored
> "Highway 61" is not a palindrome
> "A man, a plan, a canal - Panama" is a palindrome if whitespace and punctuation are ignored
> ```
> 
> In the `when` statement, note the use of three different types of expressions for each `passes` case test:
> 
> * `::palindrome` - A **reference** to the helper function `palindrome(string s -> bool)`
> * `no_whitespace_palindrome` - A **variable** that was initialized with an anonymous function that composed `palindrome(string s -> bool)` with `no_whitespace(string s -> string)`
> * `(s -> palindrome(only_letters(s)))` - An **anonymous function** that composed `palindrome(string s -> bool)` with `only_letters(string s -> string)`

<br>

The `otherwise` keyword is used to specify a case that executes if no other cases match. An `otherwise` case is optional; if present, it must be preceded by one or more non-trivial cases (`is`, `matches`, `passes`).

<br>

> **Note:**
> 
> `when` statements have some peculiar **semantics**. Consider the following script.
> 
> ```js
> () {
>   ~ int REPS = 100;
> 
>   for (int i = 0; i < REPS; i++) {
>     when (flip_coin()) {
>       is true, false -> print("Matched literals");
>       matches _ || !_ -> print("Matched pattern");
>       otherwise -> print("No match");
>     }
>   }
> }
> ```
> 
> This script executes a `for` loop<sup>[§5.7.3](#573--for-loops)</sup> with a `when` statement inside it 100 times. The control expression of the `when` statement is the global function [`flip_coin()`](./functions-sl.md#flip_coin), which has a 50% chance of returning `true` and a 50% chance of returning `false`. The `when` statement has two non-trivial cases and an `otherwise` case, which prints a message indicating that neither of the two non-trivial cases was matched.
> 
> The first case is an `is` case with the `bool` literals `true` and `false` as match values. Naively, one might assume that this case is always matched, as the result of `flip_coin()` can only be `true` or `false`. However, an `is` case of multiple match values actually unfolds into a series of `is` cases with a single match value each:
> 
> ```js
> is true -> print("Matched literals");
> is false -> print("Matched literals");
> ```
> 
> Critically, **the control expression is re-evaluated on every case check**. Therefore, `flip_coin()` may return `false` during the check for the unfolded case `is true -> ...`, and `flip_coin()` may then return `true` during the check for the unfolded case `is false -> ...`, thus bypassing `is true, false -> ...`.
> 
> This does not occur in the `matches` case. `_ || !_` does not unfold into multiple cases, and because the control expression is only evaluated once per case, both special identifier `_` sub-expressions will always evaluate to the same value. Thus, `_ || !_` will always be true and this case will always be matched if it is reached.

## 5.7 – Loops

**Loops** allow the program to execute a block of code multiple times. *DeltaScript* supports `while`, `do`...`while`, `for`, and iterator loops. The block of code to be executed by a loop is often called the loop's **body**.

Loops are matched by the following production of &lt;stat&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;stat&gt;_:**
> * &lt;loop_stat&gt;
> * (... lower precedence productions)
> 
> **_&lt;loop_stat&gt;_:**
> * &lt;while_def&gt; &lt;body&gt;
> * &lt;iteration_def&gt; &lt;body&gt;
> * &lt;for_def&gt; &lt;body&gt;
> * `do` &lt;body&gt; &lt;while_def&gt; `;`
> 
> **_&lt;while_def&gt;_:** `while` `(` &lt;expr&gt; `)`
> 
> **_&lt;iteration_def&gt;_:** `for` `(` &lt;iterator_declaration&gt; `in` &lt;expr&gt; `)`
> 
> **_&lt;for_def&gt;_:** `for` `(` &lt;var_init&gt; `;` &lt;expr&gt; `;` &lt;assignment&gt; `)`
> 
> **_&lt;iterator_declaration&gt;_:** &lt;declaration&gt; | &lt;ident&gt;

### 5.7.1 – `while` loops

**`while` loops** execute a block of code as long as a specified condition is true.

If the conditional expression of an `while` loop is not of type `bool`<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup>, a semantic error<sup>[§TODO - semantic error]()</sup> is triggered.

`while` loops are matched by the following production of &lt;loop_stat&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;loop_stat&gt;_:**
> * &lt;while_def&gt; &lt;body&gt;
> * (... lower precedence productions)
> 
> **_&lt;while_def&gt;_:** `while` `(` &lt;expr&gt; `)`

A `while` loop `while (C) B` consists of a conditional expression of type `bool` `C` and a block of code `B`, where `B` can be zero or more statements<sup>[§5.2](#52--statements)</sup> enclosed in curly braces `{}`, or a single statement without enclosing punctuation.

> **Examples:**
> 
> ```js
> while (i > 0) {
>   i--;
>   print(i);
> }
> ```
> 
> The body of the `while` loop contains two statements.
> 
> ```js
> while (i > 0)
>   i--;
> ```
> 
> The body of the `while` loop consists of a single statement `i--;`.

A `while` loop's condition `C` is evaluated first. If `C` is true, `B` is executed. Once `C` is false, the loop terminates and script execution<sup>[§TODO - execution]()</sup> moves on to the next statement.

### 5.7.2 – `do`...`while` loops

**`do`...`while` loops** execute a block of code at least once, and then continue executing it as long as a specified condition is true.

They are matched by the following production of &lt;loop_stat&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;loop_stat&gt;_:**
> * (... higher precedence productions)
> * `do` &lt;body&gt; &lt;while_def&gt; `;`
> 
> **_&lt;while_def&gt;_:** `while` `(` &lt;expr&gt; `)`

A `do`...`while` loop `do B while (C);` consists of a conditional expression of type `bool` `C` and a block of code `B`, where `B` can be zero or more statements<sup>[§5.2](#52--statements)</sup> enclosed in curly braces `{}`, or a single statement without enclosing punctuation.

If the expression `C` is not of type `bool`<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup>, a semantic error<sup>[§TODO - semantic error]()</sup> is triggered.

When the `do`...`while` statement is reached by the script's execution, its body `B` is executed first. After the first execution of `B`, its condition `C` is evaluated. If `C` is true, `B` is executed again. This repeats until `C` is false, at which point the loop terminates and script execution<sup>[§TODO - execution]()</sup> moves on to the next statement.

> **Example:**
> 
> ```js
> () {
>   int x = 0;
>   
>   do {
>     x++;
>     print(x);
>   } while (x < 5);
> }
> ```
> 
> This script produces the output:
> 
> ```
> 1
> 2
> 3
> 4
> 5
> ```

### 5.7.3 – `for` loops

**`for` loops** are generally used to execute a block of code a specified number of times. However, they mustn't exclusively be used this way.

> **Note:**
> 
> Iterator loops<sup>[§5.7.4](#574--iterator-loops)</sup> also begin with the keyword `for`; however, this specification always uses the term "`for` loops" to mean the types of loops described in this section.

`for` loops are matched by the following production of &lt;loop_stat&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;loop_stat&gt;_:**
> * (... higher precedence productions)
> * &lt;for_def&gt; &lt;body&gt;
> * (... lower precedence productions)
> 
> **_&lt;for_def&gt;_:** `for` `(` &lt;var_init&gt; `;` &lt;expr&gt; `;` &lt;assignment&gt; `)`

A `for` loop `for (I; C; A) B` consists of:

* An initialization<sup>[§3.2.2](./ls-3-vars.md#322--initialization)</sup> `I`
* A conditional expression of type `bool` `C`
* An assignment<sup>[§5.4](#54--assignments)</sup> `A`
* A block of code `B`, where `B` can be zero or more statements<sup>[§5.2](#52--statements)</sup> enclosed in curly braces `{}`, or a single statement without enclosing punctuation

> **Note:**
> 
> The conditional expression `C` generally invokes the variable initialized in `I`, and `A` is generally a compound assignment<sup>[§4.5.4](./ls-4-expr.md#454--compound-assignment-operators)</sup> of the variable initialized in `I`. However, neither of these have to be the case.

`for` loops can be conceptualized as a special case of the `while` loop<sup>[§5.7.1](#571--while-loops)</sup>. Any `for` loop `for (I; C; A) B` can equivalently<sup>[c](#fn-c)</sup> be expressed as:

```js
/* preceding statements */
I;
while (C) {
  B
  A;
}
/* following statements */
```

When a `for` loop is reached by the script's execution, this is the sequence of evaluations and executions:

1.  `I` is executed
2.  `C` is evaluated. If `C` is true, proceeds to step 3. If `C` is false, the loop terminates and script execution<sup>[§TODO - execution]()</sup> moves on to the next statement following the loop.
3.  `B` is executed
4.  `A` is executed
5.  Returns to step 2

> **Example:**
> 
> ```js
> for (int i = 0; i < 10; i++) {
>   int square = i * i;
>   print(square);
> }
> ```

### 5.7.4 – Iterator loops

**Iterator loops** – also called **foreach loops** or **enhanced for loops** – iterate over the elements in a collection<sup>[§2.3](./ls-2-types.md#23--collection-types)</sup> or the characters (`char`) in a `string`.

An iterator node declares an **element variable** to represent an arbitrary element of the iterated collection or `string` during each execution of the loop body. The type of the element variable and the order in which the elements of the collection are accessed depend on the type of the collection:

| Collection type | Element type | Access order |
| :-------------- | :-------------------- | :----------- |
| `string` | `char` | From left to right in the `string` |
| Array `T[]`<sup>1</sup> | `T` | Ascending index order |
| List `T<>` | `T` | Ascending index order |
| Set `T{}` | `T` | Unspecified<sup>2</sup> |

1.  `T` is an arbitrary type than can be any type<sup>[§2](./ls-2-types.md)</sup>
2.  Left to the discretion of language implementers

Iterator loops are matched by the following production of &lt;loop_stat&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;loop_stat&gt;_:**
> * (... higher precedence productions)
> * &lt;iteration_def&gt; &lt;body&gt;
> * (... lower precedence productions)
> 
> **_&lt;iteration_def&gt;_:** `for` `(` &lt;iterator_declaration&gt; `in` &lt;expr&gt; `)`
> 
> **_&lt;iterator_declaration&gt;_:** &lt;declaration&gt; | &lt;ident&gt;

An iterator loop `for (D in I_C) B` consists of:

* A simple declaration<sup>[§3.2](./ls-3-vars.md#32--declarations)</sup> (not initialized) `D`. `D` may omit the type identifier<sup>[§2.1](./ls-2-types.md#21--type-system)</sup> from the declaration, as its type can be inferred<sup>[§2.1.2](./ls-2-types.md#212--type-inference)</sup> by the compiler or interpreter from the type of `I_C` as per the table above.
* An expression representing the collection to be iterated over `I_C`. `I_C` must be of one of the following types:
  * `string`
  * `T[]` - an array of elements of any type `T`
  * `T<>` - a list of elements of any type `T`
  * `T{}` - a set of elements of any type `T`
* A block of code `B`, where `B` can be zero or more statements<sup>[§5.2](#52--statements)</sup> enclosed in curly braces `{}`, or a single statement without enclosing punctuation

When an iterator loop is reached by the script's execution<sup>[§TODO - execution]()</sup>, it assigns an element of the collection to the element variable and executes the loop body for each element in the collection, as outlined by the table above.

> **Note:**
> 
> This version of *DeltaScript* is intentionally ambiguous about the semantics of modifying the contents of the iterated collection inside the loop body. It is discouraged as bad programming practice but not explicitly disallowed.
> 
> 
> Future language versions may declare an unambiguous position on this issue.

> **Example:**
> 
> ```js
> () {
>   ~ string word = "Iterate";
>   (string -> char)[] s_to_c_funcs = [ ::first, ::last, ::random ];
> 
>   for (f in s_to_c_funcs)
>     print(f.call(word));
> }
> 
> first(string s -> char) -> s.at(0)
> last(string s -> char) -> s.at(#|s - 1)
> random(string s -> char) -> s.at(rand(0, #|s))
> ```
> 
> This script may<sup>[d](#fn-d)</sup> produce the output:
> 
> ```
> I
> e
> t
> ```
> 
> The iterator loop in the script iterates over the collection `s_to_c_funcs`, an array of string to character functions. Thus, the type of the element variable `f` is inferred to be `(string -> char)`. The loop body consists of the single statement `print(f.call(word));`.

## 5.8 – `return` statements

**`return` statements** are used to recall the script's execution<sup>[§TODO - execution]()</sup> from a function<sup>[§TODO - function]()</sup> back to the statement in which the function was invoked. Depending on the type signature<sup>[§TODO - type signature]()</sup> of the function within which they are found, a `return` statement may return a value.

`return` statements can be found in any source code-defined function: a script's header function<sup>[§TODO - header function]()</sup>, its helper functions<sup>[§TODO - helper function]()</sup>, and even anonymous functions<sup>[§TODO - anonymous function]()</sup>. A `return` statement is bound to the **most immediate function scope**. Anonymous functions are defined within the bodies of other functions. The `return` statements contained therein are bound to the scope of the anonymous function, and not to the helper function, header function, or outer anonymous function within which the anonymous function was defined.

`return` statements can be implicit. **Single expression function bodies** are a syntactical shorthand<sup>[§1.3.4](./ls-1-syntax.md#134--shorthands)</sup> that are treated as a function body comprising a single value-returning `return` statement [under the hood![](../assets/definition.png)](./glossary.md#under-the-hood).

`return` statements are matched by the following production of &lt;stat&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;stat&gt;_:**
> * (... higher precedence productions)
> * &lt;return_stat&gt;
> * (... lower precedence productions)
> 
> **_&lt;return\_stat&gt;_:** `return` &lt;expr&gt;? `;`

`return` statements in the header function terminate script execution when they are reached.

### 5.8.1 – Value `return`

A **value `return` statement** exits a function and returns a specified value. Such statements occur in functions with a return type<sup>[§TODO - type signature]()</sup>. The return value replaces the function invocation expression<sup>[§4.7](./ls-4-expr.md#47--function-calls)</sup> in the evaluation of the expression that contained the function call.

A value `return` statement `return V;` consists of an expression `V` whose type matches the return type of the function containing the statement. If the type of `V` does not match the return type of the statement's container function, a semantic error<sup>[§TODO - semantic error]()</sup> is triggered.

`V` is evaluated before it is returned to the function call expression.

> **Example:**
> 
> ```js
> () {
>   print(helper() + 2);
> }
> 
> helper(-> int) {
>   return rand(0, 5);
> }
> ```

### 5.8.2 – Void `return`

A **void `return` statement** exits a function without returning a value. Such statements occur in functions with no return type<sup>[§TODO - type signature]()</sup>.

If a void `return` statement is found in a function with a return type, a semantic error<sup>[§TODO - semantic error]()</sup> is triggered.

> **Example:**
> 
> ```js
> () {
>   if (true)
>     return;       // script execution terminates here
> 
>   dont_do_this(); // never reached
> }
> 
> dont_do_this() {
>   print("Something mean");
> }
> ```

---

## Footnotes

* <sup id="fn-a">a</sup> - *DeltaScript* has many features that make it a multi-paradigm language, but it is fundamentally imperative in its structure.
* <sup id="fn-b">b</sup> - Recent versions of Java have extended the `switch` statement into a much more powerful and expressive [pattern matching![](../assets/external.png)](https://en.wikipedia.org/wiki/Pattern_matching) structure.
* <sup id="fn-c">c</sup> - This isn't exactly true. `I` could be used after the `while` loop, but the `I` of the `for` cannot be used outside of the `for` loop it is declared in.
* <sup id="fn-d">d</sup> - The output of the script is [non-deterministic![](../assets/external.png)](https://en.wikipedia.org/wiki/Nondeterministic_algorithm) due to the use of the [`rand(int min, int max_ex) -> int`](./functions-sl.md#rand) function.
