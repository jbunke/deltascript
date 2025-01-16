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

The execution of *DeltaScript* code is highly dependent on the language implementation. This chapter outlines general steps and guidelines for correct and expected behaviour.

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

<!-- TODO -->

Semantic error checking involves validating the AST to ensure that the script adheres to the language's semantic rules. This includes type checking, scope resolution, and ensuring that operations are performed on compatible types.

## 7.4 – Runtime execution

<!-- TODO -->

Runtime execution is the final stage where the validated script is executed. The interpreter or compiler processes the AST, performing the operations specified in the script. This stage involves managing the program's state, executing statements, and evaluating expressions.

## 7.5 – Errors

<!-- TODO -->

Errors in *DeltaScript* are categorized based on the stage at which they occur. Each category of errors has specific characteristics and handling mechanisms.

### 7.5.1 – Syntax errors

<!-- TODO -->

Syntax errors occur during the parsing stage when the script does not conform to the grammar rules. These errors prevent the generation of a valid AST and must be corrected before further processing.

### 7.5.2 – Semantic errors

<!-- TODO -->

Semantic errors are detected during the semantic error checking stage. These errors occur when the script violates the language's semantic rules, such as type mismatches or undefined variables. Semantic errors must be resolved for the script to execute correctly.

### 7.5.3 – Runtime errors

<!-- TODO -->

Runtime errors occur during the execution stage. These errors arise from invalid operations performed while the script is running, such as division by zero or accessing out-of-bounds array elements. Runtime errors can cause the script to terminate unexpectedly.

---

## Footnotes

* <sup id="fn-a">a</sup> - Only entire scripts must be a match for &lt;head_rule&gt;. Code snippets in isolation may match different rules from the syntax grammar<sup>[§1.2](./ls-1-syntax.md#122--syntax-grammar)</sup>.
