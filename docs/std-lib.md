[**< Home**](../README.md)

# *DeltaScript* – Standard Library

<!-- TODO - link to a Delta Time release -->

| Version | Published | Author | Implementation |
| :-----: | :-------: | :----: | :------------: |
| alpha-0.1 | January 6, 2025 | Jordan Bunke | [Link![](../assets/external.png)]() |

<!-- TODO -->

## Contents

### Built-in types

* [`color`](./color-sl.md)
* [`image`](./image-sl.md)
* [`string`](./string-sl.md)

**Note:**

*DeltaScript* has built-in types that are not listed here. The types listed here are the only built-in types with functions and/or properties in the [base language![](../assets/definition.png)](./glossary.md#base-language).

### Collection types

* [Array – `T[]`](./collections-sl.md#array)
* [List – `T<>`](./collections-sl.md#list)
* [Set – `T{}`](./collections-sl.md#set)
* [Map/dictionary – `{K:V}`](./collections-sl.md#mapdictionary)

### Built-in functions

* [`abs(N value) -> N`](./functions-sl.md#abs)
* [`clamp(N min, N value, N max) -> N`](./functions-sl.md#clamp)
* [`flip_coin() -> bool`](./functions-sl.md#flip_coin)
* [`max(C(N) collection) -> N`](./functions-sl.md#max)
* [`max(N a, N b) -> N`](./functions-sl.md#max)
* [`min(C(N) collection) -> N`](./functions-sl.md#min)
* [`min(N a, N b) -> N`](./functions-sl.md#min)
* [`new_image_of(int width, int height) -> image`](./functions-sl.md#new_image_of)
* [`print(T message);`](./functions-sl.md#print)
* [`prob(float p) -> bool`](./functions-sl.md#prob)
* [`prompt(T message) -> string`](./functions-sl.md#prompt)
* [`rand() -> float`](./functions-sl.md#rand)
* [`rand(N min, N max_ex) -> float`](./functions-sl.md#rand)
* [`read() -> string`](./functions-sl.md#read)
* [`read_image(string filepath) -> image`](./functions-sl.md#read_image)
* [`rgb(int r, int g, int b) -> color`](./functions-sl.md#rgb)
* [`rgba(int r, int g, int b, int a) -> color`](./functions-sl.md#rgba)

## Terminology

### Function notation

Functions of the form `name(params*);` are **void functions** (functions that perform an action but return nothing), while functions of the form `name(params*) -> return_type` **return a value** of the type `return_type`.

`params*` represents a list of zero or more comma-separated [parameters![](../assets/external.png)](https://en.wikipedia.org/wiki/Parameter_(computer_programming)).

### Arbitrary types

<!-- TODO - links to language specification -->

`T` represents an arbitrary type. Note that `T` **can be ANY type**, whether a [simple type](), a [collection type](), or a [functional type]().

`K` and `V` also represent arbitrary types. `K` is the type of the **keys** of a [map/dictionary![](../assets/external.png)](https://en.wikipedia.org/wiki/Associative_array), while `V` is the type of its **values**.

`N` represents a numeric type, whether `float` or `int`. Repeated uses of `N` in the same function type signature suggest that:
1. the same numeric type must be provided for each argument of type `N`
2. the return type will match the argument type

`C(T)` represents an arbitrary collection of some type `T` of elements. `C(T)` can represent an array `T[]`, a list `T<>`, or a set `T{}`.
