[**< Standard Library**](./std-lib.md)

# Collection types

<!-- TODO -->

## Array

**Arrays** in *DeltaScript* are represented by **square brackets** `[]`. An array of elements of an arbitrary type `T` would be declared with the type `T[]`.

**Examples:**

* `int[]` - array of integers
* `color<>[]` - array of lists of colors
* `(string -> char)[]` - array of string to character functions

Definitions in this section will use `ARR` to represent an arbitrary array `T[]` with elements of an arbitrary type `T`.

---

### `has`

```js
ARR.has(T check) -> bool
```

**Definition:**

<!-- TODO -->

## List

**Lists** in *DeltaScript* are represented by **angle brackets** `<>`. A list of elements of an arbitrary type `T` would be declared with the type `T<>`.

**Examples:**

* `int<>` - list of integers
* `color[]<>` - list of arrays of colors
* `(string -> char)[]` - list of string to character functions

Definitions in this section will use `LST` to represent an arbitrary list `T<>` with elements of an arbitrary type `T`.

---

### `add`

1.  ```js
    LST.add(T element);
    ```
    
    **Definition:**
    
    <!-- TODO -->

2.  ```js
    LST.add(T element, int index);
    ```

    **Description:**

    <!-- TODO -->

### `has`

```js
LST.has(T check) -> bool
```

**Definition:**

<!-- TODO -->

### `remove`

<!-- TODO -->

## Set

**Sets** in *DeltaScript* are represented by **curly brackets / braces** `{}`. A set of elements of an arbitrary type `T` would be declared with the type `T{}`.

**Examples:**

* `int{}` - set of integers
* `color[]{}` - set of arrays of colors
* `(string -> char){}` - set of string to character functions

Definitions in this section will use `SET` to represent an arbitrary set `T{}` with elements of an arbitrary type `T`.

---

### `add`

 ```js
SET.add(T element);
```

**Definition:**

<!-- TODO -->

### `has`

```js
SET.has(T check) -> bool
```

**Definition:**

<!-- TODO -->

## Map/dictionary

**Maps**, also known as **dictionaries**, are a collection type consisting of associations between **keys** and **values**. In *DeltaScript*, they are represented by **curly brackets / braces** and a **colon** separating their key and value types. A map of keys of an arbitrary type `K` and values of an arbitrary type `V` would be declared with the type `{K:V}`.

**Examples:**

* `{string:int}` - map with strings as keys and integers as values
* `{int:(-> color)}` - map with integers as keys and color-returning functions with no parameters as values

Definitions in this section will use `MAP` to represent an arbitrary map `{K:V}` with keys of an arbitrary type `K` and values of an arbitrary type `V`.

---

### `define`

```js
MAP.define(K key, V value);
```

**Definition:**

<!-- TODO -->

### `has`

```js
MAP.has(K key) -> bool
```

**Definition:**

<!-- TODO -->

### `keys`

```js
MAP.keys() -> K{}
```

**Definition:**

<!-- TODO -->

### `lookup`

```js
MAP.lookup(K key) -> V
```

**Definition:**

<!-- TODO -->
