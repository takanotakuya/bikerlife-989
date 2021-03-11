class AddUserIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :Self_introduction, :text
  end
end
