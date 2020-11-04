# Text2SVG

This is a small wrapper aoung Pango and Cairo which allows you to enter a text and get you svg files ready. This is wrapped using Cython.

## Installation

You would need Pango and Cairo along with the header files and its dependencies.

Installing using pip,

```sh
pip install text2svg
```
ad checking your installation by running the below example.

## Example

This is a small example on how it works.
```py
from text2svg import *
info = TextInfo("Hello World","hello.svg",50,50)
text2svg(info)
```

This will simply create a `hello.svg` in the current working directory.
