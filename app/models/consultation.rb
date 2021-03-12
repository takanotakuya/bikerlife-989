class Consultation < ApplicationRecord
  belongs_to :user
  has_many :consultations_comments, foreign_key: :consultation_id, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :post_text
  end

  def self.search(search)
    if search != ""
      Consultation.where('text LIKE(?)', "%#{search}%")
    else
      Consultation.all
    end
  end
end
