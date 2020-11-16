# -*- coding: utf-8 -*-
from .ctext2svg import TextInfo, text2svg
from .__version__ import __version__ as version
import sys

try:
    from colorama import Fore, Style
except ImportError:
    Fore = None


def main():
    if Fore:
        print(Fore.GREEN + f"Text2SVG v{version}")
        print(Style.RESET_ALL)
    else:
        print(f"Text2SVG v{version}")
    import argparse
    from pathlib import Path

    parser = argparse.ArgumentParser(
        description="Convert Text to SVG file.", prog="text2svg"
    )

    def dir_path(path):
        return Path(path).as_posix()

    parser.add_argument(
        "text",
        help="The text which need to be Converted.",
        type=str,
    )
    parser.add_argument(
        "filename",
        help="The filename to write.",
        type=dir_path,
    )
    parser.add_argument(
        "--width",
        "-w",
        help="The width of the image.",
        default=100,
    )
    parser.add_argument(
        "--height",
        "-ht",
        help="The height of the image.",
        default=100,
    )
    parser.add_argument(
        "--font-size",
        "-fs",
        help="Size of font",
        type=int,
        dest="fontsize",
        default=10,
    )
    parser.add_argument("--font", "-f", help="Font to use.")
    parser.add_argument("-y", help="no prompts.", action="store_true")
    args = parser.parse_args()
    if Path(args.filename).exists() and args.y is False:
        if Fore:
            chk = int(
                input(
                    Fore.CYAN
                    + f"File {args.filename} already exists. \n"
                    + "Do you wantto overwrite?[1/0]"
                )
            )
            print(Style.RESET_ALL)
        else:
            chk = int(
                input(
                    f"File {args.filename} already exists. \n"
                    + "Do you wantto overwrite?[1/0]"
                )
            )
        if chk == 0:
            sys.exit(1)
    else:
        if Fore:
            print(Fore.RED + "Exiting file already exists")
            print(Style.RESET_ALL)
        else:
            print("Exiting file alreay exists")
        sys.exit(1)
    text = TextInfo(
        args.text,
        args.filename,
        args.width,
        args.height,
        font_size=args.fontsize,
    )
    if text2svg(text) == 1:
        if Fore:
            print(Fore.YELLOW + f"Saved to {args.filename}")
            print(Style.RESET_ALL)
        else:
            print(f"Saved to {args.filename}")
