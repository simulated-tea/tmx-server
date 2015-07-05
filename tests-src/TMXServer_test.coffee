buster = require 'buster'
buster.spec.expose()
net = require '../lib/util/net-tools'
http = require 'http'
{PNG} = require 'pngjs'
{assert, refute} = buster

TMXServer = require '../lib/TMXServer'

describe 'TMX Server', ->
  tmxServer = null

  beforeAll (done) ->
    tmxServer = new TMXServer()
    tmxServer.on 'ready', done ->
      tmxServer.start()

  afterAll (done) ->
    tmxServer.stop done

  it 'answers to image requests', (done) ->
    @timeout = 400
    req = http.request net.exampleUrl.image, (res) ->
      assert res.statusCode, 200
      assert res.statusMessage, 'OK'
      assert.equals res.headers['access-control-allow-origin'],
        'http://'+req.connection.localAddress+':'+req.connection.localPort
      res.pipe new PNG filterType: 4
        .on 'parsed', done ->
          assert.isNumber @width
          assert.isNumber @height
          assert @readable

    req.on 'error', done (e) ->
      refute true

    req.end()

  it 'answers to map requests - currently c2 specific', (done) ->
    req = http.request net.exampleUrl['map-in-dictionary'], (res) ->
      assert res.statusCode, 200
      assert res.statusMessage, 'OK'
      assert.equals res.headers['access-control-allow-origin'],
        'http://'+req.connection.localAddress+':'+req.connection.localPort
        res.on 'data', done (chunk) ->
          payload = JSON.parse chunk.toString 'utf8'
          assert.isTrue payload.c2dictionary
          mapdata = payload.data
          assert.defined mapdata
          assert.equals mapdata.z, 0

    req.on 'error', done (e) ->
      refute true

    req.end()
