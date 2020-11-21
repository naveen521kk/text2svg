# -*- coding: utf-8 -*-
# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))


# -- Project information -----------------------------------------------------
from pathlib import Path

project = "Text2SVG"
copyright = "2020, Naveen M K"
author = "Naveen M K"

# The full version, including alpha/beta/rc tags
release = "0.2.0"


# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    "sphinx.ext.autodoc",
    "sphinx_copybutton",
    "sphinx.ext.napoleon",
    "sphinx.ext.autosummary",
    "sphinxext.opengraph",
    "sphinx_material",
]

# Automatically generate stub pages when using the .. autosummary directive
autosummary_generate = True

# Add any paths that contain templates here, relative to this directory.
templates_path = ["_templates"]

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = "sphinx_material"
html_baseurl = "https://text2svg.syrusdark.website"
html_logo = str(Path("_static/logo.png"))
html_favicon = str(Path("_static/favicon.ico"))
html_show_sphinx = False
html_theme_options = {
    "nav_title": "Text2SVG",
    "base_url": "https://text2svg.syrusdark.website/",
    "color_primary": "blue",
    "color_accent": "green",
    "theme_color": "E86342",
    "repo_url": "https://github.com/naveen521kk/text2svg",
    "repo_name": "Text2SVG",
    "html_minify": True,
    "css_minify": True,
    "logo_icon": "edit",
    "globaltoc_depth": 2,
    "nav_links": [{"href": "/reference", "title": "Reference", "internal": True}],
    "heroes": {
        "index": "Convert Text to SVG files easily.",
        "reference": "Python API reference",
        "install": "Installing Text2SVG",
    },
    "touch_icon": "apple-touch-icon.png",
    "version_dropdown": True,
    "version_dropdown_text": "Versions",
    "version_json": "_static/versions.json",
    "version_info": {
        "Release": "https://text2svg.syrusdark.website/",
        "Development": "https://text2svg.syrusdark.website/latest/",
        "Release (rel)": "/",
        "Development (rel)": "/latest/",
    },
}

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ["_static"]

html_sidebars = {"**": ["logo-text.html", "globaltoc.html", "searchbox.html"]}

ogp_image = "https://text2svg.syrusdark.website/_static/logo.png"
ogp_site_name = "Text2SVG | Documentation"
ogp_site_url = "https://text2svg.syrusdark.website/"

latex_logo = str(Path("_static/logo.png"))
