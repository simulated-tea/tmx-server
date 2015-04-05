fs            = require 'fs'
{exec, spawn} = require 'child_process'

class FileWatcher
  constructor: (options) ->
    defaults = recursive: true, args: []
    optionsWithDefaults = defaults
    optionsWithDefaults[key] = value for key, value of options

    throw "File to watch is required" unless optionsWithDefaults.file?
    throw "Command is required" unless optionsWithDefaults.command?

    this.options = optionsWithDefaults
    this.spawnedRun = null
    this.recentRestartLock = false
    this


  resetWatcher: ->
    unless this.recentRestartLock
      console.log "change: restarting"
      this.spawnedRun.kill 'SIGINT' if this.spawnedRun?
      this.spawnedRun = spawn this.options.command, this.options.args, 'stdio': 'inherit'
    else console.log "change: suppressed"
    this.recentRestartLock = true
    that = this
    setTimeout (-> that.recentRestartLock = false), 1000

  start: ->
    this.resetWatcher()
    that = this
    fs.watch this.options.file, recursive: this.options.recursive
      .on 'change', ->
        that.resetWatcher()
      .on 'error', (err) ->
        console.log 'error occured' + err
        that.spawnedRun.kill 'SIGINT' if that.spawnedRun?

module.exports = FileWatcher
