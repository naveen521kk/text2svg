# -*- coding: utf-8 -*-
from pathlib import Path
import tempfile


def test_svg_create():
    from text2svg import TextInfo, text2svg

    with tempfile.TemporaryDirectory() as tmpdirname:
        save_locatiion = Path(tmpdirname) / "test1.svg"
        t_info = TextInfo(
            "test",
            str(save_locatiion),
            45,
            45,
        )
        assert text2svg(t_info) == 1
        assert save_locatiion.exists()


def test_variant():
    from text2svg import TextInfo, text2svg, Variant

    t_info = TextInfo(
        "Random Nice",
        "some.svg",
        600,
        600,
        font_size=60,
        font="Crimson",
        font_variant=Variant.SMALL_CAPS,
    )
    assert text2svg(t_info) == 1
    t_info = TextInfo(
        "Random Nice",
        "some1.svg",
        600,
        600,
        font_size=60,
        font_variant=Variant.NORMAL,  # noqa E501
    )
    assert text2svg(t_info) == 1


def test_exceptions_file_handling():
    from text2svg import TextInfo, text2svg
    import os

    with tempfile.TemporaryDirectory() as tmpdirname:
        save_locatiion = Path(tmpdirname) / "lock.svg"
        t_info = TextInfo("test", str(save_locatiion), 45, 45)
        assert text2svg(t_info) == 1
        assert save_locatiion.exists()
        os.chmod(save_locatiion, 0o444)

        try:
            text2svg(t_info)
        except Exception as e:
            assert str(e) == str(
                Exception(b"error while writing to output stream")
            )  # noqa: E501
        os.chmod(save_locatiion, 0o644)
