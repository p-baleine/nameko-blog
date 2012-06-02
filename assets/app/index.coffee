require('lib/setup')

Spine = require('spine')
Feed = require('controllers/feed')

class App extends Spine.Controller
  constructor: ->
    super
    @feed = new Feed el: "body"

module.exports = App
