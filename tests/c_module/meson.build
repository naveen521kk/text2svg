project('text2svg', 'c',
  version : '0.1.0',
  default_options : ['warning_level=3'])

pango = dependency('pango', required: true)
cairo = dependency('cairo', required: true)
pangocairo = dependency('pangocairo', required: true)
pangoft2 = dependency('pangoft2',required: true)

executable('text2svg',
           'text2svg.c',
		  dependencies: [pango,cairo,pangocairo,pangoft2],
		  install : true)
		  
library('text2svg','text2svg.c',dependencies: [pango,cairo,pangocairo,pangoft2],install: true)
install_headers('text2svg.h')

pkg = import('pkgconfig')

pkg.generate(
  name: 'text2svg',
  description: 'Convert Text to SVG using cairo and Pango',
  requires: [cairo,pango,pangocairo,pangoft2],
)