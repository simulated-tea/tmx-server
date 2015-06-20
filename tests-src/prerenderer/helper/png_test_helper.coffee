{assert} = require 'buster'
config = require 'config'
js = require '../../../lib/util/language'
pixel = require '../../../lib/prerenderer/pixel_tools'

tileWidth = config.get 'prerenderer.tiles.widthInPixel'
tileHeight = config.get 'prerenderer.tiles.heightInPixel'

exports.fillPng = (png, color) ->
  for [x,y] in js.carthesianProduct [0..png.width-1], [0..png.height-1]
    index = (png.width*y + x) << 2
    (new Buffer [
      255*color.red(),
      255*color.green(),
      255*color.blue(),
      255,
    ]).copy png.data, index

exports.assertInnerColor = (png, color, tileX, tileY) ->
  tileX ?= 0
  tileY ?= 0
  tileOffsetX = tileWidth*tileX
  tileOffsetY = tileHeight*tileY

  for [x,y] in pixel.innerRhombus tileHeight
    index = (tileWidth*y + x) << 2
    _assertColorOfPixelInPng png, index, color, x, y


_assertColorOfPixelInPng = (png, index, color, x, y) ->
  actual = png.data.slice index, index+4
  expect = new Buffer [
    255*color.red(),
    255*color.green(),
    255*color.blue(),
    255,
  ]
  assert actual.equals(expect), "pixel at [#{x},#{y}] should have been data #{expect.toString 'hex'} but was #{actual.toString 'hex'}"

