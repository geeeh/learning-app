# frozen_string_literal: true

class UserCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :user_subjects do |column|
      column.references :user, foreign_key: true
      column.references :subject, foreign_key: true
      column.timestamps null: false
    end
  end
end
