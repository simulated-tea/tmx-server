config = module.exports

config.All =
  environment: 'node'
  rootPath: '../'
  sources: [
    'lib/*.js'
    'lib/**/*.js'
  ]
  tests: [
    'test/*test.js',
    'test/**/*test.js'
  ]
