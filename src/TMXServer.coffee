http = require 'http'
url = require 'url'
config = require 'config'
net = require './util/net-tools'

ip = config.get 'server.ip'
port = config.get 'server.port'

{EventEmitter} = require 'events'
MapGenerator = require './map_generator/map_generator'
Prerenderer = require './prerenderer/prerenderer'
c2_tools = require './construct2_tools/construct2_tools'

class TMXServer extends EventEmitter
  mapGenerator: new MapGenerator()
  constructor: ->
    @server = null
    @ready = false
    @listening = false
    @prerender = new Prerenderer()
    @prerender.on 'ready', =>
      @ready = true
      @emit 'ready'

  start: ->
    throw 'Not ready yet.' unless @ready
    @setupHttpServer() unless @server?
    if not @listening then @listen()
    else console.log 'Server it still listening. Nothing to do.'

  setupHttpServer: ->
    @server = http.createServer @handleRequest

  listen: ->
    @server.listen port, ip
    @listening = true
    console.log "Server started. Try #{net.exampleUrl.image}"

  stop: (callback) ->
    if @listening then @server.close =>
      @listening = false
      console.log 'Server shut down.'
      @emit 'stopped'
      callback() if callback?

  handleRequest: (req, res) =>
    connection = req.connection
    res.setHeader 'Access-Control-Allow-Origin',
      ["http://#{connection.remoteAddress}:#{connection.remotePort}"]
    if req.url.match /^\/map-dictionary\?/
      res.writeHead 200, 'Content-Type': 'application/json'
      params = (url.parse req.url, true).query
      console.log "Request for map at x: #{params.x}, y: #{params.y}"
      mapdata = @mapGenerator.get params
      c2Dictionary = c2_tools.asDictionary mapdata
      res.end JSON.stringify c2Dictionary

    if req.url.match /^\/image\?/
      res.writeHead 200, 'Content-Type': 'image/png'
      params = (url.parse req.url, true).query
      console.log "Request for image at x: #{params.x}, y: #{params.y}"
      mapDescription = @mapGenerator.get params
      @prerender.to res, mapDescription, ->
        req.connection.destroy() # for testing -- do i really want this?

module.exports = TMXServer
