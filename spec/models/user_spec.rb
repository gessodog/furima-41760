require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空だと登録できない' do
      user = User.new(nickname: '', email: 'test@example', password: '000abc', password_confirmation: '000abc', first_name: "あ", last_name: "あ", first_name_kana: "カ", last_name_kana: "カ", birth: "1999-05-06")
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
    end
  end
end
