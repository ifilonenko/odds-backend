Database = require '../db/database.coffee'

class FeedController
  index: (req, res) =>
    query = 'SELECT * FROM posts ORDER BY id DESC;'
    Database.query(query, [], (dbres) ->
      res.send({posts: dbres})
    )

module.exports = new FeedController()