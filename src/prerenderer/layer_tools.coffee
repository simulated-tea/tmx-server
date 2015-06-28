require '../util/language'
config = require 'config'
{PNG} = require 'pngjs'


class LayerTools
  tileWidth: config.get 'prerenderer.tiles.widthInPixel'
  tileHeight: config.get 'prerenderer.tiles.heightInPixel'
  tMapWidth: config.get 'resources.grassland.widthInTiles'
  tMapHeight: config.get 'resources.grassland.heightInTiles'
  tileTools: require './tile_tools'
  layerWidth: null
  layerHeight: null
  tilemap: null
  data: null
  constructor: (layer, tilemap) ->
    @tilemap = tilemap
    @layerWidth = layer.width
    @layerHeight = layer.height
    @data = layer.data

  render: ->
    png = new PNG @layerSizeInPixel()
    for [x, y] in carthesianProduct [1..@layerWidth], [1..@layerHeight]
      tilemapIndex = @data[@layerWidth*(y-1) + (x-1)]
      @tileTools.addTile @tilemap, @getTileCoordinatesOnTilemap(tilemapIndex)..., png, x, y
    png

  layerSizeInPixel: ->
    width: @layerWidth*@tileWidth + @tileWidth/2
    height: (@layerHeight+1)*@tileHeight/2

  getTileCoordinatesOnTilemap: (index) -> [
      (index - 1) %% @tMapWidth + 1
      (index - 1) // @tMapWidth + 1
    ]

module.exports = LayerTools
