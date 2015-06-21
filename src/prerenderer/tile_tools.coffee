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
