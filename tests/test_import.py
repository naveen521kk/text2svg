def test_import():
    import text2svg
    assert True
def test_TextInfo():
    from text2svg import TextInfo
    assert str(TextInfo("Hello World","hello.svg",50,50))=="TextInfo(b'Hello World')"
