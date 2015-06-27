buster = require 'buster'
buster.spec.expose()
{assert} = buster

{PNG} = require 'pngjs'
color = require 'onecolor'
pngHelper = require './helper/png_test_helper'

tile = require '../../lib/prerenderer/tile_tools'

# Concept:
#   source: "tilemap"
#   -----------------------------
#   |      ,^.          ,^.     |
#   |   ,´    ` .    ,´    ` .  |
#   |.´    1,1   `.´    2,1   `.|
#   | ` .       ,´ ` .       ,´ |
#   |    ` . ,´       ` . ,´    |
#   |      ,^.          ,^.     |
#   |   ,´    ` .    ,´    ` .  |
#   |.´    1,2   `.´    2,2   `.|
#   | ` .       ,´ ` .       ,´ |
#   |    ` . ,´       ` . ,´    |
#   -----------------------------
#
#   target: "isoGrid"
#   -----------------------------
#   |0,0   ,^.   1,0    ,^.  2,0|
#   |   ,´    ` .    ,´    ` .  |
#   |.´    1,1   `.´    2,1   `.|
#   | ` .       ,´ ` .       ,´ |
#   |    ` . ,´       ` . ,´    |
#   |0,2   ,^.   1,2    ,^.  2,2|
#   |   ,´    ` .    ,´    ` .  |
#   |.´    1,3   `.´    2,3   `.|
#   | ` .       ,´ ` .       ,´ |
#   |0,4 ` . ,´  1,4  ` . ,´ 2,4|
#   -----------------------------

describe 'compositing', ->
  it 'adds two pixel respecting alpha values', ->
    black_opaque      = new Buffer '000000ff', 'hex'
    black_translucent = new Buffer '0000007f', 'hex'
    black_transparent = new Buffer '00000000', 'hex'
    white_opaque      = new Buffer 'ffffffff', 'hex'
    white_translucent = new Buffer 'ffffff7f', 'hex'

    assert.equals tile._addPixelOver(white_translucent, black_transparent), new Buffer 'ffffff7f', 'hex'
    assert.equals tile._addPixelOver(white_translucent, black_translucent), new Buffer 'a9a9a9be', 'hex'
    assert.equals tile._addPixelOver(white_translucent, black_opaque),      new Buffer '7f7f7fff', 'hex'
    assert.equals tile._addPixelOver(black_opaque, white_translucent),      black_opaque
    assert.equals tile._addPixelOver(black_opaque, white_opaque),           black_opaque
    assert.equals tile._addPixelOver(black_transparent, white_translucent), white_translucent
    assert.equals tile._addPixelOver(black_transparent, white_opaque),      white_opaque
