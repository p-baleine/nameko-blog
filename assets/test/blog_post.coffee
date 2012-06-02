#require = window.require
require('../../public/application')
Spine = require('spine')
Spine.Model.Local = {}

describe 'BlogPost', ->
  BlogPost = require('../app/models/blog_post')

  describe 'BlogPost', ->
    it 'contentなしで作成できないこと', ->
      post = BlogPost.create()
      res = post.save()
        post.should.be.false
    it 'contentありで作成できること', ->
      post = BlogPost.create(content: '内容')
      post.should.not.be.false
