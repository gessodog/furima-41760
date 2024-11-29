class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,        presence: true
  validates :birth,           presence: true
  validate :password_complexity

  
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,message: 'must be full-width characters(Kanji,Hiragana,Katakana)' } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'must be full-width characters(Katakana)' } do
    validates :first_name_kana
    validates :last_name_kana
  end



  private

  def password_complexity
    return if password.blank? || password =~ /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i

    errors.add :password, 'must including one letter, one number'
  end
end
