buster = require 'buster'
buster.spec.expose()
{assert} = buster

{PNG} = require 'pngjs'
color = require 'onecolor'
pngHelper = require './helper/png_test_helper'

layer = require '../../lib/prerenderer/layer_tools'

# Concept:
#   source: "tilemap"
#   -----------------------------
#   |      ,^.          ,^.     |
#   |   ,´    ` .    ,´    ` .  |
#   |.´    1,1   `.´    2,1   `.|
#   | ` .       ,´ ` .       ,´ |
#   |    ` . ,´       ` . ,´    |
#   |      ,^.          ,^.     |
#   |   ,´    ` .    ,´    ` .  |
#   |.´    1,2   `.´    2,2   `.|
#   | ` .       ,´ ` .       ,´ |
#   |    ` . ,´       ` . ,´    |
#   -----------------------------
#
#   target: "isoGrid"
#   -----------------------------
#   |0,0   ,^.   1,0    ,^.  2,0|
#   |   ,´    ` .    ,´    ` .  |
#   |.´    1,1   `.´    2,1   `.|
#   | ` .       ,´ ` .       ,´ |
#   |    ` . ,´       ` . ,´    |
#   |0,2   ,^.   1,2    ,^.  2,2|
#   |   ,´    ` .    ,´    ` .  |
#   |.´    1,3   `.´    2,3   `.|
#   | ` .       ,´ ` .       ,´ |
#   |0,4 ` . ,´  1,4  ` . ,´ 2,4|
#   -----------------------------

