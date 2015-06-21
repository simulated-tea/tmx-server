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

_checkPngContains = (png, x, y) ->
  maxIndex = y*png.width + x << 2
  unless png.data.length >= maxIndex
    throw 'Given PNG appears to be too small to contain the requested area of manipulation'

exports.fillRectangle = (png, color, x, y, width, height) ->
  _checkPngContains png, x+width-1, y+height-1
  for v in [y..y+height-1]
    index = (png.width*v + x) << 2
    (new Buffer [].repeat width-1, [
      255*color.red(),
      255*color.green(),
      255*color.blue(),
      255,
    ]).copy png.data, index

_upperRightCornerPixelOfEnclosingRectangleInIsoGrid = (x, y) ->
  [
    tileWidth*(x-1) + (if y % 2 == 0 then 32 else 0), # No - ????
    tileHeight*(y-1)/2,
  ]

exports.assertInnerColorOnIsoGrid = (png, color, tileX, tileY) ->
  tileX ?= 1
  tileY ?= 1
  [tileOffsetX, tileOffsetY] = _upperRightCornerPixelOfEnclosingRectangleInIsoGrid tileX, tileY
  for [x,y] in pixel.innerRhombus tileHeight, tileOffsetX, tileOffsetY
    index = (png.width*y + x) << 2
    _assertColorOfPixelInPng png, index, color, x, y

_assertColorOfPixelInPng = (png, index, color, x, y) ->
  actual = png.data.slice index, index+4
  expect = new Buffer [
    255*color.red(),
    255*color.green(),
    255*color.blue(),
    255,
  ]
  assert actual.equals(expect), """
    \tpixel at [#{x},#{y}]
    \tshould have been #{expect.toString 'hex'} but was #{actual.toString 'hex'}
    """

