fs = require 'fs'
isThere = require 'is-there'
colors = require 'colors'
{spawn} = require 'child_process'
rimraf = require 'rimraf'

# cannot use platform tools - they are part of this project - at least build must be independent
thisIsWindows = process.env.OS? && process.env.OS == 'Windows_NT'
coffeeBinary = if thisIsWindows then 'coffee.cmd' else 'coffee'

task 'generate:src', ->
  spawn coffeeBinary, ['--compile', '--bare', '--output', 'lib/', 'src/'], 'stdio': 'inherit'

task 'generate:tests', ->
  spawn coffeeBinary, ['--compile', '--bare', '--output', 'test/', 'tests-src/'], 'stdio': 'inherit'

task 'build', 'shortcut: generate:src & tests', ->
    invoke 'generate:src'
    invoke 'generate:tests'
task 'b', 'shortcut: build', -> invoke 'build'

task 'clean', ->
  rimraf './lib', ->
  rimraf './test', ->

task 'c', 'shortcut: clean', -> invoke 'clean'

withCompiled = (file, callback) ->
  if isThere file+'.js'
    callback require file
  else
    console.log "Required library #{file} for task not found. Did you 'build' the project?"

task 'run:test', ->
  withCompiled './lib/util/platform-tools', (platform) ->
    spawn platform.command('buster-test'), [], 'stdio': 'inherit'

task 'test', 'shortcut: run:test', -> invoke 'run:test'
task 't', 'shortcut: test', -> invoke 'test'

task 'run:app', ->
  withCompiled './lib/TMXServer', (TMXServer) ->
    TMXServer.start()

task 'run', 'shortcut: run:app', -> invoke 'run:app'
task 'r', 'shortcut: run', -> invoke 'run'

runServerWatcher = null
getServerWatcher = (options) ->
  util = require 'util'
  withCompiled './lib/util/file-watcher', (FileWatcher) ->
    runServerWatcher = new FileWatcher options unless runServerWatcher

task 'test:watchful', =>
  getServerWatcher { file: './src', runArgument: ['test'] }
  runServerWatcher.start()

task 'keeptesting', 'shortcut: test:watchful', => invoke 'test:watchful'
task 'k', 'shortcut: keeptesting', => invoke 'keeptesting'

task 'run:watchful', =>
  getServerWatcher file: './src'
  runServerWatcher.start()

task 'watch', 'shortcut: run:watchful', => invoke 'run:watchful'
task 'w', 'shortcut: watch', => invoke 'watch'

