class BuysController < ApplicationController

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @item = Item.find(params[:item_id])
    @form_buy = FormBuy.new
  end

  def create
    @item = Item.find(params[:item_id])
    @form_buy = FormBuy.new(buy_params)
    if @form_buy.valid?
      pay_item
      @form_buy.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render 'index', status: :unprocessable_entity
    end
  end

  private
  def buy_params
    params.require(:form_buy).permit(:zipcode, :prefecture_id, :city, :house_number, :building, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
    Payjp::Charge.create(
      amount: @item.price,  
      card: buy_params[:token],
      currency: 'jpy'               
    )
  end
end
