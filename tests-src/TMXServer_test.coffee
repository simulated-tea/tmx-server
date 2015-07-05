buster = require 'buster'
buster.spec.expose()
net = require '../lib/util/net-tools'
http = require 'http'
{PNG} = require 'pngjs'
{assert, assertions, refute} = buster

TMXServer = require '../lib/TMXServer'
#assertions.throwOnFailure = false

describe "=>TMX Server", ->
  tmxServer = null

  beforeAll (done) ->
    tmxServer = new TMXServer()
    tmxServer.on 'ready', ->
      tmxServer.start()
      done()

  afterAll (done) ->
    tmxServer.stop ->
      done()

  it "answers to image requests", (done) ->
    @timeout = 400
    req = http.request net.exampleUrl.image, (res) ->
      assert res.statusCode, 200
      assert res.statusMessage, 'OK'
      assert.equals res.headers['access-control-allow-origin'],
        'http://'+req.connection.localAddress+':'+req.connection.localPort
      res.pipe new PNG filterType: 4
        .on 'parsed', ->
          assert.isNumber @width
          assert.isNumber @height
          assert @readable
          done()

    req.on 'error', done (e) ->
      assertions.fail()

    req.end()

  it "answers to map requests", ->
    assert true
