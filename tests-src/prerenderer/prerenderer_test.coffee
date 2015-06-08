buster = require 'buster'
buster.spec.expose()

describe "another test", ->
  it "should be ok", ->
    buster.assert true

