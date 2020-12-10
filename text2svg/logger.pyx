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
    logging.pyx
    ~~~~~~~~~~~

    This modules helps in translating Glib logging
    to Python Logger.

    :copyright: Copyright 2020 by Naveen M K
    :licence: GPLv3, See LICENSE for details.

"""
cimport logger
import logging as pylogging
import warnings as pywarnings
from libc.stdio cimport fprintf, printf, stderr

cdef void log_handler_cb(const gchar* log_domain,GLogLevelFlags log_level,const gchar* message,gpointer user_data) nogil:
    cdef bint inited = Py_IsInitialized()
    if not inited:
        return

    with gil:
        try:
            log_callback_gil(log_level, log_domain, message)
        except Exception as e:
            fprintf(stderr, "Exception\n")

cdef void log_callback_gil(int log_level,const char * log_domain,const char * c_message):
    _logger = pylogging.getLogger(name=log_domain.decode('utf8'))
    message = (<bytes>c_message).decode('utf8')
    #print(message)
    if log_level == G_LOG_LEVEL_ERROR:
        _logger.error(message)
    elif log_level == G_LOG_LEVEL_CRITICAL:
        _logger.critical(message)
    elif log_level == G_LOG_LEVEL_WARNING:
        pywarnings.warn(message)
    elif log_level == G_LOG_LEVEL_INFO:
        _logger.info(message)
    elif log_level == G_LOG_LEVEL_MESSAGE:
        _logger.info(message)
    elif log_level == G_LOG_LEVEL_DEBUG:
        _logger.debug(message)
    else:
        _logger.info(message)

cdef void initialise_logger():
    g_log_set_default_handler(log_handler_cb,NULL)
