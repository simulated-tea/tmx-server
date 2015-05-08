http = require 'http'
url = require 'url'
MapGenerator = require './map_generator/map_generator'

mapGenerator = new MapGenerator

exports.start = ->
  http.createServer (req, res) =>
    res.writeHead 200, 'Content-Type': 'application/json'
    replyMessage = ''
    if req.url.match /^\/map\?/
      params = (url.parse req.url, true).query
      console.log "Delivering map for x: #{params.x}, y: #{params.y}"
      replyMessage = JSON.stringify(mapGenerator.get params)
    res.end replyMessage
  .listen 1337, '127.0.0.1'
  console.log 'Server running at http://127.0.0.1:1337/'
