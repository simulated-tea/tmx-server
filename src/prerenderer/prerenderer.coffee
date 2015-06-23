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
    map = new PNG width: mapWidthInTiles*tileWidth, height: (mapHeightInTiles+1)*tileHeight/2
    for [x, y] in js.carthesianProduct [1..mapWidthInTiles], [1..mapHeightInTiles]
      descriptionIndex = mapWidthInTiles*y + x
      tilemapIndex = mapDetails.data[descriptionIndex]
      tile.addTile tilemap, @getTileCoordinatesOnTilemap(tilemapIndex)..., map, x, y
    console.log 'done. delivering map'
    map

  getTileCoordinatesOnTilemap: (index) ->
    [
      index %% tMapWidth + 1
      index // tMapWidth + 1
    ]

  getTileCoordinatesOnIsoMap: (index, mapWidth) ->
    [
      index %% mapWidth + 1
      index // mapWidth + 1
    ]

module.exports = Prerenderer
