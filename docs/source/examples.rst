********
Examples
********

Hello World
-----------

.. code-block:: python

	from text2svg import *
	text = TextInfo("Hello World","hello.svg",100,100)
	text2svg(text)

This will create a SVG file called ``hello.svg`` which has ``Hello World`` written on it.
You would get an svg file something like this.

.. image:: _static/example_hello_world.svg

Change Font using ``TFF`` file
------------------------------

Here we use `Tangerine <https://fonts.google.com/specimen/Tangerine>`_ font.
Download it from https://fonts.google.com/download?family=Tangerine.

.. code-block:: python

	from text2svg import *
	tff_file="Tangerine-Regular.ttf"
	font_family="Tangerine"
	register_font(tff_file)
	text = TextInfo("Hello Font","hello.svg",200,200,font=font_family,font_size=50)
	text2svg(text)

You would get an image like below one.

.. image:: _static/example_font.svg

Colouring Individual Characters
-------------------------------

Here, we are going to create a SVG file with ``Hello`` written
in ``RED`` and ``WORLD`` written in ``GREEN``.

.. code-block:: python
	
	from text2svg import *
	char = [CharSettings(0,5,foreground_color="RED")]
	char.append(CharSettings(6,11,foreground_color="GREEN"))
	text = TextInfo("Hello World","hello.svg",100,100,text_setting=char)
	text2svg(text)
