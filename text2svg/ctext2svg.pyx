# text2svg, Convert text to SVG files.
# Copyright (C) 2020 Naveen M K
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

"""
    ctext2svg.pyx
    ~~~~~~~~~~~~~

    This is the core module. Exports some function
    which help in converting ``text`` to ``.svg`` files.

    The backend here is Pango and Cairo. This is a small
    implementation of those libraries with the help of
    Cython.

    :copyright: Copyright 2020 by Naveen M K
    :licence: GPLv3, See LICENSE for details.

"""
cimport ctext2svg
import warnings
from pathlib import Path
from enum import Enum

class Style(Enum):
    """
    An enumeration specifying the various slant styles possible for a font.

    Attributes
    ----------

    NORMAL :
        the font is upright.

    ITALIC :
        the font is slanted, but in a roman style.

    OBLIQUE:
        the font is slanted in an italic style.
    """
    NORMAL = PANGO_STYLE_NORMAL
    ITALIC = PANGO_STYLE_ITALIC
    OBLIQUE = PANGO_STYLE_OBLIQUE

class Weight(Enum):
    """
    An enumeration specifying the weight (boldness) of a font.
    This is a numerical value ranging from 100 to 1000, but there are some predefined values
    Using numerical value other then that defined here is not supported.

    Attributes
    ----------

    NORMAL :
        the default weight (= 400)

    BOLD :
        the bold weight( = 700)

    THIN :
        the thin weight( = 100; Since: 1.24)

    ULTRALIGHT :
        the ultralight weight( = 200)

    LIGHT :
        the light weight( = 300)

    BOOK :
        the book weight( = 380; Since: 1.24)

    MEDIUM :
        the normal weight( = 500; Since: 1.24)

    SEMIBOLD :
        the semibold weight( = 600)

    ULTRABOLD :
        the ultrabold weight( = 800)

    HEAVY :
        the heavy weight( = 900)

    ULTRAHEAVY :
        the ultraheavy weight( = 1000; Since: 1.24)
    """
    # TODO: Support numerical values also
    NORMAL = PANGO_WEIGHT_NORMAL
    BOLD = PANGO_WEIGHT_BOLD
    THIN = PANGO_WEIGHT_THIN
    ULTRALIGHT = PANGO_WEIGHT_ULTRALIGHT
    LIGHT = PANGO_WEIGHT_LIGHT
    BOOK = PANGO_WEIGHT_BOOK
    MEDIUM = PANGO_WEIGHT_MEDIUM
    SEMIBOLD = PANGO_WEIGHT_SEMIBOLD
    ULTRABOLD = PANGO_WEIGHT_ULTRABOLD
    HEAVY = PANGO_WEIGHT_HEAVY
    ULTRAHEAVY = PANGO_WEIGHT_ULTRAHEAVY

class Variant(Enum):
    """
    An enumeration specifying capitalization variant of the font.

    Attributes
    ----------

    NORMAL :
        A normal font.

    SMALL_CAPS :
        A font with the lower case characters replaced by smaller variants
        of the capital characters.
    """
    NORMAL = PANGO_VARIANT_NORMAL
    SMALL_CAPS = PANGO_VARIANT_SMALL_CAPS

class TextInfo:
    """
    This is the class which validates the arguments passed.
    This must be passed to :func:`text2svg`.

    Parameters
    ----------
    text : :class:`str`
        Text to convert.
    filename : :class:`str`
        The filename to write into.
    width : :class:`int`
        The width of the SVG.
    height : :class:`int`
        The height of the SVG.
    font_size : :class:`int`
        Size of font to write.
    font_style : :class:`Style`
        The style of font. Should be one from the defined
        enum.
    font_weight : :class:`Weight`
        The Weight of Font. Should be one from the defined
        enums.
    font_variant : :class:`Variant`
        An enumeration specifying capitalization variant of the font.
        Should be from the one defined.
    font : :class:`str`
        The font which the text must use.

        .. important ::

                This font must be installed in the system or registered
                using :func:`register_font`

    START_X : :class:`float`
        Where to move the ``Cairo.Context`` before writing?
        Specify the x-coordinate here. Also, please see
        cairo docs about where the pointer starts.
    START_Y : :class:`float`
        Where to move the ``Cairo.Context`` before writing?
        Specify the y-coordinate here. Also, please see
        cairo docs about where the pointer starts.

    Returns
    -------
    :class:`TextInfo`
        The generated TextInfo with the specified attributes and modifications.

    Examples
    --------
    >>> TextInfo("Hello World","hello.svg",50,50)
    TextInfo(b'Hello World')

    Raises
    ------

    AssertionError
        If the file name doesn't ends with ``.svg``.

    ValueError
        If the directory you are trying to create the
        file doesn't exists

    Warns
    -----

    Filename exits already.
    Width set to zero.
    Height set to zero.

    """
    def __init__(
        self,
        text: str,
        filename:str,
        width:int,
        height:int,
        font_size:int=10,
        font_style:Style = Style.NORMAL,
        font_weight:Weight = Weight.NORMAL,
        font_variant:Variant = Variant.NORMAL,
        font:str="Sans",
        START_X:float=0,
        START_Y:float=0
    ):
        self.text=text
        self.filename=filename
        self.width=width
        self.height=height
        self.font_size=font_size
        self.font_style=font_style.value
        self.font_weight=font_weight.value
        self.font_variant=font_variant.value
        self.font=font.encode()
        self.START_X=START_X
        self.START_Y=START_Y
    def __repr__(self):
        return f"TextInfo({self.text})"
    @property
    def text(self):
        return self._text.encode()

    @text.setter
    def text(self,text:str):
        if text=="":
            warnings.warn("Text is empty.")
        self._text = text
    @property
    def filename(self):
        return self._filename.encode()
    @filename.setter
    def filename(self,filename:str):
        assert filename.endswith(".svg"), "Only SVG file is supported, where it must end with .svg"
        if Path(filename).exists():
            warnings.warn(f"{filename} already exists. Overwriting it.")
        if not Path(filename).parent.exists():
            raise ValueError("Directory doesn't exists. This will cause a Memory Leak.")
        self._filename = str(Path(filename))
    @property
    def width(self):
        return self._width
    @width.setter
    def width(self,width:int):
        if width==0:
            warnings.warn("Width is set to zero. Which would mean, you would be having a empty file.")
        assert isinstance(width,int)
        self._width=width
    @property
    def height(self):
        return self._height
    @height.setter
    def height(self,height:int):
        if height==0:
            warnings.warn("Height is set to zero. Which would mean, you would be having a empty file.")
        assert isinstance(height,int)
        self._height=height
    @property
    def font_size(self):
        return self._font_size
    @font_size.setter
    def font_size(self,font_size:int):
        assert isinstance(font_size,int)
        self._font_size=font_size



def text2svg(text_info:TextInfo) -> int:
    """
    This is the main function which actually converts
    the :class:`TextInfo` to an SVG file.

    Parameters
    ==========
    text_info : :class:`TextInfo`
        The returned value from :class:`TextInfo`.

    Returns
    =======
    :class:`int`
        Either 0 or 1
        1 means it worked without any error.

    Examples
    --------
    >>> text2svg(TextInfo("Hello World","hello.svg",50,50))
    0

    Raises
    ------

    MemoryError
        When ran out of Memory.
    Exception
        When ``cairo.Context`` returns any error this is raised.
    """
    if not isinstance(text_info,TextInfo):
        raise ValueError("text_info is not a instance of TextInfo")

    cdef cairo_surface_t* surface
    cdef cairo_t* cr
    cdef PangoFontDescription* font_desc
    cdef PangoLayout* layout
    cdef double width_layout = text_info.width
    cdef double font_size_c=text_info.font_size
    cdef cairo_status_t status
    cdef PangoFontMap* mPangoFontMap
    cdef PangoContext* mPangoContext
    surface = cairo_svg_surface_create(text_info.filename, text_info.width, text_info.height)
    if surface == NULL:
        raise MemoryError("Cairo.SVGSurface can't be created.")
    cr = cairo_create(surface)
    status = cairo_status(cr)
    if cr == NULL or status == CAIRO_STATUS_NO_MEMORY:
        cairo_destroy(cr)
        cairo_surface_destroy(surface)
        raise MemoryError("Cairo.Context can't be created.")
    elif status != CAIRO_STATUS_SUCCESS:
        cairo_destroy(cr)
        cairo_surface_destroy(surface)
        raise Exception(cairo_status_to_string(status))
    cairo_move_to(cr,text_info.START_X,text_info.START_Y)

    mPangoFontMap = pango_cairo_font_map_new_for_font_type(CAIRO_FONT_TYPE_FT)
    if mPangoFontMap == NULL:
        raise Exception("Cairo is not Compiled with Fontconfig and FreetType Enabled.")
    mPangoContext = pango_font_map_create_context(mPangoFontMap)
    layout = pango_layout_new(mPangoContext)
    #layout = pango_cairo_create_layout(cr)
    if layout==NULL:
        cairo_destroy(cr)
        cairo_surface_destroy(surface)
        raise MemoryError("Pango.Layout can't be created from Cairo Context.")

    pango_layout_set_width(layout, pango_units_from_double(width_layout))
    font_desc = pango_font_description_new()
    if font_desc==NULL:
        cairo_destroy(cr)
        cairo_surface_destroy(surface)
        g_object_unref(layout)
        raise MemoryError("Pango.FontDesc can't be created.")
    pango_font_description_set_size(font_desc, pango_units_from_double(font_size_c))
    pango_font_description_set_family(font_desc, text_info.font)
    pango_font_description_set_style(font_desc, text_info.font_style)
    pango_font_description_set_weight(font_desc, text_info.font_weight)
    pango_font_description_set_variant(font_desc, text_info.font_variant)
    pango_layout_set_font_description(layout, font_desc)

    pango_layout_set_text(layout, text_info.text, -1)

    pango_cairo_show_layout(cr, layout)

    status = cairo_status(cr)
    if cr == NULL or status == CAIRO_STATUS_NO_MEMORY:
        cairo_destroy(cr)
        cairo_surface_destroy(surface)
        g_object_unref(layout)
        raise MemoryError("Cairo.Context can't be created.")
    elif status != CAIRO_STATUS_SUCCESS:
        cairo_destroy(cr)
        cairo_surface_destroy(surface)
        g_object_unref(layout)
        raise Exception(cairo_status_to_string(status).decode())

    cairo_destroy(cr)
    cairo_surface_destroy(surface)
    g_object_unref(mPangoFontMap)
    g_object_unref(mPangoContext)
    g_object_unref(layout)

    return 1

def register_font(font_path:str):
    """This function registers the font file using ``fontconfig`` so that
    it is available for use by Pango.

    Parameters
    ==========
    font_path : :class:`str`
        Relative or absolute path to font file.

    Returns
    =======
    :class:`int`
        Either 0 or 1

        .. note ::

            1 means it worked without any error.

    Examples
    --------
    >>> register_font("/home/roboto.tff")
    1

    Raises
    ------

    TypeError
        If the font couldn't be loaded due to various reasons.
    """
    a=Path(font_path)
    assert a.exists(), f"font doesn't exists at {a.absolute()}"
    font_path = str(a.absolute())
    font_path_bytes=font_path.encode()
    cdef const unsigned char* fontPath = font_path_bytes
    fontAddStatus = FcConfigAppFontAddFile(FcConfigGetCurrent(), fontPath)
    if fontAddStatus:
        return 1
    else:
        raise TypeError("Could not load font from file %s"%fontPath)
