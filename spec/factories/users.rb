FactoryBot.define do
  factory :user do
    nickname { Faker::Name.initials(number: 2) }
    email { Faker::Internet.free_email }
    # password = Faker::Internet.password(min_length: 8)
    password { 'aaa000' }
    password_confirmation { 'aaa000' }
    first_name { 'あア亜' }
    family_name { 'あア亜' }
    first_name_kana { 'カタカナ' }
    family_name_kana { 'カタカナ' }
    birthday { 19_900_403 }
  end
end
