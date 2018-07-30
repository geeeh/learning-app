# frozen_string_literal: true

require 'active_record'

# Category model
class Category < ActiveRecord::Base
  has_many :user_categories, class_name: 'UserCategory'
  has_many :users, through: :user_categories

  validates :name, :description, length: {
    maximum: 255
  }, presence: true
  validates :name, uniqueness: true
end
