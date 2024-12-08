class Shipping < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  belongs_to :buy

  validates :zipcode,          presence: true
  validates :prefecture_id,    numericality: { other_than: 1, message: "can't be blank" }
  validates :city,             presence: true
  validates :house_number,     presence: true
  validates :telephone_number, presence: true
end
