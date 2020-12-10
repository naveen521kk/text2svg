# -*- coding: utf-8 -*-
from pathlib import Path


def test_svg_create(tmp_path):

    from text2svg import TextInfo, text2svg

    save_location = Path(tmp_path) / "test1.svg"
    t_info = TextInfo(
        "test",
        str(save_location),
        45,
        45,
    )
    assert text2svg(t_info) == 1
    assert save_location.exists()


def test_variant(tmp_path):
    from text2svg import TextInfo, Variant, text2svg

    save_location = Path(tmp_path) / "some.svg"
    t_info = TextInfo(
        "Random Nice",
        str(save_location),
        600,
        600,
        font_size=60,
        font="Crimson",
        font_variant=Variant.SMALL_CAPS,
    )
    assert text2svg(t_info) == 1
    t_info = TextInfo(
        "Random Nice",
        str(save_location),
        600,
        600,
        font_size=60,
        font_variant=Variant.NORMAL,  # noqa E501
    )
    assert text2svg(t_info) == 1


def test_exceptions_file_handling(tmp_path):
    import os

    from text2svg import TextInfo, text2svg

    save_locatiion = Path(tmp_path) / "lock.svg"
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
