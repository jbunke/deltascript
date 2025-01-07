[**< Standard Library**](./std-lib.md)

# Global functions

This page describes the [**global functions**![](../assets/definition.png)](./glossary.md#global-function) included in the standard library.

## Contents

* [`abs`](#abs)
* [`clamp`](#clamp)
* [`flip_coin`](#flip_coin)
* [`max`](#max)
* [`min`](#min)
* [`new_image_of`](#new_image_of)
* [`print`](#print)
* [`prob`](#prob)
* [`prompt`](#prompt)
* [`rand`](#rand)
* [`read`](#read)
* [`read_image`](#read_image)
* [`rgb`](#rgb)
* [`rgba`](#rgba)

**Note:**

Functions of the form `name(params*);` are **void functions** (functions that perform an action but return nothing), while functions of the form `name(params*) -> return_type` **return a value** of the type `return_type`.

`params*` represents a list of zero or more comma-separated [parameters![](../assets/external.png)](https://en.wikipedia.org/wiki/Parameter_(computer_programming)).

---

## Probability & RNG functions

### `flip_coin`

```js
flip_coin() -> bool
```
**Description:**

Has an equal chance of returning `true` or `false`.

**Note:**

`flip_coin()` is [semantically equivalent![](../assets/definition.png)](./glossary.md#semantic-equivalence) to [`prob(0.5)`](#prob).

### `prob`

```js
prob(float p) -> bool
```

**Description:**

Generates a random value ranging from 0 to 1. Returns `true` if and only if `p` is greater than the value generated, `false` otherwise.

### `rand`

1.  ```js
    rand() -> float
    ```
    **Description:**

    Generates and returns a random `float` ranging from `0.0` to `1.0`.

2.  ```js
    rand(N min, N max_ex) -> N

    // Concretely:
    rand(float min, float max_ex) -> float
    rand(int min, int max_ex) -> int
    ```
    **Conventions:** [`N`](#n)

    **Description:**

    Generates and returns a random value ranging from `min` to `max_ex`.

    **Note:**

    `max_ex` is an **exclusive** maximum bound. `rand(min, max_ex)` will never return `max_ex`.

## Other mathematical functions

### `abs`

```js
abs(N value) -> N

// Concretely:
abs(float value) -> float
abs(int value) -> int
```
**Conventions:** [`N`](#n)

**Description:**

Returns the absolute value (magnitude) of `value`.

### `clamp`

```js
clamp(N min, N value, N max) -> N

// Concretely:
clamp(float min, float value, float max) -> float
clamp(int min, int value, int max) -> int
```
**Conventions:** [`N`](#n)

**Description:**

Returns `value` if it is between `min` and `max`. If `value` is less than `min`, returns `min`. If `value` is greater than `max`, returns `max`.

### `max`

1.  ```js
    max(C(N) collection) -> N

    // Concretely:
    max(float[] collection) -> float
    max(float<> collection) -> float
    max(float{} collection) -> float
    max(int[] collection) -> int
    max(int<> collection) -> int
    max(int{} collection) -> int
    ```
    **Conventions:** [`C`](#c), [`N`](#n)

    **Description:**
    
    Returns the element from `collection` with the highest value.

2.  ```js
    max(N a, N b) -> N

    // Concretely:
    max(float a, float b) -> float
    max(int a, int b) -> int
    ```
    **Conventions:** [`N`](#n)

    **Description:**
    
    Returns the greater of the two values `a` and `b`.

### `min`

1.  ```js
    min(C(N) collection) -> N

    // Concretely:
    min(float[] collection) -> float
    min(float<> collection) -> float
    min(float{} collection) -> float
    min(int[] collection) -> int
    min(int<> collection) -> int
    min(int{} collection) -> int
    ```
    **Conventions:** [`C`](#c), [`N`](#n)

    **Description:**
    
    Returns the element from `collection` with the lowest value.

2.  ```js
    min(N a, N b) -> N

    // Concretely:
    min(float a, float b) -> float
    min(int a, int b) -> int
    ```
    **Conventions:** [`N`](#n)

    **Description:**
    
    Returns the lesser of the two values `a` and `b`.

## Color constructors

### `rgb`

```js
rgb(int r, int g, int b) -> color
```
**Description:**

Creates a 32-bit RGBA `color` from its red, green, and blue components. The alpha/opacity channel is allocated a value of 255, which represents a fully opaque color.

**Parameters:**

* `int r` - The red color channel. An integer between 0 and 255 (inclusive).
* `int g` - The green color channel. An integer between 0 and 255 (inclusive).
* `int b` - The blue color channel. An integer between 0 and 255 (inclusive).

**Triggers runtime error(s):**

This function will trigger a runtime error that will terminate script execution if any of the following conditions are met:

* `r < 0` or `r > 255`
* `g < 0` or `g > 255`
* `b < 0` or `b > 255`

**Note:**

`rgb(r, g, b)` is [semantically equivalent![](../assets/definition.png)](./glossary.md#semantic-equivalence) to [`rgba(r, g, b, 255)`](#rgba).

### `rgba`

```js
rgba(int r, int g, int b, int alpha) -> color
```
**Description:**

Creates a 32-bit RGBA `color` from its red, green, blue, and alpha/opacity components.

**Parameters:**

* `int r` - The red color channel. An integer between 0 and 255 (inclusive).
* `int g` - The green color channel. An integer between 0 and 255 (inclusive).
* `int b` - The blue color channel. An integer between 0 and 255 (inclusive).
* `int alpha` - The alpha (opacity) channel. An integer between 0 and 255 (inclusive).

**Triggers runtime error(s):**

This function will trigger a runtime error that will terminate script execution if any of the following conditions are met:

* `r < 0` or `r > 255`
* `g < 0` or `g > 255`
* `b < 0` or `b > 255`
* `alpha < 0` or `alpha > 255`

## Image constructors

### `new_image_of`

```js
new_image_of(int width, int height) -> image
```
**Description:**

Creates a new image with the specified `width` and `height`.

**Parameters:**

* `int width` - The width of the new image in pixels.
* `int height` - The height of the new image in pixels.

**Triggers runtime error(s):**

This function will trigger a runtime error that will terminate script execution if any of the following conditions are met:

* `width <= 0`
* `height <= 0`

### `read_image`

```js
read_image(string filepath) -> image
```
**Description:**

Reads an image from the specified `filepath` and returns it as an `image` object.

**Triggers runtime error(s):**

This function will trigger a runtime error that will terminate script execution if any of the following conditions are met:

* `filepath` does not point to a readable raster image in the local file system

## I/O functions

### `print`

```js
print(T message);
```
**Conventions:** [`T`](#t)

**Description:**

Prints `message` to the standard output on its own line.

**Parameters:**

* `T message` - The message to be printed. Can be of any type; converted to `string` internally. However, keep in mind that objects of certain types – functional types, notably – are not always suitable for textual representation.

### `prompt`

```js
prompt(T message) -> string
```
**Conventions:** [`T`](#t)

**Description:**

Displays `message` to the user and waits for input. Returns the input as a `string`.

**Parameters:**

* `T message` - The message to be displayed. Can be of any type; converted to `string` internally. However, keep in mind that objects of certain types – functional types, notably – are not always suitable for textual representation.

### `read`

```js
read() -> string
```
**Description:**

Reads a line of input from the standard input and returns it as a `string`.

**Note:**

This function waits for the user to press <kbd>Enter</kbd> before returning the input.

---

## Arbitrary type conventions

### `T`

<!-- TODO - links to language specification -->

`T` represents an arbitrary type. Note that `T` **can theoretically be ANY type**. This includes [simple types](), [collection types](), or [functional types]().

### `N`

`N` represents a numeric type, whether `float` or `int`. Repeated use of `N` in the same function type signature means that:

* arguments of the same numeric type must be provided for each parameter of type `N`
* the return type `N` will match the parameter type `N`

### `C`

`C(T)` represents an arbitrary collection of some type `T` of elements. `C(T)` can represent an array `T[]`, a list `T<>`, or a set `T{}`.
