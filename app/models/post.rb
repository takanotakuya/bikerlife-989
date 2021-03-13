class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, foreign_key: :post_id, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :image
  end
end
