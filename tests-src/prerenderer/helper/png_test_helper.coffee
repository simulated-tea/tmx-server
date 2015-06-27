{assert} = require 'buster'
config = require 'config'
js = require '../../../lib/util/language'

tileWidth = config.get 'prerenderer.tiles.widthInPixel'
tileHeight = config.get 'prerenderer.tiles.heightInPixel'

exports.fillPng = (png, color) -> exports.fillRectangle png, color, 0, 0, png.width, png.height

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

_checkPngContains = (png, x, y) ->
  maxIndex = y*png.width + x << 2
  unless png.data.length >= maxIndex
    throw 'Given PNG appears to be too small to contain the requested area of manipulation'

exports.assertColorOnRectangle = (png, color, tileX, tileY) ->
  [tileOffsetX, tileOffsetY] = _upperRightCornerPixelOfEnclosingRectangleInIsoGrid tileX, tileY
  for [x,y] in js.carthesianProduct [tileOffsetX..tileOffsetX+tileHeight-1], [tileOffsetY..tileOffsetY+tileHeight-1]
    index = (png.width*y + x) << 2
    _assertColorOfPixelInPng png, index, color, x, y

_upperRightCornerPixelOfEnclosingRectangleInIsoGrid = (x, y) ->
  [
    tileWidth*(x-1) + (if y % 2 == 0 then 32 else 0),
    tileHeight*(y-1)/2,
  ]

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

