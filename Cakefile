fs = require 'fs'
path = require 'path'
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

task 'run:test', ->
  platform = require './lib/util/platform-tools'
  spawn platform.command('buster-test'), [], 'stdio': 'inherit'

task 'test', 'shortcut: run:test', -> invoke 'run:test'
task 't', 'shortcut: test', -> invoke 'test'

task 'run:app', ->
  TMXServer = require './lib/TMXServer'
  TMXServer.start()

task 'run', 'shortcut: run:app', -> invoke 'run:app'
task 'r', 'shortcut: run', -> invoke 'run'

runServerWatcher = null
getServerWatcher = ->
  FileWatcher = require './lib/util/file-watcher'
  runServerWatcher = new FileWatcher file: './src' unless runServerWatcher

task 'run:watchful', =>
  invoke 'build'
  getServerWatcher()
  runServerWatcher.start()

task 'watch', 'shortcut: run:watchful', => invoke 'run:watchful'
task 'w', 'shortcut: watch', => invoke 'watch'

