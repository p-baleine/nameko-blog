defineModels = (mongoose, mongooseAuth, fn) ->
    Schema = mongoose.Schema
    ObjectId = Schema.ObjectId

    BlogPost = new Schema
        user: type: ObjectId, ref: 'User'
        content: String
        insert_ts: type: Date, default: Date.now
        update_ts: type: Date, default: Date.now
    BlogPost.virtual('id')
        .get -> @._id.toHexString()

    User = new Schema
    User.plugin mongooseAuth,
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
    mongoose.model 'User', User
    fn()

exports.defineModels = defineModels