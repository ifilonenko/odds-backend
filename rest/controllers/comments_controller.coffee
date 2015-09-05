Database = require '../db/database.coffee'

class CommentsController
  create: (req, res) =>
    comment = req.comment
    timestamp = (new Date()).getTime()
    query = 'INSERT INTO comments (id, user_id, post_id, message) VALUES ($1::int, $2::int, $3::int, $4) RETURNING id';
    Database.query(query, [timestamp, comment.user_id, comment.post_id, comment.message], (dbres) ->
      res.send({comment: dbres})
    )

module.exports = new FeedController()