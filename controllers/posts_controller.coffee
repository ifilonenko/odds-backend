Database = require '../db/database.coffee'

class PostsController
  create: (req, res) =>
    post = req.body.post
    createdAt = updatedAt = (new Date()).toISOString()
    query = 'INSERT INTO posts (id, winner_id, loser_id, task, odds, like_count, created_at, updated_at) VALUES ($1::int, $2::int, $3::int, $4, $5::int, 0, $6, $7) RETURNING id';
    Database.query(query, [Database.timestamp(), post.winner_id, post.loser_id, post.task, post.odds, createdAt, updatedAt], (dbres) ->
      res.send({post: dbres})
    )

module.exports = new PostsController()