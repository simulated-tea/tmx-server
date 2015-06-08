buster = require 'buster'
buster.spec.expose()

{PNG} = require 'pngjs'
color = require 'onecolor'
pngHelper = require './helper/png_test_helper'

Prerenderer = require '../../lib/prerenderer/prerenderer'
prerender = new Prerenderer

describe "another test", ->
  it "should be ok", ->
    source = new PNG width: 64, height: 32
    target = new PNG width: 64, height: 32

    pngHelper.fillPng source, color '#000'
    pngHelper.fillPng target, color '#DDD'

    util = require 'util'
    console.log util.inspect source.data, depth: 0
    console.log util.inspect target.data, depth: 0

    #prerender.getSingleTile source, 1, 1, target

    buster.assert true

