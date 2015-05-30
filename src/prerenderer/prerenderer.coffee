fs = require 'fs'
{PNG} = require 'pngjs'

class Prerenderer
  constructor: () ->
    this

  to: (response, params) ->
    section = new PNG width: 64, height: 32
    fs.createReadStream 'resources/grassland_tiles.png'
      .pipe new PNG filterType: 4
      .on 'parsed', ->
        for y in [0..31]
          for x in [0..63]
            src_idx = @width*y + x << 2
            dst_idx = 64*y + x << 2
            @data.copy section.data, dst_idx, src_idx, src_idx+4

        section.pack().pipe(response)

module.exports = Prerenderer
