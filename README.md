<h1 align="center">Text2SVG</h1>
[![GitHub license](https://img.shields.io/github/license/naveen521kk/text2svg?style=flat-square)](https://github.com/naveen521kk/text2svg/blob/main/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/naveen521kk/text2svg?style=flat-square)](https://github.com/naveen521kk/text2svg/issues)
![PyPI](https://img.shields.io/pypi/v/text2svg?style=flat-square)
![PyPI - Format](https://img.shields.io/pypi/format/text2svg?style=flat-square)
![PyPI - Status](https://img.shields.io/pypi/status/text2svg)
![GitHub Release Date](https://img.shields.io/github/release-date/naveen521kk/text2svg?style=flat-square)
![Build Wheels](https://github.com/naveen521kk/text2svg/workflows/Build%20Wheels/badge.svg)

This is a small wrapper aoung Pango and Cairo which allows you to enter a text and get you svg files ready. This is wrapped using Cython.

## Installation

For Windows and MacOS, wheels are provided which seems to be working. For linux it is not recommended to use the `manylinux` wheels which was published to PyPi as it seems that it is working well. Instead you can install Pango and Cairo along with the header files for your package manage and run the below command
```sh
pip install --no-binary :all: text2svg
```

Other users, can directly install using pip,

```sh
pip install text2svg
```
and checking your installation by running the below example.

## Example

This is a small example on how it works.
```py
from text2svg import *
info = TextInfo("Hello World","hello.svg",50,50)
text2svg(info)
```

This will simply create a `hello.svg` in the current working directory.
