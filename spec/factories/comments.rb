FactoryBot.define do
  factory :comment do
    comment_text { 'コメント' }
    association :user
    association :post
  end
end