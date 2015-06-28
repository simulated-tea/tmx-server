require '../../lib/util/language'

thisIsWindows = ->
  process.env.OS? && process.env.OS == 'Windows_NT'

exports.thisIsWindows = thisIsWindows

exports.command = (name) ->
  if thisIsWindows() then name + '.cmd' else name

exports.kill = (process) ->
  if thisIsWindows()
    {exec} = require 'child_process'
    exec 'taskkill /PID '+process.pid+' /T /F'
  else
    process.kill
