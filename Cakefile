fs              = require 'fs'
path            = require 'path'
colors          = require 'colors'
{exec, spawn}   = require 'child_process'

thisIsWindows = process.env.OS? && process.env.OS == 'Windows_NT'
coffeeBinary = if thisIsWindows then 'coffee.cmd' else 'coffee'

task 'run:app', ->
  invoke 'generate:src'
  TMXServer = require './lib/TMXServer.js'
  TMXServer.start()

task 'run', 'shortcut: run:app', -> invoke 'run:app'
task 'r', 'shortcut: run', -> invoke 'run'

task 'generate:src', ->
  spawn '' + coffeeBinary, ['--compile', '--bare', '--output', 'lib/', 'src/'], 'stdio': 'inherit'

task 'build', 'shortcut: generate:src', -> invoke 'generate:src'
task 'b', 'shortcut: build', -> invoke 'build'

fileIsPresent = (filename) ->
  try file = fs.statSync filename
  file?

if fileIsPresent './lib/util/file-watcher.js'
  FileWatcher = require './lib/util/file-watcher'
  runServerWatcher = new FileWatcher
    file: './lib'
    command: 'cake'
    args: ['run']

  task 'run:watchful', ->
    runServerWatcher.start()

  task 'watch', 'shortcut: run:watchful', -> invoke 'run:watchful'
  task 'w', 'shortcut: watch', -> invoke 'watch'

