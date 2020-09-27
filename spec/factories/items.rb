FactoryBot.define do
  factory :item do
    name { 'テスト商品' }
    info { 'テスト商品の説明' }
    category_id { 2 }
    status_id { 2 }
    postage_id { 2 }
    prefecture_id { 2 }
    schduled_delivery_id { 2 }
    price { 1000 }
    association :user

    after(:build) do |content|
      content.image.attach(io: File.open('public/images/test_image.jpeg'), filename: 'test_image.png')
    end
  end
end
