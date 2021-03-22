FactoryBot.define do
  factory :consultations_comment do
    comment_text { 'コメント' }
    association :user
    association :consultation
  end
end