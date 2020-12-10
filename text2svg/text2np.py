# -*- coding: utf-8 -*-
from .ctext2np import Text2np
from .ctext2svg import TextInfo

try:
    import numpy as np
except ImportError:
    np = None


def text2np(text_info: TextInfo):
    buf = Text2np(text_info)
    data = np.ndarray(
        shape=(text_info.width, text_info.height), dtype=np.uint32, buffer=buf
    )
    return np.copy(data)
