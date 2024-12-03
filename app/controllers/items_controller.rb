class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

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
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_information, :item_category_id, :item_state_id, :delivery_cost_id,
                                 :prefecture_id, :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
