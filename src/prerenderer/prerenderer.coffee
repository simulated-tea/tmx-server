require '../util/language'
config = require 'config'
fs = require 'fs'
{PNG} = require 'pngjs'
LayerTools = require './layer_tools'

class Prerenderer
  tilemaps: {
    default: 'grassland'
  }
  constructor: () ->
    tilemap = @tilemaps
    fs.createReadStream 'resources/grassland_tiles.png'
      .pipe new PNG filterType: 4
      .on 'parsed', ->
        tilemap.grassland = @
    @

  to: (response, mapDescription) ->
    layerTool = new LayerTools mapDescription.layers[0], @tilemaps.grassland
    layerPng = layerTool.render()
    layerPng.pack().pipe(response)

module.exports = Prerenderer
