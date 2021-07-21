class PurchaseAddress

  include ActiveModel::Model
  attr_accessor :post_code, :shipping_area_id, :city, :address, :building_name, :phone_number, :purchase, :item_id, :user_id, :token

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :shipping_area_id, numericality: { greater_than: 1 }
    validates :city
    validates :address
    VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
    validates :phone_number, numericality: { with: VALID_PHONE_NUMBER_REGEX, only_integer: true }, length: { maximum: 11 }
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, shipping_area_id: shipping_area_id, city: city, address: address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end