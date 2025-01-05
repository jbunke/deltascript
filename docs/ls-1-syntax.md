[**< Language Specification**](./lang-spec.md)

# Chapter 1 – Syntax and grammar

## Contents

* [**1.1**](#11--grammar-notation) – Grammar notation
* [**1.2**](#12--grammars) – Grammars
  * [**1.2.1**](#121--lexical-grammar) – Lexical grammar
  * [**1.2.2**](#122--syntax-grammar) – Syntax grammar
* [**1.3**](#13--notes-on-syntax) – Notes on syntax
  * [**1.3.1**](#131--comments) – Comments
  * [**1.3.2**](#132--whitespace) – Whitespace
  * [**1.3.3**](#133--shorthands) – Shorthands

---

<!-- TODO -->

## 1.1 – Grammar notation

<!-- TODO -->

## 1.2 – Grammars

<!-- TODO -->

### 1.2.1 – Lexical grammar

<!-- TODO -->

**Note:**

For the sake of clarity, rules may have been adapted, renamed or rearranged from those found in the [`grammars/ScriptLexer.g4`](../grammars/ScriptLexer.g4) source file.

---

**<i id="lg-final">FINAL</i>:** `final` | `~`

> Description

**<i id="lg-identifier">IDENTIFIER</i>:** [LEADOFF](#lg-leadoff) [FOLLOWING](#lg-following)\*

> Description

**<i id="lg-leadoff">LEADOFF</i>:** `_` | `A..Z` | `a..z`

> Description

**<i id="lg-following">FOLLOWING</i>:** `_` | `A..Z` | `a..z` | [DIGIT](#lg-digit)

> Description

**<i id="lg-subident">SUBIDENT</i>:** `.` [IDENTIFIER](#lg-identifier)

> Description

**<i id="lg-digit">DIGIT</i>:** `0..9`

> Description

**<i id="lg-hexdigit">HEX_DIGIT</i>:** [DIGIT](#lg-digit) | `a..f` | `A..F`

> Description

**<i id="lg-floatlit">FLOAT_LIT</i>:**
* [DIGIT](#lg-digit)\+ `.` [DIGIT](#lg-digit)\+
* [DIGIT](#lg-digit)\+ `f`

> Description

**<i id="lg-declit">DEC_LIT</i>:** [DIGIT](#lg-digit)\+

> Description

**<i id="lg-hexlit">HEX_LIT</i>:** `0x` [HEX_DIGIT](#lg-hexdigit)\+

> Description

**<i id="lg-channel">CHANNEL</i>:** [HEX_DIGIT](#lg-hexdigit) [HEX_DIGIT](#lg-hexdigit)

> Description

**<i id="lg-colorhexlit">COLOR_HEX_LIT</i>:** `#` [CHANNEL](#lg-channel) [CHANNEL](#lg-channel) [CHANNEL](#lg-channel) [CHANNEL](#lg-channel)?

> Description

**<i id="lg-escapechar">ESCAPE_CHAR</i>:** `\` ( `0` | `b` | `t` | `n` | `f` | `r` | `"` | `'` | `\` )

> Description

**<i id="lg-restrictedcharset">RESTRICTED_CHARSET</i>:** ~( `\` | `'` | `"` )

> Description

**<i id="lg-character">CHARACTER</i>:** [RESTRICTED_CHARSET](#lg-restrictedcharset) | [ESCAPE_CHAR](#lg-escapechar)

> Description

**<i id="lg-charlit">CHAR_LIT</i>:** `'` [CHARACTER](#lg-character) `'`

> Description

**<i id="lg-stringlit">STRING_LIT</i>:** `"` ( [CHARACTER](#lg-character) | `'` ) `"`

> Description

### 1.2.2 – Syntax grammar

<!-- TODO -->

**Note:**

For the sake of clarity, rules may have been adapted, renamed or rearranged from those found in the [`grammars/ScriptParser.g4`](../grammars/ScriptParser.g4) and [`grammars/ScriptLexer.g4`](../grammars/ScriptLexer.g4) source files.

---

**<i id="sg-headrule">headRule</i>:** [signature](#sg-signature) [funcBody](#sg-funcbody) [helper](#sg-helper)\*

> The outermost rule. The contents of the entire script file must match *headRule* in order for the script to be syntactically correct.

**<i id="sg-helper">helper</i>:** [ident](#sg-ident) [signature](#sg-signature) [funcBody](#sg-funcbody)

> The matching rule for a [helper function](). <!-- TODO - link to specification -->

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

**<i id="sg-declaration">declaration</i>:** [FINAL](#lg-final)? [type](#sg-type) [ident](#sg-ident)

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
* [expr](#sg-expr) ( `+` | `-` ) [expr](#sg-expr)
* [expr](#sg-expr) ( `*` | `/` | `%` ) [expr](#sg-expr)
* [expr](#sg-expr) `^` [expr](#sg-expr)
* [expr](#sg-expr) ( `==` | `!=` | `>` | `<` | `>=` | `<=` ) [expr](#sg-expr)
* [expr](#sg-expr) ( `||` | `&&` ) [expr](#sg-expr)
* [expr](#sg-expr) `?` [expr](#sg-expr) `:` [expr](#sg-expr)
* `{` [kvPairs](#sg-kvpairs) `}`
* `[` [elements](#sg-elements)? `]`
* `<` [elements](#sg-elements)? `>`
* `{` [elements](#sg-elements)? `}`
* `new` [type](#sg-type) `[` [expr](#sg-expr) `]`
* `new` `{` [type](#sg-type) `:` [type](#sg-type) `}`
* [assignable](#sg-assignable)
* [literal](#sg-literal)

> Description

**<i id="sg-lambdaparams">lambdaParams</i>:**
* `(` `)`
* [ident](#sg-ident)
* `(` [ident](#sg-ident) ( `,` [ident](#sg-ident) )\+ `)`

> Description

**<i id="sg-lambdabody">lambdaBody</i>:** `->` ( [body](#sg-body) | [expr](#sg-expr) )

> Description

**<i id="sg-kvpairs">kvPairs</i>:** [kvPair](#sg-kvpair) ( `,` [kvPair](#sg-kvpair) )\*

> Description

**<i id="sg-kvpair">kvPair</i>:** [expr](#sg-expr) `:` [expr](#sg-expr)

> Description

**<i id="sg-args">args</i>:** `(` [elements](#sg-elements)? `)`

> Description

**<i id="sg-elements">elements</i>:** [expr](#sg-expr) ( `,` [expr](#sg-expr) )\*

> Description

**<i id="sg-assignment">assignment</i>:**
* [assignable](#sg-assignable) `=` [expr](#sg-expr)
* [assignable](#sg-assignable) `++`
* [assignable](#sg-assignable) `--`
* [assignable](#sg-assignable) `+=` [expr](#sg-expr)
* [assignable](#sg-assignable) `-=` [expr](#sg-expr)
* [assignable](#sg-assignable) `*=` [expr](#sg-expr)
* [assignable](#sg-assignable) `/=` [expr](#sg-expr)
* [assignable](#sg-assignable) `%=` [expr](#sg-expr)
* [assignable](#sg-assignable) `&=` [expr](#sg-expr)
* [assignable](#sg-assignable) `|=` [expr](#sg-expr)

> Description

**<i id="sg-varinit">varInit</i>:** [declaration](#sg-declaration) `=` [expr](#sg-expr)

> Description

**<i id="sg-vardef">varDef</i>:** [declaration](#sg-declaration) | [varInit](#sg-varinit)

> Description

**<i id="sg-assignable">assignable</i>:**
* [ident](#sg-ident)
* [ident](#sg-ident) `<` [expr](#sg-expr) `>`
* [ident](#sg-ident) `[` [expr](#sg-expr) `]`

> Description

**<i id="sg-ident">ident</i>:** [IDENTIFIER](#lg-identifier)

> Description

**<i id="sg-subident">subident</i>:** [SUB_IDENT](#lg-subident)

> Description

**<i id="sg-namespaceident">namespaceIdent</i>:** `$` [ident](#sg-ident) [subident](#sg-subident)

> Description

**<i id="sg-literal">literal</i>:**
* [STRING_LIT](#lg-stringlit)
* [CHAR_LIT](#lg-charlit)
* [COLOR_HEX_LIT](#lg-colorhexlit)
* [intLiteral](#sg-intliteral)
* [FLOAT_LIT](#lg-floatlit)
* [boolLiteral](#sg-boolliteral)

> Description

**<i id="sg-intliteral">intLiteral</i>:** [HEX_LIT](#lg-hexlit) | [DEC_LIT](#lg-declit)

> Description

**<i id="sg-boolliteral">boolLiteral</i>:** `true` | `false`

> Description

## 1.3 – Notes on syntax

<!-- TODO -->

### 1.3.1 – Comments

<!-- TODO -->

### 1.3.2 – Whitespace

<!-- TODO -->

### 1.3.3 – Shorthands

<!-- TODO -->
