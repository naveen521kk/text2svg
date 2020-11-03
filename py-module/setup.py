import argparse
import shlex
from pathlib import Path
from shlex import quote
from subprocess import PIPE, Popen

from Cython.Build import cythonize
from setuptools import Extension, setup


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
            ["pkg-config", "--cflags", "--libs", name], stdout=PIPE, stderr=PIPE
        )
    except OSError:
        print("pkg-config is required for building PyAV")
        exit(1)

    raw_cflags, _ = proc.communicate()
    # if proc.wait():
    # return
    known, unknown = parse_cflags(raw_cflags.decode("utf8"))
    if unknown:
        print("pkg-config returned flags we don't understand: {}".format(unknown))
        # exit(1) #know issue
    return known


pyx_file = str(Path(__file__).parent / "hello.pyx")
returns = get_library_config("text2svg")
returns["libraries"].append("text2svg") # misses it. Need to find a nice fix soon.
setup(ext_modules=cythonize([Extension("text2svg", [pyx_file], **returns)]))
