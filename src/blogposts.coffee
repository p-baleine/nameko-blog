BlogPost = require('./models').BlogPost
User = require('./models').User

# blogposts GET
exports.index = (req, res) ->
  console.log 'blogposts GET'
  BlogPost.find({}).exec (err, docs) ->
    res.send docs, 200

# blogposts POST
exports.create = (req, res) ->
  console.log 'blogposts POST'

# blogposts PUT
exports.update = (req, res) ->
  console.log 'blogposts PUT'

# blogposts DELETE
exports.destroy = (req, res) ->
  console.log 'blogposts DELETE'

