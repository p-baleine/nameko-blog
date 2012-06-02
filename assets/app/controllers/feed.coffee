Spine = require('spine')
BlogPost = require('models/blog_post')
BlogPosts = require('controllers/blog_posts')

class Feed extends Spine.Controller
  elements:
    "#feed": "feed"

  constructor: ->
    super
    BlogPost.bind "create", @addOne
    BlogPost.bind "refresh", @addAll
    BlogPost.fetch()

  addOne: (blog_post) =>
    view = new BlogPosts(item: blog_post)
    # console.log @feed
    # console.log view.render().el
    @feed.append(view.render().el)

  addAll: =>
    BlogPost.each(@addOne)

module.exports = Feed