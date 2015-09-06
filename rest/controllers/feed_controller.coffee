Database = require '../db/database.coffee'

class FeedController
  index: (req, res) =>
    query = 'SELECT id, like_count, odds, task, winner_id, loser_id FROM posts ORDER BY posts.id DESC;';
    posts = []
    done = 0
    render = ->
      return unless done == 3
      res.send({posts: posts})

    Database.query(query, [], (dbres) ->
      posts = dbres.rows
      postIDString = '{' + posts.map((row) -> row.id).join(',') + '}'
      commentsQuery = 'SELECT * FROM comments WHERE comments.post_id = ANY($1::INT[]);'
      Database.query(commentsQuery, [postIDString], (commentsRes) ->
        comments = commentsRes.rows
        for comment in comments
          for post in posts
            if post.id == comment.post_id
              if !post.comments
                post.comments = [comment]
              else
                post.comments.push(comment)
              `break`

        done++
        render()
      )

      winnerQuery = 'SELECT * FROM users WHERE users.id = ANY($1::INT[]);'
      postWinnerIDString = '{' + posts.map((row) -> row.winner_id).join(',') + '}'
      Database.query(winnerQuery, [postWinnerIDString], (winnerRes) ->
        winners = winnerRes.rows
        for winner in winners
          for post in posts
            if post.winner_id == winner.id
              post.winner = winner
              `break`
        done++
        render()
      )

      loserQuery = 'SELECT * FROM users WHERE users.id = ANY($1::INT[]);'
      postLoserIDString = '{' + posts.map((row) -> row.loser_id).join(',') + '}'
      Database.query(loserQuery, [postLoserIDString], (loserRes) ->
        losers = loserRes.rows
        for loser in losers
          for post in posts
            if post.loser_id == loser.id
              post.loser = loser
              `break`
        done++
        render()
      )
    )

module.exports = new FeedController()