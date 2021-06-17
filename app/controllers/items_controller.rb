class ItemsController < ApplicationController

  
    def index
      @items = Item.all
    end

    def new
      @item = Item.new
    end

    def create
      @item = Item.new(item_params)
    end

    private

    def item_params
      params.require(:item).permit(:name, :image, :description, :category_id, :status_id, :shipping_charge_burden_id,
                                   :shipping_area_id, :shipping_period_id, :price, :user).merge(user_id: current_user.id)
    end

    def set_item
      @item = Item.find(params[:id])
    end
  

end
