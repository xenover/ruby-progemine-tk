class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :category
      t.references :user
      t.string :name

      t.timestamps
    end
    add_index :topics, :category_id
    add_index :topics, :user_id
  end
end
