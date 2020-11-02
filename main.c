#include <cairo.h>
#include <math.h>
#include <cairo-svg.h>
#include <freetype2/freetype/ftbitmap.h>
#include <stdio.h>
#include <stdlib.h>
#include <pango/pangocairo.h>
#include <pango/pangoft2.h>

void text2svg(const char *text,const char*filename, const char*font,int width,int height,float START_X,float START_Y,double width_layout, gint font_size,PangoStyle font_style,PangoWeight font_weight);

void text2svg(const char *text,const char*filename, const char*font,int width,int height,float START_X,float START_Y,double width_layout, gint font_size,PangoStyle font_style,PangoWeight font_weight)
{
    //some variable deinition
    cairo_surface_t *surface=NULL;
    cairo_t *cr=NULL;
    PangoLayout* layout = NULL;
    PangoFontDescription* font_desc = NULL;

    /* ------------------------------------------------------------ */
    /*                   I N I T I A L I Z E                        */
    /* ------------------------------------------------------------ */

    // create surface and necessary cairo context
    // simply assume that filename contains .svg if not a wrapper aroung this will handle it.
    surface = cairo_svg_surface_create (filename,width, height);
    if (NULL == surface) {
        printf("+ error: cannot surface the cairo.\n");
        exit(1);
    }

    cr = cairo_create (surface);
    if (NULL == cr) {
        printf("+ error: cannot context the cairo.\n");
        exit(1);
    }

	//move to specified locations
    cairo_move_to (cr,START_X,START_Y);

    //create pango context
    layout = pango_cairo_create_layout(cr);
    if (NULL == layout) {
        printf("+ error: cannot create the pango layout.\n");
        exit(1);
    }
    pango_layout_set_width(layout,width_layout * PANGO_SCALE);

	//declare font description
	font_desc = pango_font_description_new ();
	pango_font_description_set_size (font_desc, font_size * PANGO_SCALE);
	pango_font_description_set_family (font_desc, font);
	pango_font_description_set_style (font_desc,font_style);
	pango_font_description_set_weight (font_desc,font_weight);
	
	pango_layout_set_font_description (layout,font_desc);
	
	pango_layout_set_text (layout,text,-1);
	pango_cairo_show_layout (cr,layout);

    // save as text.png uncomment the bellow line for that
    //cairo_surface_write_to_png (surface, "text.png");
    // needs to be in c alway we should destroy what we create or else it wont save
    // I just found that surface.finish() in pycairo does this. ;-)
    // Also destroy one created from pango
    cairo_destroy (cr);
    cairo_surface_destroy (surface);
    g_object_unref(layout);
    printf(text);
    printf(font);
}

int
main (void)
{
    double a=200;
    int width=200;
    int height=200;
    float zero=0.3;
	gint font_size=20;
    text2svg("Love ❤️🔥 見 تشرفت ","fun.svg","sans",width,height,zero,zero,a,font_size,PANGO_STYLE_NORMAL,PANGO_WEIGHT_NORMAL);
}

