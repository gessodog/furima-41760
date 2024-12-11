class FormBuy
  include ActiveModel::Model
  attr_accessor :zipcode, :prefecture_id, :city, :house_number, :building, :telephone_number, :user_id, :item_id, :buy_id, :token

  validates :token, presence: true
  validates :zipcode, presence: true
  validate :validate_zipcode
  validates :prefecture_id,    numericality: { other_than: 1, message: "can't be blank" }
  validates :city,             presence: true
  validates :house_number,     presence: true
  validates :telephone_number, presence: true
  validate :telephone_number_errors

  def save
    buy = Buy.create(user_id: user_id, item_id: item_id)
    Shipping.create(zipcode: zipcode, prefecture_id: prefecture_id, city: city, house_number: house_number, building: building,
                    telephone_number: telephone_number, buy_id: buy.id)
  end

  private

  def validate_zipcode
    return if zipcode.blank? || zipcode =~ /\A[0-9]{3}-[0-9]{4}\z/

    errors.add(:zipcode, 'is Include hyphen(-) and numbers(half-width digits)')
  end

  def telephone_number_errors
    return if telephone_number.blank? || telephone_number =~ /\A\d{10,11}\z/

    errors.add(:telephone_number, 'is must be 10 or 11 numbers(half-width digits)')
  end
end
