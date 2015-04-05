fs              = require 'fs'
path            = require 'path'
util            = require 'util'
colors          = require 'colors'
{exec, spawn}   = require 'child_process'

delay = (ms, func) -> setTimeout func, ms

task 'run:app', ->
  invoke 'generate:src'
  TMXServer = require './lib/TMXServer.js'
  TMXServer.start()

task 'run', 'shortcut: run:app', -> invoke 'run:app'
task 'r', 'shortcut: run', -> invoke 'run'

task 'generate:src', ->
  spawn 'coffee', ['--compile', '--output', 'lib/', 'src/'], 'stdio': 'inherit'

task 'build', 'shortcut: generate:src', -> invoke 'generate:src'
task 'b', 'shortcut: build', -> invoke 'build'

FileWatcher = (options) ->
  optsWithDefaults = recursive: true
  optsWithDefaults.it = options.it for it in options

  options: optsWithDefaults
  spawnedRun: null
  readdirTimeout: null


FileWatcher.prototype.resetWatcher = ->
  unless this.readdirTimeout
    this.spawnedRun.kill 'SIGINT' if this.spawnedRun?
    this.spawnedRun = spawn 'cake', ['run:app'], 'stdio': 'inherit'
  this.readdirTimeout = delay 1000, ->
    this.readdirTimeout = null

FileWatcher.prototype.start = ->
  this.resetWatcher()
  fs.watch this.options.file, recursive: this.options.recursive, -> this.resetWatcher()
    .on 'error', (err) ->
      console.log 'error occured' + err
      this.spawnedRun.kill 'SIGINT' if spawnedRun?


task 'run:watchful', ->
  resetWatcher()
  fs.watch './lib', recursive: true, ->
      resetWatcher()
    .on 'error', (err) ->
      console.log 'error occured' + err
      spawnedRun.kill 'SIGINT' if spawnedRun?

task 'watch', 'shortcut: run:watchful', -> invoke 'run:watchful'
task 'w', 'shortcut: watch', -> invoke 'watch'

task 'o', ->
  child = spawn 'cake', ['r'], 'stdio': 'inherit'
  delay 3000, -> child.kill 'SIGINT'
