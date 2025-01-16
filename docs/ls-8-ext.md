[**< Language Specification**](./lang-spec.md)

# Chapter 8 – Extensions

## Contents

* [**8.1**](#81--extensions-philosophy) – Extensions philosophy
* [**8.2**](#82--extensions) – Extensions
* [**8.3**](#83--types-in-extensions) – Types in extensions
  * [**8.3.1**](#831--new-types) – New types
  * [**8.3.2**](#832--extending-built-in-types) – Extending built-in types
* [**8.4**](#84--namespaces) – Namespaces

---

This chapter describes the philosophy behind, as well as the scope and possible features of, extensions to the *DeltaScript* [base language![](../assets/definition.png)](./glossary.md#base-language).

## 8.1 – Extensions philosophy

Having gotten this far through the language specification, or perhaps even at a glance, an experienced programmer may ask themselves why *DeltaScript* is designed in the way that it is, not providing the features of a modern [general-purpose programming language![](../assets/external.png)](https://en.wikipedia.org/wiki/General-purpose_programming_language) (GPL) that let programmers create data structures and types on the fly, but rather opting for additional functionality to be implemented via specific extensions to the language, built on top of a *DeltaScript* language implementation in a programming language other than *DeltaScript* itself.

**_DeltaScript_ is extremely restrictive by design**. The language was designed for experienced programmers and non-programmers alike, for use as an embedded scripting language in specific application domains.

Let us take [*Stipple Effect*![](../assets/external.png)](https://stipple-effect.github.io/), the project that [motivated](./ls-intro.md#motivation) the creation of *DeltaScript*, as an example. *Stipple Effect* is a pixel art editor: a [raster graphics![](../assets/external.png)](https://en.wikipedia.org/wiki/Raster_graphics) editor with a feature set specifically designed for creating [pixel art![](../assets/external.png)](https://en.wikipedia.org/wiki/Pixel_art) assets for video games and online distribution. Such features include multi-frame and multi-layer projects, an animation timeline, dithering, and numerous others. *Stipple Effect*'s killer feature is [preview scripting![](../assets/external.png)](https://stipple-effect.github.io/docs/preview-scripts): the user can write a simple transformation script that takes as input the current project as it is, and returns a transformation that will be displayed in the preview window alongside the primary workspace. This transformation can merely act as a visual aid to help the user work, or can itself be converted into a full-fledged project. This has countless applications: animating a sprite sheet in real time, applying a shader, simulating dynamic lighting of a character or environment, etc.

Thus, scripts written for *Stipple Effect* ought to have a narrow scope. Generally, anything achievable in the program via script is either the programmatic invocation of a program action (e.g. creating a new layer) or some graphical or rendering behaviour.

Thus, the set of types<sup>[§2](./ls-2-types.md)</sup> and non-user-defined functions<sup>[§6.1](./ls-6-func.md#61--functions)</sup> available should be finite and restricted to the context of the application. This makes scripting a more accessible feature for non-programmers who might be otherwise overwhelmed by the sheer possibilities that exist when writing scripts in a GPL.

## 8.2 – Extensions

In practice, an **extension to _DeltaScript_** is a [domain-specific language![](../assets/external.png)](https://en.wikipedia.org/wiki/Domain-specific_language) that borrows *DeltaScript*'s syntax<sup>[§1.2](./ls-1-syntax.md#12--grammars)</sup> and [ubiquitous![](../assets/definition.png)](./glossary.md#ubiquitous-function) built-in functions from the [standard library](./std-lib.md) as a foundation to build upon. They are intended for use as embedded scripting languages that execute scripts written by users for particular applications.

Extensions can add the following language features:

* New types<sup>[§8.3.1](#831--new-types)</sup>
* New member functions<sup>[§1.2](./ls-1-syntax.md#12--grammars)</sup> and properties<sup>[§4.7.3](./ls-4-expr.md#473--scoped-function-calls)</sup> of types included in the [base language![](../assets/definition.png)](./glossary.md#base-language)
* Namespaces<sup>[§8.4](#84--namespaces)</sup>

This chapter will use the [*Stipple Effect* scripting API](https://stipple-effect.github.io/api/)<sup>[a](#fn-a)</sup> (the first *DeltaScript* extension) for practical examples of each of the extension language features.

## 8.3 – Types in extensions

### 8.3.1 – New types

**New types** defined in extensions are simple types<sup>[§2.2](./ls-2-types.md#22--simple-types)</sup> that represent objects not represented by the built-in types<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup>.

They are matched by the following production of &lt;type&gt; from the syntax grammar<sup>[§1.2.2](./ls-1-syntax.md#122--syntax-grammar)</sup>:

> **_&lt;type&gt;_:**
> * (... higher precedence productions)
> * &lt;ident&gt;

New types can define their own **definition of equality** for use by the equality `==` and inequality `!=` operators<sup>[§4.5.2](./ls-4-expr.md#452--binary-operators)</sup>.

They may also define member functions<sup>[§6.3.5](./ls-6-func.md#635--member-functions)</sup> and properties<sup>[§4.7.3](./ls-4-expr.md#473--scoped-function-calls)</sup>.

> **Example from _Stipple Effect_:**
> 
> *Stipple Effect* defines the following new types:
> * [`layer`![](../assets/external.png)](https://stipple-effect.github.io/api/layer) - Represents a [layer![](../assets/external.png)](https://stipple-effect.github.io/docs/layer) of a *Stipple Effect* project
> * [`light`![](../assets/external.png)](https://stipple-effect.github.io/api/light) - Represents a point light or directional light
> * [`palette`![](../assets/external.png)](https://stipple-effect.github.io/api/palette) - Represents a *Stipple Effect* [color palette![](../assets/external.png)](https://stipple-effect.github.io/docs/palette)
> * [`project`![](../assets/external.png)](https://stipple-effect.github.io/api/project)
> * [`save_config`![](../assets/external.png)](https://stipple-effect.github.io/api/save_config) - Represents the save or export configuration of a *Stipple Effect* project
> * [`script`![](../assets/external.png)](https://stipple-effect.github.io/api/script) - Represents a validated *DeltaScript* script file; used to permit the execution of scripts from within other scripts

### 8.3.2 – Extending built-in types

Extensions may also extend the functionality of built-in types<sup>[§2.2.1](./ls-2-types.md#221--built-in-types)</sup> with new member functions<sup>[§6.3.5](./ls-6-func.md#635--member-functions)</sup> and properties<sup>[§4.7.3](./ls-4-expr.md#473--scoped-function-calls)</sup>.

> **Example from _Stipple Effect_:**
> 
> *Stipple Effect* defines three new properties for the type `color`. For an arbitrary `color` object `C`:
> 
> * [`C.hue -> float`![](../assets/external.png)](https://stipple-effect.github.io/api/color#hue-hue)
> * [`C.sat -> float`![](../assets/external.png)](https://stipple-effect.github.io/api/color#saturation-sat)
> * [`C.val -> float`![](../assets/external.png)](https://stipple-effect.github.io/api/color#value-val)

## 8.4 – Namespaces

**Namespaces** are identifiers [prepended![](../assets/definition.png)](./glossary.md#prepend) with `$` that act as packages for related functions<sup>[§6.1](./ls-6-func.md#61--functions)</sup> and constants<sup>[§4.7.3](./ls-4-expr.md#473--scoped-function-calls)</sup> in an extension.

Functions defined as part of a namespace may be either value-returning<sup>[§6.2.1](./ls-6-func.md#621--value-returning-functions)</sup> or void<sup>[§6.2.2](./ls-6-func.md#622--void-functions)</sup>.

> **Example from _Stipple Effect_:**
> 
> *Stipple Effect* defines the following namespaces:
> * [`$SE`![](../assets/external.png)](https://stipple-effect.github.io/api/global) - used to interface with most program actions
> * [`$Graphics`![](../assets/external.png)](https://stipple-effect.github.io/api/graphics)
> * [`$Math`![](../assets/external.png)](https://stipple-effect.github.io/api/math)
> 
> ```js
> () {
>   string first_10_digits = ((string) $Math.PI).sub(0, 10); // $Math.PI is a constant
>   print(first_10_digits);
> 
>   project p = $SE.get_project();
>   p.save();
> }
> ```
> 
> * `$Math.PI` is a constant of the `$Math` namespace
> * `$SE.get_project() -> project` is a function of the `$SE` namespace that retrieves the project that is currently being edited in the *Stipple Effect* [GUI![](../assets/external.png)](https://en.wikipedia.org/wiki/Graphical_user_interface)

---

## Footnotes

* <sup id="fn-a">a</sup> - Examples are from *Stipple Effect* v1.2.2 and accurate as of the date of publication of the specification.
