config = require 'config'
pixel = require './pixel_tools'

tileHeight = config.get 'prerenderer.tiles.heightInPixel'

exports.copy = (source, src_x, src_y, target, trg_x, trg_y) ->
  for [x,y] in pixel.outerRhombus tileHeight, 0, 0
    src_idx = 64*y + x << 2
    dst_idx = target.width*y + x << 2
    source.data.copy target.data, dst_idx, src_idx, src_idx+4
