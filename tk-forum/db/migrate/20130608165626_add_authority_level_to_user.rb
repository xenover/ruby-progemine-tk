class AddAuthorityLevelToUser < ActiveRecord::Migration
  def change
  	add_column :users, :authority_level, :integer, :default => 0
  end
end
