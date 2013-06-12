class AddPriorityToCategories < ActiveRecord::Migration
  def up
  	add_column :categories, :priority, :integer, :default => 0
  end

  def down
  	remove_column :categories, :priority
  end
end
