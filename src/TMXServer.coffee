http = require 'http'
url = require 'url'
MapGenerator = require './map_generator/map_generator'
Prerenderer = require './prerenderer/prerenderer'
c2_tools = require './construct2_tools/construct2_tools'

mapGenerator = new MapGenerator
prerender = new Prerenderer

exports.start = ->
  http.createServer (req, res) =>
    res.setHeader 'Access-Control-Allow-Origin', ['http://localhost:50000']
    if req.url.match /^\/map-dictionary\?/
      res.writeHead 200, 'Content-Type': 'application/json'
      params = (url.parse req.url, true).query
      console.log "Request for map at x: #{params.x}, y: #{params.y}"
      mapdata = mapGenerator.get params
      c2Dictionary = c2_tools.asDictionary mapdata
      res.end JSON.stringify c2Dictionary

    if req.url.match /^\/image\?/
      res.writeHead 200, 'Content-Type': 'image/png'
      params = (url.parse req.url, true).query
      console.log "Request for image at x: #{params.x}, y: #{params.y}"
      prerender.to res, params

  .listen 1337, '127.0.0.1'
  console.log 'Server started'
