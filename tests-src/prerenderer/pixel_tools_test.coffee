buster = require 'buster'
buster.spec.expose()
{assert} = buster

pixel = require '../../lib/prerenderer/pixel_tools'

describe "pixel tools", ->
  describe "everyone", ->
    it "returns [] for size 0", ->
      for func in [
        'lowerUpwardTriangleInclusive',
        'lowerUpwardTriangleExclusive'
      ]
        coordinates = pixel[func] 0
        assert.equals coordinates, []

  describe "lowerUpwardTriangleInclusive", ->
    it "produces the correct coordinates for size 2", ->
      coordinates = pixel.lowerUpwardTriangleInclusive 2
      assert.equals coordinates, [
        [2,0], [3,0],
        [0,1], [1,1], [2,1], [3,1],
      ]

    it "produces the correct coordinates for size 4", ->
      coordinates = pixel.lowerUpwardTriangleInclusive 4
      assert.equals coordinates, [
        [6,0], [7,0],
        [4,1], [5,1], [6,1], [7,1],
        [2,2], [3,2], [4,2], [5,2], [6,2], [7,2],
        [0,3], [1,3], [2,3], [3,3], [4,3], [5,3], [6,3], [7,3],
      ]

  describe "lowerUpwardTriangleExclusive", ->
    it "produces the correct coordinates for size 2", ->
      coordinates = pixel.lowerUpwardTriangleExclusive 2
      assert.equals coordinates, [ [2,1], [3,1] ]
