_getLowerTriangleUpwardsInclusive = (h) ->
  w = 2*h + 1
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x,n] for x in [2*(h-n)..w])...,
      ], n+1
  getForRow [], 0

exports.lowerUpwardTriangleInclusive = (height) -> _getLowerTriangleUpwardsInclusive height-1

_getLowerTriangleUpwardsExclusive = (h) ->
  w = 2*h + 1
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x,n] for x in [2*(h-n+1)..w])...,
      ], n+1
  getForRow [], 1

exports.lowerUpwardTriangleExclusive = (height) -> _getLowerTriangleUpwardsExclusive height-1

_getUpperTriangleUpwardsInclusive = (h) ->
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x-1,n] for x in [1..2*(h-n+1)])...,
      ], n+1
  getForRow [], 0

exports.upperUpwardTriangleInclusive = (height) -> _getUpperTriangleUpwardsInclusive height-1

_getUpperTriangleUpwardsExclusive = (h) ->
  getForRow = (ac, n) ->
    if n > h-1
      ac
    else
      getForRow [ac...,
        ([x-1,n] for x in [1..2*(h-n)])...,
      ], n+1
  getForRow [], 0

exports.upperUpwardTriangleExclusive = (height) -> _getUpperTriangleUpwardsExclusive height-1

_getLowerTriangleDownwardInclusive = (h) ->
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x,n] for x in [0..2*n+1])...,
      ], n+1
  getForRow [], 0

exports.lowerDownwardTriangleInclusive = (height) -> _getLowerTriangleDownwardInclusive height-1

_getLowerTriangleDownwardExclusive = (h) ->
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x,n] for x in [0..2*n-1])...,
      ], n+1
  getForRow [], 1

exports.lowerDownwardTriangleExclusive = (height) -> _getLowerTriangleDownwardExclusive height-1

_getUpperTriangleDownwardInclusive = (h) ->
  w = 2*h + 1
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac...,
        ([x,n] for x in [2*n..w])...,
      ], n+1
  getForRow [], 0

exports.upperDownwardTriangleInclusive = (height) -> _getUpperTriangleDownwardInclusive height-1

_getUpperTriangleDownwardExclusive = (h) ->
  w = 2*h + 1
  getForRow = (ac, n) ->
    if n > h-1
      ac
    else
      getForRow [ac...,
        ([x,n] for x in [2*(n+1)..w])...,
      ], n+1
  getForRow [], 0

exports.upperDownwardTriangleExclusive = (height) -> _getUpperTriangleDownwardExclusive height-1
