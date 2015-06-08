buster = require 'buster'
buster.spec.expose()

describe "a test", ->
  it "should be ok", ->
    buster.assert true

