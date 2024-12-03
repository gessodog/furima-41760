class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items, dependent: :destroy

  validates :nickname,        presence: true
  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana,  presence: true
  validates :birth,           presence: true
  validate :first_name_complexity
  validate :last_name_complexity
  validate :first_name_kana_complexity
  validate :last_name_kana_complexity
  validate :password_complexity

  private

  def first_name_complexity
    return if first_name.blank? || first_name =~ /\A[ぁ-んァ-ヶ一-龥々ー]+\z/

    errors.add :first_name, 'must be full-width characters(Kanji,Hiragana,Katakana)'
  end

  def last_name_complexity
    return if last_name.blank? || last_name =~ /\A[ぁ-んァ-ヶ一-龥々ー]+\z/

    errors.add :last_name, 'must be full-width characters(Kanji,Hiragana,Katakana)'
  end

  def first_name_kana_complexity
    return if first_name_kana.blank? || first_name_kana =~ /\A[ァ-ヶー]+\z/

    errors.add :first_name_kana, 'must be full-width characters(Katakana)'
  end

  def last_name_kana_complexity
    return if last_name_kana.blank? || last_name_kana =~ /\A[ァ-ヶー]+\z/

    errors.add :last_name_kana, 'must be full-width characters(Katakana)'
  end

  def password_complexity
    return if password.blank? || password =~ /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

    errors.add :password, 'must including one letter, one number'
  end
end
