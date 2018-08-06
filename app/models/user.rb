# frozen_string_literal: true

require 'active_record'

# user model.
class User < ActiveRecord::Base
  has_many :user_categories, class_name: 'UserCategory'
  has_many :categories, through: :user_categories

  VALID_USERNAME = /\A[^\d]+\z/
  VALID_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :username,
            uniqueness: true,
            presence: true,
            format: { with: VALID_USERNAME },
            length: { minimum: 2 }

  validates :email,
            format: { with: VALID_EMAIL },
            presence: true,
            uniqueness: true

  validates :password, length: {
    minimum: 8,
    confirmation: true
  }

  has_secure_password

  def set_admin
    self.admin = true
  end

  def admin?
    admin
  end
end
