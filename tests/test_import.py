# -*- coding: utf-8 -*-
def test_import():
    import text2svg  # noqa

    assert True


def test_textinfo_attrs():
    from text2svg import CharSettings, Style, TextInfo, Variant, Weight

    a = TextInfo(
        "random",
        "a.svg",
        150,
        100,
        font_size=20,
        font_style=Style.ITALIC,
        font_weight=Weight.BOLD,
        font_variant=Variant.NORMAL,
        font="sans-serief",
        START_X=20,
        START_Y=20,
        text_setting=CharSettings(1, 5, font="Roboto"),
    )
    assert str(a) == (
        "TextInfo(text='random',filename='a.svg'"
        ",width=150,height=100,font_size=20"
        ",font_weight=700,font_variant=0,font"
        "='sans-serief',START_X=20.0,START_Y=20.0"
        ",text_setting=CharSettings(start=1,end=5))"
    ), "something wrong with TextInfo.__repr__()"
    assert a.text.decode() == "random"
    assert a.filename.decode() == "a.svg"
    assert a.width == 150
    assert a.height == 100
    assert a.font_size == 20
    assert a.font_style == Style.ITALIC.value
    assert a.font_weight == Weight.BOLD.value
    assert a.font_variant == Variant.NORMAL.value
    assert a.font.decode() == "sans-serief"
    assert a.START_X == 20
    assert a.START_Y == 20
    assert str(a.text_setting) == str(CharSettings(1, 5, font="Roboto"))

    a.text = "nice"
    assert a.text.decode() == "nice"
