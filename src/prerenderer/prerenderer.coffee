require '../util/language'
config = require 'config'
fs = require 'fs'
{PNG} = require 'pngjs'
{EventEmitter} = require 'events'
LayerTools = require './layer_tools'

class Prerenderer extends EventEmitter
  constructor: ->
    @tilemaps = { default: 'grassland' }
    that = @
    fs.createReadStream 'resources/grassland_tiles.png'
      .pipe new PNG filterType: 4
      .on 'parsed', ->
        unless that.tilemaps.grassland?
          that.tilemaps.grassland = @
          that.emit 'ready'

  to: (response, mapDescription, callback) ->
    layer = mapDescription.layers[0]
    #cheat:
    layer.width = 18
    layer.height = 50

    layerTool = new LayerTools layer, @tilemaps.grassland
    layerPng = layerTool.render()
    layerPng.pack().pipe response
    layerPng.on 'end', callback if callback?

module.exports = Prerenderer
