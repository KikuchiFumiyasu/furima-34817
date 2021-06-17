class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user

  has_one_attached :image

  belongs_to :category
  belongs_to :status
  belongs_to :shipping_charge_burden
  belongs_to :shipping_area
  belongs_to :shipping_period

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id
    validates :status_id
    validates :shipping_charge_burden_id
    validates :shipping_area_id
    validates :shipping_period_id
    validates :price
  end
  
end
