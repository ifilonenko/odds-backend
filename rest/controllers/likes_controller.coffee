Database = require '../db/database.coffee'

class LikesController
  create: (req, res) =>
    console.log('Params: ' + JSON.stringify(req.body))
    like = req.body.like
    timestamp = (new Date()).getTime()
    query = 'UPDATE posts SET like_count = like_count + 1 WHERE id=$1::int';
    Database.query(query, [like.post_id], (dbres) ->
      res.send({success: true})
    )

module.exports = new LikesController()