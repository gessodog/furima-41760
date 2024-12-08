class BuysController < ApplicationController

  def index
    # @buy = Buy.new
    # @item = Item.find(params[:item_id])
    @form_object = FormObject.new
  end

  def create
    @buy = Buy.new(buy_params)
    if @buy.valid?
      @buy.save
      return redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private
  def buy_params
    params.require(:buy).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
