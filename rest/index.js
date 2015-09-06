require('dotenv').load();
require('coffee-script/register');

var express = require('express');
var app = express();
var bodyParser = require('body-parser');
app.use(bodyParser());

var FeedController = require('./controllers/feed_controller.coffee');
var CommentsController = require('./controllers/comments_controller.coffee');
var PostsController = require('./controllers/posts_controller.coffee');
var UsersController = require('./controllers/users_controller.coffee');
var LikesController = require('./controllers/likes_controller.coffee');
var VideosController = require('./controllers/videos_controller.coffee');

app.get('/feed', FeedController.index);
app.post('/users', UsersController.create);
app.post('/comments', CommentsController.create);
app.post('/posts', PostsController.create);
app.post('/likes', LikesController.create);
app.get('/videos/:file_name', VideosController.getURL);
app
  .set('port', (process.env.PORT || 8080))
  .listen(app.get('port'), function() {
    console.log('Node app is running on port', app.get('port'));
  });
