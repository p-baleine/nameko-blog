require = window.require

describe 'BlogPost', ->
  BlogPost = require('/models/blog_post')

  describe 'BlogPost', ->
    it 'contentなしで作成できないこと', ->
      post = BlogPost.create()
      post.should.be.false
