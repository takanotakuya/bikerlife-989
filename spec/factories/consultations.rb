FactoryBot.define do
  factory :consultation do
    name { '相談名' }
    post_text { '相談内容' }
    association :user
  end
end