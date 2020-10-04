class OrderShape
  include ActiveModel::Model

  attr_accessor :post_code, :prefecture_id, :city, :municipality, :building_name, :phone_number, :user_id, :item_id, :token

  # 空の投稿を保存できないようにする
  validates :post_code, :prefecture_id, :city, :municipality, :phone_number, :token,  presence: true


  validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"} 
   # 「住所」の都道府県に関するバリデーション
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  # validates :phone_number, numericality: { /\A[0-9]+\z/, message: "Phone number can't be blank" }

  def save
    # 商品購入者情報を保存し、「order」という変数に入れている
    order = Order.create(user_id: user_id, item_id: item_id)
    # 配送先の情報を保存
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, municipality: municipality, building_name: building_name, phone_number: phone_number, order: order)
  end

end