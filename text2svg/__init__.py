# -*- coding: utf-8 -*-
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
    __init__.py
    ~~~~~~~~~~~

    Initialisation of the module is done here.

    :copyright: Copyright 2020 by Naveen M K
    :licence: GPLv3, See LICENSE for details.

"""
import os

from .__version__ import *  # noqa: F401,F403
from .settings import *  # noqa: F401,F403

if os.name == "nt":
    os.environ["PATH"] = (
        os.path.abspath(os.path.dirname(__file__))
        + os.pathsep
        + os.environ["PATH"]  # noqa: E501
    )
try:
    from .ctext2svg import *  # noqa: F401,F403
    from .ctext2np import *  # noqa: F401,F403
except ImportError:
    raise ImportError("Couldn't load the necessary Shared Libraries.")
