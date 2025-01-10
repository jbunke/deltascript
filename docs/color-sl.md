[**< Standard Library**](./std-lib.md)

# `color`

The type `color` represents a [32-bit RGBA color![](../assets/external.png)](https://en.wikipedia.org/wiki/RGBA_color_model). A color is made up of four *channels*: red, green, blue, and alpha/[opacity![](../assets/definition.png)](./glossary.md#opacity). Each channel is assigned 8 bits. Thus, a color channel can have a value ranging from 0 to 255 (inclusive).

Definitions on this page will use `C` to represent an arbitrary [object![](../assets/definition.png)](./glossary.md#object) of type `color`.

---

## Properties

### `red`

*Shorthand:* `r`

```js
C.red -> int

// Shorthand:
C.r -> int
```

The value of the **red** color channel of `C`.

### `green`

*Shorthand:* `g`

```js
C.green -> int

// Shorthand:
C.g -> int
```

The value of the **green** color channel of `C`.

### `blue`

*Shorthand:* `b`

```js
C.blue -> int

// Shorthand:
C.b -> int
```

The value of the **blue** color channel of `C`.

### `alpha`

*Shorthand:* `a`

```js
C.alpha -> int

// Shorthand:
C.a -> int
```

The value of the **alpha/opacity** color channel of `C`.
