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

cdef extern from "Python.h" nogil:

    cdef int Py_AddPendingCall(void *, void *)
    void PyErr_PrintEx(int set_sys_last_vars)
    int Py_IsInitialized()
    void PyErr_Display(object, object, object)
cdef extern from "glib.h":
    ctypedef void* gpointer
    ctypedef int gint
    ctypedef unsigned int guint
    ctypedef gint gboolean
    ctypedef unsigned short guint16
    ctypedef char gchar
    ctypedef enum GLogLevelFlags:
        G_LOG_LEVEL_ERROR
        G_LOG_LEVEL_CRITICAL
        G_LOG_LEVEL_WARNING
        G_LOG_LEVEL_MESSAGE
        G_LOG_LEVEL_INFO
        G_LOG_LEVEL_DEBUG
        G_LOG_LEVEL_MASK
        G_LOG_FLAG_FATAL
        G_LOG_FLAG_RECURSION
    ctypedef void(*GLogFunc) (const gchar *log_domain,
             GLogLevelFlags log_level,
             const gchar *message,
             gpointer user_data)
    GLogFunc g_log_set_default_handler(GLogFunc log_func,gpointer user_data)

cdef void initialise_logger()
