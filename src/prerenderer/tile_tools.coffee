config = require 'config'
pixel = require './pixel_tools'

tileWidth = config.get 'prerenderer.tiles.widthInPixel'
tileHeight = config.get 'prerenderer.tiles.heightInPixel'

_copyPixelInPng = (source, target, x, y) ->
  src_idx = source.width*y + x << 2
  dst_idx = target.width*y + x << 2
  source.data.copy target.data, dst_idx, src_idx, src_idx+4

exports.copy = (source, src_x, src_y, target, trg_x, trg_y) ->
  x_off_src = tileWidth*(src_x-1)
  y_off_src = tileHeight*(src_y-1)
  for [x,y] in pixel.outerRhombus tileHeight, x_off_src, y_off_src
    _copyPixelInPng source, target, x, y
