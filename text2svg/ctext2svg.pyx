cimport ctext2svg
import warnings
from pathlib import Path
from typing import List

cpdef enum font_style:
    STYLE_NORMAL = PANGO_STYLE_NORMAL
    ITALIC = PANGO_STYLE_ITALIC
    OBLIQUE = PANGO_STYLE_OBLIQUE

cpdef enum font_weight:
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
    """This is the class which validates the arguments passed.
    This must be passed to text2svg
    """
    def __init__(
        self,
        text: str, 
        filename:str,
        width:int, 
        height:int, 
        font_size:int=10, 
        font_style:font_style = STYLE_NORMAL, 
        font_weight:font_weight = WEIGHT_NORMAL,
        font:str="sans",
        START_X:float=0,
        START_Y:float=0
    ):
        if text=="":
            warnings.warn("Text is empty.")
        assert filename.endswith(".svg"), "Only SVG file is supported, where it must end with .svg"
        self.text=text.encode()
        if Path(filename).exists():
            warnings.warn(f"{filename} already exists. Overwriting it.")
        if not Path(filename).parent.exists():
            raise ValueError("Directory doesn't exists. This will cause a Memory Leak.")
        self.filename=str(Path(filename)).encode()
        if width==0:
            warnings.warn("Width is set to zero. Which would mean, you would be having a empty file.")
        self.width=width
        if height==0:
            warnings.warn("Height is set to zero. Which would mean, you would be having a empty file.")
        self.height=height
        self.font_size=font_size
        self.font_style=font_style
        self.font_weight=font_weight
        self.font=font.encode()
        self.START_X=START_X
        self.START_Y=START_Y

def text2svg(self,text_info:TextInfo,text_settings:List[TextSetting]=[]) -> int:
    """This is the only function which is converted. 

    Parameters
    ==========

    text
    
    """
    if not isinstance(text_info,TextInfo):
        raise ValueError("text_info is not a instance of TextInfo")

    cdef cairo_surface_t* surface
    cdef cairo_t* cr
    cdef PangoFontDescription* font_desc
    cdef PangoLayout* layout
    cdef double width_layout = text_info.width
    cdef double font_size_c=text_info.font_size
    surface = cairo_svg_surface_create(text_info.filename, text_info.width, text_info.height)
    if surface == NULL:
        raise MemoryError("Cairo.SVGSurface can't be created.")
    cr = cairo_create(surface)
    if cr == NULL:
        raise MemoryError("Cairo.Context can't be created.")
    
    cairo_move_to(cr,text_info.START_X,text_info.START_Y)
    if text_settings == []:
        layout = pango_cairo_create_layout(cr)
        if layout==NULL:
            raise MemoryError("Pango.Layout can't be created from Cairo Context.")

        pango_layout_set_width(layout, pango_units_from_double(width_layout))
        font_desc = pango_font_description_new()
        pango_font_description_set_size(font_desc, pango_units_from_double(font_size_c))
        pango_font_description_set_family(font_desc, text_info.font)
        pango_font_description_set_style(font_desc, text_info.font_style)
        pango_font_description_set_weight(font_desc, text_info.font_weight)

        pango_layout_set_font_description(layout, font_desc)

        pango_layout_set_text(layout, text_info.text, -1)

        pango_cairo_show_layout(cr, layout)

        cairo_destroy(cr)
        cairo_surface_destroy(surface)
        g_object_unref(layout)

    return 0