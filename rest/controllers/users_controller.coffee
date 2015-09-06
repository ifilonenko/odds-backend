Database = require '../db/database.coffee'

class UsersController
  create: (req, res) =>
    user = req.body.user
    createdAt = updatedAt = (new Date()).toISOString()
    query = 'INSERT INTO users (id, name, photo_url, created_at, updated_at) VALUES ($1::int, $2, $3, $4, $5) RETURNING id';
    Database.query(query, [Database.timestamp(), user.name, user.photo_url, createdAt, updatedAt], (dbres) ->
      res.send({user: dbres})
    )

module.exports = new UsersController()