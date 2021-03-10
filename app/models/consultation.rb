class Consultation < ApplicationRecord
  belongs_to :user
  has_many :consultations_comments

  with_options presence: true do
    validates :name
    validates :post_text
  end
end
