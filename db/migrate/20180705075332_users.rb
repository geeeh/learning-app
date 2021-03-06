# User table migration.
class Users < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |column|
      column.string :username
      column.string :email
      column.string :password_digest
      column.boolean :admin, default: false
      column.timestamps null: false
    end
  end
end
