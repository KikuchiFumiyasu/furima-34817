class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user

  has_one_attached :image

  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_charge_burden
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :shipping_period

  with_options presence: true do
    validates :image
    validates :name
    validates :description

    with_options numericality: { greater_than: 1 } do
      validates :category_id
      validates :status_id
      validates :shipping_charge_burden_id
      validates :shipping_area_id
      validates :shipping_period_id
    end

    VALID_PRICEL_HALF = /\A[0-9]+\z/
    validates :price,
              numericality: { with: VALID_PRICEL_HALF, only_integer: true, greater_than_or_equal_to: 300,
                              less_than_or_equal_to: 9_999_999 }
  end
end
