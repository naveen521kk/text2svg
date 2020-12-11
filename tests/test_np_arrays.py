# -*- coding: utf-8 -*-
import json
from pathlib import Path

import numpy as np

from text2svg import Style, Variant, Weight  # noqa
from text2svg.text2np import text2np

from text2svg import TextInfo, register_font  # isort:skip

data_dir = (Path(__file__).parent / "control_data" / "numpy_test").resolve()
assets_dir = (Path(__file__).parent / "assets").resolve()


def test_hello_world_data():
    i = Path(data_dir / "hello_world.npz")
    width = 100
    heigth = 100
    expected = np.load(i)["frame_data"]
    text2info = TextInfo("Hello World", i.stem + ".svg", width, heigth)
    data = text2np(text2info)
    assert np.array_equal(data, expected)


def test_np_arrays():
    font_lst = []
    for i in data_dir.glob("*.npz"):
        if i.stem != "hello_world":
            with open(data_dir / (i.stem + ".json")) as f:
                info = json.load(f)
            expected = np.load(i)["frame_data"]
            args = dict(
                font_size=info["font_size"],
                font_style=eval("Style." + info["font_style"]),
                font_weight=eval("Weight." + info["font_weight"]),
                font_variant=eval("Variant." + info["font_variant"]),
                START_X=info["START_X"],
                START_Y=info["START_Y"],
            )
            if "font" in info:
                if info["font"] not in font_lst:
                    assert (
                        register_font(
                            str(
                                Path(__file__).parent / info["font_loc"],
                            ),
                        )
                        == 1
                    )
                    font_lst.append(info["font"])
                args["font"] = info["font"]
            if "text_setting" in info:
                args["text_setting"] = info["text_setting"]

            text2info = TextInfo(
                info["text"],
                info["file_name"],
                info["width"],
                info["height"],
                **args,
            )
            del args
            data = text2np(text2info)
            assert data.shape == expected.shape
            create_png(data, assets_dir / "images" / (i.stem + "-got.png"))
            # assert np.array_equal(data, expected),
            # np.setdiff1d(data, expected)


def test_cairo_png_data():
    import cairo

    for i in data_dir.glob("*.npz"):
        if i.stem != "hello_world":
            with open(data_dir / (i.stem + ".json")) as f:
                info = json.load(f)
            data = np.load(i)["frame_data"]
            surface = cairo.ImageSurface.create_for_data(
                data, cairo.FORMAT_ARGB32, info["width"], info["height"]
            )
            surface.write_to_png(assets_dir / "images" / (i.stem + ".png"))


def create_png(data, filename):
    import cairo

    surface = cairo.ImageSurface.create_for_data(
        data, cairo.FORMAT_ARGB32, data.shape[0], data.shape[1]
    )
    surface.write_to_png(str(filename))
