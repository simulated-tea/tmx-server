fs = require 'fs'
config = require 'config'
js = require '../util/language'
tile = require './tile_tools'
{PNG} = require 'pngjs'

tileWidth = config.get 'prerenderer.tiles.widthInPixel'
tileHeight = config.get 'prerenderer.tiles.heightInPixel'
tMapWidth = config.get 'resources.grassland.widthInTiles'
tMapHeight = config.get 'resources.grassland.heightInTiles'

class Prerenderer
  constructor: () ->
    this

  to: (response, mapDescription) ->
    that = @
    fs.createReadStream 'resources/grassland_tiles.png'
      .pipe new PNG filterType: 4
      .on 'parsed', ->
        mapPng = that.buildPng @, mapDescription
        mapPng.pack().pipe(response)

  buildPng: (tilemap, mapDescription) ->
    mapWidthInTiles = mapDescription.width
    mapHeightInTiles = mapDescription.height
    mapDetails = mapDescription.layers[0]
    map = new PNG width: mapWidthInTiles*tileWidth + tileWidth/2, height: (mapHeightInTiles+1)*tileHeight/2
    for [x, y] in js.carthesianProduct [1..mapWidthInTiles], [1..mapHeightInTiles]
      descriptionIndex = mapWidthInTiles*(y-1) + (x-1)
      tilemapIndex = mapDetails.data[descriptionIndex]
      tile.addTile tilemap, @getTileCoordinatesOnTilemap(tilemapIndex)..., map, x, y
    map

  getTileCoordinatesOnTilemap: (index) ->
    [
      (index - 1) %% tMapWidth + 1
      (index - 1) // tMapWidth + 1
    ]

module.exports = Prerenderer
