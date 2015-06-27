config = require 'config'
js = require '../util/language'

tileWidth = config.get 'prerenderer.tiles.widthInPixel'
tileHeight = config.get 'prerenderer.tiles.heightInPixel'

exports.addTile = (source, src_x, src_y, target, trg_x, trg_y) ->
  [x_off_src, y_off_src] = _upperRightCornerPixelOfEnclosingRectangleInTilemap src_x, src_y
  [x_off_trg, y_off_trg] = _upperRightCornerPixelOfEnclosingRectangleInIsoGrid trg_x, trg_y
  for y in [0..tileHeight-1] # performance critical pixel loop
    for x in [0..tileWidth-1]
      _addPixelInPngs source, x_off_src+x, y_off_src+y, target, x_off_trg+x, y_off_trg+y

_upperRightCornerPixelOfEnclosingRectangleInTilemap = (x, y) ->
  [
    tileWidth*(x-1)
    tileHeight*(y-1)
  ]

_upperRightCornerPixelOfEnclosingRectangleInIsoGrid = (x, y) ->
  [
    tileWidth*(x-1) + (if y % 2 == 0 then 32 else 0)
    tileHeight*(y-1)/2
  ]

_addPixelInPngs = (source, x, y, target, u, v) ->
  src_idx = source.width*y + x << 2
  dst_idx = target.width*v + u << 2
  pixel_a = source.data
  pixel_b = target.data

  red_a   = pixel_a.readUInt8 src_idx
  green_a = pixel_a.readUInt8 src_idx + 1
  blue_a  = pixel_a.readUInt8 src_idx + 2
  alpha_a = pixel_a.readUInt8 src_idx + 3

  red_b   = pixel_b.readUInt8 dst_idx
  green_b = pixel_b.readUInt8 dst_idx + 1
  blue_b  = pixel_b.readUInt8 dst_idx + 2
  alpha_b = pixel_b.readUInt8 dst_idx + 3

  chi = alpha_b*(255-alpha_a)/255
  alpha_o = alpha_a + chi
  pixel_b[dst_idx    ] = (red_a  *alpha_a + red_b  *chi)/alpha_o
  pixel_b[dst_idx + 1] = (green_a*alpha_a + green_b*chi)/alpha_o
  pixel_b[dst_idx + 2] = (blue_a *alpha_a + blue_b *chi)/alpha_o
  pixel_b[dst_idx + 3] = alpha_o
