Database = require '../db/database.coffee'

class CommentsController
  create: (req, res) =>
    comment = req.body.comment
    createdAt = updatedAt = (new Date()).toISOString()
    query = 'INSERT INTO comments (id, user_id, post_id, message, created_at, updated_at) VALUES ($1::int, $2::int, $3::int, $4, $5, $6) RETURNING id';
    Database.query(query, [Database.timestamp(), comment.user_id, comment.post_id, comment.message, createdAt, updatedAt], (dbres) ->
      res.send({comment: dbres})
    )

module.exports = new CommentsController()