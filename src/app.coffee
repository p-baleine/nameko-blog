express = require 'express'
routes = require '../routes'
models = require './models'
mongoose = require 'mongoose'
mongooseAuth = require 'mongoose-auth'

app = module.exports = express.createServer()

# 設定
app.configure ->
    app.set 'views', __dirname + '/../views'
    app.set 'view engine', 'jade'
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser()
    app.use express.session secret: 'nameko'
    app.use express.static(__dirname + '/../public')

app.configure 'development', ->
    app.set 'connstring', 'mongodb://localhost/nameko'
    app.use express.errorHandler(dumpException: true, showStack: true)

app.configure 'production', ->
    app.set 'connstring', 'mongodb://localhost/nameko'
    app.use express.errorHandler()

models.defineModels mongoose, mongooseAuth, ->
    app.BlogPost = mongoose.model 'BlogPost'
    app.User = mongoose.model 'User'
    db = mongoose.connect app.set 'connstring'
    app.use mongooseAuth.middleware()

# ルーティング

app.get '/', (req, res) ->
    console.log req.user

mongooseAuth.helpExpress app

app.listen 3000, ->
    console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env