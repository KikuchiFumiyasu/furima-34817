FactoryBot.define do
  factory :item do
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test-image.png'), filename: 'test-image.png')
    end

    name                           { 'test' }
    description                    { 'test,test' }
    category_id                    { 2 }
    status_id                      { 2 }
    shipping_charge_burden_id      { 2 }
    shipping_area_id               { 2 }
    shipping_period_id             { 2 }
    price                          { 300 }

    association :user

  end
end
