# -*- coding: utf-8 -*-
import argparse
import shlex
from pathlib import Path
from shlex import quote
from subprocess import PIPE, Popen

from Cython.Build import cythonize
from setuptools import Extension, find_packages, setup

_cflag_parser = argparse.ArgumentParser(add_help=False)
_cflag_parser.add_argument("-I", dest="include_dirs", action="append")
_cflag_parser.add_argument("-L", dest="library_dirs", action="append")
_cflag_parser.add_argument("-l", dest="libraries", action="append")
_cflag_parser.add_argument("-D", dest="define_macros", action="append")
_cflag_parser.add_argument("-R", dest="runtime_library_dirs", action="append")


def parse_cflags(raw_cflags):
    raw_args = shlex.split(raw_cflags.strip())
    args, unknown = _cflag_parser.parse_known_args(raw_args)
    config = {k: v or [] for k, v in args.__dict__.items()}
    for i, x in enumerate(config["define_macros"]):
        parts = x.split("=", 1)
        value = x[1] or None if len(x) == 2 else None
        config["define_macros"][i] = (parts[0], value)
    return config, " ".join(quote(x) for x in unknown)


def get_library_config(name):
    """Get distutils-compatible extension extras for the given library.
    This requires ``pkg-config``.
    """
    try:
        proc = Popen(
            ["pkg-config", "--cflags", "--libs", name],
            stdout=PIPE,
            stderr=PIPE,
        )
    except OSError:
        print("pkg-config is required for building text2svg")
        exit(1)

    raw_cflags, _ = proc.communicate()
    known, unknown = parse_cflags(raw_cflags.decode("utf8"))
    if unknown:
        print(
            "pkg-config returned flags we \
            don't understand: {}".format(
                unknown
            )
        )
    return known


def update_dict(dict1, dict2):
    for key in dict2:
        if key in dict1:
            dict2[key] = dict2[key] + dict1[key]
        else:
            pass
    return dict2


pyx_file = str(Path(__file__).parent / "text2svg" / "ctext2svg.pyx")
returns = get_library_config("pangocairo")
returns = update_dict(returns, get_library_config("pangofc"))

ext_modules = [Extension("text2svg.ctext2svg", [pyx_file], **returns)]

with open("README.md", "r") as fh:
    long_description = fh.read()

setup(
    name="text2svg",
    version="0.3.0",
    author="Naveen M K",
    author_email="naveen@syrusdark.website",
    maintainer="Naveen M K",
    maintainer_email="naveen@syrusdark.website",
    url="https://text2svg.syrusdark.website",
    description="Convert text to SVG file.",
    long_description=long_description,
    zip_safe=False,
    long_description_content_type="text/markdown",
    packages=find_packages(),
    platforms=["Linux", "macOS", "Windows"],
    keywords=["cython", "pango", "cairo", "svg"],
    classifiers=[
        "Programming Language :: Python :: 3",
        "Development Status :: 3 - Alpha",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
        "Operating System :: OS Independent",
        "Programming Language :: Cython",
    ],
    python_requires=">=3.6",
    ext_modules=cythonize(
        ext_modules,
        language_level=3,
        include_path=["text2svg"],
        build_dir=str(Path(__file__).parent / "build"),
    ),
    entry_points={
        "console_scripts": [
            "text2svg=text2svg.cli:main",
        ],
    },
    extras_require={
        "cli": ["colorama"],
    },
)
