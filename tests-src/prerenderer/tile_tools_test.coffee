buster = require 'buster'
buster.spec.expose()
{assert} = buster

{PNG} = require 'pngjs'
color = require 'onecolor'
pngHelper = require './helper/png_test_helper'

tile = require '../../lib/prerenderer/tile_tools'

describe 'tileTools', ->
  it 'copy a complete tile', ->
    source = new PNG width: 64, height: 32
    target = new PNG width: 64, height: 32
    pngHelper.fillPng source, color '#CCC'
    pngHelper.fillPng target, color '#000'

    tile.copy source, 1, 1, target, 1, 1

    pngHelper.assertInnerColor target, color '#CCC'

