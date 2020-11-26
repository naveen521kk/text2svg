# -*- coding: utf-8 -*-
# text2svg, Convert text to SVG files.
# Copyright (C) 2020 Naveen M K
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

import sys

from .__version__ import __version__ as version
from .ctext2svg import TextInfo, text2svg

try:
    from colorama import Fore, Style, init

    init()
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
        type=int,
    )
    parser.add_argument(
        "--height",
        "-ht",
        help="The height of the image.",
        default=100,
        type=int,
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
    if Path(args.filename).exists():
        if args.y is False:
            if Fore:
                chk = int(
                    input(
                        Fore.CYAN
                        + f"File {args.filename} already exists. \n"
                        + "Do you wantto overwrite?[1/0]"
                    )
                )
            else:
                chk = int(
                    input(
                        f"File {args.filename} already exists. \n"
                        + "Do you wantto overwrite?[1/0]"
                    )
                )
            print(Style.RESET_ALL)
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
        font=args.font,
    )
    if text2svg(text) == 1:
        if Fore:
            print(Fore.YELLOW + f"Saved to {args.filename}")
            print(Style.RESET_ALL)
        else:
            print(f"Saved to {args.filename}")
