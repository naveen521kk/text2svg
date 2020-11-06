def test_svg_create():
    from text2svg import TextInfo,text2svg
    t_info=TextInfo("test",r"text.svg",45,45)
    assert text2svg(t_info)==0
