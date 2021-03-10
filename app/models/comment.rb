class Comment < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :user, optional: true

  with_options presence: true do
    validates :comment_text
  end
end
