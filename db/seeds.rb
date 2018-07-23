# frozen_string_literal: true

require './app/models/user'
require './app/models/category'
users = [
  { username: 'Admin', email: 'admin@gmail.com', password: '123454321' },
  { username: 'godwin', email: 'dev.godwin.gitonga@gmail.com', password: '123454321' }
]

categories = [
  { name: 'music', description: 'stories about music' },
  { name: 'food', description: 'stories about food' },
  { name: 'politics', description: 'stories about politics' },
  { name: 'technology', description: 'stories about technology' },
  { name: 'movies', description: 'stories about movies' },
  { name: 'war', description: 'stories about war' }
]

users.each do |user|
  new_user = User.new(user)
  new_user.set_admin
  new_user.save!
end

categories.each do |category|
  new_category = Category.new(category)
  new_category.save!
end
