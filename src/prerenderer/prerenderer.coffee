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
        for y in [0..15]
          diagonal_offset = Math.max 0, 2*(15 - y)
          src_idx = @width*y + diagonal_offset << 2
          dst_idx = section.width*y + diagonal_offset << 2
          bytes_to_copy = section.width - 2*diagonal_offset << 2
          @data.copy section.data, dst_idx, src_idx, src_idx+bytes_to_copy

        for y in [16..31]
          diagonal_offset = Math.max 0, 2*(y - 16)
          src_idx = @width*y + diagonal_offset << 2
          dst_idx = section.width*y + diagonal_offset << 2
          bytes_to_copy = section.width - 2*diagonal_offset << 2
          @data.copy section.data, dst_idx, src_idx, src_idx+bytes_to_copy

        section.pack().pipe(response)

module.exports = Prerenderer
