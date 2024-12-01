class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_state
  belongs_to :delivery_cost
  belongs_to :prefecture
  belongs_to :delivery_day

  belongs_to :user
  has_one_attached :image

  validates :image,            presence: true
  validates :item_name,        presence: true
  validates :item_information, presence: true
  validates :item_category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_state_id,    numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_cost_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id,    numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_day_id,  numericality: { other_than: 1 , message: "can't be blank"}
  validates :price,            presence: true
  validate :price_errors

  private

  def price_errors
    return if price.blank? || price >= 300 && price <= 9999999

    errors.add(:price, "must be between ¥300 and ¥9,999,999(half-width digits)")
  end
end


