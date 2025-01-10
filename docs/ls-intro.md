[**< Language Specification**](./lang-spec.md)

# Introduction

## Contents

* [Motivation](#motivation)
* [About the specification](#about-the-specification)
  * [Notation and conventions](#notation-and-conventions)
  * [Language status and compatibility](#language-status-and-compatibility)
  * [Overview of the specification](#overview-of-the-specification)

## Motivation

*DeltaScript* was first developed as a domain-specific scripting language for [*Stipple Effect*![](../assets/external.png)](https://github.com/stipple-effect/stipple-effect), a pixel art editor that makes extensive use of scripting for automation and for transforming project contents.

Eventually, the *Stipple Effect* codebase was extensively refactored. The core of the scripting language implementation was ripped out and reimplemented in the underlying library that served as an external dependency for *Stipple Effect*, and the language features deemed specific to the context of *Stipple Effect* were implemented in its codebase as an extension to the [base language![](../assets/definition.png)](./glossary.md#base-language). The idea was that, this way, the base language would be reuseable for multiple projects, with application-specific behaviours and features implemented as extensions.

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

The question mark icon ( ![](../assets/definition.png) ) indicates that the link leads to the **[glossary](./glossary.md) entry** for the highlighted term. These are terms that are used repeatedly throughout the specification that warrant a definition. The glossary link will usually appear when such a term is used for the first time in a given section.

The arrow leaving a box icon ( ![](../assets/external.png) ) indicates that a link is an **external link**. That is, it links to a webpage beyond the *DeltaScript* documentation. Oftentimes such links will be to Wikipedia articles that expand on a term or concept referenced in the specification.

**Section links:**

At various points throughout the specification are superscripted links with section numbers. Such links begin with the section sign ( § ) and link to that section of the specification.

**Code snippets:**

Code snippets are multi-line segments of the specification that appear in monospaced font. Unless otherwise specified, code inside a code snippet is written in *DeltaScript*. Unless a particular language extension is referenced, the code can be assumed to be written in the [base language![](../assets/definition.png)](./glossary.md#base-language).

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
