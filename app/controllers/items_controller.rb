class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :aggregate_items, except: [:index, :new, :create]
  before_action :appropriate_user, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
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

  def update
    @item.update(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_to item_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :description, :category_id, :status_id, :shipping_charge_burden_id,
                                 :shipping_area_id, :shipping_period_id, :price).merge(user_id: current_user.id)
  end

  def aggregate_items
    @item = Item.find(params[:id])
  end

  def appropriate_user
    redirect_to root_path unless current_user.id == @item.user_id
  end
end
