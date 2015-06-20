buster = require 'buster'
buster.spec.expose()
{assert} = buster
reverseTupelSort = (a,b) -> Math.sign a[1] - b[1] || a[0] - b[0]

pixel = require '../../lib/prerenderer/pixel_tools'

describe 'pixel tools - primitives', ->
  describe 'every helper', ->
    it 'returns [] for size 0', ->
      for func in [
        'lowerUpwardTriangleInclusive',
        'lowerUpwardTriangleExclusive',
        'upperUpwardTriangleInclusive',
        'upperUpwardTriangleExclusive',
        'lowerDownwardTriangleInclusive',
        'lowerDownwardTriangleExclusive',
        'upperDownwardTriangleInclusive',
        'upperDownwardTriangleExclusive'
      ]
        coordinates = pixel[func] 0
        assert.equals coordinates, []

  describe 'lowerUpwardTriangleInclusive', ->
    it 'LUI - produces the correct coordinates for size 2', ->
      coordinates = pixel.lowerUpwardTriangleInclusive 2
      assert.equals coordinates, [
                      [2,0], [3,0],
        [0,1], [1,1], [2,1], [3,1],
      ]

    it 'LUI - produces the correct coordinates for size 4', ->
      coordinates = pixel.lowerUpwardTriangleInclusive 4
      assert.equals coordinates, [
                                                  [6,0], [7,0],
                                    [4,1], [5,1], [6,1], [7,1],
                      [2,2], [3,2], [4,2], [5,2], [6,2], [7,2],
        [0,3], [1,3], [2,3], [3,3], [4,3], [5,3], [6,3], [7,3],
      ]

  describe 'lowerUpwardTriangleExclusive', ->
    it 'LUE - produces the correct coordinates for size 2', ->
      coordinates = pixel.lowerUpwardTriangleExclusive 2
      assert.equals coordinates, [

                      [2,1], [3,1],
      ]

  describe 'upperUpwardTriangleInclusive', ->
    it 'UUI - produces the correct coordinates for size 2', ->
      coordinates = pixel.upperUpwardTriangleInclusive 2
      assert.equals coordinates, [
        [0,0], [1,0], [2,0], [3,0],
        [0,1], [1,1],
      ]

  describe 'upperUpwardTriangleExclusive', ->
    it 'UUE - produces the correct coordinates for size 2', ->
      coordinates = pixel.upperUpwardTriangleExclusive 2
      assert.equals coordinates, [
        [0,0], [1,0],

      ]

  describe 'lowerDownwardTriangleInclusive', ->
    it 'LDI - produces the correct coordinates for size 2', ->
      coordinates = pixel.lowerDownwardTriangleInclusive 2
      assert.equals coordinates, [
        [0,0], [1,0],
        [0,1], [1,1], [2,1], [3,1],
      ]

  describe 'lowerDownwardTriangleExclusive', ->
    it 'LDE - produces the correct coordinates for size 2', ->
      coordinates = pixel.lowerDownwardTriangleExclusive 2
      assert.equals coordinates, [

        [0,1], [1,1],
      ]

    it 'LDE - produces the correct coordinates for size 4', ->
      coordinates = pixel.lowerDownwardTriangleExclusive 4
      assert.equals coordinates, [

        [0,1], [1,1],
        [0,2], [1,2], [2,2], [3,2],
        [0,3], [1,3], [2,3], [3,3], [4,3], [5,3],
      ]

  describe 'upperDownwardTriangleInclusive', ->
    it 'UDI - produces the correct coordinates for size 2', ->
      coordinates = pixel.upperDownwardTriangleInclusive 2
      assert.equals coordinates, [
        [0,0], [1,0], [2,0], [3,0],
                      [2,1], [3,1],
      ]

  describe 'upperDownwardTriangleExclusive', ->
    it 'UDE - produces the correct coordinates for size 2', ->
      coordinates = pixel.upperDownwardTriangleExclusive 2
      assert.equals coordinates, [
                      [2,0], [3,0],

      ]

describe 'pixel tools - use cases', ->
  describe 'innerRhombus', ->
    it 'produces the correct coordinates for size 2', ->
      coordinates = pixel.innerRhombus 2
      assert.equals coordinates, []

  describe 'outerRhombus', ->
    it 'produces the correct coordinates for size 4', ->
      coordinates = pixel.outerRhombus 4
      assert.equals coordinates.sort(reverseTupelSort), [
                      [2,0], [3,0], [4,0], [5,0],
        [0,1], [1,1], [2,1], [3,1], [4,1], [5,1], [6,1], [7,1],
        [0,2], [1,2], [2,2], [3,2], [4,2], [5,2], [6,2], [7,2],
                      [2,3], [3,3], [4,3], [5,3],
      ].sort(reverseTupelSort)

    it 'produces the correct coordinates for size 4 with offsets', ->
      coordinates = pixel.outerRhombus 4, 16, 4
      assert.equals coordinates.sort(reverseTupelSort), [
                        [18,4], [19,4], [20,4], [21,4],
        [16,5], [17,5], [18,5], [19,5], [20,5], [21,5], [22,5], [23,5],
        [16,6], [17,6], [18,6], [19,6], [20,6], [21,6], [22,6], [23,6],
                        [18,7], [19,7], [20,7], [21,7],
      ].sort(reverseTupelSort)

    it 'produces the correct coordinates for size 4', ->
      coordinates = pixel.innerRhombus 4
      assert.equals coordinates, [

                      [2,1], [3,1], [4,1], [5,1],
                      [2,2], [3,2], [4,2], [5,2],

      ]

    it 'produces the correct coordinates for size 4 with offsets', ->
      coordinates = pixel.innerRhombus 4, 16, 4
      assert.equals coordinates, [

                      [18,5], [19,5], [20,5], [21,5],
                      [18,6], [19,6], [20,6], [21,6],

      ]

  describe 'borders', ->
    it 'upper inclusive size 4', ->
      coordinates = pixel.upperBorderInclusive 4, 8, 0
      assert.equals coordinates.sort(reverseTupelSort), [
        [8,0], [9,0], [10,0], [11,0], [12,0], [13,0], [14,0], [15,0],
                      [10,1], [11,1], [12,1], [13,1],
      ].sort(reverseTupelSort)

    it 'upper exclusive size 4', ->
      coordinates = pixel.upperBorderExclusive 4, 8, 0
      assert.equals coordinates.sort(reverseTupelSort), [
                      [10,0], [11,0], [12,0], [13,0],

      ].sort(reverseTupelSort)

    it 'lower inclusive size 4', ->
      coordinates = pixel.lowerBorderInclusive 4, 8, 14
      assert.equals coordinates.sort(reverseTupelSort), [
                        [10,14], [11,14], [12,14], [13,14],
        [8,15], [9,15], [10,15], [11,15], [12,15], [13,15], [14,15], [15,15],
      ].sort(reverseTupelSort)

    it 'lower exclusive size 4', ->
      coordinates = pixel.lowerBorderExclusive 4, 8, 14
      assert.equals coordinates.sort(reverseTupelSort), [

                      [10,15], [11,15], [12,15], [13,15],
      ].sort(reverseTupelSort)

