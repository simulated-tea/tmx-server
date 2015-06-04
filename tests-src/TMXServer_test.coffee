require 'mocha'
buster = require 'buster'
should = require('chai').should()

buster.spec.expose()

describe "a test", ()->
  it "should be ok", ->
    buster.assert true

