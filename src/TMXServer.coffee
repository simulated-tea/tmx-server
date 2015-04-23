http         = require 'http'
MapGenerator = require './map_generator/map_generator'

seed = 0
mapGenerator = new MapGenerator seed

exports.start = ->
  http.createServer (req, res) ->
    res.writeHead 200, 'Content-Type': 'application/json'
    res.end (mapGenerator.get 0, 0).toJSONString()
  .listen 1337, '127.0.0.1'
  console.log 'Server running at http://127.0.0.1:1337/'

