# *DeltaScript* <!-- TODO - language banner here instead: ![DeltaScript](link) -->

*DeltaScript* is a lightweight scripting language skeleton that is designed to be easily extended for the **specification and implementation of [domain-specific languages![](./assets/external.png)](https://en.wikipedia.org/wiki/Domain-specific_language)** with a shared syntax.

## Documentation

* [Language specification](./docs/lang-spec.md): a formal document outlining the rules governing *DeltaScript*'s intended behaviour
* [Standard library](./docs/std-lib.md): descriptions of *DeltaScript*'s built-in functions

## Implementation

The official implementation of *DeltaScript* is an interpreter targetting Java. It can be found in the `script` module of [*Delta Time*![](./assets/external.png)](https://github.com/jbunke/delta-time), a general-purpose Java framework for developing GUI programs and games that is in active development.

## Use cases

*DeltaScript* is notably used and extended in the following projects:
* [*Stipple Effect*![](./assets/external.png)](https://github.com/jbunke/stipple-effect) - scriptable pixel art editor [**\[ extension specification \]**![](./assets/external.png)](https://jbunke.github.io/se/api)

## Overview

*DeltaScript* is the fruition of my vision of a concise, statically typed scripting language with a C-style syntax.

### Extensibility

*DeltaScript*'s design ensures that it can be easily extended by the programs that use it additional with **types** and **built-in functions organized in namespaces**.

Consider the [*Stipple Effect* scripting API specification![](./assets/external.png)](https://jbunke.github.io/se/api) for an example of an extension to the DeltaScript base language.

### Single source file execution instances

*DeltaScript* files consist of a nameless **header function** followed by optional named **helper functions**. The header function marks the entry point of the script, and the type signature of the header function is the type signature of the script overall.

The header function is nameless, so it cannot be called internally.

```js
// header function - this is the entry point of the script's execution
// * has a single parameter "letters"
// * returns a string
(int letters -> string) {
    string word = "";

    for (int i = 0; i < letters; i++)
        word += random_letter();

    return word;
}

// helper function "random_letter"
// * has no parameters
// * returns a char
random_letter(-> char) {
    ~ int MIN = (int) 'a';
    ~ int MAX_EX = ((int) 'z') + 1;

    // "rand" is a native function defined by DeltaScript
    return (char) rand(MIN, MAX_EX);
}
```

### Static typing

<!-- TODO - link to type checking in the language specification -->

*DeltaScript* is statically typed, so [type checking](#) is performed before scripts are executed.

### Clear, concise syntax

*DeltaScript* is designed to be concise, while still ensuring syntax conveys meaning.

<!-- TODO - link to collection types in the language specification -->

For example, the various [collection data types](#) supported by the language are not referenced by name in code, but rather by different types of brackets.

For collections with elements of type `T`:

* **Array**: `T[]` - ordered collection of fixed length
* **List**: `T<>` - ordered collection that can grow and shrink
* **Set**: `T{}` - unordered collection that can grow and shrink

A **map/dictionary** with keys of type `K` and values of type `V`: `{K:V}`

### Syntactical shorthands

*DeltaScript* features a few shorthands to write less code.

1. The `final` keyword is prepended to a variable declaration to mark the variable as immutable, but can also be written as `~`.
2.  The following functions are equivalent:
    ```js
    roll_dice(-> int) {
        return rand(1, 7);
    }
    ```
    ```js
    roll_dice(-> int) -> rand(1, 7)
    ```

### Function pointers and functional types

Functions can be stored as variables in *DeltaScript*.

```js
// accepts an input color as a parameter
// returns a list of colors transformed from input in various ways
(~ color input -> color<>) {
    ~ (color -> color)[] color_functions = [
         c -> rgba(c.r, 0, 0, c.a),     // isolate red channel
         c -> rgba(0, c.g, 0, c.a),     // isolate green channel
         ::iso_blue,                    // reference to function "iso_blue"
         c -> {
            int avg = (c.r + c.g + c.b) / 3;
            return rgba(avg, avg, avg, c.a);
         },                             // greyscale of color
         c -> rgb(rc(), rc(), rc()),    // random opaque color
         c -> #ffffff                   // the color white
    ];
    ~ color<> channels = <>;            // initializes an empty list of colors

    // iterates through the (color -> color) functions in color_functions
    // calls each function with "input" as input and appends its
    //   return value to "channels"
    for (f in color_functions)
        channels.add(f.call(input));

    return channels;
}

// helper function to isolate the blue channel of a color
iso_blue(~ color c -> color) -> rgba(0, 0, c.b, c.a)

// helper function to generate a random color channel value
// uses the hexadecimal integer literal 0x100 (= 256)
rc(-> int) -> rand(0, 0x100)
```
