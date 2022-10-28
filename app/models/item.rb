class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_date

validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :delivery_date_id, numericality: { other_than: 1, message: "can't be blank" }
  with_options presence: true do
    validates :image, :name, :explanation
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
  end
end