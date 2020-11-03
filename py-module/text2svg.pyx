cimport text2svg
import warnings
cpdef enum pango_style:
    STYLE_NORMAL = PANGO_STYLE_NORMAL
    ITALIC = PANGO_STYLE_ITALIC
    OBLIQUE = PANGO_STYLE_OBLIQUE

cpdef enum pango_weight:
    WEIGHT_NORMAL = PANGO_WEIGHT_NORMAL
    BOLD = PANGO_WEIGHT_BOLD
    THIN = PANGO_WEIGHT_THIN
    ULTRALIGHT = PANGO_WEIGHT_ULTRALIGHT
    LIGHT = PANGO_WEIGHT_LIGHT
    SEMILIGHT = PANGO_WEIGHT_SEMILIGHT
    BOOK = PANGO_WEIGHT_BOOK
    MEDIUM = PANGO_WEIGHT_MEDIUM
    SEMIBOLD = PANGO_WEIGHT_SEMIBOLD
    ULTRABOLD = PANGO_WEIGHT_ULTRABOLD
    HEAVY = PANGO_WEIGHT_HEAVY
    ULTRAHEAVY = PANGO_WEIGHT_ULTRAHEAVY

class TextSetting:
    def __init__(self, start, end, font, slant, weight, line_num=-1):
        self.start = start
        self.end = end
        self.font = font
        self.slant = slant
        self.weight = weight
        self.line_num = line_num

class TextInfo:
    def __init__(
        self,
        text: str, 
        filename:str, 
        width:int, 
        height:int, 
        font_size:int=10, 
        font_style:str ='NORMAL', 
        font_weight:str='NORMAL',
        font:str="sans",
        START_X:float=0,
        START_Y:float=0
    ):
        if text=="":
            warnings.warn("Text is empty.")
        if filename:
            assert filename.endswith(".svg"), "Only SVG file is supported"
        self.text=text
        self.filename=filename
        self.width=width
        self.height=height
        self.font_size=font_size
        self.font_style=font_style
        self.font_weight=font_weight
        self.font=font
        self.START_X=START_X
        self.START_Y=START_Y
class text2svg(TextInfo):
    """This is the only function which is converted. 

    Parameters
    ==========

    text
    
    """
    def __init__(self):
        #cdef gint font_size_c=text_info.font_size
        #cdef double width_layout = text_info.width
        #cdef float START_X_C=text_info.START_X
        #cdef float START_Y_C=text_info.START_Y
        #cdef PangoWeight font_weight_c
        #cdef PangoStyle font_style_c
        #assert text_info.filename.endswith(".svg")
        #return text2svg(text.encode(),filename.encode(),font.encode(),width,height,START_X_C,START_Y_C,width_layout, font_size_c,font_style_c,font_weight_c)
        print("nice")