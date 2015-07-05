require '../../lib/util/language'
config = require 'config'

ip = config.get 'server.ip'
port = config.get 'server.port'

exports.exampleUrl =
  image: "http://#{ip}:#{port}/image?x=0&y=0"
  'map-in-dictionary': "http://#{ip}:#{port}/map-dictionary?x=0&y=0"
