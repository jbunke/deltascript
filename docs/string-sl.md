[**< Standard Library**](./std-lib.md)

# `string`

The type `string` represents a sequence of characters.

Definitions on this page will use `STR` to represent an arbitrary [object![](../assets/definition.png)](./glossary.md#object) of type `string`.

---

## Member functions

### `at`

```js
STR.at(int index) -> char
```

**Description:**

Returns the character at `index` in `STR`.

**Triggers runtime error(s):**

This function will trigger a runtime error that will terminate script execution if any of the following conditions are met:

* `index < 0`
* `index >= #|STR`: `index` is greater than or equal to the [length![](../assets/definition.png)](./glossary.md#length) of `STR`

**Note:**

*DeltaScript* uses [zero-based numbering![](../assets/external.png)](https://en.wikipedia.org/wiki/Zero-based_numbering).

### `has`

1.  ```js
    STR.has(char c) -> bool
    ```

    **Description:**

    Returns `true` if the character `c` is found in `STR`, otherwise returns `false`.

2.  ```js
    STR.has(string substring) -> bool
    ```

    **Description:**

    Returns `true` if the substring `substring` is found in `STR`, otherwise returns `false`.

### `sub`

```js
STR.sub(int beg, int end_ex) -> string
```

**Description:**

Returns a substring of `STR` starting from the index `beg` and ending at `end_ex`. `end_ex` is an exclusive bound, so the final character included in the substring will be the character at index `end_ex - 1` in `STR`.

**Triggers runtime error(s):**

This function will trigger a runtime error that will terminate script execution if any of the following conditions are met:

* `beg < 0`
* `end_ex > #|STR`: `end_ex` is greater than the [length![](../assets/definition.png)](./glossary.md#length) of `STR`
* `beg >= end_ex`

**Note:**

*DeltaScript* uses [zero-based numbering![](../assets/external.png)](https://en.wikipedia.org/wiki/Zero-based_numbering).
