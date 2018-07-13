# frozen_string_literal: true

require 'active_record'

# user model.
class User < ActiveRecord::Base
  has_many :user_subjects, class_name: 'UserSubject'
  has_many :subjects, through: :user_subjects

  validates :username, :email, length: {
    maximum: 35,
    too_long: 'must have at least %{count} letters'
  }, uniqueness: true

  validates :password, format: {
    with: /\A[a-zA-Z0-9!@#\$%^&\(\)]+\z/,
    message: "only allows a-z, 0-9 and !@\#$%^&*()"
  }

  def encrypt_password(password)
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    self.password = password_hash
    self.salt = password_salt
  end

  def confirm_password(password, user)
    @confirmed = false
    correct_pass = BCrypt::Engine.hash_secret(password, user.salt)
    if correct_pass == user.password
      @confirmed = true
    else
      @confirmed
    end
  end
end