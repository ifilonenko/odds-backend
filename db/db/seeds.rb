# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [
  User.create(name: 'Ilan Filonenko', profile_pic: 'http://i.imgur.com/8KtR5g4.jpg'),
  User.create(name: 'Eric Appel', profile_pic: 'http://static.libsyn.com/p/assets/4/0/b/7/40b79e5360461d35/eric-appel.jpg')
]

posts = [
  Post.create(winner_id: user.first.id, loser_id: user.last.id, task: 'Hug a platypus', odds: 5, like_count: 0)
]

comments = [
  Comment.create(user_id: user.first.id, text: 'Hahaha')
]