class AddClosedToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :closed, :boolean, {:default => false}
  end

  def down
    remove_column :posts, :closed
  end
end
