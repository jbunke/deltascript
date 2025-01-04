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

<!-- TODO -->

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
    
    Here

<!-- TODO -->

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
    
    Here

<!-- TODO -->

## Color constructors

### `rgb`

```js
rgb(int r, int g, int b) -> color
```
**Description:**

<!-- TODO -->

**Note:**

`rgb(r, g, b)` is [semantically equivalent![](../assets/definition.png)](./glossary.md#semantic-equivalence) to [`rgba(r, g, b, 255)`](#rgba).

### `rgba`

```js
rgba(int r, int g, int b, int alpha) -> color
```
**Description:**

<!-- TODO -->

## Image constructors

### `new_image_of`

```js
new_image_of(int width, int height) -> image
```
**Description:**

<!-- TODO -->

**Triggers runtime error(s):**

<!-- TODO -->

### `read_image`

```js
read_image(string filepath) -> image
```
**Description:**

<!-- TODO -->

## I/O functions

### `print`

```js
print(T message);
```
**Conventions:** [`T`](#t)

**Description:**

<!-- TODO -->

### `prompt`

```js
prompt(T message) -> string
```
**Conventions:** [`T`](#t)

**Description:**

<!-- TODO -->

### `read`

```js
read() -> string
```
**Description:**

<!-- TODO -->

---

## Arbitrary type conventions

### `T`

<!-- TODO - links to language specification -->

`T` represents an arbitrary type. Note that `T` **can theoretically be ANY type**. This includes [simple types](), [collection types](), or [functional types]().

### `N`

`N` represents a numeric type, whether `float` or `int`. Repeated uses of `N` in the same function type signature suggest that:
1. the same numeric type must be provided for each argument of type `N`
2. the return type will match the argument type

### `C`

`C(T)` represents an arbitrary collection of some type `T` of elements. `C(T)` can represent an array `T[]`, a list `T<>`, or a set `T{}`.
