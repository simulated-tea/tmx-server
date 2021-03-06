fs = require 'fs'
isThere = require 'is-there'
colors = require 'colors'
{exec, spawn} = require 'child_process'
rimraf = require 'rimraf'
config = require 'config'
{series} = require 'async'

ip = config.get 'server.ip'
port = config.get 'server.port'

# cannot use platform tools - they are part of this project - at least build must be independent
thisIsWindows = process.env.OS? && process.env.OS == 'Windows_NT'
coffeeBinary = if thisIsWindows then 'coffee.cmd' else 'coffee'

task 'generate:src', ->
  spawn coffeeBinary, ['--compile', '--bare', '--output', 'lib/', 'src/'], 'stdio': 'inherit'

task 'generate:tests', ->
  spawn coffeeBinary, ['--compile', '--bare', '--output', 'test/', 'tests-src/'], 'stdio': 'inherit'

task 'b', 'shortcut: build', -> invoke 'build'
task 'build', 'shortcut: generate:src & tests', ->
    invoke 'generate:src'
    invoke 'generate:tests'

task 'c', 'shortcut: clean', -> invoke 'clean'
task 'clean', ->
  rimraf './lib', ->
  rimraf './test', ->

#==============================================================================

withCompiled = (file, callback) ->
  if isThere file+'.js'
    callback require file
  else
    console.log "Required library #{file} for task not found. Did you 'build' the project?"

wait = (time, func) -> setTimeout func, time

#==============================================================================

task 't', 'shortcut: test', -> invoke 'test'
task 'test', 'shortcut: run:test', -> invoke 'run:test'
task 'run:test', ->
  withCompiled './lib/util/platform-tools', (platform) ->
    spawn platform.command('buster-test'), [], 'stdio': 'inherit'


task 'r', 'shortcut: run', -> invoke 'run'
task 'run', 'shortcut: run:app', -> invoke 'run:app'
task 'run:app', ->
  withCompiled './lib/TMXServer', (TMXServer) ->
    tmxServer = new TMXServer()
    tmxServer.on 'ready', ->
      tmxServer.start()


task 'rpi', 'shortcut: run:profile:image', -> invoke 'run:profile:image'
task 'run:profile:image', ->
  platform = null; server = null
  series [
    (next) -> withCompiled './lib/TMXServer',     (TMXServer) -> next null
    (next) ->
      withCompiled './lib/util/platform-tools', (pl) -> platform = pl; next null
    (next) ->
      server = spawn 'node', ['--prof', 'index.js'], 'stdio': 'inherit'
      wait 500,                                               -> next null
    (next) -> exec "curl http://#{ip}:#{port}/image?x=0&y=0", -> next null
    (next) -> wait 500,                                       -> next null
    (next) -> exec "curl http://#{ip}:#{port}/image?x=0&y=0", -> next null
    (next) -> wait 500,                                       -> next null
    (next) -> exec "curl http://#{ip}:#{port}/image?x=0&y=0", -> next null
    (next) -> platform.kill server
  ]

runServerWatcher = null
getServerWatcher = (options) ->
  util = require 'util'
  withCompiled './lib/util/file-watcher', (FileWatcher) ->
    runServerWatcher = new FileWatcher options unless runServerWatcher

task 'k', 'shortcut: keeptesting', => invoke 'keeptesting'
task 'keeptesting', 'shortcut: test:watchful', => invoke 'test:watchful'
task 'test:watchful', =>
  getServerWatcher { files: ['./src/**/*.coffee', 'tests-src/**/*.coffee'], runArgument: ['test'] }
  runServerWatcher.start()

task 'w', 'shortcut: watch', => invoke 'watch'
task 'watch', 'shortcut: run:watchful', => invoke 'run:watchful'
task 'run:watchful', =>
  getServerWatcher file: './src'
  runServerWatcher.start()
