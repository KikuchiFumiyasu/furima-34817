class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_date, only: [:index, :create]
  before_action :transition_limit

  def index
    @purchase_address = PurchaseAddress.new
  end

  def new
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:post_code, :shipping_area_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,              # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency: 'jpy'                   # 通貨の種類（日本円）
    )
  end

  def item_date
    @item = Item.find(params[:item_id])
  end

  def transition_limit
    return redirect_to root_path if current_user.id == @item.user.id || user_signed_in? && !@item.purchase.nil?
  end
end
