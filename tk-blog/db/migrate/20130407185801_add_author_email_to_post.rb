class AddAuthorEmailToPost < ActiveRecord::Migration
  def change
    add_column :posts, :author_email, :string
  end
end
