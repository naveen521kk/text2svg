project('text2svg', 'c',
  version : '0.1',
  default_options : ['warning_level=3'])

pango = dependency('pango', required: true)
cairo = dependency('cairo', required: true)
pangocairo = dependency('pangocairo', required: true)
freetype = dependency('freetype', required: true)
pangoft2 = dependency('pangoft2',required: true)

executable('text2svg',
           'main.c',
		  dependencies: [pango,cairo,pangocairo,freetype,pangoft2])
		  
library('text2svg','main.c',dependencies: [pango,cairo,pangocairo,freetype,pangoft2])
