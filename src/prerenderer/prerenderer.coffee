fs = require 'fs'
config = require 'config'
pixel = require './pixel_tools'
{PNG} = require 'pngjs'

class Prerenderer
  constructor: () ->
    this

  to: (response, params) ->
    section = new PNG width: 64, height: 32
    fs.createReadStream 'resources/grassland_tiles.png'
      .pipe new PNG filterType: 4
      .on 'parsed', ->
        @copyTile @, 1, 1, section, 1, 1
        section.pack().pipe(response)

  copyTile: (source, src_x, src_y, target, trg_x, trg_y) ->
    for [x,y] in pixel.innerRhombus config.get 'prerenderer.tiles.heightInPixel', 0, 0
      src_idx = @width*y + x << 2
      dst_idx = target.width*y + x << 2
      source.data.copy target.data, dst_idx, src_idx, src_idx+4

module.exports = Prerenderer
