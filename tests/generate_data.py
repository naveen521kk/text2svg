# -*- coding: utf-8 -*-
import hashlib
import json
import string
from pathlib import Path

import numpy as np

from text2svg.text2np import text2np

from text2svg import TextInfo, register_font, text2svg  # isort:skip

from text2svg import Variant, Weight, settings  # isort:skip

control_data_dir = (Path(__file__).parent / "control_data").resolve()
data_dir_numpy = control_data_dir / "numpy_test"
assets_dir = (Path(__file__).parent / "assets").resolve()
if not control_data_dir.exists():
    control_data_dir.mkdir()
if not data_dir_numpy.exists():
    data_dir_numpy.mkdir()


def hello_world(output):
    text = "Hello World"
    file_name = "s.svg"
    width = 100
    heigth = 100
    text2info = TextInfo(text, file_name, width, heigth)
    data = text2np(text2info)
    np.savez_compressed(data_dir_numpy / (output + ".npz"), frame_data=data)


def generate_random_string_data():
    # lets test for everything from 6-12 character
    min_length = 5

    def random_string(length):
        ALL = np.array(list(string.printable))
        return "".join(np.random.choice(ALL, size=length))

    l = []
    for i in range(0, 10):
        length = min_length + i
        l.append(random_string(length))
    return l


def create_hash(setting):
    """Internally used function.
    Generates ``sha256`` hash for file name.
    """
    id_str = ""
    for i in setting:
        id_str += str(i) + "=" + str(setting[i])
    hasher = hashlib.sha256()
    hasher.update(id_str.encode())
    return hasher.hexdigest()[:16]


def generate_npz_file(
    width,
    height,
    text_setting=None,
    START_Y=0,
    START_X=0,
    font_variant="NORMAL",
    font_weight="NORMAL",
    font_size=20,
    style="NORMAL",
    font=None,
):

    texts = generate_random_string_data()
    for i in range(len(texts)):
        info = {}
        info["type"] = "text2np"
        info["text"] = texts[i]
        info["file_name"] = str(i) + ".svg"
        info["width"] = width
        info["height"] = height
        info["font_size"] = font_size
        info["font_style"] = style
        info["font_weight"] = font_weight
        info["font_variant"] = font_variant
        if font:
            info["font"] = font[0]
            assert register_font(str(font[1])) == 1
            info["font_loc"] = str(font[1].relative_to(Path(__file__).parent))
        info["START_X"] = START_X
        info["START_Y"] = START_Y
        file_name = create_hash(info)
        file_path_json = data_dir_numpy / (file_name + ".json")
        if text_setting:
            info["text_setting"] = text_setting.__dict__()
        with open(file_path_json, "w") as f:
            json.dump(info, f)
        del info
        with open(file_path_json, "r") as f:
            info = json.load(f)

        args = dict(
            font_size=info["font_size"],
            font_style=eval("Style." + info["font_style"]),
            font_weight=eval("Weight." + info["font_weight"]),
            font_variant=eval("Variant." + info["font_variant"]),
            START_X=info["START_X"],
            START_Y=info["START_Y"],
        )
        if "font" in info:
            args["font"] = info["font"]
        if "text_setting" in info:
            args["text_setting"] = (info["text_setting"],)
        text2info = TextInfo(
            info["text"], info["file_name"], info["width"], info["height"], **args
        )
        data = text2np(text2info)
        np.savez_compressed(data_dir_numpy / (file_name + ".npz"), frame_data=data)


def main():
    hello_world("hello_world")
    generate_npz_file(100, 100, font=["Bitstream Vera Sans", assets_dir / "Vera.ttf"])
    generate_npz_file(500, 500, font=["Bitstream Vera Sans", assets_dir / "Vera.ttf"])
    generate_npz_file(50, 100, START_X=10, START_Y=5, font_size=20, style="ITALIC")
    generate_npz_file(
        150, 150, START_X=10, START_Y=10, font_size=15, font_weight="BOLD"
    )
    generate_npz_file(500, 500, font=["Langar", assets_dir / "Langar-Regular.ttf"])


if __name__ == "__main__":
    main()
