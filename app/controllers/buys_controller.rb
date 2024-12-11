class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @form_buy = FormBuy.new
  end

  def create
    @form_buy = FormBuy.new(buy_params)
    if @form_buy.valid?
      pay_item
      @form_buy.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def buy_params
    params.require(:form_buy).permit(:zipcode, :prefecture_id, :city, :house_number, :building, :telephone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: buy_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    return if current_user.id != @item.user_id && !Buy.exists?(item_id: @item.id)

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
