class BuysController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @form_buy = FormBuy.new
  end

  def create
    @item = Item.find(params[:item_id])
    @form_buy = FormBuy.new(buy_params)
    if @form_buy.valid?
      @form_buy.save
      return redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private
  def buy_params
    params.require(:form_buy).permit(:zipcode, :prefecture_id, :city, :house_number, :building, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
