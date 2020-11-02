#include <cairo.h>
#include <math.h>
#include <cairo-svg.h>
#include <cairo.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <pango/pangocairo.h>

void text2svg(char* text, char* font,int WIDTH,int HEIGHT,float START_X,float START_Y,double width_layout);

void text2svg(char* text, char* font, int WIDTH,int HEIGHT,float START_X,float START_Y ,double width_layout)
{
    //some variable deinition
    cairo_surface_t *surface=NULL;
    cairo_t *cr=NULL;
    PangoLayout *pc=NULL;

    // create surface and necessary cairo context
    surface = cairo_svg_surface_create ("some_chk.svg",WIDTH, HEIGHT);
    if (NULL == surface) {
        printf("+ error: cannot surface the cairo.\n");
        exit(1);
    }
    cr = cairo_create (surface);
    if (NULL == cr) {
        printf("+ error: cannot context the cairo.\n");
        exit(1);
    }
    //create pango context
    pc = pango_cairo_create_layout(cr);
    if (NULL == pc) {
        printf("+ error: cannot create the pango layout.\n");
        exit(1);
    }
    cairo_move_to (cr,START_X,START_Y);
    //pango_layout_set_width(pc,width_layout);

    double xc = 128.0;
    double yc = 128.0;
    double radius = 100.0;
    double angle1 = 45.0  * (M_PI/180.0);  /* angles are specified */
    double angle2 = 180.0 * (M_PI/180.0);  /* in radians           */

    cairo_set_line_width (cr, 10.0);
    cairo_arc (cr, xc, yc, radius, angle1, angle2);
    cairo_stroke (cr);

    /* draw helping lines */
    cairo_set_source_rgba (cr, 1, 0.2, 0.6, 0.6);
    cairo_set_line_width (cr, 6.0);

    cairo_arc (cr, xc, yc, 10.0, 0, 2*M_PI);
    cairo_fill (cr);

    cairo_arc (cr, xc, yc, radius, angle1, angle1);
    cairo_line_to (cr, xc, yc);
    cairo_arc (cr, xc, yc, radius, angle2, angle2);
    cairo_line_to (cr, xc, yc);
    cairo_stroke (cr);

    // save as text.png uncomment the bellow line for that
    //cairo_surface_write_to_png (surface, "text.png");
    // needs to be in c alway we should destroy what we create or else it wont save
    // I just found that surface.finish() in pycairo does this. ;-)
    cairo_destroy (cr);
    cairo_surface_destroy (surface);
    g_object_unref(pc);

    printf(text);
    printf(font);
}

int
main (void)
{
    double a=5;
    text2svg("hi","sans",600,800,0,0,a);
}

