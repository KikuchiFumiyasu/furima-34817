FactoryBot.define do
  factory :purchase_address do
    post_code        { '123-4567' }
    shipping_area_id { 2 }
    city             { '千代田区' }
    address          { '1-1' }
    building_name    { '東京ハイツ' }
    phone_number     { '08023234242' }
    token            { 'tok_a1b2c3d4e5f6g7h8i9j10k11l120' }
  end
end