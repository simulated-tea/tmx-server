require '../../lib/util/language'

class MapGenerator
  constructor: () ->
    this

  get: (params) ->
    'x': params.x
    'y': params.y
    'z': 0
    'height': 30
    'layers': [
      'data': [
        5,  21, 16, 22, 23, 30, 30, 12, 8,  22, 7,  8,  29, 25, 16, 23, 8,  7,  19, 5,  5,  19, 14, 22, 7,  20, 8,  32, 15, 5,
        3,  5,  31, 11, 25, 29, 28, 13, 29, 32, 23, 32, 30, 14, 5,  3,  32, 9,  25, 14, 10, 27, 24, 3,  3,  4,  9,  31, 11, 31,
        25, 24, 6,  3,  23, 16, 8,  14, 27, 29, 24, 5,  30, 11, 8,  19, 3,  21, 30, 13, 10, 20, 32, 32, 5,  5,  24, 20, 22, 6,
        11, 28, 23, 31, 23, 27, 6,  19, 11, 31, 4,  29, 31, 13, 16, 20, 30, 7,  28, 24, 31, 26, 23, 6,  13, 22, 26, 8,  24, 30,
        29, 29, 3,  23, 8,  26, 7,  8,  14, 26, 12, 25, 3,  28, 15, 16, 4,  28, 21, 31, 31, 16, 16, 23, 12, 14, 13, 15, 24, 23,
        11, 21, 24, 9,  28, 29, 31, 10, 3,  11, 8,  14, 7,  11, 25, 31, 8,  13, 16, 23, 24, 3,  31, 23, 25, 6,  21, 22, 20, 19,
        19, 22, 16, 7,  21, 13, 32, 8,  20, 23, 4,  26, 20, 9,  26, 11, 5,  4,  24, 23, 12, 16, 23, 26, 19, 5,  21, 3,  12, 16,
        29, 14, 28, 7,  20, 13, 3,  23, 21, 4,  32, 32, 26, 14, 7,  31, 4,  30, 22, 7,  6,  11, 7,  4,  27, 22, 7,  19, 24, 32,
        15, 8,  27, 20, 24, 15, 4,  32, 29, 21, 25, 6,  7,  11, 28, 27, 7,  14, 29, 27, 5,  28, 25, 4,  32, 30, 25, 26, 5,  9,
        28, 26, 13, 8,  23, 20, 22, 9,  4,  10, 28, 9,  23, 5,  26, 28, 29, 14, 27, 10, 28, 10, 9,  9,  26, 5,  19, 25, 6,  20,
        31, 16, 22, 3,  25, 25, 26, 3,  27, 5,  10, 12, 9,  11, 25, 15, 14, 3,  4,  8,  13, 7,  22, 26, 19, 30, 9,  4,  15, 27,
        29, 28, 26, 14, 30, 29, 26, 10, 14, 6,  19, 5,  8,  3,  22, 10, 11, 3,  21, 20, 10, 24, 21, 23, 10, 23, 7,  3,  28, 13,
        30, 23, 24, 23, 20, 16, 3,  3,  11, 7,  31, 16, 25, 26, 32, 24, 13, 24, 4,  28, 14, 3,  7,  12, 15, 12, 8,  21, 12, 14,
        30, 29, 3,  15, 14, 27, 10, 3,  27, 21, 6,  11, 8,  25, 3,  30, 21, 13, 31, 9,  15, 4,  22, 30, 20, 20, 20, 15, 25, 22,
        31, 10, 29, 14, 28, 32, 5,  9,  6,  15, 12, 8,  16, 14, 21, 10, 9,  27, 8,  3,  16, 28, 13, 3,  29, 15, 30, 26, 26, 21,
        10, 12, 8,  4,  8,  12, 24, 11, 19, 32, 21, 11, 7,  25, 29, 11, 12, 22, 28, 19, 6,  16, 32, 14, 23, 15, 6,  3,  21, 29,
        16, 7,  4,  6,  23, 24, 11, 15, 6,  12, 21, 29, 8,  29, 31, 11, 21, 24, 5,  20, 31, 29, 12, 6,  23, 9,  24, 26, 31, 15,
        26, 15, 25, 7,  31, 7,  32, 3,  4,  10, 13, 3,  13, 5,  16, 15, 9,  14, 21, 5,  25, 27, 25, 4,  3,  6,  13, 16, 4,  20,
        25, 27, 6,  26, 4,  32, 13, 11, 25, 25, 28, 29, 13, 27, 31, 16, 10, 28, 16, 6,  8,  15, 11, 22, 24, 15, 9,  13, 26, 15,
        30, 21, 28, 15, 15, 25, 32, 11, 6,  26, 20, 31, 20, 25, 26, 16, 20, 23, 30, 25, 11, 20, 10, 30, 11, 7,  22, 24, 4,  24,
        31, 28, 4,  24, 6,  27, 31, 9,  4,  5,  7,  20, 27, 7,  15, 24, 14, 8,  10, 24, 32, 21, 3,  11, 22, 6,  3,  27, 10, 21,
        25, 16, 8,  12, 10, 21, 23, 31, 23, 11, 30, 19, 30, 12, 27, 14, 23, 10, 7,  29, 6,  30, 21, 28, 9,  20, 20, 5,  5,  14,
        30, 4,  19, 6,  16, 32, 27, 23, 20, 31, 28, 5,  11, 13, 21, 32, 16, 28, 29, 21, 29, 29, 29, 9,  13, 13, 14, 10, 6,  32,
        7,  32, 21, 9,  15, 26, 7,  19, 30, 22, 21, 6,  21, 7,  3,  3,  14, 13, 21, 27, 5,  8,  14, 29, 20, 16, 5,  24, 3,  30,
        7,  6,  23, 30, 16, 10, 7,  21, 8,  30, 10, 12, 25, 15, 16, 30, 8,  13, 9,  8,  30, 24, 32, 25, 21, 6,  19, 7,  26, 6,
        4,  14, 28, 32, 21, 8,  20, 27, 13, 28, 10, 20, 6,  21, 25, 23, 21, 25, 25, 27, 26, 11, 5,  9,  27, 23, 9,  11, 32, 16,
        23, 19, 32, 20, 15, 29, 12, 11, 25, 32, 7,  5,  7,  32, 6,  10, 20, 31, 4,  10, 14, 31, 14, 16, 32, 11, 31, 30, 3,  14,
        31, 32, 14, 6,  4,  8,  19, 15, 8,  7,  16, 16, 27, 5,  23, 25, 7,  30, 29, 25, 23, 21, 31, 13, 26, 12, 27, 12, 14, 22,
        3,  28, 12, 21, 9,  9,  31, 20, 11, 4,  22, 19, 27, 22, 12, 12, 4,  21, 29, 8,  9,  8,  14, 29, 23, 23, 4,  27, 27, 29,
        32, 19, 28, 29, 19, 21, 4,  25, 11, 3,  8,  30, 29, 11, 31, 11, 14, 24, 22, 22, 11, 8,  11, 5,  13, 31, 6,  8,  12, 24
      ]
      'height': 30
      'name': 'Lv 1'
      'opacity': 1
      'type': 'tilelayer'
      'visible': true
      'width': 30
      'x': params.x
      'y': params.y
    ]
    'orientation': 'isometric'
    'properties': {}
    'tileheight': 32
    'tilesets': [
      'firstgid': 1
      'image': '..\/Pictures\/grassland_tiles.png'
      'imageheight': 1344
      'imagewidth': 1024
      'margin': 0
      'name': 'grassland_tiles'
      'properties': {}
      'spacing': 0
      'tileheight': 32
      'tilewidth': 64
    ]
    'tilewidth': 64
    'version': 1
    'width': 30

module.exports = MapGenerator
