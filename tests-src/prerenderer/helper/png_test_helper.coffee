{assert} = require 'buster'

exports.fillPng = (png, color) ->
  for y in [0..png.height-1]
    for x in [0..png.width-1]
      index = (png.width*y + x) << 2
      png.data[index]   = 255*color.red()
      png.data[index+1] = 255*color.green()
      png.data[index+2] = 255*color.blue()
      png.data[index+3] = 255

_assertOn = (png, index, color, x, y) ->
  assert.equals png.data[index],   255*color.red(),   "red @(#{x},#{y})"
  assert.equals png.data[index+1], 255*color.green(), "green @(#{x},#{y})"
  assert.equals png.data[index+2], 255*color.blue(),  "blue @(#{x},#{y})"
  assert.equals png.data[index+3], 255*color.alpha(), "alpha @(#{x},#{y})"

exports.assertInnerColor = (png, color) ->
  half_y = last_pixel_before_middle = png.height/2-1
  half_x = last_pixel_before_center = png.width/2-1
  for y in [0..half_y]
    offset = Math.max 0, half_x-2*y
    for x in [offset..png.width-offset]
      index = (png.width*y + x) << 2
      _assertOn png, index, color, x, y

  for y in [half_y..0]
    offset = Math.max 0, half_x-2*y
    for x in [offset..png.width-offset]
      index = (png.width*y + x) << 2
      _assertOn png, index, color, x, y

