class Consultation < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :name
    validates :post_text
  end
end
