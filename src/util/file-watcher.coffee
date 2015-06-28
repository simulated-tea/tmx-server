require '../../lib/util/language'
fs = require 'fs'
globExpand = require 'glob-expand'
platform = require './platform-tools'
{execSync, spawn} = require 'child_process'

class FileWatcher
  constructor: (options) ->
    optionsWithDefaults =
      files: []
      buildTool: platform.command 'cake'
      runArgument: ['run']
      buildArgument: ['build']
      recursive: true
    optionsWithDefaults[key] = value for key, value of options
    optionsWithDefaults.files = [optionsWithDefaults.files..., options.file] if options.file

    throw "File(s) to watch is(are) required" unless optionsWithDefaults.files.length >= 1
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
    setTimeout (=> @recentRestartLock = false), 1000

  start: ->
    console.log 'starting'
    @resetWatcher()
    for file in globExpand @options.files
      @rewatchFileAndReset file

  rewatchFileAndReset: (file) ->
    fs.watch file, recursive: @options.recursive
      .on 'change', =>
        @throttledReset()
        @rewatchFileAndReset file
      .on 'error', (err) =>
        console.log 'error occured: ' + err
        platform.kill @spawnedRun if @spawnedRun?

module.exports = FileWatcher
