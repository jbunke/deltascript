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

Sets the pixel at the position `x`, `y` in `IMG` to the color `c`.

### `draw`

```js
IMG.draw(image superimposed, int x, int y);
```

**Description:**

Draws the `superimposed` image onto `IMG` at the position `x`, `y`. The top-left corner of the `superimposed` image will be placed at the coordinates `x`, `y` of `IMG`.

**Note:**

The position `x`, `y` may be outside of the bounds of `IMG`, and `superimposed` may extend beyond the bounds of `IMG`.

### `fill`

```js
IMG.fill(color c, int x, int y, int width, int height);
```

**Description:**

Fills a rectangular area of `IMG` with the color `c`. The rectangle is defined by its top-left corner at `x`, `y` and its dimensions `width` and `height`.

**Fails:**

This function will fail and be skipped over if any of the following conditions are met:

* `width <= 0`
* `height <= 0`

### `line`

```js
IMG.line(color c, float breadth, int x1, int y1, int x2, int y2);
```

**Description:**

Draws a straight line of the color `c` with a breadth of `breadth` pixels from `x1`, `y1` to `x2`, `y2` onto `IMG`.

**Fails:**

This function will fail and be skipped over if any of the following conditions are met:

* `breadth < 0.0`

### `pixel`

```js
IMG.pixel(int x, int y) -> color
```

**Description:**

Returns the color of the pixel at the position `x`, `y` in `IMG`.


**Triggers runtime error(s):**

This function will trigger a runtime error that will terminate script execution if any of the following conditions are met:

* `x < 0`
* `y < 0`
* `x >= IMG.width`: `x` is greater than or equal to the width of `IMG` in pixels
* `y >= IMG.height`: `y` is greater than or equal to the height of `IMG` in pixels

### `section`

```js
IMG.section(int x, int y, int width, int height) -> image
```

**Description:**

Extracts and returns a subsection of `IMG` as a new image. The subsection is defined by the rectangle starting at the position `x`, `y` with the specified `width` and `height`.

The rectangle may include pixels that are out of bounds of `IMG`. Such pixels in the returned image will simply be transparent.

**Triggers runtime error(s):**

This function will trigger a runtime error that will terminate script execution if any of the following conditions are met:

* `width <= 0`
* `height <= 0`
