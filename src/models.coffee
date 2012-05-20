defineModels = (mongoose, mongooseAuth, fn) ->
    Schema = mongoose.Schema
    ObjectId = Schema.ObjectId

    # ブログ投稿
    BlogPost = new Schema
        user: type: ObjectId, ref: 'User', required: true
        content: type: String, required: true
        insert_ts: type: Date, default: Date.now
        update_ts: type: Date, default: Date.now
    BlogPost.virtual('id')
        .get -> @._id.toHexString()

    # ユーザー
    UserSchema = new Schema
    UserSchema.plugin mongooseAuth,
        everymodule:
            everyauth:
                User: -> User
        password:
            loginWith: 'email'
            extraParams: name: String
            everyauth:
                getLoginPath: '/login'
                postLoginPath: '/login'
                loginView: 'login.jade'
                getRegisterPath: '/register'
                postRegisterPath: '/register'
                registerView: 'register.jade'
                loginSuccessRedirect: '/'
                registerSuccessRedirect: '/'

    mongoose.model 'BlogPost', BlogPost
    BlogPost = exports.BlogPost = mongoose.model 'BlogPost'
    mongoose.model 'User', UserSchema
    User = exports.User = mongoose.model 'User'
    fn()

exports.defineModels = defineModels