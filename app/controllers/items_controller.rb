class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :set_buy, only: [:index, :show]

  def index
    @item = Item.order(created_at: :desc)
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

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_information, :item_category_id, :item_state_id, :delivery_cost_id,
                                 :prefecture_id, :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    return if current_user.id == @item.user_id && !Buy.exists?(item_id: @item.id)

    redirect_to action: :index
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_buy
    @buy = Buy.all
  end
end
