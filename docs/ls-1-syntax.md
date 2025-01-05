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

**<i id="sg-helper">helper</i>:** [ident](#sg-ident) [signature](#sg-signature) [funcBody](#sg-funcbody)

> Description

**<i id="sg-funcbody">funcBody</i>:**
* [body](#sg-body)
* `->` [expr](#sg-expr)

> Description

**<i id="sg-signature">signature</i>:**
* `(` [paramList](#sg-paramlist)? `)`
* `(` [paramList](#sg-paramlist)? `->` [type](#sg-type) `)`

> Description

**<i id="sg-paramlist">paramList</i>:** [declaration](#sg-declaration) ( `,` [declaration](#sg-declaration) )\*

> Description

**<i id="sg-declaration">declaration</i>:** FINAL? [type](#sg-type) [ident](#sg-ident)

> Description

**<i id="sg-type">type</i>:**
* `bool`
* `char`
* `color`
* `float`
* `image`
* `int`
* `string`
* [type](#sg-type) `[]`
* [type](#sg-type) `<>`
* [type](#sg-type) `{}`
* `{` [type](#sg-type) `:` [type](#sg-type) `}`
* `(` [funcType](#sg-functype) `)`

> Description

**<i id="sg-functype">funcType</i>:** [paramTypes](#sg-paramtypes)? `->` [type](#sg-type)

> Description

**<i id="sg-paramtypes">paramTypes</i>:** [type](#sg-type) ( `,` [type](#sg-type) )\*

> Description

**<i id="sg-body">body</i>:**
* [stat](#sg-stat)
* `{` [stat](#sg-stat)\* `}`

> Description

**<i id="sg-stat">stat</i>:**
* [loopStat](#sg-loopstat)
* [ifStat](#sg-ifstat)
* [whenStat](#sg-whenstat)
* [varDef](#sg-vardef) `;`
* [assignment](#sg-assignment) `;`
* [returnStat](#sg-returnstat)
* [expr](#sg-expr) [subident](#sg-subident) [args](#sg-args) `;`
* [ident](#sg-ident) [args](#sg-args) `;`
* [namespaceIdent](#sg-namespaceident) [args](#sg-args) `;`

> Description

**<i id="sg-returnstat">returnStat</i>:** `return` [expr](#sg-expr)? `;`

> Description

**<i id="sg-loopstat">loopStat</i>:**
* [whileDef](#sg-whiledef) [body](#sg-body)
* [iterationDef](#sg-iterationdef) [body](#sg-body)
* [forDef](#sg-fordef) [body](#sg-body)
* `do` [body](#sg-body) [whileDef](#sg-whiledef) `;`

> Description

**<i id="sg-iterationdef">iterationDef</i>:** `for` `(` [iteratorDeclaration](#sg-iteratordeclaration) `in` [expr](#sg-expr) `)`

> Description

**<i id="sg-iteratordeclaration">iteratorDeclaration</i>:** [declaration](#sg-declaration) | [ident](#sg-ident)

> Description

**<i id="sg-whiledef">whileDef</i>:** `while` `(` [expr](#sg-expr) `)`

> Description

**<i id="sg-fordef">forDef</i>:** `for` `(` [varInit](#sg-varinit) `;` [expr](#sg-expr) `;` [assignment](#sg-assignment) `)`

> Description

**<i id="sg-ifstat">ifStat</i>:** [ifDef](#sg-ifdef) ( `else` [ifDef](#sg-ifdef) )\* ( `else` [body](#sg-body) )?

> Description

**<i id="sg-ifdef">ifDef</i>:** `if` `(` [expr](#sg-expr) `)` [body](#sg-body)

> Description

**<i id="sg-whenstat">whenStat</i>:** `when` `(` [expr](#sg-expr) `)` [whenBody](#sg-whenbody)

> Description

**<i id="sg-whenbody">whenBody</i>:** `{` [whenCase](#sg-whencase)\+ [otherwiseCase](#sg-otherwisecase)? `}`

> Description

**<i id="sg-whencase">whenCase</i>:**
* `is` [elements](#sg-elements) `->` [body](#sg-body)
* `matches` [expr](#sg-expr) `->` [body](#sg-body)
* `passes` [expr](#sg-expr) `->` [body](#sg-body)

> Description

**<i id="sg-otherwisecase">otherwiseCase</i>:** `otherwise` `->` [body](#sg-body)

> Description

**<i id="sg-expr">expr</i>:**
* `(` [expr](#sg-expr) `)`
* [lambdaParams](#sg-lambdaparams) [lambdaBody](#sg-lambdabody)
* [ident](#sg-ident) [args](#sg-args)
* [namespaceIdent](#sg-namespaceident) [args](#sg-args)
* [namespaceIdent](#sg-namespaceident)
* `::` [ident](#sg-ident)
* [expr](#sg-expr) [subident](#sg-subident) [args](#sg-args)
* [expr](#sg-expr) [subident](#sg-subident)
* ( `-` | `!` | `#|` ) [expr](#sg-expr)
* `(` [type](#sg-type) `)` [expr](#sg-expr)
* expr ( `+` | `-` ) expr
* expr ( `*` | `/` | `%` ) expr
* expr `^` expr
* expr ( `==` | `!=` | `>` | `<` | `>=` | `<=` ) expr
* expr ( `||` | `&&` ) expr
* expr `?` expr `:` expr
* `{` kvPairs `}`
* `[` elements? `]`
* `<` elements? `>`
* `{` elements? `}`
* `new` type `[` expr `]`
* `new` `{` type `:` type `}`
* assignable
* literal

> Description

**<i id="sg-lambdaparams">lambdaParams</i>:**
* `(` `)`
* ident
* `(` ident ( `,` ident )\+ `)`

> Description

**<i id="sg-lambdabody">lambdaBody</i>:** `->` ( body | expr )

> Description

**<i id="sg-kvpairs">kvPairs</i>:** kvPair ( `,` kvPair )\*

> Description

**<i id="sg-kvpair">kvPair</i>:** expr `:` expr

> Description

**<i id="sg-args">args</i>:** `(` elements? `)`

> Description

**<i id="sg-elements">elements</i>:** expr ( `,` expr )\*

> Description

**<i id="sg-assignment">assignment</i>:**
* assignable `=` expr
* assignable `++`
* assignable `--`
* assignable `+=` expr
* assignable `-=` expr
* assignable `*=` expr
* assignable `/=` expr
* assignable `%=` expr
* assignable `&=` expr
* assignable `|=` expr

> Description

**<i id="sg-varinit">varInit</i>:** declaration `=` expr

> Description

**<i id="sg-vardef">varDef</i>:** declaration | varInit

> Description

**<i id="sg-assignable">assignable</i>:**
* ident
* ident `<` expr `>`
* ident `[` expr `]`

> Description

**<i id="sg-ident">ident</i>:** IDENTIFIER

> Description

**<i id="sg-subident">subident</i>:** SUB_IDENT

> Description

**<i id="sg-namespaceident">namespaceIdent</i>:** `$` ident subident

> Description

**<i id="sg-literal">literal</i>:**
* STRING_LIT
* CHAR_LIT
* COLOR_HEX_LIT
* intLiteral
* FLOAT_LIT
* boolLiteral

> Description

**<i id="sg-intliteral">intLiteral</i>:** HEX_LIT | DEC_LIT

> Description

**<i id="sg-boolliteral">boolLiteral</i>:** `true` | `false`

## 1.3 – Notes on syntax

<!-- TODO -->

### 1.3.1 – Shorthands

<!-- TODO -->
