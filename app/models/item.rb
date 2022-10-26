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
    validates :image, :name
    validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :delivery_date_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      format: { with: /\A[0-9]+\z/ }
  end
end