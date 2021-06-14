class Item < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  with_options presence: true do
    validtes :image
    validtes :name
    validtes :description
    validtes :category_id
    validtes :status_id
    validtes :shipping_charge_burden_id
    validtes :shipping_area_id
    validtes :shipping_period_id
    validtes :price
  end
  
end
