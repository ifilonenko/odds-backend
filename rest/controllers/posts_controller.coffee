Database = require '../db/database.coffee'

class PostsController
  create: (req, res) =>
    post = req.post
    timestamp = (new Date()).getTime()
    query = 'INSERT INTO posts (id, winner_id, loser_id, task, odds, like_count) VALUES ($1::int, $2::int, $3::int, $4, $5::int, 0) RETURNING id';
    Database.query(query, [timestamp, post.winner_id, post.loser_id, post.task, post.odds], (dbres) ->
      res.send({post: dbres})
    )

module.exports = new PostsController()