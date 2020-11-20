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

cimport ctext2np
from .buf cimport Buffer
from .ctext2svg import TextInfo
cdef class Text2np(Buffer):

    cdef int size
    cdef unsigned char *buf
    cdef cairo_t* cr
    cdef cairo_surface_t* surface
    def __cinit__(self, text_info:TextInfo):
        """
        This is the main function which actually converts
        the :class:`TextInfo` to an Numpy Array.

        Parameters
        ==========
        text_info : :class:`TextInfo`
            The returned value from :class:`TextInfo`.

        Returns
        =======
        :class:`int`
            Either 0 or 1
            1 means it worked without any error.

        Raises
        ------

        MemoryError
            When ran out of Memory.
        Exception
            When ``cairo.Context`` returns any error this is raised.
        """
        if not isinstance(text_info,TextInfo):
            raise ValueError("text_info is not a instance of TextInfo")
        text_info.__dict__()
        cdef cairo_surface_t* surface
        cdef cairo_t* cr
        cdef PangoFontDescription* font_desc
        cdef PangoLayout* layout
        cdef double width_layout = text_info.width
        cdef double font_size_c=text_info.font_size
        cdef cairo_status_t status
        cdef PangoFontMap* mPangoFontMap
        cdef PangoContext* mPangoContext
        cdef PangoAttrList* pango_attr_list = pango_attr_list_new ()
        cdef PangoAttribute * attr
        cdef PangoColor color_c
        if pango_attr_list == NULL:
            raise MemoryError("PangoAttrList can't be initialised")
        surface = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, text_info.width, text_info.height)
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
            pango_attr_list_unref (pango_attr_list)
            raise Exception("Cairo is not Compiled with Fontconfig and FreetType Enabled.")
        mPangoContext = pango_font_map_create_context(mPangoFontMap)
        layout = pango_layout_new(mPangoContext)
        #layout = pango_cairo_create_layout(cr)
        if layout==NULL:
            cairo_destroy(cr)
            cairo_surface_destroy(surface)
            pango_attr_list_unref (pango_attr_list)
            raise MemoryError("Pango.Layout can't be created from Cairo Context.")

        pango_layout_set_width(layout, pango_units_from_double(width_layout))
        font_desc = pango_font_description_new()
        if font_desc==NULL:
            cairo_destroy(cr)
            cairo_surface_destroy(surface)
            g_object_unref(layout)
            pango_attr_list_unref (pango_attr_list)
            raise MemoryError("Pango.FontDesc can't be created.")
        pango_font_description_set_size(font_desc, pango_units_from_double(font_size_c))
        pango_font_description_set_family(font_desc, text_info.font)
        pango_font_description_set_style(font_desc, text_info.font_style)
        pango_font_description_set_weight(font_desc, text_info.font_weight)
        pango_font_description_set_variant(font_desc, text_info.font_variant)
        pango_layout_set_font_description(layout, font_desc)
        if text_info.text_setting:
            for setting in text_info.text_setting:
                if setting.font:
                    print(f"Setting Font {setting.font}")
                    attr = pango_attr_family_new(setting.font)
                    attr.start_index = setting.start
                    attr.end_index = setting.end
                    pango_attr_list_insert(pango_attr_list,attr)
                if setting.style:
                    print(f"Setting style {setting.style}")
                    attr = pango_attr_style_new(setting.style.value)
                    attr.start_index = setting.start
                    attr.end_index = setting.end
                    pango_attr_list_insert(pango_attr_list,attr)
                if setting.weight:
                    print(f"Setting weight {setting.weight}")
                    attr = pango_attr_weight_new(setting.weight.value)
                    attr.start_index = setting.start
                    attr.end_index = setting.end
                    pango_attr_list_insert(pango_attr_list,attr)
                if setting.variant:
                    print(f"Setting variant {setting.variant}")
                    attr = pango_attr_variant_new (setting.variant.value)
                    attr.start_index = setting.start
                    attr.end_index = setting.end
                    pango_attr_list_insert(pango_attr_list,attr)
                if setting.foreground_color:
                    print(f"Setting foreground_color {setting.foreground_color}")
                    chk = pango_color_parse(&color_c,setting.foreground_color)
                    if chk:
                        print("Valid Color")
                        attr=pango_attr_foreground_new(color_c.red,color_c.green,color_c.blue)
                    else:
                        raise Exception("Invalid Colour")
                    attr.start_index = setting.start
                    attr.end_index = setting.end
                    pango_attr_list_insert(pango_attr_list,attr)
        pango_layout_set_text(layout, text_info.text, -1)
        pango_layout_set_attributes(layout,pango_attr_list)
        pango_cairo_show_layout(cr, layout)

        status = cairo_status(cr)
        if cr == NULL or status == CAIRO_STATUS_NO_MEMORY:
            cairo_destroy(cr)
            cairo_surface_destroy(surface)
            g_object_unref(layout)
            pango_attr_list_unref (pango_attr_list)
            raise MemoryError("Cairo.Context can't be created.")
        elif status != CAIRO_STATUS_SUCCESS:
            cairo_destroy(cr)
            cairo_surface_destroy(surface)
            g_object_unref(layout)
            pango_attr_list_unref (pango_attr_list)
            raise Exception(cairo_status_to_string(status).decode())

        g_object_unref(mPangoFontMap)
        g_object_unref(mPangoContext)
        g_object_unref(layout)
        pango_attr_list_unref (pango_attr_list)

        buf = cairo_image_surface_get_data (surface);


        height = cairo_image_surface_get_height (surface);
        stride = cairo_image_surface_get_stride (surface);


        self.buf = buf
        self.cr = cr
        self.surface = surface
        self.size = height * stride

    cdef size_t _buffer_size(self):
        return self.size
    cdef void * _buffer_ptr(self):
        cairo_destroy(self.cr)
        cairo_surface_destroy(self.surface)
        return self.buf
    cdef bint _buffer_writable(self):
        return False
