# Category migration file.
class Categories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |column|
      column.string :name
      column.string :description
      column.timestamps null: false
    end
  end
end
