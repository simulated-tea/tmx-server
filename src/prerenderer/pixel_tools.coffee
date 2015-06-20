_getLowerTriangleUpwardInclusive = (h, x_off, y_off) ->
  w = 2*h + 1
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x_off+x,y_off+n] for x in [2*(h-n)..w])...,
      ], n+1
  getForRow [], 0

_getLowerTriangleUpwardExclusive = (h, x_off, y_off) ->
  w = 2*h + 1
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x_off+x,y_off+n] for x in [2*(h-n+1)..w])...,
      ], n+1
  getForRow [], 1

_getUpperTriangleUpwardInclusive = (h, x_off, y_off) ->
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x_off+x-1,y_off+n] for x in [1..2*(h-n+1)])...,
      ], n+1
  getForRow [], 0

_getUpperTriangleUpwardExclusive = (h, x_off, y_off) ->
  getForRow = (ac, n) ->
    if n > h-1
      ac
    else
      getForRow [ac...,
        ([x_off+x-1,y_off+n] for x in [1..2*(h-n)])...,
      ], n+1
  getForRow [], 0

_getLowerTriangleDownwardInclusive = (h, x_off, y_off) ->
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x_off+x,y_off+n] for x in [0..2*n+1])...,
      ], n+1
  getForRow [], 0

_getLowerTriangleDownwardExclusive = (h, x_off, y_off) ->
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x_off+x,y_off+n] for x in [0..2*n-1])...,
      ], n+1
  getForRow [], 1

_getUpperTriangleDownwardInclusive = (h, x_off, y_off) ->
  w = 2*h + 1
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x_off+x,y_off+n] for x in [2*n..w])...,
      ], n+1
  getForRow [], 0

_getUpperTriangleDownwardExclusive = (h, x_off, y_off) ->
  w = 2*h + 1
  getForRow = (ac, n) ->
    if n > h-1
      ac
    else
      getForRow [ac...,
        ([x_off+x,y_off+n] for x in [2*(n+1)..w])...,
      ], n+1
  getForRow [], 0

exports.lowerUpwardTriangleInclusive =   (height) -> _getLowerTriangleUpwardInclusive   height-1, 0, 0
exports.lowerUpwardTriangleExclusive =   (height) -> _getLowerTriangleUpwardExclusive   height-1, 0, 0
exports.upperUpwardTriangleInclusive =   (height) -> _getUpperTriangleUpwardInclusive   height-1, 0, 0
exports.upperUpwardTriangleExclusive =   (height) -> _getUpperTriangleUpwardExclusive   height-1, 0, 0
exports.lowerDownwardTriangleInclusive = (height) -> _getLowerTriangleDownwardInclusive height-1, 0, 0
exports.lowerDownwardTriangleExclusive = (height) -> _getLowerTriangleDownwardExclusive height-1, 0, 0
exports.upperDownwardTriangleInclusive = (height) -> _getUpperTriangleDownwardInclusive height-1, 0, 0
exports.upperDownwardTriangleExclusive = (height) -> _getUpperTriangleDownwardExclusive height-1, 0, 0

exports.outerRhombus = (height, x_off, y_off) ->
  x_off ?= 0
  y_off ?= 0
  half = height/2
  throw "Only even sizes are suppored" unless half == height//2

  [
    (_getLowerTriangleUpwardInclusive   half-1,        x_off,      y_off)...,
    (_getLowerTriangleDownwardInclusive half-1, 2*half+x_off,      y_off)...,
    (_getUpperTriangleDownwardInclusive half-1,        x_off, half+y_off)...,
    (_getUpperTriangleUpwardInclusive   half-1, 2*half+x_off, half+y_off)...,
  ]

exports.innerRhombus = (height, x_off, y_off) ->
  x_off ?= 0
  y_off ?= 0
  half = height/2
  throw "Only even sizes are suppored" unless half == height//2

  [
    (_getLowerTriangleUpwardExclusive   half-1,        x_off,      y_off)...,
    (_getLowerTriangleDownwardExclusive half-1, 2*half+x_off,      y_off)...,
    (_getUpperTriangleDownwardExclusive half-1,        x_off, half+y_off)...,
    (_getUpperTriangleUpwardExclusive   half-1, 2*half+x_off, half+y_off)...,
  ]

exports.upperBorderInclusive = (height, x_off, y_off) ->
  x_off ?= 0
  y_off ?= 0
  half = height/2
  throw "Only even sizes are suppored" unless half == height//2

  [
    (_getUpperTriangleDownwardInclusive half-1,        x_off, y_off)...,
    (_getUpperTriangleUpwardInclusive   half-1, 2*half+x_off, y_off)...,
  ]

exports.upperBorderExclusive = (height, x_off, y_off) ->
  x_off ?= 0
  y_off ?= 0
  half = height/2
  throw "Only even sizes are suppored" unless half == height//2

  [
    (_getUpperTriangleDownwardExclusive half-1,        x_off, y_off)...,
    (_getUpperTriangleUpwardExclusive   half-1, 2*half+x_off, y_off)...,
  ]

exports.lowerBorderInclusive = (height, x_off, y_off) ->
  x_off ?= 0
  y_off ?= 0
  half = height/2
  throw "Only even sizes are suppored" unless half == height//2

  [
    (_getLowerTriangleUpwardInclusive   half-1,        x_off, y_off)...,
    (_getLowerTriangleDownwardInclusive half-1, 2*half+x_off, y_off)...,
  ]

exports.lowerBorderExclusive = (height, x_off, y_off) ->
  x_off ?= 0
  y_off ?= 0
  half = height/2
  throw "Only even sizes are suppored" unless half == height//2

  [
    (_getLowerTriangleUpwardExclusive   half-1,        x_off, y_off)...,
    (_getLowerTriangleDownwardExclusive half-1, 2*half+x_off, y_off)...,
  ]

