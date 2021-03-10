class ConsultationsComment < ApplicationRecord
  belongs_to :user
  belongs_to :consultation

  with_options presence: true do
    validates :comment_text
  end
end
