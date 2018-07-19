# frozen_string_literal: true

require 'active_record'

# Category model
class Subject < ActiveRecord::Base
  has_many :user_subjects, class_name: 'UserSubject'
  has_many :users, through: :user_subjects

  validates :name, :description, length: {
    maximum: 255
  }
  validates :name, uniqueness: true
end
