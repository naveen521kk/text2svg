cdef extern from "glib.h":
    ctypedef int gint

cdef extern from "cairo.h":
    ctypedef struct cairo_surface_t:
        pass
    ctypedef struct cairo_t:
        pass
    cairo_t* cairo_create(cairo_surface_t* target)
    void cairo_move_to(cairo_t* cr, double x, double y)
    void cairo_destroy(cairo_t* cr)
    void cairo_surface_destroy (cairo_surface_t* surface)

cdef extern from "cairo-svg.h":
    cairo_surface_t* cairo_svg_surface_create(const char *filename,double	width_in_points,double	height_in_points)

cdef extern from "pango/pango-layout.h":
    ctypedef struct PangoLayout:
        pass
    void pango_layout_set_width(PangoLayout* layout,int width)
    void pango_layout_set_font_description (PangoLayout* layout, const PangoFontDescription* desc)
    void pango_layout_set_text (PangoLayout* layout,const char* text,int length)

cdef extern from "pango/pango-font.h":
    ctypedef struct PangoFontDescription:
        pass
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
    PangoFontDescription* pango_font_description_new()
    void pango_font_description_set_size(PangoFontDescription* desc,gint size)
    void pango_font_description_set_family(PangoFontDescription* desc,const char* family)
    void pango_font_description_set_style(PangoFontDescription* desc,PangoStyle style)
    void pango_font_description_set_weight (PangoFontDescription* desc,PangoWeight weight)
cdef extern from "pango/pangocairo.h":
    PangoLayout* pango_cairo_create_layout(cairo_t* cr)
    void pango_cairo_show_layout (cairo_t* cr,PangoLayout* layout)



#cdef extern from "text2svg.h":
#    cdef int text2svg(const char *text, const char *filename, const char *font, int width, int height, float START_X, float START_Y, double width_layout, gint font_size, PangoStyle font_style, PangoWeight font_weight)