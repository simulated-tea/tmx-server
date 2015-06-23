config = require 'config'
pixel = require './pixel_tools'

tileWidth = config.get 'prerenderer.tiles.widthInPixel'
tileHeight = config.get 'prerenderer.tiles.heightInPixel'

exports.copy = (source, src_x, src_y, target, trg_x, trg_y) ->
  x_off_src = tileWidth*(src_x-1)
  y_off_src = tileHeight*(src_y-1)
  [x_off_trg, y_off_trg] = _upperRightCornerPixelOfEnclosingRectangleInIsoGrid trg_x, trg_y
  for [x,y] in pixel.outerRhombus tileHeight, x_off_src, y_off_src
    _copyPixelInPngs source, x, y, target, x_off_trg+x, y_off_trg+y

_upperRightCornerPixelOfEnclosingRectangleInIsoGrid = (x, y) ->
  [
    tileWidth*(x-1) + (if y % 2 == 0 then -32 else 0), # here with - ?????
    tileHeight*(y-1)/2,
  ]

_copyPixelInPngs = (source, x, y, target, u, v) ->
  src_idx = source.width*y + x << 2
  dst_idx = target.width*v + u << 2
  source.data.copy target.data, dst_idx, src_idx, src_idx+4

_addPixelInPngs = (source, x, y, target, u, v) ->
  src_idx = source.width*y + x << 2
  dst_idx = target.width*v + u << 2
  addPixel = source.data.slice src_idx, src_idx+4
  originalPixel = target.data.slice dst_idx, dst_idx+4
  newPixel = _addPixelOver addPixel, originalPixel
  newPixel.copy target.data, dst_idx

_addPixelOver = (pixel_a, pixel_b) ->
  red_a = pixel_a.readUInt8 0
  green_a = pixel_a.readUInt8 1
  blue_a = pixel_a.readUInt8 2
  alpha_a = pixel_a.readUInt8 3

  red_b = pixel_b.readUInt8 0
  green_b = pixel_b.readUInt8 1
  blue_b = pixel_b.readUInt8 2
  alpha_b = pixel_b.readUInt8 3

  alpha_o = alpha_a + alpha_b*(255-alpha_a)/255
  new Buffer [
    (red_a*alpha_a + red_b*alpha_b*(255-alpha_a)/255)/alpha_o,
    (green_a*alpha_a + green_b*alpha_b*(255-alpha_a)/255)/alpha_o,
    (blue_a*alpha_a + blue_b*alpha_b*(255-alpha_a)/255)/alpha_o,
    alpha_o,
  ]

exports._addPixelOver = _addPixelOver
