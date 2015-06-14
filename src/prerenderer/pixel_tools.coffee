
_getlowerTriangleUpwardsExclusive = (h) ->
  w = 2*h + 1
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac..., ([x,n] for x in [2*(h-n+1)..w])...], n+1
  getForRow [], 1

exports.lowerUpwardTriangleExclusive = (height) -> _getlowerTriangleUpwardsExclusive height-1

_getlowerTriangleUpwardsInclusive = (h) ->
  w = 2*h + 1
  getForRow = (ac, n) ->
    if n > h
      ac
    else
      getForRow [ac..., ([x,n] for x in [2*(h-n)..w])...], n+1
  getForRow [], 0

exports.lowerUpwardTriangleInclusive = (height) -> _getlowerTriangleUpwardsInclusive height-1
