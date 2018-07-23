# frozen_string_literal: true

require 'active_record'

# user model.
class User < ActiveRecord::Base
  has_many :user_categories, class_name: 'UserCategory'
  has_many :categories, through: :user_categories

  validates :username, length: {
    maximum: 35,
    too_long: 'must have at most %{count} letters'
  }, uniqueness: true

  has_secure_password

  def set_admin
    self.admin = true
  end

  def admin?
    admin
  end
end
