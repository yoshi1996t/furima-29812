class Item < ApplicationRecord
  belongs_to:user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :schduled_delivery

  #空の投稿を保存できないようにする
  validates :category, :sales_status, :shipping_fee_status, :prefecture, :schduled_delivery, presence: true

  #ジャンルの選択が「---」の時は保存できないようにする
  validates :genre_id, numericality: { other_than: 1 } 
end
