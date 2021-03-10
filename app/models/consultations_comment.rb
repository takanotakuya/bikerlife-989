class ConsultationsComment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :consultation, optional: true

  with_options presence: true do
    validates :comment_text
  end
end
