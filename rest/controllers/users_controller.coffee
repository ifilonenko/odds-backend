Database = require '../db/database.coffee'

class UsersController
  create: (req, res) =>
    user = req.user
    timestamp = (new Date()).getTime()
    query = 'INSERT INTO users (id, name, photo_url) VALUES ($1::int, $2, $3) RETURNING id';
    Database.query(query, [timestamp, req.name, req.photo_url], (dbres) ->
      res.send({user: dbres})
    )

module.exports = new UsersController()