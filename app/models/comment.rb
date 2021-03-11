class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  with_options presence: true do
    validates :comment_text
  end
end
