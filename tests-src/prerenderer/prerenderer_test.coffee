require 'mocha'
buster = require 'buster'
should = require('chai').should()

buster.spec.expose()

describe "another test", ()->
  it "should be ok", ->
    buster.assert true

