class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_date
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name, :price
    validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :delivery_date_id, numericality: { other_than: 1, message: "can't be blank" }
  end
end