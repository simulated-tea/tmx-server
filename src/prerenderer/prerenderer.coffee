fs = require 'fs'
{PNG} = require 'pngjs'

class Prerenderer
  constructor: () ->
    this

  to: (response, params) ->
    fs.createReadStream 'resources/grassland_tiles.png'
      .pipe new PNG filterType: 4
      .on 'parsed', ->
        for y in [1..@height]
            for x in [1..@width]
              idx = @width*y + x << 2


        @pack().pipe(response)

module.exports = Prerenderer
