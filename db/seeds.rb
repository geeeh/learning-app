# frozen_string_literal: true

require './app/models/user'
users = [
  { username: 'Admin', email: 'admin@gmail.com', password: '123454321' },
  { username: 'godwin', email: 'godwin@gmail.com', password: '123454321' }
]

users.each do |user|
  @user = User.new(user)
  @user.set_admin
  @user.save!
end
