exports.asDictionary = (object) ->
  'c2dictionary': true
  'data':
    'x': object.x
    'y': object.y
    'z': object.z
    'mapData': JSON.stringify object
