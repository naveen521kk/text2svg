<h1 align="center">Text2SVG</h1>

<p align="center"><a href="https://github.com/naveen521kk/text2svg/blob/main/LICENSE"><img src="https://img.shields.io/github/license/naveen521kk/text2svg?style=flat-square" alt="GitHub license"></a>
<a href="https://github.com/naveen521kk/text2svg/issues"><img src="https://img.shields.io/github/issues/naveen521kk/text2svg?style=flat-square" alt="GitHub issues"></a>
<img src="https://img.shields.io/pypi/v/text2svg?style=flat-square" alt="PyPI">
<img src="https://img.shields.io/pypi/format/text2svg?style=flat-square" alt="PyPI - Format">
<img src="https://img.shields.io/pypi/status/text2svg?style=flat-square" alt="PyPI - Status">
<img src="https://img.shields.io/github/release-date/naveen521kk/text2svg?style=flat-square" alt="GitHub Release Date">
<img src="https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square" alt="pre-commit hook>
</p>
<p align="center">
  <img alt="Build Wheels" src="https://github.com/naveen521kk/text2svg/workflows/Build%20Wheels/badge.svg">
</p>

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
