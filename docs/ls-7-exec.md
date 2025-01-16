[**< Language Specification**](./lang-spec.md)

# Chapter 7 – Execution

## Contents

* [**7.1**](#71--general) – General
* [**7.2**](#72--parsing) – Parsing
* [**7.3**](#73--semantic-analysis) – Semantic analysis
* [**7.4**](#74--runtime-execution) – Runtime execution
* [**7.5**](#75--errors) – Errors
  * [**7.5.1**](#751--syntax-errors) – Syntax errors
  * [**7.5.2**](#752--semantic-errors) – Semantic errors
  * [**7.5.3**](#753--runtime-errors) – Runtime errors

---

This chapter describes the proper loading, pre-processing, and execution of *DeltaScript* files by a language implementation like an [interpreter![](../assets/external.png)](https://en.wikipedia.org/wiki/Interpreter_(computing)) or [compiler![](../assets/external.png)](https://en.wikipedia.org/wiki/Compiler).

## 7.1 – General

The particulars of the execution of *DeltaScript* code are highly dependent on the language implementation. This chapter outlines general steps and guidelines for correct and expected behaviour.

> **Note:**
> 
> *DeltaScript* execution threads are limited to a single source code file. This is a limitation of the [base language![](../assets/definition.png)](./glossary.md#base-language); if necessary, it can be worked around by defining a new type<sup>[§8.3.1](./ls-8-ext.md#831--new-types)</sup> to represent scripts in an extension<sup>[§8.2](./ls-8-ext.md#82--extensions)</sup> to the language. That way, scripts will be able to call other scripts.

Execution can generally be sorted into three stages:

1.  Parsing (syntax<sup>[§1](./ls-1-syntax.md)</sup> analysis)
2.  Semantic analysis
3.  Runtime

Errors<sup>[§7.5](#75--errors)</sup> can occur at any stage and are categorized accordingly.

## 7.2 – Parsing

**Parsing** or **syntax analysis** is the process of analyzing *DeltaScript* code to ensure it conforms to the grammar rules <sup>[§1.2](./ls-1-syntax.md#12--grammars)</sup> defined in this specification.

If the grammars are unable to match the contents of the file to &lt;head_rule&gt;<sup>[a]</sup>, a syntax error is triggered and execution does not proceed to semantic analysis.

> **Note:**
> 
> The degree of descriptiveness syntax error messages are capable of providing will depend on the [parsing algorithm![](../assets/external.png)](https://en.wikipedia.org/wiki/Parsing#Types_of_parsers) of the language implementation.

In the event that the contents of the file are a match for &lt;head_rule&gt;, the parser will generate an [abstract syntax tree![](../assets/external.png)](https://en.wikipedia.org/wiki/Abstract_syntax_tree) (AST) that represents the hierarchical structure of the program.

## 7.3 – Semantic analysis

**Semantic analysis** involves validating the AST to ensure that the script adheres to the language's semantic rules. This includes type<sup>[§2](./ls-2-types.md)</sup> checking, ensuring variables<sup>[§3.1](./ls-3-vars.md#31--variables)</sup> are in scope<sup>[§3.4](./ls-3-vars.md#34--variable-scope)</sup> wherever they are references, and ensuring that operations<sup>[§4.5](./ls-4-expr.md#45--operators)</sup> are performed on compatible types.

If a semantic error is during the analysis, execution is halted and does not proceed to runtime execution.

## 7.4 – Runtime execution

Runtime execution is the final stage, where the validated script is executed. The interpreter or compiler processes the AST, performing the operations specified in the script. This stage involves managing the program's state (e.g. updating the values of variables<sup>[§3.1](./ls-3-vars.md#31--variables)</sup>), executing statements<sup>[§5.2](./ls-5-stat.md#52--statements)</sup>, and evaluating expressions<sup>[§4](./ls-4-expr.md)</sup>.

## 7.5 – Errors

Errors in *DeltaScript* are categorized based on the stage at which they occur. An error encountered at any stage of the execution process must be resolved in order to progress to the next stage.

### 7.5.1 – Syntax errors

**Syntax errors** occur during the parsing<sup>[§7.2](#72--parsing)</sup> (syntax analysis) stage when the script does not conform to the grammar rules.

> **Example:**
> 
> ```js
> () {
>   print("Hello, world!");
> 
> ```
> 
> This script is missing a curly bracket `}` to close its header function<sup>[§6.3.1](./ls-6-func.md#631--header-functions)</sup>.

### 7.5.2 – Semantic errors

**Semantic errors** are detected during the semantic analysis<sup>[§7.3](#73--semantic-analysis)</sup>. These errors occur when the script violates the language's semantic rules, such as type<sup>[§2](./ls-2-types.md)</sup> mismatches or attempting to evaluate an undefined variable<sup>[§3.1](./ls-3-vars.md#31--variables)</sup>.

> **Examples of semantic errors:**
> 
> ```js
> int some_var = "This is not an int";
> ```
> 
> ```js
> int some_var = 10 - false;
> ```
> 
> ```js
> () {
>   if (flip_coin()) {
>     string v = "Vendetta";
>   }
> 
>   print(v);   // semantic error - v is out of scope
> }
> ```
> 
> These code snippets are all syntacticall correct but fail semantic analysis.

### 7.5.3 – Runtime errors

**Runtime errors** occur during the runtime execution<sup>[§7.4](#74--runtime-execution)</sup> stage. These errors arise from invalid operations performed while the script is running, such as division by zero or accessing out-of-bounds array elements.

As of this language version, *DeltaScript* has no runtime error suppression mechanisms. Any runtime error triggered during execution<sup>[§7.4](#74--runtime-execution)</sup> will cause the script to terminate abruptly.

---

## Footnotes

* <sup id="fn-a">a</sup> - Only entire scripts must be a match for &lt;head_rule&gt;. Code snippets in isolation may match different rules from the syntax grammar<sup>[§1.2](./ls-1-syntax.md#122--syntax-grammar)</sup>.
