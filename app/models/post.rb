class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :comments, foreign_key: :post_id, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :images
  end
end
