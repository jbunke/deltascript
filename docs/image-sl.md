[**< Standard Library**](./std-lib.md)

# `image`

The type `image` represents a digital raster image. An image is a rectangular area of fixed positive width and height (in pixels). Colors of pixels are represented as [32-bit RGBA colors![](../assets/external.png)](https://en.wikipedia.org/wiki/RGBA_color_model).

Definitions on this page will use `IMG` to represent an arbitrary [object![](../assets/definition.png)](./glossary.md#object) of type `image`.

---

## Properties

### `width`

*Shorthand:* `w`

```js
IMG.width -> int

// Shorthand:
IMG.w -> int
```

**Description:**

The width of `IMG` in pixels.

### `height`

*Shorthand:* `h`

```js
IMG.height -> int

// Shorthand:
IMG.h -> int
```

**Description:**

The height of `IMG` in pixels.

## Member functions

### `dot`

```js
IMG.dot(color c, int x, int y);
```

**Description:**

<!-- TODO -->

### `draw`

```js
IMG.draw(image superimposed, int x, int y);
```

**Description:**

<!-- TODO -->

### `fill`

```js
IMG.fill(color c, int x, int y, int width, int height);
```

**Description:**

<!-- TODO -->

### `line`

```js
IMG.line(color c, int x1, int y1, int x2, int y2);
```

**Description:**

<!-- TODO -->

### `pixel`

```js
IMG.pixel(int x, int y) -> color
```

**Description:**

<!-- TODO -->

### `section`

```js
IMG.section(int x, int y, int width, int height) -> image
```

**Description:**

<!-- TODO -->
