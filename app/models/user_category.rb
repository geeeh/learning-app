# frozen_string_literal: true

class UserSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
end
