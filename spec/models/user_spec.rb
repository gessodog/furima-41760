require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての条件がそろっていれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが重複すると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailが@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空だと登録できない' do
        @user.password = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下だと登録できない' do
        @user.password = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが半角英字のみだと登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must including one letter, one number')
      end
      it 'passwordが数字のみだと登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must including one letter, one number')
      end
      it 'passwordが全角文字だと登録できない' do
        @user.password = 'あいうえおか'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must including one letter, one number')
      end
      it 'passwordとpassword_confirmationは値が不一致だと登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = '456def'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'first_nameが空だと登録できない' do
        @user.first_name = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank",
                                                      'First name must be full-width characters(Kanji,Hiragana,Katakana)')
      end
      it 'last_nameが空だと登録できない' do
        @user.last_name = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank",
                                                      'Last name must be full-width characters(Kanji,Hiragana,Katakana)')
      end
      it 'first_nameは全角（漢字・ひらがな・カタカナ）以外が含まれていると登録できない' do
        @user.first_name = '試験test'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name must be full-width characters(Kanji,Hiragana,Katakana)')
      end
      it 'last_nameは全角（漢字・ひらがな・カタカナ）以外が含まれていると登録できない' do
        @user.last_name = '試験test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name must be full-width characters(Kanji,Hiragana,Katakana)')
      end
      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank",
                                                      'First name kana must be full-width characters(Katakana)')
      end
      it 'last_name_kanaが空だと登録できない' do
        @user.last_name_kana = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank",
                                                      'Last name kana must be full-width characters(Katakana)')
      end
      it 'first_name_kanaは全角（カタカナ）以外が含まれていると登録できない' do
        @user.first_name_kana = ' テストtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana must be full-width characters(Katakana)')
      end
      it 'last_name_kanaは全角（カタカナ）以外が含まれていると登録できない' do
        @user.last_name_kana = 'テストtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana must be full-width characters(Katakana)')
      end
      it 'birthが「--」だと登録できない' do
        @user.birth = '--------'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
      it 'birthが空だと登録できない' do
        @user.birth = ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end
