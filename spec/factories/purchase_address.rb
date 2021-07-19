FactoryBot.define do
  factory :purchase_address do
    post_code        { '123-4567' }
    shipping_area_id { 2 }
    city             { '千代田区' }
    address          { '1-1' }
    building_name    { '東京ハイツ' }
    phone_number     { '08023234242' }
  end
end