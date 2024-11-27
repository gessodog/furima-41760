class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,        presence: true
  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana,  presence: true
  validates :birth,           presence: true
  validate :password_complexity
  validate :first_name_zenkaku
  validate :last_name_zenkaku
  validate :first_name_kana_zenkaku
  validate :last_name_kana_zenkaku

  
  private

  def password_complexity
    return if password.blank? || password =~ /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/

    errors.add :password, 'must including one letter, one number'
  end

  def first_name_zenkaku
    return if first_name.blank? || first_name =~ /\A[ぁ-んァ-ヶ一-龠々ー]+\z/ 

    errors.add :first_name, 'must be full-width characters'
  end

  def last_name_zenkaku
    return if last_name.blank? || last_name =~ /\A[ぁ-んァ-ヶ一-龠々ー]+\z/ 

    errors.add :last_name, 'must be full-width characters'
  end

  def first_name_kana_zenkaku
    return if first_name_kana.blank? || first_name_kana =~ /\A[ァ-ヶー]+\z/ 

    errors.add :first_name_kana, 'must be full-width characters'
  end

  def last_name_kana_zenkaku
    return if last_name_kana.blank? || last_name_kana =~ /\A[ァ-ヶー]+\z/ 

    errors.add :last_name_kana, 'must be full-width characters'
  end
end
