buster = require 'buster'
buster.spec.expose()
{assert} = buster

js = require '../../lib/util/language'

describe 'carthesianProduct', ->
  it 'produces the product lines-first', ->
    actual = js.carthesianProduct [0..2], [0..1]
    expect = [[0,0], [1,0], [2,0], [0,1], [1,1], [2,1]]

    assert.equals actual, expect

