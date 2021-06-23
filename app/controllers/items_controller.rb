class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :description, :category_id, :status_id, :shipping_charge_burden_id,
                                 :shipping_area_id, :shipping_period_id, :price, :user).merge(user_id: current_user.id)
  end
end
