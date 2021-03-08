FactoryBot.define do
  factory :post do
    name { '投稿名' }
    post_text { '投稿文' }
    association :user

    after(:build) do |post|
      post.image.attach(io: File.open('public/test_image.png'), filename: 'test_image.png')
    end
  end
end