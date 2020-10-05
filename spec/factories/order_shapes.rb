FactoryBot.define do
  factory :order_shape do
    token { "tok_abcdefghijk00000000000000000" }
    post_code  { '123-4567' }   
    prefecture_id  { 2 }
    city         { '東京都' }
    municipality  { '1-1' }
    building_name  { '東京ベイ' }
    phone_number  { "00000000000" }
  end
end
