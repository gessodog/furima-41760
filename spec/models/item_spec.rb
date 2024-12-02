require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品を出品できるとき' do
      it 'すべての条件がそろっていれば保存できる' do
        expect(@item).to be_valid
      end
    end
    context '商品を出品できないとき' do
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_nameが空では保存できない' do
        @item.item_name = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'item_informationが空では保存できない' do
        @item.item_information = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Item information can't be blank")
      end
      it 'item_category_idが空では保存できない' do
        @item.item_category_id = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Item category can't be blank")
      end
      it 'item_state_idが空では保存できない' do
        @item.item_state_id = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Item state can't be blank")
      end
      it 'delivery_cost_idが空では保存できない' do
        @item.delivery_cost_id = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery cost can't be blank")
      end
      it 'prefecture_idが空では保存できない' do
        @item.prefecture_id = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'delivery_day_idが空では保存できない' do
        @item.delivery_day_id = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end
      it 'priceが空では保存できない' do
        @item.price = ' '
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが300~9,999,999の間にないなら保存できない' do
        @item.price = '100'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be between ¥300 and ¥9,999,999(half-width digits)')
      end
      it 'priceが半角数字ではないなら保存できない' do
        @item.price = 'あいう'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be between ¥300 and ¥9,999,999(half-width digits)')
      end
      it 'userが紐づいていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
