class RemoveSelfIntroductionFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :self_introduction, :text
  end
end
