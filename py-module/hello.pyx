cimport text2svg

def convert(text: str, filename:str, width:int, height:int, font_size:int=10, font_style:str="NORMAL", font_weight:str="NORMAL",font:str=None,START_X:float=0,START_Y:float=0):
    """This is the only function which is converted. 

    Parameters
    ==========

    text
    
    """
    cdef gint font_size_c=font_size
    cdef double width_layout = width
    cdef float START_X_C=START_X
    cdef float START_Y_C=START_Y
    font_style=parse_font_style(font_style)
    font_weight=parse_font_weight(font_weight)
    assert filename.endswith(".svg")
    if font is None:
        font='sans'
    return text2svg(text.encode(),filename.encode(),font.encode(),width,height,START_X_C,START_Y_C,width_layout, font_size_c,font_style,font_weight)
    print("nice")

def parse_font_style(string):
    if string == "NORMAL":
        return PANGO_STYLE_NORMAL
    elif string == "ITALIC":
        return PANGO_STYLE_ITALIC
    elif string == "OBLIQUE":
        return PANGO_STYLE_OBLIQUE
    else:
        raise AttributeError("There is no Style Called %s" % string)
def parse_font_weight(string):
    if string == "NORMAL":
        return PANGO_WEIGHT_NORMAL
    elif string == "BOLD":
        return PANGO_WEIGHT_BOLD
    elif string == "THIN":
        return PANGO_WEIGHT_THIN
    elif string == "ULTRALIGHT":
        return PANGO_WEIGHT_ULTRALIGHT
    elif string == "LIGHT":
        return PANGO_WEIGHT_LIGHT
    elif string == "SEMILIGHT":
        return PANGO_WEIGHT_SEMILIGHT
    elif string == "BOOK":
        return PANGO_WEIGHT_BOOK
    elif string == "MEDIUM":
        return PANGO_WEIGHT_MEDIUM
    elif string == "SEMIBOLD":
        return PANGO_WEIGHT_SEMIBOLD
    elif string == "ULTRABOLD":
        return PANGO_WEIGHT_ULTRABOLD
    elif string == "HEAVY":
        return PANGO_WEIGHT_HEAVY
    elif string == "ULTRAHEAVY":
        return PANGO_WEIGHT_ULTRAHEAVY
    else:
        raise AttributeError("There is no Font Weight Called %s" % string)
