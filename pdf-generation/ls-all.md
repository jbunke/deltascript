<head>
    <link rel="stylesheet" href="https://github.com/assets/dark_colorblind-cdcaf9e749e5.css">
</head>

# *DeltaScript* – Language Specification

<!-- TODO - link to a Delta Time release -->

| Version | Published | Author | Implementation |
| :-----: | :-------: | :----: | :------------: |
| 0.1.0 | January 6, 2025 | Jordan Bunke | [Link![](../assets/external.png)]() |

*DeltaScript* is a lightweight scripting language skeleton that is designed to be easily extended for the specification and implementation of [domain-specific languages![](../assets/external.png)](https://en.wikipedia.org/wiki/Domain-specific_language).

The language is in active development. As it is already in production as the scripting language used by [*Stipple Effect*![](../assets/external.png)](https://github.com/stipple-effect/stipple-effect), it became necessary to publish a specification for the language.

*DeltaScript* is technically **platform-agnostic**. It can be implemented as a compiled language, or an interpreted language that targets any other programming language. However, the official implementation (latest version linked above) is an **interpreter that targets Java**.

This specification aims to provide an exhaustive description of how the language is designed, including its **syntax**, **semantics**, **execution**, and **extension possibilities**. Parts of this document employ advanced mathematical concepts, alongside formal mathematical notation and language. However, thorough explanations and external resources linked from within should ensure that the content remains accessible to non-experts. A strong mathematics and/or computer science background is helpful, but not required.

For a more beginner-friendly overview of the language, please see the [guides section](./guides.md) of the documentation.

## Contents

### [Introduction](#introduction-1)
* [Motivation](#motivation)
* [About the specification](#about-the-specification)
  * [Notation and conventions](#notation-and-conventions)
  * [Language status and compatibility](#language-status-and-compatibility)
  * [Overview of the specification](#overview-of-the-specification)

### [1 – Syntax and grammar](#chapter-1--syntax-and-grammar)
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

### [2 – Types]()
* [**2.1**](#21--type-system) – Type system
  * [**2.1.1**](#211--type-safety) – Type safety
  * [**2.1.2**](#212--type-inference) – Type inference
  * [**2.1.3**](#213--extensibility) – Extensibility
* [**2.2**](#22--simple-types) – Simple types
  * [**2.2.1**](#221--built-in-types) – Built-in types
  * [**2.2.2**](#222--primitive-vs-composite-types) – Primitive vs. composite types
* [**2.3**](#23--collection-types) – Collection types
  * [**2.3.1**](#231--arrays) – Arrays
  * [**2.3.2**](#232--lists) – Lists
  * [**2.3.3**](#233--sets) – Sets
  * [**2.3.4**](#234--mapsdictionaries) – Maps/dictionaries
* [**2.4**](#24--functional-types) – Functional types
  * [**2.4.1**](#241--parsing-complex-types) – Parsing complex types
* [**2.5**](#25--type-conversion) – Type conversion
  * [**2.5.1**](#251--implicit-type-conversion) – Implicit type conversion
  * [**2.5.2**](#252--explicit-type-conversion-casting) – Explicit type conversion (casting)

### [3 – Variables and declarations](#chapter-3--variables-and-declarations)
* [**3.1**](#31--variables) – Variables
* [**3.2**](#32--declarations) – Declarations
  * [**3.2.1**](#321--variable-names) – Variable names
  * [**3.2.2**](#322--initialization) – Initialization
  * [**3.2.3**](#323--immutability) – Immutability
* [**3.3**](#33--function-parameters) – Function parameters
* [**3.4**](#34--variable-scope) – Variable scope

### [4 – Expressions](#chapter-4--expressions)
* [**4.1**](#41--precedence) – Precedence
* [**4.2**](#42--nested-expressions) – Nested expressions
* [**4.3**](#43--literals) – Literals
  * [**4.3.1**](#431--bool-literals) – `bool` literals
  * [**4.3.2**](#432--char-literals) – `char` literals
  * [**4.3.3**](#433--color-literals) – `color` literals
  * [**4.3.4**](#434--int-literals) – `int` literals
  * [**4.3.5**](#435--float-literals) – `float` literals
  * [**4.3.6**](#436--string-literals) – `string` literals
  * [**4.3.7**](#437--escape-sequences) – Escape sequences
* [**4.4**](#44--variables-as-expressions) – Variables as expressions
* [**4.5**](#45--operators) – Operators
  * [**4.5.1**](#451--unary-operators) – Unary operators
  * [**4.5.2**](#452--binary-operators) – Binary operators
  * [**4.5.3**](#453--ternary-operator) – Ternary operator
  * [**4.5.4**](#454--compound-assignment-operators) – Compound assignment operators
* [**4.6**](#46--cast-expressions) – Cast expressions
* [**4.7**](#47--function-calls) – Function calls
  * [**4.7.1**](#471--global-function-calls) – Global function calls
  * [**4.7.2**](#472--helper-function-calls) – Helper function calls
  * [**4.7.3**](#473--scoped-function-calls) – Scoped function calls
* [**4.8**](#48--helper-function-references) – Helper function references
* [**4.9**](#49--anonymous-functions) – Anonymous functions
* [**4.10**](#410--array-and-list-elements) – Array and list elements
* [**4.11**](#411--explicit-collections) – Explicit collections
* [**4.12**](#412--collection-initializers) – Collection initializers

### [5 – Statements](./ls-5-stat.md)
* Declaration statements
* Assignments
* Void function calls
* Conditional statements
  * `if`
  * `when`
    * Cases
      * `is`
      * `matches`
      * `passes`
      * `otherwise`
* Loops
  * `while`
  * `do`...`while`
  * `for`
  * Iterator
* `return`
  * Value `return`
  * Void `return`

### [6 – Functions](./ls-6-func.md)
* Type signatures
  * Value-returning functions
  * Void functions
* Types of functions
  * Header functions
  * Helper functions
  * Anonymous functions
  * Global functions
  * Member functions
  * Extension functions
    * Namespace functions
    * Extension member functions
* Function semantics
  * No return value
  * Parameters and arguments

### [7 – Execution](./ls-7-exec.md)
* Type checking
* Errors
  * Syntax errors
  * Semantic errors
  * Runtime errors

### [8 – Extensions](./ls-8-ext.md)
* Types
  * New types
  * Extending built-in types
* Namespaces

### [Standard Library](./std-lib.md)

### [Glossary](#glossary-1)

# Introduction

## Motivation

*DeltaScript* was first developed as a domain-specific scripting language for [*Stipple Effect*![](../assets/external.png)](https://github.com/stipple-effect/stipple-effect), a pixel art editor that makes extensive use of scripting for automation and for transforming project contents.

Eventually, the *Stipple Effect* codebase was extensively refactored. The core of the scripting language implementation was ripped out and reimplemented in the underlying library that served as an external dependency for *Stipple Effect*, and the language features deemed specific to the context of *Stipple Effect* were implemented in its codebase as an extension to the [base language![](../assets/definition.png)](#base-language). The idea was that, this way, the base language would be reuseable for multiple projects, with application-specific behaviours and features implemented as extensions.

There are other programs in a similar niche as *Stipple Effect* that support scripting, like [*Aseprite*![](../assets/external.png)](https://www.aseprite.org), which lets users write scripts with [Lua![](../assets/external.png)](https://www.lua.org). I opted to design and implement my own scripting language for a few reasons, chief among which was **how I wanted the code to look**. Lua's keyword noise, lack of punctuation, and general boilerplate were all non-starters for me. I wanted scripts written in my language to clearly reflect their behaviour at a glance without any additional fluff.

Moreover, *DeltaScript* is **not a general-purpose programming language**. It is intended for writing scripts in particular application contexts. Thus, it is designed to be quite [high-level![](../assets/external.png)](https://en.wikipedia.org/wiki/High-level_programming_language) and narrow in its scope.

These are real examples of scripts in the [*Stipple Effect* extension dialect![](../assets/external.png)](https://stipple-effect.github.io/api) of *DeltaScript*:

1.  Add a black background layer to every project that is open in the program

    ```js
    () {
        for (p in $SE.get_projects()) {
            // Create a new background layer
            p.set_layer_index(0);
            p.add_layer();
            p.move_layer_down();

            // Link the cels of the layer and rename it
            layer l = p.get_layer();
            l.link_cels();
            l.set_name("Background");
            
            // Prepare a canvas of the same dimensions as the project
            //   and fill it with the color black (hex code #000000)
            int w = p.get_width();
            int h = p.get_height();
            image filled = new_image_of(w, h);
            filled.fill(#000000, 0, 0, w, h);

            // Set the contents of the layer to the black image
            // Cel index 0 will always exist;
            //   chosen arbitrarily as layer has linked cels
            l.set_cel(0, filled);
        }
    }
    ```

    This script makes use of the `project` and `layer` types, both of which are not present in the base language. The namespace `$SE` is also defined as part of the extension.

2.  Take an image and return the right half of the image

    ```js
    (image input -> image) {
        // an image must have a width of at least 1 pixel
        int new_w = max(1, input.width / 2);
        return input.section(input.width - new_w, 0, new_w, input.height);
    }
    ```

    This script exclusively utilizes language features from the base language.

## About the specification

### Notation and conventions

This language specification makes use of several conventions that are worth mentioning.

**Link icons:**

Some links in the specification are followed by small, blue superscript icons.

The question mark icon ( ![](../assets/definition.png) ) indicates that the link leads to the **[glossary](#glossary-1) entry** for the highlighted term. These are terms that are used repeatedly throughout the specification that warrant a definition. The glossary link will usually appear when such a term is used for the first time in a given section.

The arrow leaving a box icon ( ![](../assets/external.png) ) indicates that a link is an **external link**. That is, it links to a webpage beyond the *DeltaScript* documentation. Oftentimes such links will be to Wikipedia articles that expand on a term or concept referenced in the specification.

**Section links:**

At various points throughout the specification are superscripted links with section numbers. Such links begin with the section sign ( § ) and link to that section of the specification.

**Code snippets:**

Code snippets are multi-line segments of the specification that appear in monospaced font. Unless otherwise specified, code inside a code snippet is written in *DeltaScript*. Unless a particular language extension is referenced, the code can be assumed to be written in the [base language![](../assets/definition.png)](#base-language).

```js
() {
    print("This is a code snippet.");
}
```

> **Note:**
> 
> The specification is written in a lightweight markup language called [Markdown![](../assets/external.png)](https://en.wikipedia.org/wiki/Markdown), which allows for a programming language to be specified alongside a code snippet so that the code can be syntax highlighted. As *DeltaScript* is not yet a widely adopted language, code snippets are highlighted using a JavaScript syntax highlighter instead. This does a mostly satisfactory job of tokenizing *DeltaScript* code, but sometimes leads to mistakes.

**Text styling:**

These are the general guidelines that inform how text is styled in this specification:
* **Bold** - key terms and important information
* *Italics* - the names of non-ubiquitous technologies
* `Monospaced` - *DeltaScript* code

### Language status and compatibility

*DeltaScript* is still in active development and has not been released. While it is my aim that future changes to the language do not break programs written in earlier language versions, I cannot guarantee it.

Throughtout the specification and standard library, language features or standard library functions may be listed as:

* **Deprecated** - still a part of the language, but **discouraged and flagged for future removal**
* **Experimental** - likely to change or be removed in a future language version
* **Planned** - likely to be implemented in an impending language version

### Overview of the specification

This specification aims to provide an exhaustive description of how the language is designed, including its **syntax**, **semantics**, **execution**, and **extension possibilities**. After reading the specification, someone looking to write a compiler or interpreter for *DeltaScript* should be able to do so without requiring additional information about the language. It is intentionally vague about many low-level language implementation details, which are delegated to the discretion of the implementers.

The specification has been sequenced in a way that concepts from earlier chapters inform the broader concepts discussed in later chapters. Concepts are itemized and encapsulated as much as possible, allowing the reader to easily jump ahead or refer back to individual sections.

# Chapter 1 – Syntax and grammar

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

Conversely, the syntax grammar is responsible for parsing those tokens and understanding how they fit into the larger, more complex structures of the language, such as loops<sup>[§TODO]()</sup> or functions<sup>[§TODO]()</sup>.

Lexical production rule names are ***&lt;CAPITALIZED&gt;***, whereas syntactical production rule names are written in ***&lt;snake_case&gt;***.

### 1.2.1 – Lexical grammar

The lexical grammar contains the production rules that pertain to the tokenization of *DeltaScript* code. This includes correctly identifying:
* Keywords<sup>[§1.3.3](#133--keywords)</sup>
* Punctuation (types of brackets, semicolons, etc.)
* [Identifiers![](../assets/definition.png)](#identifier)
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
> The optional fourth color channel represents the alpha/[opacity![](../assets/definition.png)](#opacity) channel. If it is omitted, the color is assigned an opacity of `255` / `0xff` (fully opaque).

**<i id="lg-escapechar">&lt;ESCAPE_CHAR&gt;</i>:** `\` ( `0` | `b` | `t` | `n` | `f` | `r` | `"` | `'` | `\` )

> The [escape characters![](../assets/external.png)](https://en.wikipedia.org/wiki/Escape_character) supported in *DeltaScript*.

**<i id="lg-restrictedcharset">&lt;RESTRICTED_CHARSET&gt;</i>:** ~( `\` | `'` | `"` )

**<i id="lg-character">&lt;CHARACTER&gt;</i>:** [&lt;RESTRICTED_CHARSET&gt;](#lg-restrictedcharset) | [&lt;ESCAPE_CHAR&gt;](#lg-escapechar)

**<i id="lg-charlit">&lt;CHAR_LIT&gt;</i>:** `'` [&lt;CHARACTER&gt;](#lg-character) `'`

**<i id="lg-stringlit">&lt;STRING_LIT&gt;</i>:** `"` ( [&lt;CHARACTER&gt;](#lg-character) | `'` ) `"`

### 1.2.2 – Syntax grammar

The syntax grammar is responsible for arranging the tokens produced by lexical grammar into a hierarchy that reflects the grammatical structure of the programming language.

---

**<i id="sg-headrule">&lt;head_rule&gt;</i>:** [&lt;signature&gt;](#sg-signature) [&lt;funcBody&gt;](#sg-funcbody) [&lt;helper&gt;](#sg-helper)\*

> The outermost rule. The contents of an entire script file must match *head_rule* in order for the script to be syntactically correct.

**<i id="sg-helper">&lt;helper&gt;</i>:** [&lt;ident&gt;](#sg-ident) [&lt;signature&gt;](#sg-signature) [&lt;func_body&gt;](#sg-funcbody)

> The matching rule for a helper function<sup>[§TODO]()</sup>.

**<i id="sg-funcbody">&lt;func_body&gt;</i>:**
* [&lt;body&gt;](#sg-body)
* `->` [&lt;expr&gt;](#sg-expr)

> The function body is everything associated with the function besides its signature and its name (in the case of a helper function; header functions<sup>[§TODO]()</sup> have no name).
> 
> The second production is a [shorthand](#133--shorthands) for a function body that consists of a single value `return` statement<sup>[§TODO]()</sup>.

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

> The last production represents extension types<sup>[§TODO]()</sup>.

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

> Represents a foreach / iterator / enhanced for loop<sup>[§TODO]()</sup>.

**<i id="sg-iteratordeclaration">&lt;iterator_declaration&gt;</i>:** [&lt;declaration&gt;](#sg-declaration) | [&lt;ident&gt;](#sg-ident)

**<i id="sg-whiledef">&lt;while_def&gt;</i>:** `while` `(` [&lt;expr&gt;](#sg-expr) `)`

**<i id="sg-fordef">&lt;for_def&gt;</i>:** `for` `(` [&lt;var_init&gt;](#sg-varinit) `;` [&lt;expr&gt;](#sg-expr) `;` [&lt;assignment&gt;](#sg-assignment) `)`

**<i id="sg-ifstat">&lt;if_stat&gt;</i>:** [&lt;if_def&gt;](#sg-ifdef) ( `else` [&lt;if_def&gt;](#sg-ifdef) )\* ( `else` [&lt;body&gt;](#sg-body) )?

**<i id="sg-ifdef">&lt;if_def&gt;</i>:** `if` `(` [&lt;expr&gt;](#sg-expr) `)` [&lt;body&gt;](#sg-body)

**<i id="sg-whenstat">&lt;when_stat&gt;</i>:** `when` `(` [&lt;expr&gt;](#sg-expr) `)` [&lt;when_body&gt;](#sg-whenbody)

> Represents a `when` statement<sup>[§TODO - when statement]()</sup>, which is similar to a [switch![](../assets/external.png)](https://en.wikipedia.org/wiki/Switch_statement) statement in some other programming languages.

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

> Represents an identifier of a constant or function in an extension namespace<sup>[§TODO - extension namespace]()</sup>.

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

Comments in *DeltaScript* are identical to comments in most programming languages with [C-like syntax![](../assets/definition.png)](#c-like-syntax):

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
> 2. Whitespace inside a string literal<sup>[§TODO - string literal]()</sup> **DOES** affect the behaviour of the program. `"Helloworld"` and `"Hello world"` are **NOT** [semantically equivalent![](../assets/definition.png)](#semantic-equivalence).

### 1.3.3 – Keywords

*DeltaScript* utilizes the following keywords. **These are not to be used as [identifiers![](../assets/definition.png)](#identifier).**

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

*DeltaScript* supports a few types of shorthands. A **shorthand** is a way of expressing something [semantically equivalent![](../assets/definition.png)](#semantic-equivalence) using less code than it would otherwise take.

<br>

**Immutability:**

Like in [Java![](../assets/external.png)](https://en.wikipedia.org/wiki/Java_(programming_language)), *DeltaScript* uses the keyword `final` to declare a variable as immutable<sup>[§TODO]()</sup>. The tilde `~` is a shorthand that can be used instead.

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

Sometimes, a function body consists of a single return statement:

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

Certain types define properties<sup>[§TODO]()</sup>. Some of these properties can be accessed by an abbreviation.

These are all of the property abbreviations available in the [base language![](../assets/definition.png)](#base-language), though extensions<sup>[§TODO]()</sup> may define additional ones:

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

# Chapter 2 – Types

This chapter describes how *DeltaScript* handles types and their values.

## 2.1 – Type system

A **type** is a classification that specifies the kind of value a variable can hold and the operations that can be performed on it. In programming languages, types are used to enforce constraints on the values that can be represented by expressions<sup>[§TODO - expressions]()</sup>, ensuring that operations on these expressions and their values are semantically correct.

A sequence of characters written in the code to refer to a type is known as a **type identifier**. For example, the type identifier for an integer is `int`, while the type identifier for a set of characters is `char{}`.

Types in *DeltaScript* can be broadly categorized into three main groups: **simple types**<sup>[§2.2](#22--simple-types)</sup>, **collection types**<sup>[§2.3](#23--collection-types)</sup>, and **functional types**<sup>[§2.4](#24--functional-types)</sup>.

### 2.1.1 – Type safety

*DeltaScript* is type-safe and statically typed, meaning that type checking<sup>[§TODO - type checking]()</sup> is performed at compile-time<sup>[a](#fn-a)</sup> rather than at runtime. This ensures that type errors are caught early in the development process, leading to more reliable and maintainable code.

### 2.1.2 – Type inference

While *DeltaScript* requires explicit type declarations in many cases, it also supports type inference in certain contexts. This allows the language to deduce the type of a variable or expression based on the context in which it is used, reducing the need for redundant type annotations.

An example of this is in iterator loops<sup>[§TODO - iterator loops]()</sup>. The iterator variable can be declared without a type, as its type can be inferred from the collection.

> **Example 1:**
> 
> ```js
> () {
>     string aretharized = "";
>     
>     for (letter in "RESPECT")
>         aretharized += letter + ".";
> 
>     print(aretharized);
> }
> ```
> 
> The iterator variable `letter` is inferred to be of type `char`, because the collection is a `string`.

> **Example 2:**
> 
> ```js
> () {
>     color[] cs = [ #ff0000, #28283c, rgba(169, 75, 0x80, 0x3b) ];
> 
>     for (c in cs)
>         print("Value: " + value(c));
> }
> 
> value(color c -> int) -> max([ c.red, c.green, c.blue ])
> ```
> 
> This script calculates the [value![](../assets/external.png)](https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_RGB) of each color in the array `cs` on an integer scale from 0 to 255. The iterator variable `c` is inferred to be of type `color`, because the collection is an array of colors `color[]`.

### 2.1.3 – Extensibility

The type system in *DeltaScript* is designed to be extensible, allowing for the addition of new types<sup>[§TODO - new types]()</sup> and the extension of built-in types<sup>[§TODO - extension of built-in types]()</sup> through language extensions. This makes *DeltaScript* highly adaptable to various application domains and use cases.

## 2.2 – Simple types

Simple types are types whose identifiers consist of a single word and no punctuation. These types are **simple** in contrast to collection types and functional types, which are considered complex. Simple types comprise [built-in![](../assets/definition.png)](#built-in) types like `bool` and `int`, as well as new types defined by extensions to *DeltaScript*<sup>[§TODO - extension types]()</sup>.

### 2.2.1 – Built-in types

The following simple types are built into the [base language![](../assets/definition.png)](#base-language):
* `bool` - one of two possible [truth values![](../assets/external.png)](https://en.wikipedia.org/wiki/Truth_value): true or false
* `char` - a [UTF-8![](../assets/external.png)](https://en.wikipedia.org/wiki/UTF-8) character
* `color` - a 32-bit [RGBA color![](../assets/external.png)](https://en.wikipedia.org/wiki/RGBA_color_model)
* `float` - [a 64-bit (double precision) floating-point number![](../assets/external.png)](https://en.wikipedia.org/wiki/Double-precision_floating-point_format)
* `image` - a [bitmap![](../assets/external.png)](https://en.wikipedia.org/wiki/Bitmap); a [matrix![](../assets/external.png)](https://en.wikipedia.org/wiki/Matrix_(mathematics)) of pixels represented as colors
* `int` - a 32-bit signed [integer![](../assets/external.png)](https://en.wikipedia.org/wiki/Integer_(computer_science))
* `string` - [a sequence of zero or more characters![](../assets/external.png)](https://en.wikipedia.org/wiki/String_(computer_science))

### 2.2.2 – Primitive vs. composite types

Simple types can be further subdivided into **primitive types** and **composite types**.

**Primitive types** (`bool`, `char`, `float`, and `int`) represent primitive data values; they cannot be broken down into smaller units.

**Composite types** (`image`, `string`) represent **objects**, which are composed of multiple primitive data values. Objects have mutable states, meaning their internal data can change without altering the object's identity. For example, an object of the type `image` can have one of its pixels change color without becoming a different `image` object. Extension types are also usually composite.

Many composite types will also define [member functions![](../assets/definition.png)](#member-functions) and [properties![](../assets/definition.png)](#properties). The member functions and properties of the built-in composite types are detailed in *DeltaScript*'s [standard library](./std-lib.md).

`color` does not fall neatly into either category. Fundamentally, `color` represents a 32-bit integer. However, the type defines additional behaviours in the form of properties that give it the characteristics of a composite type.

## 2.3 – Collection types

Collection types represent collections of elements. They allow for the storage and manipulation of multiple values in a structured manner.

A collection's elements must all be of the same type<sup>[b](#fn-b)</sup>. A collection's elements mustn't be of a simple type; functions and collections themselves can also be grouped into collections.

The basic collection types in *DeltaScript* are **arrays**, **lists**, and **sets**. Each of these collection types contains elements of a single type, and is constrained by different rules determining how its elements can be accessed, arranged, added, or removed.

**Maps**, also known as **dictionaries**, are a special type of collection that represent associations between **keys** and **values**.

The member functions of collection types are detailed in the standard library [here](./collections-sl.md).

### 2.3.1 – Arrays

An **array** is an ordered collection of fixed [length![](../assets/definition.png)](#length).

**Ordered** means that elements in an array are arranged in a certain order, and that individual elements can be accessed via their **index** - their position in the array. *DeltaScript* uses [zero-based numbering![](../assets/external.png)](https://en.wikipedia.org/wiki/Zero-based_numbering), which means that the initial<sup>[c](#fn-c)</sup> element in an ordered collection has an index of 0.

> **Example:**
> 
> ```js
> () {
>     int[] squares = [ 1, 4, 9, 16, 25, 36, 49, 64, 81, 100 ];
> 
>     print(squares[0]); // prints "1"
>     print(squares[1]); // prints "4"
>     print(squares[9]); // prints "100"
> }
> ```

**Fixed length** means that an array can neither grow, nor shrink. It will always have the same number of allocated elements, even if some indices do not contain elements. <!-- TODO - How does the language currently handle attempting to access indices of collections of elements of a composite type that are empty? -->

Arrays are represented by **square brackets** `[]`. An array of elements of an arbitrary type `T` would be declared with the type identifier `T[]`.

### 2.3.2 – Lists

Like an array<sup>[§2.3.1](#231--arrays)</sup>, a **list** is an ordered collection. However, unlike an array, the [size![](../assets/definition.png)](#size) of a list is dynamic. This means that it can grow and shrink: elements can be added and removed.

Lists are represented by **angle brackets** `[]`. A list of elements of an arbitrary type `T` would be declared with the type identifier `T<>`.

### 2.3.3 – Sets

Like a list, a **set** is a collection of dynamic size. However, unlike a list, a set is **unordered**. Elements in a set have no order, and thus cannot be retrieved from an index.

Unlike arrays and lists, each element in a [set![](../assets/external.png)](https://en.wikipedia.org/wiki/Set_(mathematics)) is unique; a set cannot contain two elements of the same value or object.

Sets are represented by **curly brackets / braces** `{}`. A set of elements of an arbitrary type `T` would be declared with the type identifier `T{}`.

### 2.3.4 – Maps/dictionaries

A **map**, or **dictionary**, is a collection of associations, or **mappings**, between **keys** and **values**. Like lists and sets, the size of a **map** is dynamic. They are also unordered. A value can be retrieved from the map by providing the corresponding key.

Maps are represented by **curly brackets / braces** and a **colon** separating their key and value types. A map of keys of an arbitrary type `K` and values of an arbitrary type `V` would be declared with the type identifier `{K:V}`.

## 2.4 – Functional types

Functional types represent value-returning functions<sup>[§TODO - value-returning functions]()</sup>, including both named helper functions and anonymous functions. They enable the definition and invocation of reusable code blocks.

Functional type identifiers consist of **optional comma-separated parameter types**, followed by an **arrow**, followed by a **return type**, all **enclosed in parentheses**. A functional type with the arbitrary parameter types `P1`, `P2`, etc. and the arbitrary return type `R` would be declared with the type identifier `(P1, P2, ... -> R)`.

**Examples:**

* `(int -> string)` - a function that accepts an integer as a parameter and returns a string
* `(float, float -> bool)` - a function that accepts two floating-point numbers as parameters and returns a boolean
* `(-> int)` - a function with no parameters that returns an integer
* `((float -> int), float[] -> int[])` - a function that accepts a floating-point number to integer function and an array of floating-point numbers as parameters and returns an array of integers

> **Planned:**
> 
> Future language versions may support functional types for void functions<sup>[§TODO - void functions]()</sup>.

### 2.4.1 – Parsing complex types

It is important for users to be able to parse complex type identifiers<sup>[§2.1](#21--type-system)</sup> in order to correctly conceptualize what they represent.

In these examples, the "outermost" type is bolded:

* `int[]` - **an array** of integers
* `char{}[]` - **an array** of sets of characters
* `char[]{}` - **a set** of arrays of characters
* `{string:int}<>` - **a list** of maps mapping strings to integers
* `{bool[]:bool}` - **a map** mapping arrays of booleans to booleans
* `(float, float -> int)[]` - **an array** of functions that accept two floating-point numbers as parameters and return integers
* `(int, int, bool -> int[])` - **a function** that accepts an integer, an integer, and a boolean as parameters and returns an array of integers

## 2.5 – Type conversion

**Type conversion** is when a value of a certain type is converted to a correspondent value of another type, either implicitly or explicitly.

*DeltaScript* supports both implicit and explicit type conversion. Implicit type conversion occurs automatically when it is safe to do so, while explicit type conversion (casting) requires the user to specify the desired type. Type conversion is not universal; only certain types can be converted to certain other types.

These are all the type conversions that are possible in *DeltaScript*:

| From |  To  | Value conversion |
| :--- | :--- | :--------------- |
| `bool` | `string` | `true` values converted to `"true"`, `false` values to `"false"` |
| `char` | `int` | Converts a character to its [Unicode![](../assets/external.png)](https://en.wikipedia.org/wiki/List_of_Unicode_characters) decimal (base-10) value |
| `char` | `string` | Converts a character to the equivalent one-character string |
| `float` | `int` | Truncates a `float` to its integer component |
| `float` | `string` | Represents a `float` as a string in decimal point notation |
| `int` | `char` | Derives a character from its Unicode decimal value |
| `int` | `float` | Trivial |
| `int` | `string` | Trivial |

### 2.5.1 – Implicit type conversion

**Implicit type conversion** usually occurs when operands of different types are operated on by a (binary) operator<sup>[§TODO - binary operators]()</sup>.

> **Example:**
> 
> ```js
> () {
>     print(27.25 + 12); // prints "39.25"
> }
> ```
> 
> The operand `27.25` is a `float`, and the operand `12` is an `int`. Before this addition operation is performed, `12` is converted to the equivalent `float` (`12f` / `12.0`). That way, the operation is an addition of `float` rather than an addition of `int`. An addition of `float` preserves the fractional component of `27.25` (`0.25`), which would have been truncated had `27.25` been converted into an integer (`27`) instead.

**Any value of any type** can be implicitly converted to a `string` value.

### 2.5.2 – Explicit type conversion (casting)

**Explicit type conversion**, or **casting**, is when a user specifies in the source code that the value of an expression should be converted to another type. This is achieved with a cast expression<sup>[§TODO - cast expression]()</sup>, where the desired type is enclosed in parentheses before the expression whose value is to be converted.

> **Example:**
> 
> ```js
> () {
>     print((int) 27.25 + 12); // prints "39"
> }
> ```
> 
> The precedence of the expression `(int) 27.25 + 12` looks like this: `((int) 27.25) + 12`. The cast operation is performed first; the `float` `27.25` is truncated to an `int` with a value of `27`. Now, as both operands of the addition operation (`27` and `12`) are `int`, the operation is an addition of `int`.

---

## Footnotes

* <sup id="fn-a">a</sup> - The term "compile-time" is used here, however, depending on the language implementation, *DeltaScript* code may be either compiled or interpreted. Either way, type checking is performed prior to runtime – the execution of the script.
* <sup id="fn-b">b</sup> - This applies to arrays, lists, and sets. Maps/dictionaries have two element types: one for keys and one for values. All keys in a map must be of the same type, and all values must be of the same type. However, keys and values mustn't be of the same type.
* <sup id="fn-c">c</sup> - Because the ordinal number "first" doesn't correspond with the index 0, some people refer to the initial element of an ordered collection in a zero-based language as the "zeroth" element. However, this specification uses "first" to mean initial, i.e. at index 0.

# Chapter 3 – Variables and declarations

## 3.1 – Variables

In *DeltaScript*, a **variable** is a storage location associated with a particular name, in a particular scope<sup>[§3.4](#34--variable-scope)</sup> of the program. Variables are either **declared** in the body of a function, or are **parameters** of the function itself.

A variable stores a value of a particular type<sup>[§2](#chapter-2--types)</sup>, which is stated in the variable's declaration<sup>[§3.2](#32--declarations)</sup>.

A variable may or may not be assigned a value when it is declared. The assignment of a value to a variable upon its declaration is known as initialization<sup>[§3.2.2](#322--initialization)</sup>.

## 3.2 – Declarations

A **variable declaration** is a type of statement<sup>[§TODO - statements]()</sup> in *DeltaScript* that appoints a particular name as a storage location for values of a particular type.

Referring back to the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>, variable declarations are matched by the following production rules:

> **_&lt;var_def&gt;_:** &lt;declaration&gt; | &lt;var_init&gt;
> 
> **_&lt;var_init&gt;_:** &lt;declaration&gt; `=` &lt;expr&gt;
> 
> **_&lt;declaration&gt;_:** &lt;FINAL&gt;? &lt;type&gt; &lt;ident&gt;

From left to right, a declaration consists of an optional immutability<sup>[§3.2.3](#323--immutability)</sup> modifier, a type identifier, and a variable name. A declaration statement may also be an initialization statement, in which case the variable name will be followed by the assignment operator `=` and an expression<sup>[§TODO - expressions]()</sup> representing the variable's initial value.

After its initialization, a variable's name can be used as an expression to retrieve its associated value. A **mutable** variables can also be assigned<sup>[§TODO - assignment]()</sup> a new value.

### 3.2.1 – Variable names

Variable names in *DeltaScript* must be valid [identifiers![](../assets/definition.png)](#identifier). An identifier must match the following rule<sup>[a](#fn-a)</sup> from the lexical grammar<sup>[§1.2.1](#121--lexical-grammar)</sup>:

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

A variable is declared as immutable by [prepending![](../assets/definition.png)](#prepend) the type identifier in the declaration with the keyword<sup>[§1.3.3](#133--keywords)</sup> `final`<sup>[c](#fn-c)</sup>.

Contrastingly, a variable that **can** have its value reassigned is called **mutable**.

Immutability in *DeltaScript* is **shallow**. This means that, for variables representing arrays<sup>[§2.3.1](#231--arrays)</sup> or lists<sup>[§2.3.2](#232--lists)</sup>, while the entire collection cannot be reassigned, indices of the collection can be reassigned with new elements.

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
> `nums` is declared as immutable. Assignments with a [LHS![](../assets/definition.png)](#lhs) of the form `nums[I]`, where `I` is an arbitrary expression that evaluates to a value of type `int`, are permitted. However, direct assignments to `nums` (`nums = ...`) are not.

## 3.3 – Function parameters

**Function parameters** are special types of variables. Rather than being declared with statements in the bodies of functions<sup>[§TODO - functions]()</sup>, they are defined in the function's signature. Function parameters receive their values from the arguments passed to the function when it is called. These parameters can be either mutable or immutable, depending on whether the `final` keyword<sup>[c](#fn-c)</sup> is used in their declaration. That is to say, mutable parameters can be assigned new values in the bodies of the functions they are defined with.

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

The **scope** of a variable is the section of a program's source code in which the name of the variable can be used to as a reference to its associated value. Scopes are associated with a language structure, whether it is a function<sup>[§TODO - functions]()</sup>, or a [control flow![](../assets/definition.png)](#control-flow) structure like an `if` statement<sup>[§TODO - if statements]()</sup> or a loop<sup>[§TODO - loops]()</sup>.

> **Note:**
> 
> This specification uses the terms **reference** and **use** of a variable to mean the invocation of a variable's name as an expression to represent its value.

Variables cannot be referenced outside of the scope in which their are declared. Nor can they be referenced in their declaration scope prior to their declaration. Attempting to do so will lead be flagged by the semantic error checker<sup>[§TODO - semantic error checking]()</sup> and lead to a compile error<sup>[§TODO - compile/semantic error]()</sup> that will prevent the script from being executed.

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
> The outermost scope of this script is the header function body, i.e. everything between the outermost curly brackets `() {...}`. Each of the `for` loops<sup>[§TODO - for loops]()</sup> defines a nested scope within the function body scope. The variables `a` and `b` are declared in the function body scope. The `print()` statements inside each loop are part of the scopes of the respective loops. Because the loop scopes are **nested within the function scope**, variables declared in the function scope can be referenced from within the nested scopes.

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
* <sup id="fn-c">c</sup> - `final` or its shorthand<sup>[§1.3.4](#134--shorthands)</sup> equivalent `~`

# Chapter 4 – Expressions

This chapter details the various forms expressions in *DeltaScript* can take.

An **expression** is a section of source code that, when reached in the program's execution, **can be evaluated** to a single value of a certain type<sup>[§2](#chapter-2--types)</sup>.

Expressions can consist of single syntactic tokens, like a numeric literal (e.g. `12`) or a variable (e.g. `item`), or be composed of various smaller expressions (e.g. `max(12 - 5, rand(2, 15))`).

## 4.1 – Precedence

Expressions are matched in this order by the following production rule from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * &lt;literal&gt;
> * &lt;assignable&gt;
> * &lt;lambda_params&gt; &lt;lambda_body&gt;
> * &lt;ident&gt; &lt;args&gt;
> * &lt;namespace_ident&gt; &lt;args&gt;
> * &lt;namespace_ident&gt;
> * `::` &lt;ident&gt;
> * &lt;expr&gt; &lt;sub_ident&gt; &lt;args&gt;
> * &lt;expr&gt; &lt;sub_ident&gt;
> * ( `-` | `!` | `#|` ) &lt;expr&gt;
> * `(` &lt;type&gt; `)` &lt;expr&gt;
> * &lt;expr&gt; `^` &lt;expr&gt;
> * &lt;expr&gt; ( `*` | `/` | `%` ) &lt;expr&gt;
> * &lt;expr&gt; ( `+` | `-` ) &lt;expr&gt;
> * &lt;expr&gt; ( `==` | `!=` | `>` | `<` | `>=` | `<=` ) &lt;expr&gt;
> * &lt;expr&gt; ( `||` | `&&` ) &lt;expr&gt;
> * &lt;expr&gt; `?` &lt;expr&gt; `:` &lt;expr&gt;
> * `{` &lt;kv_pairs&gt; `}`
> * `[` &lt;elements&gt;? `]`
> * `<` &lt;elements&gt;? `>`
> * `{` &lt;elements&gt;? `}`
> * `new` &lt;type&gt; `[` &lt;expr&gt; `]`
> * `new` `{` &lt;type&gt; `:` &lt;type&gt; `}`
> * `(` &lt;expr&gt; `)`

> **Note:**
> 
> Definitions for production rules with occurrences in &lt;expr&gt; may be provided in later sections of the chapter.

Consider the following expression:

```cpp
(int) 12f * 2 + 14
```

This is the [parse tree![](../assets/external.png)](https://en.wikipedia.org/wiki/Parse_tree) for the expression according to the [precedence![](../assets/external.png)](https://en.wikipedia.org/wiki/Order_of_operations) order of the productions of &lt;expr&gt;:

![](../assets/expression-parse-tree.png)

## 4.2 – Nested expressions

A **nested expression** is merely an expression enclosed in parentheses `()`. This is useful for explicitly redefining the evaluation order of a compound expression.

> **Example:**
> 
> ```js
> 4 + 5 * 6 // evaluates to 34
> ```
> 
> ```js
> (4 + 5) * 6 // evaluates to 54
> ```

## 4.3 – Literals

A **literal expression** or simply **literal** is an expression whose evaluation is trivial. Its textual representation in the source code reveals its value.

Literal expressions are matched by the follow production rule from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;literal&gt;_:**
> * &lt;STRING_LIT&gt;
> * &lt;CHAR_LIT&gt;
> * &lt;COLOR_HEX_LIT&gt;
> * &lt;int_literal&gt;
> * &lt;FLOAT_LIT&gt;
> * &lt;bool_literal&gt;
> 
> **_&lt;int_literal&gt;_:** &lt;HEX_LIT&gt; | &lt;DEC_LIT&gt;
> 
> **_&lt;bool_literal&gt;_:** `true` | `false`

### 4.3.1 – `bool` literals

The literals for type<sup>[§2.2.1](#221--built-in-types)</sup> `bool` consist of the keywords<sup>[§1.3.3](#133--keywords)</sup> `true` and `false`, which represent the two possible [truth values![](../assets/external.png)](https://en.wikipedia.org/wiki/Truth_value).

### 4.3.2 – `char` literals

A **`char` literal** is consists of opening and closing single quotation marks `'`, with a single character or escape sequence<sup>[§4.3.7](#437--escape-sequences)</sup> in between. A char literal is matched by the following lexical grammar<sup>[§1.2.1](#121--lexical-grammar)</sup> production rule:

> **_&lt;CHAR_LIT&gt;_:** `'` &lt;CHARACTER&gt; `'`
> 
> **_&lt;CHARACTER&gt;_:** &lt;RESTRICTED_CHARSET&gt; | &lt;ESCAPE_CHAR&gt;
> 
> **_&lt;RESTRICTED_CHARSET&gt;_:** ~( `\` | `'` | `"` )
> 
> **_&lt;ESCAPE_CHAR&gt;_:** `\` ( `0` | `b` | `t` | `n` | `f` | `r` | `"` | `'` | `\` )

Some characters can only be represented by a `char` literal by using an escape sequence. For example, representing a tab character, which is not printed, requires the escape sequence `\t`.

**Examples:**

* `'n'` - a `char` literal representing the lowercase letter `n`
* `'\n'` - a `char` literal representing a [newline / line break character![](../assets/external.png)](https://en.wikipedia.org/wiki/Newline)

### 4.3.3 – `color` literals

Colors in *DeltaScript* can be represented as [hex codes![](../assets/external.png)](https://en.wikipedia.org/wiki/Web_colors#Hex_triplet). They consist of a hash `#` followed by three or four two-digit [hexadecimal![](../assets/external.png)](https://en.wikipedia.org/wiki/Hexadecimal) numbers representing channels of a [32-bit RGBA color![](../assets/external.png)](https://en.wikipedia.org/wiki/RGBA_color_model).

They are matched by the following production rule from the lexical grammar<sup>[§1.2.1](#121--lexical-grammar)</sup>:

> **_&lt;COLOR_HEX_LIT&gt;_:** `#` &lt;CHANNEL&gt; &lt;CHANNEL&gt; &lt;CHANNEL&gt; &lt;CHANNEL&gt;?
> 
> **_&lt;CHANNEL&gt;_:** &lt;HEX_DIGIT&gt; &lt;HEX_DIGIT&gt;
> 
> **_&lt;HEX_DIGIT&gt;_:** &lt;DIGIT&gt; | `a..f` | `A..F`
> 
> **_&lt;DIGIT&gt;_:** `0..9`

The optional fourth color channel represents the alpha/[opacity![](../assets/definition.png)](#opacity) channel. If it is omitted, the color is assigned an opacity of `255` / `0xff` (fully opaque).

> **Examples:**
> 
> * `#287de2` = `rgb(40, 125, 226)`
> * `#03ffa044` = `rgba(3, 255, 160, 68)`

### 4.3.4 – `int` literals

> **Note:**
> 
> Negative numbers (e.g. `-2`) are not treated as literals by *DeltaScript*, but rather as an application of the arithmetic negation operator<sup>[§4.5.1](#arith-neg)</sup> to a positive number literal. This is also true for `float` literals (e.g. `-2.0` or `-2f`).

`int` literals take two forms: decimal (base 10) literals and hexadecimal (base 16) literals. They are matched by the following production rules.

> * From the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:
>   
>   **_&lt;int_literal&gt;_:** &lt;HEX_LIT&gt; | &lt;DEC_LIT&gt;
> * From the lexical grammar<sup>[§1.2.1](#121--lexical-grammar)</sup>:
> 
>   **_&lt;DEC_LIT&gt;_:** &lt;DIGIT&gt;\+
>   
>   **_&lt;HEX_LIT&gt;_:** `0x` &lt;HEX_DIGIT&gt;\+
> 
>   **_&lt;HEX_DIGIT&gt;_:** &lt;DIGIT&gt; | `a..f` | `A..F`
> 
>   **_&lt;DIGIT&gt;_:** `0..9`

> **Planned:**
> 
> Future language versions may support binary (base 2) integer literals of the form `0b` ( `0` | `1` )\+.

**Decimal literals** consist of some non-empty sequence of the digits `0`-`9`.

**Hexadecimal literals** are alphanumeric. They are prefixed by `0x` and consist of the digits `0`-`9` and the letters `a`-`f` (`A`-`F`). Uppercase and lowercase letters can be used interchangeably.

In a [hexadecimal number![](../assets/external.png)](https://en.wikipedia.org/wiki/Hexadecimal), the [radix/base![](../assets/external.png)](https://en.wikipedia.org/wiki/Radix) is 16, so the values one through fifteen must be represented as a single digit each. Like with the conventional base 10 numbering system, `0` is a placeholder, and the digits `1`-`9` represent their expected digit values. The letters are used to represent the values ten through fifteen, starting with `a`/`A` as ten and culminating with `f`/`F` as fifteen.

In base 10 numbers, each place represents a power of 10, whereas in hexadecimal numbers, each place represents a power of 16.

> **Examples:**
> 
> * `0x3c`
>   
>   = `(3 * 16^1) + (12 * 16^0)`
>   
>   = `(3 * 16) + 12` = `60`
> * `0x2d5`
>   
>   = `(2 * 16^2) + (13 * 16^1) + (5 * 16^0)`
>   
>   = `(2 * 256) + (13 * 16) + 5` 
>   
>   = `512 + 208 + 5` = `725`

### 4.3.5 – `float` literals

`float` literals also have two formats. They are matched by the following production rules from the lexical grammar<sup>[§1.2.1](#121--lexical-grammar)</sup>:

> **_&lt;FLOAT_LIT&gt;_:**
> * &lt;DIGIT&gt;\+ `.` &lt;DIGIT&gt;\+
> * &lt;DIGIT&gt;\+ `f`
> 
> **_&lt;DIGIT&gt;_:** `0..9`

A `float` literal in **decimal point notation** consists of a non-empty sequence of the digits `0`-`9` preceding a decimal point `.` and followed by another non-empty sequence of the digits `0`-`9`.

**`f` notation** is used to express an integer quantity as a floating-point number. A `float` literal using `f` notation consists of some non-empty sequence of the digits `0`-`9` followed by `f` (must be lowercase).

> **Note:**
> 
> Unlike some other programming languages, where `1.5f` is a valid floating-point number literal, "f" notation in *DeltaScript* is exclusively used to specify that an integer quantity should be treated as a floating-point number. Literals with a fractional component must be expressed in decimal point notation without a trailing `f`.

### 4.3.6 – `string` literals

A **`string` literal** is bounded by opening and closing double quotation marks `"`. Within the quotation marks, zero or more characters define the contents of the string represented. Formally, they are matched by the following production rule from the lexical grammar<sup>[§1.2.1](#121--lexical-grammar)</sup>:

> **_&lt;STRING_LIT&gt;_:** `"` ( &lt;CHARACTER&gt; | `'` ) `"`
> 
> **_&lt;CHARACTER&gt;_:** &lt;RESTRICTED_CHARSET&gt; | &lt;ESCAPE_CHAR&gt;
> 
> **_&lt;RESTRICTED_CHARSET&gt;_:** ~( `\` | `'` | `"` )
> 
> **_&lt;ESCAPE_CHAR&gt;_:** `\` ( `0` | `b` | `t` | `n` | `f` | `r` | `"` | `'` | `\` )

Some characters can only be represented inside a `string` literal by using escape sequences<sup>[§4.3.7](#437--escape-sequences)</sup>. For example, representing a quotation mark inside a `string` literal requires the escape sequence `\"`. This is because the mere use of `"` without the preceding `\` would be parsed as the end of the `string` literal.

### 4.3.7 – Escape sequences

**Escape sequences** are sequences of characters beginning with `\` that are used as stand-ins for a single character that could otherwise not be represented in source code, either due to the context of its use clashing with the language's syntax or the character being a non-printing character.

This is the full set of escape sequences supported by *DeltaScript*:
* `\t` - [Tab![](../assets/external.png)](https://en.wikipedia.org/wiki/Tab_key#Tab_characters)
* `\n` - [Newline / line break![](../assets/external.png)](https://en.wikipedia.org/wiki/Newline)
* `\r` - [Carriage return![](../assets/external.png)](https://en.wikipedia.org/wiki/Carriage_return#Computers)
* `\"` - Double quotation mark `"`
* `\'` - Apostrophe / single quotation mark `'`
* `\\` - Backslash `\`

## 4.4 – Variables as expressions

**Variables**<sup>[§3.1](#31--variables)</sup> can be invoked as expressions by simply typing their names, provided they are defined in the current scope<sup>[§3.4](#34--variable-scope)</sup> and have been declared prior to the invocation statement that contains the expression.

## 4.5 – Operators

**Operators** are syntactical tokens that accept one or more expressions of certain types as **operands**, and produce a return value of a certain type. This specification categorizes operators based on how many operands they accept:

* Unary operators<sup>[§4.5.1](#451--unary-operators)</sup> - 1 operand
* Binary operators<sup>[§4.5.2](#452--binary-operators)</sup> - 2 operands
* The ternary operator<sup>[§4.5.3](#453--ternary-operator)</sup> - 3 operands

### 4.5.1 – Unary operators

Unary operators consist of one of the **unary operators** `!`, `-`, `#|` followed by an expression of a valid type.

From the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... higher precedence productions)
> * ( `-` | `!` | `#|` ) &lt;expr&gt;
> * (... lower precedence productions)

<br>

[**Logical negation**![](../assets/external.png)](https://en.wikipedia.org/wiki/Negation) or **not** is represented by the operator `!`. It can only be applied to expressions that evaluate to values of the type `bool`<sup>[§2.2.1](#221--built-in-types)</sup>.

This is the [truth table![](../assets/external.png)](https://en.wikipedia.org/wiki/Truth_table) for `!` operations with an arbitrary operand `P` of type `bool`:

| Value of `P` | Value of `!P` |
| :----------: | :-----------: |
| `true` | `false` |
| `false` | `true` |

<br>

<b id="arith-neg">Arithmetic negation</b> is represented by the operator `-`. It can only be applied to expressions that evaluate to values of a numeric type: either `float`<sup>[§2.2.1](#221--built-in-types)</sup> or `int`<sup>[§2.2.1](#221--built-in-types)</sup>.

Applying `-` to an arbitrary numeric type expression `P` yields the [additive inverse![](../assets/external.png)](https://en.wikipedia.org/wiki/Additive_inverse) of `P`. For `P` of type `float`, `-P` can be conceptualized as `0.0 - P`, while for `P` of type `int`, `-P` can be conceptualized as `0 - P`. The return type of the operation `-P` will be the same type as the operand `P`.

<br>

The `#|` operator represents **length** or **size**. It can be applied to expressions of types `string`<sup>[§2.2.1](#221--built-in-types)</sup>, array<sup>[§2.3.1](#231--arrays)</sup> `T[]`, list<sup>[§2.3.2](#232--lists)</sup> `T<>`, set<sup>[§2.3.3](#233--sets)</sup> `T{}` and map<sup>[§2.3.4](#234--mapsdictionaries)</sup> `{K:V}`.

The [length![](../assets/definition.png)](#length) of a `string` is the **number of characters in the string**.

The length of an array `T[]`<sup>[a](#fn-a)</sup> is the **number of elements allotted to the array**.

The [size![](../assets/definition.png)](#size) of a list `T<>`<sup>[a](#fn-a)</sup> or set `T{}`<sup>[a](#fn-a)</sup> is the **number of elements in the collection**.

The size of a map `{K:V}`<sup>[b](#fn-b)</sup> is the **number of mappings or key-value pairs contained in the map**.

> **Example:**
> 
> ```js
> () {
>   ~ color BLACK = #000000;
>   ~ color PINK = #f5a0a0;
> 
>   color{} cs = { BLACK, PINK };
> 
>   print(#|"Test phrase"); // prints "11"
>   print(#|[ 1, 2, 3, 4, 5 ]); // prints "5"
>   print(#|{ 'a' : 1, 'j' : 10, 'z' : 26 }); // prints "3"
> 
>   print(#|cs); // prints "2"
>   cs.add(rgb(0, 0, 0));
>   print(#|cs); // prints "2" again; cs already contained the color defined by rgb(0, 0, 0)
>   cs.add(rgb(0xff, 0, 0));
>   print(#|cs); // prints "3"
>   cs.remove(BLACK);
>   cs.remove(PINK);
>   print(#|cs); // prints "1"
> }
> ```
> 
> This script will produce the following output:
> 
> ```
> 11
> 5
> 3
> 2
> 2
> 3
> 1
> ```

### 4.5.2 – Binary operators

Binary operations consist of two operand expressions separated by a **binary operator**. Binary operators can be categorized into the following categories based on their precedence in the [order of operations![](../assets/external.png)](https://en.wikipedia.org/wiki/Order_of_operations):

* Exponent (`^`) - highest precedence, **deprecated**
* **Multiplicative operators** (`*`, `/`, `%`)
* **Additive operators** (`+`, `-`)
* **Comparison operators** (`==`, `!=`, `>` `>=`, `<=`, `<`)
* **Logic operators** (`&&`, `||`) - lowest precedence

From the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... higher precedence productions)
> * &lt;expr&gt; `^` &lt;expr&gt;
> * &lt;expr&gt; ( `*` | `/` | `%` ) &lt;expr&gt;
> * &lt;expr&gt; ( `+` | `-` ) &lt;expr&gt;
> * &lt;expr&gt; ( `==` | `!=` | `>` | `<` | `>=` | `<=` ) &lt;expr&gt;
> * &lt;expr&gt; ( `||` | `&&` ) &lt;expr&gt;
> * (... lower precedence productions)

Binary operators of the same precedence are left-[associative![](../assets/external.png)](https://en.wikipedia.org/wiki/Operator_associativity).

> **Examples:**
> 
> These chains of operators are shown with and without explicit grouping.
> 
> | Expression | With explicit grouping |
> | :--------- | :--------------------- |
> | `4 - 5 + 6 - 7` | `((4 - 5) + 6) - 7` |
> | `10 % 2 * 6` | `(10 % 2) * 6` |
> | `4 == 5 - 2 \|\| 3 != 4 - 2` | `(4 == (5 - 2)) \|\| (3 != (4 - 2))` |

<br>

The operator `+` represents both **addition** and [**concatenation**![](../assets/external.png)](https://en.wikipedia.org/wiki/Concatenation).

The operator performs an **addition** operation when both of its operands are of a numeric type. If both operands are of type `int`<sup>[§2.2.1](#221--built-in-types)</sup>, `+` performs an integer addition operation and returns the result as an `int` value. If both operands are of type `float`<sup>[§2.2.1](#221--built-in-types)</sup>, `+` performs a floating-point number addition operation and returns the result as a `float` value. If one of the operands is of type `float` and the other is of type `int`, the `int` operand is implicitly converted<sup>[§2.5.1](#251--implicit-type-conversion)</sup> to its `float` value, and `+` performs a floating-point number addition operation, returning the result as a `float` value.

If either operand is of a non-numeric type, both operands are implicitly converted to `string` values (if they are not already `string` values), and `+` performs a **concatenation** operation, returning the result as a `string` value.

> **Examples:**
> 
> | Operation | Return value | Return type |
> | :-------: | :----------: | :---------: |
> | `1 + 3` | `4` | `int` |
> | `1.0 + 3` | `4.0` | `float` |
> | `1 + 3.5` | `4.5` | `float` |
> | `"stage" + "coach"` | `"stagecoach"` | `string` |
> | `"race" + 's'` | `"races"` | `string` |
> | `"It is " + true` | `"It is true"` | `string` |

<br>

**Subtraction** is represented by the operator `-`. Its behaviour follows from the behaviour of the addition `+` operator. However, note that the subtraction operator `-` does not double as a `string` operator.

Its operand and return types can be expressed as follows:

* `int - int => int`
* `float - float => float`
* `int - float => float`
* `float - int => float`

<br>

**Multiplication** is represented by the operator `*`. 

Its operand and return types can be expressed as follows:

* `int * int => int`
* `float * float => float`
* `int * float => float`
* `float * int => float`

<br>

**Division** is represented by the operator `/`, while the **[modulo![](../assets/external.png)](https://en.wikipedia.org/wiki/Modulo) operation** is represented by the operator `%`.

For the arbitrary numeric operands `a`, `b`, the expression `a % b` returns the [remainder![](../assets/external.png)](https://en.wikipedia.org/wiki/Remainder) of the division operation `a / b` (`a` is the dividend, `b` is the divisor).

The behaviour of the modulo operator varies across programming languages in its handling of negative operands. *DeltaScript* leaves this to the discretion of implementers, but recommends an adherence to the following axiom:

* `(a / b) * b + (a % b) == a`

For both the division `/` and modulo `%` operators, attempting to divide by zero (a [RHS![](../assets/definition.png)](#rhs) operand with a value of `0` or `0.0`) will result in a runtime error<sup>[§TODO - runtime error]()</sup>.

The operand and return types of the division `/` and modulo `%` operators can be expressed as follows:

* `int OP int => int`
* `float OP float => float`
* `int OP float => float`
* `float OP int => float`

> **Note:**
> 
> This is in contrast to many other programming languages, which perform an integer or floating-point division operation based purely on the type of the divisor.

<br>

[**Exponentiation**![](../assets/external.png)](https://en.wikipedia.org/wiki/Exponentiation) is represented by the operator `^`.

For the arbitrary numeric operands `a`, `b`, the expression `a ^ b` performs an exponentiation operation with `a` as the **base** and `b` as the **power** or **exponent**.

> **Deprecated:**
> 
> This language feature is [deprecated![](../assets/external.png)](https://en.wikipedia.org/wiki/Deprecation).

<br>

**Equality** is represented by the operator `==`, while **inequality** is represented by the operator `!=`.

For any operand expressions `a`, `b`, `a == b` returns `true`<sup>[§4.3.1](#431--bool-literals)</sup> if `a` and `b` are **equal** and `false` if they are not.

The equality operator `==` can operate over operands of any type. Operands mustn't be the of the same type in order for `==` to operate on them. However, `a == b` will never return `true` if the values of `a` and `b` are of different types.

Equality is defined in the following ways for values of each of the types in the [base language![](../assets/definition.png)](#base-language):

| Type | `a == b`<sup>[c](#fn-c)</sup> |
| :--- | :------------------ |
| `bool` | `a` and `b` both evaluate to the same [truth value![](../assets/external.png)](https://en.wikipedia.org/wiki/Truth_value), whether `true` or `false` | 
| `char` | `a` and `b` both evaluate to the same [UTF-8![](../assets/external.png)](https://en.wikipedia.org/wiki/UTF-8) character |
| `color` | `a` and `b` both evaluate to the same 32-bit [RGBA color![](../assets/external.png)](https://en.wikipedia.org/wiki/RGBA_color_model): `a.red == b.red && a.green == b.green && a.blue == b.blue && a.alpha == b.alpha` |
| `float` | `a` and `b` both evaluate to equivalent floating-point numbers: `a - b == 0.0` |
| `image` | `a` and `b` represent identical images: (1) `a.width == b.width && a.height == b.height`, (2) for every `x`,`y` in `a` and `b`: `a.pixel(x, y) == b.pixel(x, y)` |
| `int` | `a` and `b` both evaluate to equivalent integers: `a - b == 0` |
| `string` | `a` and `b` both evaluate to the same string: (1) `#\|a == #\|b`, (2) for every index `i` in `a` and `b`: `a.at(i) == b.at(i)` |
| Array `T[]` | (1) `#\|a == #\|b`, (2) for every index `i` in `a` and `b`: `a[i] == b[i]` |
| List `T<>` | (1) `#\|a == #\|b`, (2) for every index `i` in `a` and `b`: `a<i> == b<i>` |
| Set `T{}` | `a` contains every element in `b` and `b` contains every element in `a` |
| Map `{K:V}` | (1) `a.keys()` contains every element in `b.keys()` and `b.keys()` contains every element in `a.keys()`, (2) for every element `k` in `a.keys()`: `a.lookup(k) == b.lookup(k)` |
| *Functional type* | `a` and `b` point to the same helper function<sup>[§TODO - helper function]()</sup>; even if the type signature and logic of two distinct functions are the same, `a != b` |

Extension types<sup>[§TODO - helper function]()</sup> should define their own definition of equality internally. The naive definition should be based on sharing the same [object reference![](../assets/external.png)](https://en.wikipedia.org/wiki/Object_(computer_science)).

For any operand expressions `a`, `b`, `a != b` is defined as `!(a == b)`.

<br>

There are four types of [mathematical inequality![](../assets/external.png)](https://en.wikipedia.org/wiki/Inequality_(mathematics)) operators:

* **Greater than** `>`
* **Greater than or equal to** `>=`
* **Less than or equal to** `<=`
* **Less than** `<`

These operators operate on operands of numeric types (`int` or `float`) are return either `true` or `false` (`bool` values).

<br>

[**Logical conjunction**![](../assets/external.png)](https://en.wikipedia.org/wiki/Logical_conjunction) (**and**) is represented by the operator `&&`, while [**logical disjunction**![](../assets/external.png)](https://en.wikipedia.org/wiki/Logical_disjunction) (**or**) is represented by the operator `||`.

Both operators require operands of type `bool`, and return a value of type `bool`.

This is the [truth table![](../assets/external.png)](https://en.wikipedia.org/wiki/Truth_table) for `&&` operations with arbitrary operands `a`, `b` of type `bool`:

| Value of `a` | Value of `b` | Value of `a && b` |
| :----------: | :----------: | :---------------: |
| `false` | `false` | `false` |
| `false` | `true` | `false` |
| `true` | `false` | `false` |
| `true` | `true` | `true` |

This is the truth table for `||` operations with arbitrary operands `a`, `b` of type `bool`:

| Value of `a` | Value of `b` | Value of `a \|\| b` |
| :----------: | :----------: | :---------------: |
| `false` | `false` | `false` |
| `false` | `true` | `true` |
| `true` | `false` | `true` |
| `true` | `true` | `true` |

### 4.5.3 – Ternary operator

The **ternary operator** or [**conditional operator**![](../assets/external.png)](https://en.wikipedia.org/wiki/Ternary_conditional_operator) returns one of two values depending on the result of a condition check. It takes the form `a ? b : c`, where `a` is an expression of type `bool`<sup>[§2.2.1](#221--built-in-types)</sup> and `b`, `c` are expressions of the same type. The return type of `a ? b : c` is the same type as `b` and `c`. If `a` evaluates to `true`, `a ? b : c` returns `b`. Otherwise (`a` evaluates to `false`), `a ? b : c` returns `c`.

> **Note:**
> 
> "Ternary" refers to any operator with three operands; however, as this is by far the most commonly used (and often only) ternary operator in many programming languages, it is widely referred to as **the** ternary operator.

### 4.5.4 – Compound assignment operators

[**Compound assignment operators**![](../assets/external.png)](https://en.wikipedia.org/wiki/Augmented_assignment) are a type of shorthand syntax used to simplify augmentative assignments of a variable; that is, variable assignments that incorporate the variable's current value to calculate the value being assigned.

For reference, this is the production rule for assignment statements<sup>[§TODO - assignment statements]()</sup> from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

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

Most compound assignment operations take the form `v OP e`, where `v` is an assignable expression like a variable<sup>[§3.1](#31--variables)</sup> or an array element or list element<sup>[§4.10](#410--array-and-list-elements)</sup>, `OP` is the operator, and `e` is an expression of a valid type that defines the change value.

The syntax of such compound assignment statements are listed below alongside their expanded forms under the hood. Refer back to the binary operators<sup>[§4.5.2](#452--binary-operators)</sup> for the semantics of each operator.

| Operation | Compound assignment | Expansion under the hood |
| :-------- | :------------------ | :----------------------- |
| Addition / concatenation | `v += e;` | `v = v + e;` |
| Subtraction | `v -= e;` | `v = v - e;` |
| Multiplication | `v *= e;` | `v = v * e;` |
| Division | `v /= e;` | `v = v / e;` |
| Modulo | `v %= e;` | `v = v % e;` |
| Conjunction (and) | `v &= e;` | `v = v && e;` |
| Disjunction (or) | `v \|= e;` | `v = v \|\| e;` |

The **incrementation** `++` and **decrementation** `--` are special cases of compound assignments. They are postfix operators, meaning that they follow their operand `v`. `++` increments the value of `v` by `1`, while `--` decrements the value of `v` by `1`.

| Operation | Compound assignment | Expansion under the hood |
| :-------- | :------------------ | :----------------------- |
| Incrementation | `v++;` | `v = v + 1;` |
| Decrementation | `v--;` | `v = v - 1;` |

For incrementation and decrementation operations, the assignable `v` must be of type `int`<sup>[§2.2.1](#221--built-in-types)</sup>.

> **Note:**
> 
> Unlike some programming languages like C and C++, in *DeltaScript*, **compound assignments are not expressions**.

## 4.6 – Cast expressions

A **cast expression** is used to explicitly convert a value from one type to another<sup>[§2.5.2](#252--explicit-type-conversion-casting)</sup>.

Cast expressions are matched by the following production rule from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... higher precedence productions)
> * `(` &lt;type&gt; `)` &lt;expr&gt;
> * (... lower precedence productions)

The type in the cast expression must be a valid type<sup>[§2](#chapter-2--types)</sup> in *DeltaScript*. The expression being cast must be of a type that can be converted to the target type<sup>[§2.5](#25--type-conversion)</sup>.

> **Example:**
> 
> ```js
> float f = (float) 10; // casts the integer 10 to a float 10.0
> ```

## 4.7 – Function calls

**Function calls** are expressions that invoke a function and return its result.

They are matched by the following production rules from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... higher precedence productions)
> * &lt;ident&gt; &lt;args&gt;
> * &lt;namespace_ident&gt; &lt;args&gt;
> * &lt;namespace_ident&gt;
> * (... productions in between)
> * &lt;expr&gt; &lt;sub_ident&gt; &lt;args&gt;
> * &lt;expr&gt; &lt;sub_ident&gt;
> * (... lower precedence productions)
> 
> **_&lt;args&gt;_:** `(` &lt;elements&gt;? `)`
> 
> **_&lt;namespace\_ident&gt;_:** `$` &lt;ident&gt; &lt;sub_ident&gt;
> 
> **_&lt;sub\_ident&gt;_:**<sup>[d](#fn-d)</sup> `.` &lt;ident&gt;

### 4.7.1 – Global function calls

**Global function calls** invoke functions that are defined globally<sup>[§TODO - global functions]()</sup> and are accessible from any scope.

They are matched by the following rule production from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> &lt;ident&gt; &lt;args&gt;

The global functions available in *DeltaScript* are defined by the [standard library](./functions-sl.md).

> **Example:**
> 
> ```js
> print("Hello, world!"); // calls the global function print
> ```

### 4.7.2 – Helper function calls

**Helper function calls** invoke helper functions<sup>[§TODO - helper functions]()</sup>: named functions that follow the header function<sup>[§TODO - header function]()</sup> in the script.

They are matched by the following rule production from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> &lt;ident&gt; &lt;args&gt;

> **Note:**
> 
> This is the same rule production that matches global function calls<sup>[§4.7.1](#471--global-function-calls)</sup>.

> **Example:**
> 
> ```js
> (int[][] arrays) {
>   for (arr in arrays) {
>     ~ int sum = array_sum(arr); // helper function call
>     print("The sum of the array " + arr + " is " + sum + ".");
>   }
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
> ```

### 4.7.3 – Scoped function calls

Functions called on a particular [object![](../assets/definition.png)](#object) or namespace<sup>[§TODO - namespace]()</sup> are considered **scoped**.

Scoped function calls are matched by the following production rules from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... higher precedence productions)
> * &lt;namespace_ident&gt; &lt;args&gt;
> * &lt;namespace_ident&gt;
> * (... productions in between)
> * &lt;expr&gt; &lt;sub_ident&gt; &lt;args&gt;
> * &lt;expr&gt; &lt;sub_ident&gt;
> * (... lower precedence productions)

They can be sorted into **member function calls** and **namespace function calls**. **Properties** and **constants** are similar concepts that are also described in this section.

<br>

**Member function calls** invoke member functions<sup>[§TODO - member functions]()</sup>: functions that are defined as callable on objects of a particular type.

They are matched by the following rule production from the syntax grammar:

> &lt;expr&gt; &lt;sub_ident&gt; &lt;args&gt;

> **Example:**
> 
> ```js
> () {
>   bool check = { 1, 2, 3 }.has(1); // member function call
>   print(check);  // prints "true"
> 
>   string name = "John Doe";
>   char fourth = name.at(3); // member function call
>   print(fourth) // prints "n"
> }
> ```
> 
> * [`has(T check) -> bool`](./collections-sl.md#has-2) is a member function of type set `T{}`
> * [`at(int index) -> char`](./string-sl.md#at) is a member function of type `string`

<br>

**Properties** are similar to member functions. Like member functions, they are called on objects of a particular type. However, unlike member functions, they take no [arguments![](../assets/external.png)](https://en.wikipedia.org/wiki/Parameter_(computer_programming)#Parameters_and_arguments) and simply return a value without executing any instructions.

Properties are matched by the following rule production from the syntax grammar:

> &lt;expr&gt; &lt;sub_ident&gt;

> **Example:**
> 
> ```js
> () {
>   int redness = #ff0000.red; // property invocation
>   print(redness); // prints "255"
> 
>   image new_img = new_image_of(160, 90);
>   print(new_img.width); // property invocation; prints "160"
> }
> ```
> * [`red -> int`](./color-sl.md#red) is a property of type `color`
> * [`width -> int`](./image-sl.md#width) is a property of type `image`

<br>

**Namespace function calls** invoke namespace functions<sup>[§TODO - namespace functions]()</sup>: functions defines as part of a namespace<sup>[§TODO - namespace]()</sup>. A namespace is an identifier used to group functions and constants in a *DeltaScript* extension<sup>[§TODO - extension]()</sup>.

They are matched by the following rule production from the syntax grammar:

> &lt;namespace_ident&gt; &lt;args&gt;

> **Example:**
> 
> Taken from the [*Stipple Effect* scripting API](https://stipple-effect.github.io/api), an extension to *DeltaScript*
> 
> ```js
> (-> color) {
>   color primary = $SE.get_primary(); // namespace function call
>   color secondary = $SE.get_secondary(); // namespace function call
> 
>   return blended_color(primary, secondary);
> }
> 
> blended_color(color a, color b -> color) {
>   color blended = $Graphics.lerp_color(a, b, 0.5); // namespace function call
>   return blended;
> }
> ```
> 
> This script returns the blended color of the two current system colors in *Stipple Effect*. It invokes the following namespace functions:
> 
> * [`$SE.get_primary() -> color`](https://stipple-effect.github.io/api/global#get_primary)
> * [`$SE.get_secondary() -> color`](https://stipple-effect.github.io/api/global#get_secondary)
> * [`$Graphics.lerp_color(color a, color b, float t) -> color`](https://stipple-effect.github.io/api/graphics#lerp_color)

<br>

**Constants** are to namespaces what properties are to objects of particular types. Namespaces may define [constants![](../assets/external.png)](https://en.wikipedia.org/wiki/Constant_(computer_programming)).

They are matched by the following rule production from the syntax grammar:

> &lt;namespace_ident&gt;

> **Example:**
> 
> Taken from the [*Stipple Effect* scripting API](https://stipple-effect.github.io/api), an extension to *DeltaScript*
> 
> ```js
> () {
>   project p = $SE.get_project();
>   save_config psc = p.get_save_config();
>   psc.set_save_type($SE.GIF); // constant invocation
>   p.save();
> }
> ```
> 
> This script changes the save association of the active *Stipple Effect* project to export to a GIF image and then saves the project. [`$SE.GIF`](https://stipple-effect.github.io/api/global#save-type-constants) is an `int` constant defined by the [`$SE` namespace](https://stipple-effect.github.io/api/global).

## 4.8 – Helper function references

**Helper function references** are expressions that return object references to helper functions without invoking them.

They are matched by the following production rule from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... higher precedence productions)
> * `::` &lt;ident&gt;
> * (... lower precedence productions)

Function objects can be invoked with the special `call()` function<sup>[§TODO - `call` function]()</sup>, which accepts the function's arguments.

> **Example:**
> 
> ```js
> (color c -> color[]) {
>   (color -> color)[] transformations = [
>     ::iso_r,        // helper function reference
>     ::iso_g,        // helper function reference
>     ::iso_b,        // helper function reference
>     ::greyscale     // helper function reference
>   ];
>   color[] output = new color[#|transformations];
> 
>   for (int i = 0; i < #|transformations; i++)
>     output[i] = transformations[i].call(c); // call()
> 
>   return output;
> }
> 
> iso_r(color c -> color) -> rgba(c.red, 0, 0, c.alpha)
> iso_g(color c -> color) -> rgba(0, c.green, 0, c.alpha)
> iso_b(color c -> color) -> rgba(0, 0, c.blue, c.alpha)
> 
> greyscale(color c -> color) {
>   int avg = (c.red + c.green + c.blue) / 3;
>   return rgba(avg, avg, avg, c.alpha);
> }
> ```

> **Planned:**
> 
> Future language versions may support a similar syntax for referencing global functions<sup>[§TODO - global functions]()</sup> and namespace functions<sup>[§TODO - namespace functions]()</sup>.
> 
> * `::max`
> * `$Math::tan`

## 4.9 – Anonymous functions

**Anonymous functions**, also known as **lambda expressions**, are functions defined without a name within the body of another function.

They are matched by the following production rule from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... higher precedence productions)
> * &lt;lambda_params&gt; &lt;lambda_body&gt;
> * (... lower precedence productions)
> 
> **_&lt;lambda_params&gt;_:**
> * `(` `)`
> * &lt;ident&gt;
> * `(` &lt;ident&gt; ( `,` &lt;ident&gt; )\+ `)`
> 
> **_&lt;lambda_body&gt;_:** `->` ( &lt;body&gt; | &lt;expr&gt; )

Parameters of anonymous functions do not have their types explicitly declared. As anonymous functions are expressions, they are used in contexts where values or objects of a particular type are expected. As such, the types of their parameters can be inferred.

> **Example:**
> 
> ```js
> () {
>   (string, string -> string) string_function = 
>           (a, b) -> flip_coin() ? a + b : b + " " + a; // anon. function definition
> 
>   string result = string_function.call("race", "car"); // call()
>   print(result);
> }
> ```
> 
> This script has a 50% chance of printing `racecar` and a 50% chance of printing `car race`.
> 
> The anonymous function `(a, b) -> ...` is defined in the initialization<sup>[§3.2.2](#322--initialization)</sup> statement for the variable `string_function` with the functional type<sup>[§2.4](#24--functional-types)</sup> `(string, string -> string)`. This context lets the compiler or interpreter to know that the parameters `a`, `b` are of type `string`, and that the anonymous function returns a value of type `string`.
 
Like helper function references<sup>[§4.8](#48--helper-function-references)</sup>, anonymous function expressions are function objects. Thus, they can be invoked with the special `call()` function<sup>[§TODO - `call` function]()</sup>, which accepts the function's arguments.

## 4.10 – Array and list elements

<!-- TODO - fix -->

Array and list elements can be accessed as expressions by using their **indices**.

Array and list element expressions are matched by the following production rule from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... higher precedence productions)
> * &lt;assignable&gt;
> * (... lower precedence productions)

**_&lt;assignable&gt;_:**
* (... higher precedence productions)
* &lt;ident&gt; `<` &lt;expr&gt; `>`
* &lt;ident&gt; `[` &lt;expr&gt; `]`

> **Planned:**
> 
> The current syntax grammar is overly restrictive, and only allows for array and list element expressions that are assignables: cases where the collection in the expression is a variable<sup>[§3.1](#31--variables)</sup>.
> 
> ```js
> () {
>   int[] arr = [ 1, 2, 3, 4 ];
>   print(arr[0]); // valid in language version 0.1.0
>   print([ 1, 2, 3, 4 ][0]); // syntax error
> 
>   int[][] arr2 = [ arr, [ 5, 6, 7, 8 ] ];
>   print(arr2[0][0]); // syntax error
> }
> ```
> 
> 
> Future language versions will change the syntax grammar rules that match array and list elements to something akin to this:
> 
>> **_&lt;expr&gt;_:**
>> * (... higher precedence productions)
>> * &lt;expr&gt; `[` &lt;expr&gt; `]`
>> * &lt;expr&gt; `<` &lt;expr&gt; `>`
>> * (... lower precedence productions)
> 
> That way, the syntax errors indicated above will be valid syntax.

**Array elements** are accessed with square brackets `[]`, and **list elements** are accessed with angle brackets `<>`.

> **Example:**
> 
> ```js
> () {
>   int[] arr = [1, 2, 3];
>   int first = arr[0]; // accesses the first element of the array
> 
>   string<> words = <>;
>   words.add("Able");
>   words.add("was");
>   words.add("I");
>   words.add("ere");
>   words.add("I");
>   words.add("saw");
>   words.add("Elba");
>   string last = words<#|words - 1>; // accesses the last element of the list
> }
> ```

> **Note:**
> 
> *DeltaScript* uses [zero-based numbering![](../assets/external.png)](https://en.wikipedia.org/wiki/Zero-based_numbering).

## 4.11 – Explicit collections

<!-- TODO - fix -->

**Explicit collections** are expressions that define collections directly by writing out their contents (elements or key-value pairs).

They are matched by the following productions of &lt;expr&gt; from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... higher precedence productions)
> * `{` &lt;kv_pairs&gt; `}`
> * `[` &lt;elements&gt;? `]`
> * `<` &lt;elements&gt;? `>`
> * `{` &lt;elements&gt;? `}`
> * (... lower precedence productions)
> 
> **_&lt;kv_pairs&gt;_:** &lt;kv_pair&gt; ( `,` &lt;kv_pair&gt; )\*
> 
> **_&lt;kv_pair&gt;_:** &lt;expr&gt; `:` &lt;expr&gt;
> 
> **_&lt;elements&gt;_:** &lt;expr&gt; ( `,` &lt;expr&gt; )\*

Each type of collection<sup>[§2.3](#23--collection-types)</sup> has a unique syntax:

* Maps<sup>[§2.3.4](#234--mapsdictionaries)</sup> are explicitly defined by outer curly braces `{}`. Key-value pairs are comma-separated `,`. The key and value in a pair are separated by a colon `:`, with the key to the left of the colon and the value to the right.
* Arrays<sup>[§2.3.1](#231--arrays)</sup> are explicitly defined by outer square brackets `[]`. Elements are comma-separated `,`.
* Lists<sup>[§2.3.2](#232--lists)</sup> are explicitly defined by outer angle brackets `<>`. Elements are comma-separated `,`.
* Sets<sup>[§2.3.3](#233--sets)</sup> are explicitly defined by outer curly braces `{}`. Elements are comma-separated `,`.

> **Example:**
> 
> ```js
> () {
>   ~ float PI_APPROX = 3.1415;
> 
>   int[] arr = [ 1, 2, 3, 4 ];
>   float{} set = { 1.0 - 0.5, PI_APPROX, 4f, 7.9 };
>   string<> list = <"This", "is", "a", "list">;
>   {char : int} map = { 'a' : 1, 'b' : 2, 'j' : (int) 'j' - (int) 'a' + 1, 'z' : 26 };
> }
> ```
> 
> * `arr` - explicit integer array
> * `set` - explicit set of floating-point numbers
> * `list` - explicit list of strings
> * `map` - explicit map of character to integer associations
> 
> Note the use of non-literal expressions like `PI_APPROX` and `(int) 'j' - (int) 'a' + 1` within the explicit collections.

## 4.12 – Collection initializers

**Collection initializers** are special ways of creating empty collections. Only arrays<sup>[§2.3.1](#231--arrays)</sup> and maps<sup>[§2.3.4](#234--mapsdictionaries)</sup> have collection initializers.

They are matched by the following productions of &lt;expr&gt; from the syntax grammar<sup>[§1.2.2](#122--syntax-grammar)</sup>:

> **_&lt;expr&gt;_:**
> * (... higher precedence productions)
> * `new` &lt;type&gt; `[` &lt;expr&gt; `]`
> * `new` `{` &lt;type&gt; `:` &lt;type&gt; `}`
> * (... lower precedence productions)

<br>

To create an empty **array** `T[]` with `n` elements, where `T` is an abstract type representing the type of elements in the array, and `n` is an expression that evaluates to a non-negative `int`:

```js
new T[n]
```

<br>

To create an empty **map** `{K:V}`, where `K` is an abstract type representing the type of keys in the map, and `V` is an abstract type representing the type of the map's values:

```js
new {K:V}
```

<br>

> **Example:**
> 
> ```js
> () {
>   final int ALLOWANCE = 10;
> 
>   string[] words = new string[5];
>   int[] nums = new int[rand(3, 7)];
>   (int -> char)[] int_to_char_fs = new (int -> char)[ALLOWANCE - 2];
> 
>   {string : char[]} str_to_letters = new {string : char[]};
>   {(-> int) : int} first_output = new {(-> int) : int};
> }
> ```
> 
> * `words` - an empty string array with 5 allocated elements
> * `nums` - an empty integer array with between 3 and 6 allocated elements
> * `int_to_char_fs` - an empty array of integer to character functions with 8 (`ALLOWANCE - 2`) allocated elements
> * `str_to_letters` - an empty map of string to character array mappings
> * `first_output` - an empty map of integer-returning function to integer mappings

---

## Footnotes

* <sup id="fn-a">a</sup> - `T` represents an arbitrary element type
* <sup id="fn-b">b</sup> - `K` represents an arbitrary type for keys of the map, while `V` represents an arbitrary type for values of the map
* <sup id="fn-c">c</sup> - `a` and `b` are both arbitrary expressions of the type indicated by the row of the table
* <sup id="fn-d">d</sup> - The rule &lt;sub_ident&gt; is adapted slightly for the sake of brevity

# Glossary

This page provides succinct definitions for terms used throughout the documentation. Links followed by the symbol ![](../assets/definition.png) will lead to glossary entries on this page.

## Sections

* [A](#a)
* [B](#b)
* [C](#c)
* [D](#d)
* [E](#e)
* [F](#f)
* [G](#g)
* [H](#h)
* [I](#i)
* [J](#j)
* [K](#k)
* [L](#l)
* [M](#m)
* [N](#n)
* [O](#o)
* [P](#p)
* [Q](#q)
* [R](#r)
* [S](#s)
* [T](#t)
* [U](#u)
* [V](#v)
* [W](#w)
* [X](#x)
* [Y](#y)
* [Z](#z)

## A

### Append

To insert/attach after or at the end.

> **Example:**
> 
> **Appending** the letter "s" to the word "farm" results in the word "farms".

> **See also:**
> * [Prepend](#prepend)

## B

### Base language

The core specification of *DeltaScript* and its implementations, in contrast to extensions of the language.

### Built-in

Included in the [base language![](../assets/definition.png)](#base-language).

## C

### C-like syntax

A programming language that uses many of the syntactical conventions pioneered by and/or associated with [C![](../assets/external.png)](https://en.wikipedia.org/wiki/C_(programming_language)), such as: 
* semicolons `;` as statement terminators
* function parameters delimited by parentheses `()`
* code blocks / scopes delimited by curly brackets `{}`

A list of such languages can be found [here![](../assets/external.png)](https://en.wikipedia.org/wiki/List_of_C-family_programming_languages).

### Control flow

<!-- TODO -->

## D

## E

## F

## G

### Global function

<!-- TODO -->

## H

## I

### Identifier

The name of a variable, helper function, function parameter, extension type, extension type property, member function, or extension namespace.

## J

## K

## L

### Length

The number of characters in a string or the number of elements in an array. When referring to the number of elements in a list or a set, the term [size![](../assets/definition.png)](#size) is used instead.

The length/size operator in *DeltaScript* is `#|`.

> **Example:**
> 
> ```js
> () {
>     string word = "foo";
>     print(#|word); // Prints "3"
> }
> ```

### LHS

An acronym for **left-hand side**.

Refers to the side of a statement<sup>[§5](./ls-5-stat.md)</sup> or expression<sup>[§4](#chapter-4--expressions)</sup> that lies to the left of an operator.

> **Example:**
> 
> ```js
> some_var = "Some " + "concatenated " + "string";
> ```
> 
> This assignment statement has a LHS of `some_var` and a [RHS![](../assets/definition.png)](#rhs) of `"Some " + "concatenated " + "string"`.

## M

### Member function

<!-- TODO -->

## N

## O

### Object

<!-- TODO -->

### Opacity

How **opaque** a color is. Opacity is the complementary property to transparency, just as darkness is to brightness.

## P

### Prepend

To insert/attach prior or at the beginning.

> **Example:**
> 
> **Prepending** the letter "a" to the word "blaze" results in the word "ablaze".

> **See also:**
> * [Append](#append)

### Property

A constant attribute of an [object![](../assets/definition.png)](#object) defined by its type.

> **Example:**
> 
> ```js
> () {
>     color c = #ffffff; // assigns c to the color white (hex code #ffffff)
>     print(c.red); // Prints the value of the "red" property of c (255 in this case)
> }
> ```
> 
> In this example, [`red`](./color-sl.md#red) is a property defined by the type [`color`](./color-sl.md). Thus, the property can be referenced on all objects of the type.

## Q

## R

### RHS

An acronym for **right-hand side**.

Refers to the side of a statement<sup>[§5](./ls-5-stat.md)</sup> or expression<sup>[§4](#chapter-4--expressions)</sup> that lies to the right of an operator.

> **Example:**
> 
> ```js
> some_var = "Some " + "concatenated " + "string";
> ```
> 
> This assignment statement has a [LHS![](../assets/definition.png)](#lhs) of `some_var` and a RHS of `"Some " + "concatenated " + "string"`.

## S

### Semantic equivalence

Two or more expressions or units of code that have the same **meaning** and **behaviour** under the hood.

### Size

The number of elements in a list or a set. When referring to the number of elements in an array, or the number of characters in a `string`, the term [length![](../assets/definition.png)](#length) is used instead.

The size/length operator in *DeltaScript* is `#|`.

> **Example:**
> 
> ```js
> () {
>     string<> words = < "quick", "brown" >; // initializes a list of strings
>     print(#|words); // Prints "2"
>     words.add("A", 0);
>     words.add("fox");
>     print(#|words); // Prints "4"
> }
> ```

## T

## U

## V

## W

## X

## Y

## Z
