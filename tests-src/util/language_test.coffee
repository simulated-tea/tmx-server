require '../../lib/util/language'
buster = require 'buster'
buster.spec.expose()
{assert} = buster

describe 'carthesianProduct', ->
  it 'produces the product lines-first', ->
    actual = carthesianProduct [0..2], [0..1]
    expect = [[0,0], [1,0], [2,0], [0,1], [1,1], [2,1]]

    assert.equals actual, expect

