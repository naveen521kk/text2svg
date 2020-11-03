cdef extern from "glib.h":
    ctypedef int gint

cdef extern from "pango/pango.h":
    ctypedef enum PangoStyle:
        PANGO_STYLE_NORMAL
        PANGO_STYLE_OBLIQUE
        PANGO_STYLE_ITALIC
    ctypedef enum PangoWeight:
        PANGO_WEIGHT_THIN
        PANGO_WEIGHT_ULTRALIGHT
        PANGO_WEIGHT_LIGHT
        PANGO_WEIGHT_SEMILIGHT
        PANGO_WEIGHT_BOOK
        PANGO_WEIGHT_NORMAL
        PANGO_WEIGHT_MEDIUM
        PANGO_WEIGHT_SEMIBOLD
        PANGO_WEIGHT_BOLD
        PANGO_WEIGHT_ULTRABOLD
        PANGO_WEIGHT_HEAVY
        PANGO_WEIGHT_ULTRAHEAVY

cdef extern from "text2svg.h":
    cdef int text2svg(const char *text, const char *filename, const char *font, int width, int height, float START_X, float START_Y, double width_layout, gint font_size, PangoStyle font_style, PangoWeight font_weight)