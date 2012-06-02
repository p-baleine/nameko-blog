Spine = require('spine')

class BlogPosts extends Spine.Controller
  constructor: ->
    super
    @item.bind "update", @render
    @item.bind "destroy", @remove

  render: =>
    @html require('views/blog_post')(@item)
    @

  remove: =>
    @el.remove()

module.exports = BlogPosts