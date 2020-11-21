===================
Installing Text2SVG
===================

Windows
*******

**Windows is our first class citizen**

Wheels are prepared (or maybe crafted) for Windows, so that they work simply
without any need of compiling C stuff.

To install typing in the following in a terminal will work

.. code-block:: powershell

   pip install text2svg

MacOS
*****

There exists wheels for MacOS but aren't tested.
If those doesn't work, install pango and cairo using brew

.. code-block:: sh

   brew install pango cairo

Then installing no binary version will work.

.. code-block:: sh

	pip install text2svg --no-binary :all:

Linux
*****

Install Cairo and Pango along with dev headers and also pkg-config.
Using no-binary install is recommended.

.. code-block:: sh

	pip install text2svg --no-binary :all:
