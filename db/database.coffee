pg = require 'pg'
env = process.env
connString = 'postgres://' + env.PG_USER + ':' + env.PG_PW + '@' + env.PG_HOST + '/' + env.PG_DB + '?ssl=true'

class Database
  constructor: ->
    @client = undefined
    @releaseClient = undefined
    @ready = false
    @connect()
  connect: =>
    pg.connect(connString, (err, client, done) =>
      return console.error('error fetching client from pool', err) if err

      @client = client
      @releaseClient = done
      @ready = true
    )
  timestamp: => Math.floor((new Date()).getTime() / 1000)
  query: (query, params, callback) =>
    if !@ready
      setTimeout((->
        @query(query, params, callback)
      ), 100)
      return
    @client.query(query, params, (err, res) =>
      @releaseClient()
      return console.log('error running query', err) if err
      callback(res)
    )

module.exports = new Database()