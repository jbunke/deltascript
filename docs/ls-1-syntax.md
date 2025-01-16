[**< Language Specification**](./lang-spec.md)

# Chapter 1 – Syntax and grammar

## Contents

* [**1.1**](#11--notation-and-terminology) – Notation and terminology
  * [**1.1.1**](#111--extended-backusnaur-form) – Extended Backus–Naur Form
  * [**1.1.2**](#112--terminology) – Terminology
  * [**1.1.3**](#113--notation) – Notation
* [**1.2**](#12--grammars) – Grammars
  * [**1.2.1**](#121--lexical-grammar) – Lexical grammar
  * [**1.2.2**](#122--syntax-grammar) – Syntax grammar
* [**1.3**](#13--notes-on-syntax) – Notes on syntax
  * [**1.3.1**](#131--comments) – Comments
  * [**1.3.2**](#132--whitespace) – Whitespace
  * [**1.3.3**](#133--keywords) – Keywords
  * [**1.3.4**](#134--shorthands) – Shorthands

---

This chapter describes the syntax of *DeltaScript* using **formal grammars**.

**Syntax** can be understood to mean the rules that govern the language's structure. A *DeltaScript* program that is syntactically correct abides by the rules described in the language's grammars.

## 1.1 – Notation and terminology

### 1.1.1 – Extended Backus–Naur Form

Grammars in this document are written in an adapted version of [Extended Backus-Naur Form![](../assets/external.png)](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_form) (EBNF). You may want to read up on [context-free grammars![](../assets/external.png)](https://en.wikipedia.org/wiki/Context-free_grammar) if you do not have much experience with them.

### 1.1.2 – Terminology

The following terms are important in order to understand the grammars.

**Production rule:**

> A **production rule**, or simply a **rule**, defines a replacement from a label, known as a **rule name** (non-terminal symbol), to one or more **productions**.
> 
> In the grammars, rules are distinguished from terminals by being enclosed in &lt;angle brackets&gt;.

**Production:**

> A **production** refers to a complete replacement of a production rule by other rules (non-terminal symbols) and/or terminals. A production rule may define more than one production.
> 
> **Example:**
>> **_&lt;when_body&gt;_:** `{` &lt;when_case&gt;\+ &lt;otherwise_case&gt;? `}`
>> 
>> **_&lt;when_case&gt;_:**
>> * `is` &lt;elements&gt; `->` &lt;body&gt;
>> * `matches` &lt;expr&gt; `->` &lt;body&gt;
>> * `passes` &lt;expr&gt; `->` &lt;body&gt;
> 
> The rule &lt;when_body&gt; defines a single production, whereas the rule &lt;when_case&gt; defines three.

**Terminal:**

> A **terminal** is a symbol that represents a concrete value or token in the language and cannot be replaced further by any production rule.
> 
> In the grammars, terminals are written in `this monospace font`.

**Rule name:**

> A **rule name** refers to the label at the beginning of a production rule's definition. It may also be referred to as the left-hand side (LHS) of a production rule.
> 
> In the grammars, rule names are ***bolded and italicized***.

**Rule occurrence:**

> A **rule occurrence**, or simply an **occurrence**, refers to a situation when a rule appears as part of a production of another rule.
> 
> **Example:**
>> **_&lt;IDENTIFIER&gt;_:** &lt;LEADOFF&gt; &lt;FOLLOWING&gt;\*
> 
> This production rule features an occurrence of &lt;LEADOFF&gt; and of &lt;FOLLOWING&gt;.

**Production unit:**

> A **production unit** is a catchall term that can refer to:
> * a rule occurrence
> * a terminal
> * multiple production units (including any attached symbols present) enclosed in parentheses

### 1.1.3 – Notation

The following symbols and conventions are used in productions in the grammars.

**? (optional):**

> A question mark following a production unit means that the unit is **optional**; it may be **excluded** or **included once**.

**\+ (one or more):**

> A plus symbol following a production unit means that the unit is **repeatable**; it may occur **once** or **multiple times in a row**.

**\* (zero or more):**

> An asterisk (\*) following a production unit means that the unit is **optional and repeatable**; it may be **omitted**, or occur **once**, or **multiple times in a row**.

**| (choice):**

> Two or more production units separated by a pipe / vertical bar ( | ) represent a **choice**; any one of the units can be supplied as a valid match.
> 
> The choice symbol can also be used for entire productions.
>
> **Example:**
>> **_&lt;LEADOFF&gt;_:** `_` | `A..Z` | `a..z`
> 
> The rule &lt;LEADOFF&gt; has three productions.
> 
> Complex rules with several productions, or with productions with several units, may use bullets instead of vertical bars to show their productions on individual lines.

**`a..z` (range):**<sup>[a](#fn-a)</sup>

> A terminal consisting of two characters separated by `..` represents a **range**. This means that any character in that range of characters (including the bounding characters) is a valid match for the range.
> 
> This notation is only used when the range specified by the bounding characters is universally intuitive:
> * `a..z` - the 26 lowercase letters of the Latin alphabet
> * `A..Z` - the 26 uppercase letters of the Latin alphabet
> * `0..9` - the 10 numerical digits of the base 10 numbering system

**\~ (complement):**<sup>[a](#fn-a)</sup>

> A tilde (~) preceding a production unit represents the [**complement**![](../assets/external.png)](https://en.wikipedia.org/wiki/Complement_(set_theory)) of the unit. Complement means **everything that is not part of the production unit**. The [universe![](../assets/external.png)](https://en.wikipedia.org/wiki/Universe_(mathematics)), which means all possible things being considered, can be understood to be all of the characters encoded under [UTF-8![](../assets/external.png)](https://en.wikipedia.org/wiki/UTF-8).

**`\n`, `\r` (line terminators):**<sup>[a](#fn-a)</sup>

> The newline (`\n`) and carriage return (`\r`) characters are used to denote the end of a line. In the context of the lexical grammar, they are treated as line terminators and are used to handle line breaks in the source code. They are represented in the grammar as their escape character counterparts; however, in the source code, **these characters are not visible**.

**◯ (anything):**<sup>[a](#fn-a)</sup>

> A large circle (◯) represents **any character**. It is used in the lexical grammar to denote that any character, except for those explicitly excluded, can be matched.

## 1.2 – Grammars

The syntax of *DeltaScript* is formally expressed by a lexical grammar and a syntax grammar.

The lexical grammar is responsible for the tokenization of *DeltaScript* code; that is, for the correct identification of **tokens**: the basic building blocks of the program.

Conversely, the syntax grammar is responsible for parsing those tokens and understanding how they fit into the larger, more complex structures of the language, such as loops<sup>[§5.7](./ls-5-stat.md#57--loops)</sup> or functions<sup>[§6.1](./ls-6-func.md#61--functions)</sup>.

Lexical production rule names are ***&lt;CAPITALIZED&gt;***, whereas syntactical production rule names are written in ***&lt;snake_case&gt;***.

### 1.2.1 – Lexical grammar

The lexical grammar contains the production rules that pertain to the tokenization of *DeltaScript* code. This includes correctly identifying:
* Keywords<sup>[§1.3.3](#133--keywords)</sup>
* Punctuation (types of brackets, semicolons, etc.)
* [Identifiers![](../assets/definition.png)](./glossary.md#identifier)
* [Literals![](../assets/external.png)](https://en.wikipedia.org/wiki/Literal_(computer_programming))

The grammar shown here is an abridged version of the lexical grammar used for the official language implementation. For the sake of brevity and clarity, keywords and punctuation have been directly included as terminals in the syntax grammar<sup>[b](#fn-b)</sup>.

---

**<i id="lg-whitespace">&lt;WHITESPACE&gt;</i>:** ( ` ` | `\t` | `\n` )\+

> ` ` (space), `\t` (tab) and `\n` (newline) are all types of **whitespace**. Tab and newline are represented in the grammar as their escape character counterparts for the sake of clarity.
> 
> This rule is matched by the grammar, but its tokens are ignored.

**<i id="lg-linecomment">&lt;LINECOMMENT&gt;</i>:** `//` ( ~( `\r` `\n` ) )\*

> `\n` (newline) and `\r` (carriage return) are escape characters that represent line terminators. They are represented in the grammar as their escape character counterparts; however, in the source code, **these characters are not visible**.
> 
> This rule is matched by the grammar, but its tokens are ignored.

**<i id="lg-multilinecomment">&lt;MULTILINECOMMENT&gt;</i>:** `/*` ◯\* `*/`

> This rule is matched by the grammar, but its tokens are ignored.

**<i id="lg-final">&lt;FINAL&gt;</i>:** `final` | `~`

> `~` is a shorthand<sup>[§1.3.3](#133--shorthands)</sup> for `final`. They have the same meaning and can be used interchangeably.

**<i id="lg-identifier">&lt;IDENTIFIER&gt;</i>:** [&lt;LEADOFF&gt;](#lg-leadoff) [&lt;FOLLOWING&gt;](#lg-following)\*

> This rule describes a valid identifier. Identifiers are used as the names of variables, helper functions, and function parameters, plus additional use cases.

**<i id="lg-leadoff">&lt;LEADOFF&gt;</i>:** `_` | `A..Z` | `a..z`

> The initial character in an identifier. The initial character cannot be a digit.

**<i id="lg-following">&lt;FOLLOWING&gt;</i>:** `_` | `A..Z` | `a..z` | [&lt;DIGIT&gt;](#lg-digit)

> Any character following the initial character in an identifier.

**<i id="lg-subident">&lt;SUBIDENT&gt;</i>:** `.` [&lt;IDENTIFIER&gt;](#lg-identifier)

**<i id="lg-digit">&lt;DIGIT&gt;</i>:** `0..9`

**<i id="lg-hexdigit">&lt;HEX_DIGIT&gt;</i>:** [&lt;DIGIT&gt;](#lg-digit) | `a..f` | `A..F`

> A [hexadecimal![](../assets/external.png)](https://en.wikipedia.org/wiki/Hexadecimal) digit. Lowercase and uppercase letters can be used interchangeably.

**<i id="lg-floatlit">&lt;FLOAT_LIT&gt;</i>:**
* [&lt;DIGIT&gt;](#lg-digit)\+ `.` [&lt;DIGIT&gt;](#lg-digit)\+
* [&lt;DIGIT&gt;](#lg-digit)\+ `f`

> Floating-point number literals have two forms: decimal point notation (e.g. `2.0`) and "f" notation (`2f`).
> 
> **Note:**
> 
> Unlike some other programming languages, where `1.5f` is a valid floating-point number literal, "f" notation in *DeltaScript* is exclusively used to specify that an integer quantity should be treated as a floating-point number. Literals with a fractional component must be expressed in decimal point notation without a trailing `f`.

**<i id="lg-declit">&lt;DEC_LIT&gt;</i>:** [&lt;DIGIT&gt;](#lg-digit)\+

**<i id="lg-hexlit">&lt;HEX_LIT&gt;</i>:** `0x` [&lt;HEX_DIGIT&gt;](#lg-hexdigit)\+

> Hexadecimal integer literals are prefixed with `0x`.

**<i id="lg-channel">&lt;CHANNEL&gt;</i>:** [&lt;HEX_DIGIT&gt;](#lg-hexdigit) [&lt;HEX_DIGIT&gt;](#lg-hexdigit)

> An 8-bit color channel component of a [hex triplet![](../assets/external.png)](https://en.wikipedia.org/wiki/Web_colors#Hex_triplet) color literal.
> 
> **Note:**
> 
> A channel component is always two hexadecimal digits long, even if its value is representable in a single digit.

**<i id="lg-colorhexlit">&lt;COLOR_HEX_LIT&gt;</i>:** `#` [&lt;CHANNEL&gt;](#lg-channel) [&lt;CHANNEL&gt;](#lg-channel) [&lt;CHANNEL&gt;](#lg-channel) [&lt;CHANNEL&gt;](#lg-channel)?

> A hex triplet color literal representing a 32-bit RGBA color.
> 
> **Note:**
> 
> The optional fourth color channel represents the alpha/[opacity![](../assets/definition.png)](./glossary.md#opacity) channel. If it is omitted, the color is assigned an opacity of `255` / `0xff` (fully opaque).

**<i id="lg-escapechar">&lt;ESCAPE_CHAR&gt;</i>:** `\` ( `0` | `b` | `t` | `n` | `f` | `r` | `"` | `'` | `\` )

> The [escape characters![](../assets/external.png)](https://en.wikipedia.org/wiki/Escape_character) supported in *DeltaScript*.

**<i id="lg-restrictedcharset">&lt;RESTRICTED_CHARSET&gt;</i>:** ~( `\` | `'` | `"` )

**<i id="lg-character">&lt;CHARACTER&gt;</i>:** [&lt;RESTRICTED_CHARSET&gt;](#lg-restrictedcharset) | [&lt;ESCAPE_CHAR&gt;](#lg-escapechar)

**<i id="lg-charlit">&lt;CHAR_LIT&gt;</i>:** `'` [&lt;CHARACTER&gt;](#lg-character) `'`

**<i id="lg-stringlit">&lt;STRING_LIT&gt;</i>:** `"` ( [&lt;CHARACTER&gt;](#lg-character) | `'` ) `"`

### 1.2.2 – Syntax grammar

The syntax grammar is responsible for arranging the tokens produced by lexical grammar into a hierarchy that reflects the grammatical structure of the programming language.

---

**<i id="sg-headrule">&lt;head_rule&gt;</i>:** [&lt;signature&gt;](#sg-signature) [&lt;func_body&gt;](#sg-funcbody) [&lt;helper&gt;](#sg-helper)\*

> The outermost rule. The contents of an entire script file must match *head_rule* in order for the script to be syntactically correct.

**<i id="sg-helper">&lt;helper&gt;</i>:** [&lt;ident&gt;](#sg-ident) [&lt;signature&gt;](#sg-signature) [&lt;func_body&gt;](#sg-funcbody)

> The matching rule for a helper function<sup>[§6.3.2](./ls-6-func.md#632--helper-functions)</sup>.

**<i id="sg-funcbody">&lt;func_body&gt;</i>:**
* [&lt;body&gt;](#sg-body)
* `->` [&lt;expr&gt;](#sg-expr)

> The function body is everything associated with the function besides its signature and its name (in the case of a helper function; header functions<sup>[§6.3.1](./ls-6-func.md#631--header-functions)</sup> have no name).
> 
> The second production is a [shorthand](#133--shorthands) for a function body that consists of a single value `return` statement<sup>[§5.8.1](./ls-5-stat.md#581--value-return)</sup>.

**<i id="sg-signature">&lt;signature&gt;</i>:**
* `(` [&lt;param_list&gt;](#sg-paramlist)? `)`
* `(` [&lt;param_list&gt;](#sg-paramlist)? `->` [&lt;type&gt;](#sg-type) `)`

**<i id="sg-paramlist">&lt;param_list&gt;</i>:** [&lt;declaration&gt;](#sg-declaration) ( `,` [&lt;declaration&gt;](#sg-declaration) )\*

**<i id="sg-declaration">&lt;declaration&gt;</i>:** [&lt;FINAL&gt;](#lg-final)? [&lt;type&gt;](#sg-type) [&lt;ident&gt;](#sg-ident)

**<i id="sg-type">&lt;type&gt;</i>:**
* `bool`
* `char`
* `color`
* `float`
* `image`
* `int`
* `string`
* [&lt;type&gt;](#sg-type) `[]`
* [&lt;type&gt;](#sg-type) `<>`
* [&lt;type&gt;](#sg-type) `{}`
* `{` [&lt;type&gt;](#sg-type) `:` [&lt;type&gt;](#sg-type) `}`
* `(` [&lt;func_type&gt;](#sg-functype) `)`
* [&lt;ident&gt;](#sg-ident)

> The last production represents extension types<sup>[§8.3.1](./ls-8-ext.md#831--new-types)</sup>.

**<i id="sg-functype">&lt;func_type&gt;</i>:** [&lt;param_types&gt;](#sg-paramtypes)? `->` [&lt;type&gt;](#sg-type)

**<i id="sg-paramtypes">&lt;param_types&gt;</i>:** [&lt;type&gt;](#sg-type) ( `,` [&lt;type&gt;](#sg-type) )\*

**<i id="sg-body">&lt;body&gt;</i>:**
* [&lt;stat&gt;](#sg-stat)
* `{` [&lt;stat&gt;](#sg-stat)\* `}`

**<i id="sg-stat">&lt;stat&gt;</i>:**
* [&lt;loop_stat&gt;](#sg-loopstat)
* [&lt;if_stat&gt;](#sg-ifstat)
* [&lt;when_stat&gt;](#sg-whenstat)
* [&lt;var_def&gt;](#sg-vardef) `;`
* [&lt;assignment&gt;](#sg-assignment) `;`
* [&lt;return_stat&gt;](#sg-returnstat)
* [&lt;expr&gt;](#sg-expr) [&lt;sub_ident&gt;](#sg-subident) [&lt;args&gt;](#sg-args) `;`
* [&lt;ident&gt;](#sg-ident) [&lt;args&gt;](#sg-args) `;`
* [&lt;namespace_ident&gt;](#sg-namespaceident) [&lt;args&gt;](#sg-args) `;`

**<i id="sg-returnstat">&lt;return_stat&gt;</i>:** `return` [&lt;expr&gt;](#sg-expr)? `;`

**<i id="sg-loopstat">&lt;loop_stat&gt;</i>:**
* [&lt;while_def&gt;](#sg-whiledef) [&lt;body&gt;](#sg-body)
* [&lt;iteration_def&gt;](#sg-iterationdef) [&lt;body&gt;](#sg-body)
* [&lt;for_def&gt;](#sg-fordef) [&lt;body&gt;](#sg-body)
* `do` [&lt;body&gt;](#sg-body) [&lt;while_def&gt;](#sg-whiledef) `;`

**<i id="sg-iterationdef">&lt;iteration_def&gt;</i>:** `for` `(` [&lt;iterator_declaration&gt;](#sg-iteratordeclaration) `in` [&lt;expr&gt;](#sg-expr) `)`

> Represents an iterator loop<sup>[§5.7.4](./ls-5-stat.md#574--iterator-loops)</sup>.

**<i id="sg-iteratordeclaration">&lt;iterator_declaration&gt;</i>:** [&lt;declaration&gt;](#sg-declaration) | [&lt;ident&gt;](#sg-ident)

**<i id="sg-whiledef">&lt;while_def&gt;</i>:** `while` `(` [&lt;expr&gt;](#sg-expr) `)`

**<i id="sg-fordef">&lt;for_def&gt;</i>:** `for` `(` [&lt;var_init&gt;](#sg-varinit) `;` [&lt;expr&gt;](#sg-expr) `;` [&lt;assignment&gt;](#sg-assignment) `)`

**<i id="sg-ifstat">&lt;if_stat&gt;</i>:** [&lt;if_def&gt;](#sg-ifdef) ( `else` [&lt;if_def&gt;](#sg-ifdef) )\* ( `else` [&lt;body&gt;](#sg-body) )?

**<i id="sg-ifdef">&lt;if_def&gt;</i>:** `if` `(` [&lt;expr&gt;](#sg-expr) `)` [&lt;body&gt;](#sg-body)

**<i id="sg-whenstat">&lt;when_stat&gt;</i>:** `when` `(` [&lt;expr&gt;](#sg-expr) `)` [&lt;when_body&gt;](#sg-whenbody)

> Represents a `when` statement<sup>[§5.6.2](./ls-5-stat.md#562--when-statements)</sup>, which is similar to a [switch![](../assets/external.png)](https://en.wikipedia.org/wiki/Switch_statement) statement in some other programming languages.

**<i id="sg-whenbody">&lt;when_body&gt;</i>:** `{` [&lt;when_case&gt;](#sg-whencase)\+ [&lt;otherwise_case&gt;](#sg-otherwisecase)? `}`

**<i id="sg-whencase">&lt;when_case&gt;</i>:**
* `is` [&lt;elements&gt;](#sg-elements) `->` [&lt;body&gt;](#sg-body)
* `matches` [&lt;expr&gt;](#sg-expr) `->` [&lt;body&gt;](#sg-body)
* `passes` [&lt;expr&gt;](#sg-expr) `->` [&lt;body&gt;](#sg-body)

**<i id="sg-otherwisecase">&lt;otherwise_case&gt;</i>:** `otherwise` `->` [&lt;body&gt;](#sg-body)

**<i id="sg-expr">&lt;expr&gt;</i>:**
* [&lt;literal&gt;](#sg-literal)
* [&lt;assignable&gt;](#sg-assignable)
* [&lt;lambda_params&gt;](#sg-lambdaparams) [&lt;lambda_body&gt;](#sg-lambdabody)
* [&lt;ident&gt;](#sg-ident) [&lt;args&gt;](#sg-args)
* [&lt;namespace_ident&gt;](#sg-namespaceident) [&lt;args&gt;](#sg-args)
* [&lt;namespace_ident&gt;](#sg-namespaceident)
* `::` [&lt;ident&gt;](#sg-ident)
* [&lt;expr&gt;](#sg-expr) [&lt;sub_ident&gt;](#sg-subident) [&lt;args&gt;](#sg-args)
* [&lt;expr&gt;](#sg-expr) [&lt;sub_ident&gt;](#sg-subident)
* ( `-` | `!` | `#|` ) [&lt;expr&gt;](#sg-expr)
* `(` [&lt;type&gt;](#sg-type) `)` [&lt;expr&gt;](#sg-expr)
* [&lt;expr&gt;](#sg-expr) `^` [&lt;expr&gt;](#sg-expr)
* [&lt;expr&gt;](#sg-expr) ( `*` | `/` | `%` ) [&lt;expr&gt;](#sg-expr)
* [&lt;expr&gt;](#sg-expr) ( `+` | `-` ) [&lt;expr&gt;](#sg-expr)
* [&lt;expr&gt;](#sg-expr) ( `==` | `!=` | `>` | `<` | `>=` | `<=` ) [&lt;expr&gt;](#sg-expr)
* [&lt;expr&gt;](#sg-expr) ( `||` | `&&` ) [&lt;expr&gt;](#sg-expr)
* [&lt;expr&gt;](#sg-expr) `?` [&lt;expr&gt;](#sg-expr) `:` [&lt;expr&gt;](#sg-expr)
* `{` [&lt;kv_pairs&gt;](#sg-kvpairs) `}`
* `[` [&lt;elements&gt;](#sg-elements)? `]`
* `<` [&lt;elements&gt;](#sg-elements)? `>`
* `{` [&lt;elements&gt;](#sg-elements)? `}`
* `new` [&lt;type&gt;](#sg-type) `[` [&lt;expr&gt;](#sg-expr) `]`
* `new` `{` [&lt;type&gt;](#sg-type) `:` [&lt;type&gt;](#sg-type) `}`
* `(` [&lt;expr&gt;](#sg-expr) `)`

**<i id="sg-lambdaparams">&lt;lambda_params&gt;</i>:**
* `(` `)`
* [&lt;ident&gt;](#sg-ident)
* `(` [&lt;ident&gt;](#sg-ident) ( `,` [&lt;ident&gt;](#sg-ident) )\+ `)`

**<i id="sg-lambdabody">&lt;lambda_body&gt;</i>:** `->` ( [&lt;body&gt;](#sg-body) | [&lt;expr&gt;](#sg-expr) )

**<i id="sg-kvpairs">&lt;kv_pairs&gt;</i>:** [&lt;kv_pair&gt;](#sg-kvpair) ( `,` [&lt;kv_pair&gt;](#sg-kvpair) )\*

**<i id="sg-kvpair">&lt;kv_pair&gt;</i>:** [&lt;expr&gt;](#sg-expr) `:` [&lt;expr&gt;](#sg-expr)

**<i id="sg-args">&lt;args&gt;</i>:** `(` [&lt;elements&gt;](#sg-elements)? `)`

**<i id="sg-elements">&lt;elements&gt;</i>:** [&lt;expr&gt;](#sg-expr) ( `,` [&lt;expr&gt;](#sg-expr) )\*

**<i id="sg-assignment">&lt;assignment&gt;</i>:**
* [&lt;assignable&gt;](#sg-assignable) `=` [&lt;expr&gt;](#sg-expr)
* [&lt;assignable&gt;](#sg-assignable) `++`
* [&lt;assignable&gt;](#sg-assignable) `--`
* [&lt;assignable&gt;](#sg-assignable) `+=` [&lt;expr&gt;](#sg-expr)
* [&lt;assignable&gt;](#sg-assignable) `-=` [&lt;expr&gt;](#sg-expr)
* [&lt;assignable&gt;](#sg-assignable) `*=` [&lt;expr&gt;](#sg-expr)
* [&lt;assignable&gt;](#sg-assignable) `/=` [&lt;expr&gt;](#sg-expr)
* [&lt;assignable&gt;](#sg-assignable) `%=` [&lt;expr&gt;](#sg-expr)
* [&lt;assignable&gt;](#sg-assignable) `&=` [&lt;expr&gt;](#sg-expr)
* [&lt;assignable&gt;](#sg-assignable) `|=` [&lt;expr&gt;](#sg-expr)

**<i id="sg-varinit">&lt;var_init&gt;</i>:** [&lt;declaration&gt;](#sg-declaration) `=` [&lt;expr&gt;](#sg-expr)

**<i id="sg-vardef">&lt;var_def&gt;</i>:** [&lt;declaration&gt;](#sg-declaration) | [&lt;var_init&gt;](#sg-varinit)

**<i id="sg-assignable">&lt;assignable&gt;</i>:**
* [&lt;ident&gt;](#sg-ident)
* [&lt;ident&gt;](#sg-ident) `<` [&lt;expr&gt;](#sg-expr) `>`
* [&lt;ident&gt;](#sg-ident) `[` [&lt;expr&gt;](#sg-expr) `]`

> In addition to variables, indices of lists and arrays are also assignable.

**<i id="sg-ident">&lt;ident&gt;</i>:** [&lt;IDENTIFIER&gt;](#lg-identifier)

**<i id="sg-subident">&lt;sub_ident&gt;</i>:** [&lt;SUBIDENT&gt;](#lg-subident)

**<i id="sg-namespaceident">&lt;namespace_ident&gt;</i>:** `$` [&lt;ident&gt;](#sg-ident) [&lt;sub_ident&gt;](#sg-subident)

> Represents an identifier of a constant or function in an extension namespace<sup>[§8.4](./ls-8-ext.md#84--namespaces)</sup>.

**<i id="sg-literal">&lt;literal&gt;</i>:**
* [&lt;STRING_LIT&gt;](#lg-stringlit)
* [&lt;CHAR_LIT&gt;](#lg-charlit)
* [&lt;COLOR_HEX_LIT&gt;](#lg-colorhexlit)
* [&lt;int_literal&gt;](#sg-intliteral)
* [&lt;FLOAT_LIT&gt;](#lg-floatlit)
* [&lt;bool_literal&gt;](#sg-boolliteral)

**<i id="sg-intliteral">&lt;int_literal&gt;</i>:** [&lt;HEX_LIT&gt;](#lg-hexlit) | [&lt;DEC_LIT&gt;](#lg-declit)

**<i id="sg-boolliteral">&lt;bool_literal&gt;</i>:** `true` | `false`

## 1.3 – Notes on syntax

### 1.3.1 – Comments

**Comments** are optional sections of source files that are ignored by interpreters or compilers implementing *DeltaScript*. Comments are intended to serve as human-readable annotations that make code easier to understand or provide additional context, such as authorship of a program, for example.

Comments in *DeltaScript* are identical to comments in most programming languages with [C-like syntax![](../assets/definition.png)](./glossary.md#c-like-syntax):

* **line comments** are initiated with `//` and run to the end of the line
* **multi-line comments** are opened with `/*` and closed with `*/`, capturing everything in between

```js
// This is a line comment.
() {
  int x = 5; // This is also a line comment.

  /*
    This is a multi-line comment.

    You can write entire paragraphs this way.
  */
  print(x);
  
  /* Although it only occupies one line, this is also a multi-line comment. */
  print(x * 2);

  print(/* You can put comments amongst code! */ "Hello world");
}
```

### 1.3.2 – Whitespace

Unlike programming languages like [Python![](../assets/external.png)](https://en.wikipedia.org/wiki/Python_(programming_language)), where indentation is used to specify the scope of code, whitespace (spaces, tabs, newlines) in *DeltaScript* has no bearing on the behaviour of a program.

> **Note:**
> 
> There are two notable exceptions to this:
> 
> 1. Whitespace within a multi-character token (like a keyword) will lead to syntax errors.
> 
> ```js
> // This program can be compiled / interpreted.
> () {
>   if (flip_coin())
>     print("Heads");
>   else
>     print("Tails");
> }
> ```
> 
> ```js
> // This program has a syntax error and cannot be compiled / interpreted.
> () {
>   if (flip_coin())
>     print("Heads");
>   el se
>     print("Tails");
> }
> ```
> 
> 2. Whitespace inside a string literal<sup>[§4.3.6](./ls-4-expr.md#436--string-literals)</sup> **DOES** affect the behaviour of the program. `"Helloworld"` and `"Hello world"` are **NOT** [semantically equivalent![](../assets/definition.png)](./glossary.md#semantic-equivalence).

### 1.3.3 – Keywords

*DeltaScript* utilizes the following keywords. **These are not to be used as [identifiers![](../assets/definition.png)](./glossary.md#identifier).**

* `bool`
* `char`
* `color`
* `do`
* `else`
* `false`
* `final`
* `float`
* `for`
* `if`
* `image`
* `in`
* `int`
* `is`
* `matches`
* `new`
* `otherwise`
* `passes`
* `return`
* `string`
* `true`
* `when`
* `while`

> **Planned:**
> 
> These keywords are associated with planned language features. To avoid having programs written in the current language version break in the future, the use of these keywords as identifiers is also discouraged.
> * `break`
> * `next`
> * `stop`

### 1.3.4 – Shorthands

*DeltaScript* supports a few types of shorthands. A **shorthand** is a way of expressing something [semantically equivalent![](../assets/definition.png)](./glossary.md#semantic-equivalence) using less code than it would otherwise take.

<br>

**Immutability:**

Like in [Java![](../assets/external.png)](https://en.wikipedia.org/wiki/Java_(programming_language)), *DeltaScript* uses the keyword `final` to declare a variable as immutable<sup>[§3.2.3](./ls-3-vars.md#323--immutability)</sup>. The tilde `~` is a shorthand that can be used instead.

> The following lines of code are semantically equivalent:
> 
> 1.  ```js
>     final string name = "John Doe";
>     ```
> 2.  ```js
>     ~ string name = "John Doe";
>     ```

<br>

**Single expression function bodies:**

Sometimes, a function body consists of a single `return` statement<sup>[§5.8](./ls-5-stat.md#58--return-statements)</sup>:

```js
red_channel(color c -> int) {
  return c.red;
}
```

Using the shorthand syntax, this can be expressed the following way:

```js
red_channel(color c -> int) -> c.red
```

Generally, for a function of the form:

```js
function_name(params? -> return_type) {
  return expression;
}
```

It can be equivalently expressed as:

```js
function_name(params? -> return_type) -> expression
```

> **Note:**
> 
> `params` is optional.

<br>

**Property abbreviations:**

Certain types define properties<sup>[§2.2.2](./ls-2-types.md#222--primitive-vs-composite-types)</sup>. Some of these properties can be accessed by an abbreviation.

These are all of the property abbreviations available in the [base language![](../assets/definition.png)](./glossary.md#base-language), though extensions<sup>[§8.2](./ls-8-ext.md#82--extensions)</sup> may define additional ones:

| Type | Property | Abbreviation |
| :--: | :------: | :----------: |
| `color` | [`red`](./color-sl.md#red) | `r` |
| `color` | [`green`](./color-sl.md#green) | `g` |
| `color` | [`blue`](./color-sl.md#blue) | `b` |
| `color` | [`alpha`](./color-sl.md#alpha) | `a` |
| `image` | [`width`](./image-sl.md#width) | `w` |
| `image` | [`height`](./image-sl.md#height) | `h` |

The following scripts are semantically equivalent:

1.  ```js
    () {
      image blank = new_image_of(300, 200);
      print(blank.width); // Prints "300"
    }
    ```
2.  ```js
    () {
      image blank = new_image_of(300, 200);
      print(blank.w); // Prints "300"
    }
    ```


---

## Footnotes

* <sup id="fn-a">a</sup> – This symbol/convention is only used in the lexical grammar.
* <sup id="fn-b">b</sup> – The exception is the keyword `final`, which is included in the abridged lexical grammar. This is because `final` has a shorthand equivalent ( `~` ), and thus cannot be trivially represented as a terminal in the syntax grammar.
