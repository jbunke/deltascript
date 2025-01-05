[**< Language Specification**](./lang-spec.md)

# Chapter 1 – Syntax and grammar

## Contents

* [**1.1**](#11--grammar-notation) – Grammar notation
* [**1.2**](#12--grammars) – Grammars
  * [**1.2.1**](#121--lexical-grammar) – Lexical grammar
  * [**1.2.2**](#122--syntax-grammar) – Syntax grammar
* [**1.3**](#13--notes-on-syntax) – Notes on syntax
  * [**1.3.1**](#131--shorthands) – Shorthands

---

<!-- TODO -->

## 1.1 – Grammar notation

<!-- TODO -->

## 1.2 – Grammars

<!-- TODO -->

**Note:**

For the sake of clarity, names of rules may have been renamed from those found in the `grammars/ScriptLexer.g4` and `grammars/ScriptParser.g4` source files.

### 1.2.1 – Lexical grammar

<!-- TODO -->

### 1.2.2 – Syntax grammar

> The outermost rule. The contents of the entire script file must match *headRule* in order for the script to be syntactically correct.

**<i id="sg-headrule">headRule</i>:** [signature](#sg-signature) [funcBody](#sg-funcbody) [helper](#sg-helper)\*

> Description

**<i id="sg-helper">helper</i>:** ident signature funcBody

> Description

**<i id="sg-funcbody">funcBody</i>:**
* body
* `->` expr

> Description

**<i id="sg-signature">signature</i>:**
* `(` paramList? `)`
* `(` paramList? `->` type `)`

> Description

**<i id="sg-paramlist">paramList</i>:** declaration (`,` declaration)\*

> Description

**<i id="sg-declaration">declaration</i>:** FINAL? type ident

> Description

**<i id="sg-type">type</i>:**
* `bool`
* `char`
* `color`
* `float`
* `image`
* `int`
* `string`
* type `[]`
* type `<>`
* type `{}`
* `{` type `:` type `}`
* `(` funcType `)`

> Description

**<i id="sg-functype">funcType</i>:** paramTypes `->` type

> Description

**<i id="sg-paramtypes">paramTypes</i>:** (type (`,` type)\*)?

> Description

**<i id="sg-body">body</i>:**
* stat
* `{` stat\* `}`

> Description

**<i id="sg-stat">stat</i>:**
* loopStat
* ifStat
* whenStat
* varDef `;`
* assignment `;`
* returnStat
* expr subident args `;`
* ident args `;`
* namespaceIdent args `;`

> Description

**<i id="sg-returnstat">returnStat</i>:** `return` expr? `;`

> Description

**<i id="sg-loopstat">loopStat</i>:**
* whileDef body
* iterationDef body
* forDef body
* `do` body whileDef `;`

> Description

**<i id="sg-iterationdef">iterationDef</i>:** `for` `(` iteratorDeclaration `in` expr `)`

> Description

**<i id="sg-iteratordeclaration">iteratorDeclaration</i>:**
* declaration
* ident

> Description

**<i id="sg-whiledef">whileDef</i>:** `while` `(` expr `)`

> Description

**<i id="sg-fordef">forDef</i>:** `for` `(` varInit `;` expr `;` assignment `)`

> Description

**<i id="sg-ifstat">ifStat</i>:** ifDef (`else` ifDef)\* (`else` body)?

> Description

**<i id="sg-ifdef">ifDef</i>:** `if` `(` expr `)` body

> Description

**<i id="sg-whenstat">whenStat</i>:** `when` `(` expr `)` whenBody

> Description

**<i id="sg-whenbody">whenBody</i>:** `{` whenCase\+ otherwiseCase? `}`

> Description

**<i id="sg-whencase">whenCase</i>:**

> Description

**<i id="sg-otherwisecase">otherwiseCase</i>:**

> Description

**<i id="sg-expr">expr</i>:**

> Description

**<i id="sg-lambdaparams">lambdaParams</i>:**

> Description

**<i id="sg-lambdabody">lambdaBody</i>:**

> Description

**<i id="sg-kvpairs">kvPairs</i>:**

> Description

**<i id="sg-kvpair">kvPair</i>:**

> Description

**<i id="sg-args">args</i>:**

> Description

**<i id="sg-elements">elements</i>:**

> Description

**<i id="sg-assignment">assignment</i>:**

> Description

**<i id="sg-varinit">varInit</i>:**

> Description

**<i id="sg-vardef">varDef</i>:**

> Description

**<i id="sg-assignable">assignable</i>:**

> Description

**<i id="sg-ident">ident</i>:**

> Description

**<i id="sg-subident">subident</i>:**

> Description

**<i id="sg-namespaceident">namespaceIdent</i>:**

> Description

**<i id="sg-literal">literal</i>:**

> Description

**<i id="sg-intliteral">intLiteral</i>:**

> Description

**<i id="sg-boolliteral">boolLiteral</i>:**

## 1.3 – Notes on syntax

<!-- TODO -->

### 1.3.1 – Shorthands

<!-- TODO -->
