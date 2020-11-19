# -*- coding: utf-8 -*-
from .ctext2svg import Style, Variant, Weight, valid_color


class CharSettings:
    def __init__(
        self,
        start: int,
        end: int,  # . The last character not included.
        font: str = None,
        style: Style = None,
        weight: Weight = None,
        variant: Variant = None,
        foreground_color: str = None,
    ):
        self.start = start
        self.end = end
        self.font = font.encode()
        self.style = style
        self.weight = weight
        self.variant = variant
        self.foreground_color = foreground_color

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
        assert valid_color(
            foreground_color
        ), "Pango couldn't understand the colour please check it"
        self._foreground_color = foreground_color.encode()
