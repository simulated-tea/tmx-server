require '../../lib/util/language'
buster = require 'buster'
buster.spec.expose()
{assert} = buster

{PNG} = require 'pngjs'
color = require 'onecolor'
pngHelper = require './helper/png_test_helper'

tile = require '../../lib/prerenderer/tile_tools'

describe 'tileTools', ->
  it 'copy a single tile', ->
    source = new PNG width: 64, height: 32
    target = new PNG width: 64, height: 32
    pngHelper.fillPng source, color '#CCC'
    pngHelper.fillPng target, color '#000'

    tile.addTile source, 1, 1, target, 1, 1

    pngHelper.assertColorOnRectangle target, color '#CCC', 1, 1

  it 'copy from arbitrary position to another arbitrary position I', ->
    source = new PNG width: 128, height: 64
    target = new PNG width: 128, height: 64
    pngHelper.fillRectangle source, (color '#AAA'), 0,  0,  64, 32

    tile.addTile source, 1, 1, target, 1, 3

    pngHelper.assertColorOnRectangle target, (color '#AAA'), 1, 3

  it 'copy from arbitrary position to another arbitrary position II', ->
    source = new PNG width: 128, height: 64
    target = new PNG width: 128, height: 64
    pngHelper.fillRectangle source, (color '#AAA'), 64, 0,  64, 32

    tile.addTile source, 2, 1, target, 1, 2

    pngHelper.assertColorOnRectangle target, (color '#AAA'), 1, 2

describe 'compositing', ->
  black_opaque      = new Buffer '000000ff', 'hex'
  black_translucent = new Buffer '0000007f', 'hex'
  black_transparent = new Buffer '00000000', 'hex'
  white_opaque      = new Buffer 'ffffffff', 'hex'
  white_translucent = new Buffer 'ffffff7f', 'hex'

  for [existing_color,  added_color,       expected_color] in [
    [black_transparent, white_translucent, new Buffer('ffffff7f', 'hex')]
    [black_translucent, white_translucent, new Buffer('a9a9a9be', 'hex')]
    [black_opaque,      white_translucent, new Buffer('7f7f7fff', 'hex')]
    [white_translucent, black_opaque,      black_opaque]
    [white_opaque,      black_opaque,      black_opaque]
    [white_translucent, black_transparent, white_translucent]
    [white_opaque,      black_transparent, white_opaque]
  ]
    do (existing_color, added_color, expected_color) ->
      it "combines #{existing_color.toString('hex')} and #{added_color.toString('hex')} correctly ", ->
        existing = { width: 0, data: existing_color.slice() }
        added =    { width: 0, data: added_color }

        tile._addPixelInPngs added, 0, 0, existing, 0, 0

        assert.equals existing.data, expected_color,
          "#{existing.data.toString('hex')} was not #{expected_color.toString('hex')}"
