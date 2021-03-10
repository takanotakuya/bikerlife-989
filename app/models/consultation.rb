class Consultation < ApplicationRecord
  belongs_to :user, optional: true
  has_many :consultations_comments, foreign_key: :consultation_id, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :post_text
  end
end
