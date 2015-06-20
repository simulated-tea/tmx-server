fs = require 'fs'
config = require 'config'
tile = require './tile_tools'
{PNG} = require 'pngjs'

class Prerenderer
  constructor: () ->
    this

  to: (response, params) ->
    section = new PNG width: 64, height: 32
    fs.createReadStream 'resources/grassland_tiles.png'
      .pipe new PNG filterType: 4
      .on 'parsed', ->
        tile.copy @, 1, 1, section, 1, 1
        section.pack().pipe(response)

module.exports = Prerenderer
