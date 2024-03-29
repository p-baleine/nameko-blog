# TODO
# インデント
# db.clear

mongo = require 'mongodb'
mongoose = require 'mongoose'
mongooseAuth = require 'mongoose-auth'

models = require('../lib/models')

BSON = mongo.BSONPure

models.defineModels mongoose, mongooseAuth, ->
    db = mongoose.connect 'mongodb://localhost/nameko'

    BlogPost = models.BlogPost
    User = models.User

    describe 'BlogPost', ->
        describe '#save()', ->
            blog_post = new BlogPost()
            blog_post.content = 'こんにちは、テスト中'
            blog_post.user = new BSON.ObjectID()
            subject = null

            beforeEach (done) ->
                # blog_post.remove (err) ->
                #     done(err) if err
                blog_post.save (err) ->
                    BlogPost.findOne _id: blog_post._id, (err, doc) ->
                        subject = doc
                        done()
            describe '内容を指定してsave()した場合', ->
                it 'contentがセットされていること', ->
                    subject.content.should.equal 'こんにちは、テスト中'
                it 'insert_tsがセットされていること', ->
                    subject.insert_ts.should.be.below (new Date()).getTime()
                it 'update_tsがセットされていること', ->
                    subject.update_ts.should.be.below (new Date()).getTime()
                it 'プロパティidにObjectIdを文字列保持してるこ', ->
                    subject.id.should.be.equal subject._id.toString()
            describe '内容を指定せずsave()した場合', ->
                it 'エラーが返却されること', ->
                    blog_post = new BlogPost()
                    blog_post.user = new BSON.ObjectID()
                    blog_post.save (err) ->
                        err.name.should.equal 'ValidationError'
            describe 'userを指定せずにsave()した場合', ->
                it 'エラーが返却されること', ->
                    blog_post = new BlogPost()
                    blog_post.save (err) ->
                        err.name.should.equal 'ValidationError'


