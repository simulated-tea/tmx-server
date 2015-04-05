fs              = require 'fs'
path            = require 'path'
util            = require 'util'
colors          = require 'colors'
{exec, spawn}   = require 'child_process'
FileWatcher     = require './lib/util/file-watcher'

task 'run:app', ->
  invoke 'generate:src'
  TMXServer = require './lib/TMXServer.js'
  TMXServer.start()

task 'run', 'shortcut: run:app', -> invoke 'run:app'
task 'r', 'shortcut: run', -> invoke 'run'

task 'generate:src', ->
  spawn 'coffee', ['--compile', '--bare', '--output', 'lib/', 'src/'], 'stdio': 'inherit'

task 'build', 'shortcut: generate:src', -> invoke 'generate:src'
task 'b', 'shortcut: build', -> invoke 'build'


runServerWatcher = new FileWatcher
  file: './lib'
  command: 'cake'
  args: ['run']

task 'run:watchful', ->
  runServerWatcher.start()

task 'watch', 'shortcut: run:watchful', -> invoke 'run:watchful'
task 'w', 'shortcut: watch', -> invoke 'watch'
