fs = require 'fs'
util = require 'util'
platform = require './platform-tools'
{execSync, spawn} = require 'child_process'

class FileWatcher
  constructor: (options) ->
    optionsWithDefaults =
      buildTool: platform.command 'cake'
      runArgument: ['run']
      buildArgument: ['build']
      recursive: true
    optionsWithDefaults[key] = value for key, value of options

    throw "File to watch is required" unless optionsWithDefaults.file?
    throw "Command is required" unless optionsWithDefaults.buildTool?

    @options = optionsWithDefaults
    @spawnedRun = null
    @recentRestartLock = false
    this

  resetWatcher: ->
    platform.kill @spawnedRun if @spawnedRun?
    execSync @options.buildTool+' '+@options.buildArgument, 'stdio': 'inherit'
    @spawnedRun = spawn @options.buildTool, @options.runArgument, 'stdio': 'inherit'

  throttledReset: ->
    @resetWatcher() unless @recentRestartLock
    @recentRestartLock = true
    setTimeout (=> @recentRestartLock = false), 2000

  start: ->
    console.log 'starting'
    @resetWatcher()
    fs.watch @options.file, recursive: @options.recursive
      .on 'change', =>
        @throttledReset()
      .on 'error', (err) =>
        console.log 'error occured: ' + err
        platform.kill @spawnedRun if @spawnedRun?

module.exports = FileWatcher
