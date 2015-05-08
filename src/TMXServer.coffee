http = require 'http'
url = require 'url'
MapGenerator = require './map_generator/map_generator'
c2_tools = require './construct2_tools/construct2_tools'

mapGenerator = new MapGenerator

exports.start = ->
  http.createServer (req, res) =>
    res.setHeader 'Access-Control-Allow-Origin', ['http://localhost:50000']
    res.writeHead 200, 'Content-Type': 'application/json'
    replyMessage = ''
    if req.url.match /^\/map\?/
      params = (url.parse req.url, true).query
      console.log "Request for map at x: #{params.x}, y: #{params.y}"
      mapdata = mapGenerator.get params
      c2Dictionary = c2_tools.asDictionary mapdata
      replyMessage = JSON.stringify c2Dictionary
    res.end replyMessage
  .listen 1337, '127.0.0.1'
  console.log 'Server started'
