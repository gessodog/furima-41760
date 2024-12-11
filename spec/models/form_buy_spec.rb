require 'rails_helper'

RSpec.describe FormBuy, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @form_buy = FactoryBot.build(:form_buy, user_id: user.id, item_id: item.id)
  end

  describe '商品購入機能' do
    context '商品を購入できるとき' do
      it 'すべての条件がそろっていれば保存できる' do
        expect(@form_buy).to be_valid
      end
      it 'buildingが空でも保存できる' do
        @form_buy.building = ''
        expect(@form_buy).to be_valid
      end
    end
    context '商品を購入できないとき' do
      it 'zipcodeが空では保存できない' do
        @form_buy.zipcode = ''
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include("Zipcode can't be blank")
      end
      it 'zipcodeは間にハイフンが含まれていないと保存できない' do
        @form_buy.zipcode = '1234567'
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include('Zipcode is Include hyphen(-) and numbers(half-width digits)')
      end
      it 'zipcodeは半角数字でないと保存できない' do
        @form_buy.zipcode = 'abc-defg'
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include('Zipcode is Include hyphen(-) and numbers(half-width digits)')
      end
      it 'prefecture_idが空では保存できない' do
        @form_buy.prefecture_id = ''
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが「---」では保存できない' do
        @form_buy.prefecture_id = '1'
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では保存できない' do
        @form_buy.city = ''
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空では保存できない' do
        @form_buy.house_number = ''
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include("House number can't be blank")
      end
      it 'telephone_numberが空では保存できない' do
        @form_buy.telephone_number = ''
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include("Telephone number can't be blank")
      end
      it 'telephone_numberはハイフンが含まれていると保存できない' do
        @form_buy.telephone_number = '090-1111-2222'
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include('Telephone number is must be 10 or 11 numbers(half-width digits)')
      end
      it 'telephone_numberは半角数字でないと保存できない' do
        @form_buy.telephone_number = 'abcddddeeee'
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include('Telephone number is must be 10 or 11 numbers(half-width digits)')
      end
      it 'telephone_numberは9桁以下では保存できない' do
        @form_buy.telephone_number = '123456789'
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include('Telephone number is must be 10 or 11 numbers(half-width digits)')
      end
      it 'telephone_numberは12桁以上では保存できない' do
        @form_buy.telephone_number = '123123456789'
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include('Telephone number is must be 10 or 11 numbers(half-width digits)')
      end
      it 'tokenが空では保存できないこと' do
        @form_buy.token = ''
        @form_buy.valid?
        expect(@form_buy.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
