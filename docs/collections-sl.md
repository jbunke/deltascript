[**< Standard Library**](./std-lib.md)

# Collection types

**Collection types** in *DeltaScript* are data structures that contain elements of particular types. There are three types of basic collections:

* [**Arrays**](#array): ordered collection of fixed [length![](../assets/definition.png)](./glossary.md#length)
* [**Lists**](#list): ordered collection with dynamic [size![](../assets/definition.png)](./glossary.md#size)
* [**Sets**](#set): unordered collection with dynamic size

Additionally, *DeltaScript* supports [**maps**](#mapdictionary) or **dictionaries**. A map is an associative collection that pairs **keys** of a given type with **values** of a given type. Values can be retrieved from a map by providing the matching key.

## Array

**Arrays** in *DeltaScript* are represented by **square brackets** `[]`. An array of elements of an arbitrary type `T` would be declared with the type `T[]`.

**Examples:**

* `int[]` - array of integers
* `color<>[]` - array of lists of colors
* `(string -> char)[]` - array of string to character functions

Definitions in this section will use `ARR` to represent an arbitrary array of type `T[]` with elements of an arbitrary type `T`.

---

### `has`

```js
ARR.has(T check) -> bool
```

**Description:**

Checks if `ARR` contains the element `check`. Returns `true` if `ARR` contains `check`, otherwise returns `false`.

## List

**Lists** in *DeltaScript* are represented by **angle brackets** `<>`. A list of elements of an arbitrary type `T` would be declared with the type `T<>`.

**Examples:**

* `int<>` - list of integers
* `color[]<>` - list of arrays of colors
* `(string -> char)[]` - list of string to character functions

Definitions in this section will use `LST` to represent an arbitrary list of type `T<>` with elements of an arbitrary type `T`.

---

### `add`

1.  ```js
    LST.add(T element);
    ```
    
    **Description:**
    
    Appends `element` to the end of `LST`.

2.  ```js
    LST.add(T element, int index);
    ```

    **Description:**

    Inserts `element` at the specified `index` in `LST`. The elements at and after the specified `index` will be shifted to the right to make space for the new element.
    
    **Note:**
    
    *DeltaScript* uses [zero-based numbering![](../assets/external.png)](https://en.wikipedia.org/wiki/Zero-based_numbering).


### `has`

```js
LST.has(T check) -> bool
```

**Description:**

Checks if `LST` contains the element `check`. Returns `true` if `LST` contains `check`, otherwise returns `false`.

### `remove`

```js
LST.remove(int index);
```

**Description:**

Removes the element at the specified `index` from `LST`. The elements that follow the removed element will be shifted to the left to fill the gap.

**Fails:**

This function will trigger a runtime error that will terminate script execution if any of the following conditions are met:

* `index < 0`
* `index >= #|LST`: `index` is greater than or equal to the size of `LST`

**Note:**

*DeltaScript* uses [zero-based numbering![](../assets/external.png)](https://en.wikipedia.org/wiki/Zero-based_numbering).

<!-- TODO - LST.remove(T element); -->

## Set

**Sets** in *DeltaScript* are represented by **curly brackets / braces** `{}`. A set of elements of an arbitrary type `T` would be declared with the type `T{}`.

**Examples:**

* `int{}` - set of integers
* `color[]{}` - set of arrays of colors
* `(string -> char){}` - set of string to character functions

Definitions in this section will use `SET` to represent an arbitrary set of type `T{}` with elements of an arbitrary type `T`.

---

### `add`

 ```js
SET.add(T element);
```

**Description:**

Adds `element` to `SET` if `SET` does not already contain `element`.

### `has`

```js
SET.has(T check) -> bool
```

**Description:**

Checks if `SET` contains the element `check`. Returns `true` if `SET` contains `check`, otherwise returns `false`.

<!-- TODO - SET.remove(T element); -->

## Map/dictionary

**Maps**, also known as **dictionaries**, are a collection type consisting of associations between **keys** and **values**. In *DeltaScript*, they are represented by **curly brackets / braces** and a **colon** separating their key and value types. A map of keys of an arbitrary type `K` and values of an arbitrary type `V` would be declared with the type `{K:V}`.

**Examples:**

* `{string:int}` - map with strings as keys and integers as values
* `{int:(-> color)}` - map with integers as keys and color-returning functions with no parameters as values

Definitions in this section will use `MAP` to represent an arbitrary map of type `{K:V}` with keys of an arbitrary type `K` and values of an arbitrary type `V`.

---

### `define`

```js
MAP.define(K key, V value);
```

**Description:**

Associates the specified `key` with the specified `value` in `MAP`. If `MAP` previously contained a mapping for `key`, the old value is replaced by `value`.

### `has`

```js
MAP.has(K key) -> bool
```

**Description:**

Checks if `MAP` contains a mapping for the specified `key`. Returns `true` if `MAP` contains `key`, otherwise returns `false`.

### `keys`

```js
MAP.keys() -> K{}
```

**Description:**

Returns a set of all keys contained in `MAP`.

### `lookup`

```js
MAP.lookup(K key) -> V
```

**Description:**

Retrieves the value associated with the specified `key` from `MAP`.

**Triggers runtime error(s):**

This function will trigger a runtime error that will terminate script execution if any of the following conditions are met:

* `!MAP.has(key)`: `MAP` does not contain a mapping for `key`
