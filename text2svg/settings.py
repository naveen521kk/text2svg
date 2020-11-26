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

from .ctext2svg import Style, Variant, Weight, valid_color


class CharSettings:
    """
    This is the class which validates the arguments passed.
    This must be passed to :func:`text2svg`.

    Parameters
    ----------
    start : :class:`int`
        The index of text attribute to start.
    end : :class:`int`
        The index of text attribute to end.

        .. important::

            The last index is ignorned.
    font : Optional[:class:`str`], optional
        The font of the selected index.
    style : Optional[:class:`Style`], optional
        The Style of the selected index.
    weight : Optional[:class:`Weight`], optional
        The Weight of the selected index.
    variant : Optional[:class:`Variant`], optional
        The Variant of the selected index.
    foreground_color : Optional[:class:`str`], optional
        The fore_ground colour of the selected index.

    Returns
    -------
    :class:`CharSettings`
        The generated :class:`CharSetting` attrribute.

    Examples
    --------
    >>> CharSettings(1,6,font="Roboto",foregound_colour="RED")
    CharSettings(start=1,end=6)

    Raises
    ------

    AssertionError
        If something doesn't match the required datatype.
        Or seems to be invalid.
    """

    def __init__(
        self,
        start: int,
        end: int,  # . The last character not included.
        font: str = None,
        style: Style = Style.NORMAL,
        weight: Weight = Weight.NORMAL,
        variant: Variant = Variant.NORMAL,
        foreground_color: str = None,
    ):
        self.start = start
        self.end = end
        if font:
            self.font = font.encode()
        else:
            self.font = None
        self.style = style
        self.weight = weight
        self.variant = variant
        self.foreground_color = foreground_color

    def __repr__(self):
        return f"CharSettings(start={self.start},end={self.end})"

    @property
    def start(self):
        return self._start

    @start.setter
    def start(self, start: int):
        assert isinstance(start, int)
        self._start = start

    @property
    def end(self):
        return self._end

    @end.setter
    def end(self, end: int):
        assert isinstance(end, int)
        self._end = end

    @property
    def style(self):
        return self._style

    @style.setter
    def style(self, style: Style):
        assert isinstance(style, Style)
        self._style = style

    @property
    def weight(self):
        return self._weight

    @weight.setter
    def weight(self, weight: Weight):
        assert isinstance(weight, Weight)
        self._weight = weight

    @property
    def variant(self):
        return self._variant

    @variant.setter
    def variant(self, variant: Variant):
        assert isinstance(variant, Variant)
        self._variant = variant

    @property
    def foreground_color(self):
        return self._foreground_color

    @foreground_color.setter
    def foreground_color(self, foreground_color):
        if foreground_color:
            assert valid_color(
                foreground_color
            ), "Pango couldn't understand the colour please check it"
            self._foreground_color = foreground_color.encode()
        else:
            self._foreground_color = None
