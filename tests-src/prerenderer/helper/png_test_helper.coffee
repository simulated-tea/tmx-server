{assert} = require 'buster'
config = require 'config'

tileWidth = config.get 'prerenderer.tiles.widthInPixel'
tileHeight = config.get 'prerenderer.tiles.heightInPixel'

exports.fillPng = (png, color) ->
  for y in [0..png.height-1]
    for x in [0..png.width-1]
      index = (png.width*y + x) << 2
      png.data[index]   = 255*color.red()
      png.data[index+1] = 255*color.green()
      png.data[index+2] = 255*color.blue()
      png.data[index+3] = 255

exports.assertInnerColor = (png, color, tileX, tileY) ->
  tileX ?= 0
  tileY ?= 0
  tileOffsetX = tileWidth*tileX
  tileOffsetY = tileHeight*tileY

  half_y = last_pixel_before_middle = tileHeight/2-1
  half_x = last_pixel_before_center = tileWidth/2-1
  for y in [tileOffsetY+0..tileOffsetY+half_y]
    rhombusOffset = Math.max 0, half_x-2*y
    for x in [tileOffsetX+rhombusOffset..tileOffsetX+tileWidth-rhombusOffset]
      index = (tileWidth*y + x) << 2
      _assertOn png, index, color, x, y

  for y in [tileOffsetY+half_y..tileOffsetY+0]
    rhombusOffset = Math.max 0, half_x-2*y
    for x in [tileOffsetX+rhombusOffset..tileOffsetX+tileWidth-rhombusOffset]
      index = (tileWidth*y + x) << 2
      _assertOn png, index, color, x, y

_assertOn = (png, index, color, x, y) ->
  assert.equals png.data[index],   255*color.red(),   "red @(#{x},#{y})"
  assert.equals png.data[index+1], 255*color.green(), "green @(#{x},#{y})"
  assert.equals png.data[index+2], 255*color.blue(),  "blue @(#{x},#{y})"
  assert.equals png.data[index+3], 255*color.alpha(), "alpha @(#{x},#{y})"

