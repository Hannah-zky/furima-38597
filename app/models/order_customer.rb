class OrderCustomer
  include ActiveModel::Model
  attr_accessor :zipcode, :prefecture_id, :city, :address_line, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :zipcode, format: { with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city, :address_line, :user_id, :item_id, :token
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Input only number" }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Customer.create(zipcode: zipcode, prefecture_id: prefecture_id, city: city, address_line: address_line, building: building, phone_number: phone_number, order_id: order.id)
  end
end

