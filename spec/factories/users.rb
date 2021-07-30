FactoryBot.define do
  factory :user do
    nickname                 { Faker::Name.initials(number: 2) }
    email                    { Faker::Internet.free_email }
    password                 { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation    { password }
    first_name               { '一郎' }
    last_name                { '山田' }
    first_name_how_to_read   { 'イチロウ' }
    last_name_how_to_read    { 'ヤマダ' }
    birth_day                { '2021-4-20' }
  end
end
