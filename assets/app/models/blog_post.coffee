Spine = require('spine')

class BlogPost extends Spine.Model
  @configure 'BlogPost', 'user', 'content', 'insert_ts'

  #@extend Spine.Model.Ajax
  @extend Spine.Model.Local

  validate: ->
    "content is required" unless @content

module.exports = BlogPost