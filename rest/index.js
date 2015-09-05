var express = require('express');
var app = express();

var FeedController = require('./controllers/feed_controller.coffee');
var CommmentsController = require('./controllers/comments_controller.coffee');
var PostsController = require('./controllers/posts_controller.coffee');

app.get('/feed', FeedController.index);
app.post('/users', UsersController.create);
app.post('/comments', CommentsController.create);
app.post('/posts', PostsController.create);