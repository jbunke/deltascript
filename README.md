# DeltaScript <!-- TODO - language banner here instead: ![DeltaScript](link) -->

DeltaScript is a lightweight scripting language skeleton that is designed to be easily extended for the **specification and implementation of [domain-specific languages](https://en.wikipedia.org/wiki/Domain-specific_language)** with a shared syntax.

## Documentation

* [Language specification](/docs/lang-spec)
* [Other documentation](/docs/about)

## Implementation

The main implementation of DeltaScript is an interpreter targetting Java. It can be found in the `script` module of [Delta Time](https://github.com/jbunke/delta-time), a general-purpose Java framework for developing GUI programs and games that is in active development.

## Overview

DeltaScript is the result of a vision of a concise, yet statically typed C-style scripting language.

### Extensibility

DeltaScript's grammar and design ensure that it can be easily extended by its implementing DSLs with **types** and **function bindings**.

Consider the [Stipple Effect API](https://github.com/jbunke/se-api) for an example of an extension to the DeltaScript base language.

### Single source file execution instances

DeltaScript files consist of a nameless **header function** followed by optional named **helper functions**. The header function marks the entry point of the script, and the type signature of the header function is the type signature of the script overall.

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

DeltaScript is statically typed, so type checking is performed at compile-time.

### Clear, concise syntax

DeltaScript is designed to be concise while still ensuring syntax conveys meaning.

For example, the various collection data types in DeltaScript are not referenced by name in code, but rather by different types of brackets.

For collections with elements of type `T`:

* list: `T<>` - ordered collection that can grow and shrink
* array: `T[]` - ordered collection of fixed size
* set: `T{}` - unordered collection that can grow and shrink

A map/dictionary with keys of type `K` and values of type `V`: `{ K : V }`

### Syntactical shorthands

DeltaScript features a few shorthands to write less code.

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

Functions can be stored as variables in DeltaScript.

```js
// accepts an input color as a parameter
// returns a list of colors transformed from input in various ways
(~ color input -> color<>) {
    ~ (color -> color) color_functions = [
         ::red, ::green, ::blue, ::greyscale, ::random_color, ::white
    ];
    ~ color<> channels = new color<>;

    for ((color -> color) f in color_functions)
        channels.add(f.call(input));

    return channels;
}

// helper functions that transform a color
greyscale(~ color c -> color) {
    int avg = (c.r + c.g + c.b) / 3;
    return rgba(avg, avg, avg, c.a);
}

// white(), random_color() match signature of other helpers but ignore parameter
// uses the hex code color literal #ffffff - white - RGB[255, 255, 255]
white(~ color c -> color) -> #ffffff;
random_color(~ color c -> color) -> rgba(rc(), rc(), rc(), 0xff)
// uses the hexadecimal integer literal 0x100 = 256
rc(-> int) -> rand(0, 0x100)

// isolate a color's RGB channels
red(~ color c -> color) -> rgba(c.r, 0, 0, c.a)
green(~ color c -> color) -> rgba(0, c.g, 0, c.a)
blue(~ color c -> color) -> rgba(0, 0, c.b, c.a)
```

## Use cases

DeltaScript is used in the following projects:
* [Stipple Effect](https://github.com/jbunke/stipple-effect) - scriptable pixel art editor
