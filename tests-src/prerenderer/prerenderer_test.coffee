buster = require 'buster'
buster.spec.expose()
{assert} = buster

{PNG} = require 'pngjs'
color = require 'onecolor'
pngHelper = require './helper/png_test_helper'

Prerenderer = require '../../lib/prerenderer/prerenderer'
prerender = new Prerenderer

describe "copyTile", ->
  it "transports the inner of a tile completely", ->
    source = new PNG width: 64, height: 32
    target = new PNG width: 64, height: 32
    pngHelper.fillPng source, color '#CCC'
    pngHelper.fillPng target, color '#000'

    prerender.copyTile source, 1, 1, target, 1, 1

    pngHelper.assertInnerColor target, color '#CCC'

