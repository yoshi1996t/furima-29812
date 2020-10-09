class OrderShape
  include ActiveModel::Model

  attr_accessor :post_code, :prefecture_id, :city, :municipality, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :city, :municipality, :token
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }

    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

    validates :phone_number, format: { with: /\A[0-9]+\z/ }, length: { maximum: 11 }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)

    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, municipality: municipality, building_name: building_name, phone_number: phone_number, order: order)
  end
end
