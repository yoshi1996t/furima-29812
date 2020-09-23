class Item < ApplicationRecord
  belongs_to:user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :schduled_delivery

  has_one_attached :image

  #空の投稿を保存できないようにする
  validates :category, :status, :postage, :prefecture, :schduled_delivery, presence: true

  #ジャンルの選択が「---」の時は保存できないようにする
  validates :genre_id, numericality: { other_than: 1 } 

  with_options presence: true do
    validates :image
    validates :info
    validates :category
    validates :status
    validates :postage
    validates :presence
    validates :schduled_delivery
    validates :price

    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, with: /\A[0-9]+\z/}
  end

  
end
