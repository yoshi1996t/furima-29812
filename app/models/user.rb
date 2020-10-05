class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :birthday, presence: true

  validates :password, presence: true, format: { with: /(?=.*\d+.*)(?=.*[a-zA-Z]+.*)./ }
  
  validates :first_name, :family_name, presence: true, format: { with: /\A([ぁ-んァ-ン一-龥]|ー)+\z/ }
  
  validates :first_name_kana, :family_name_kana, presence: true, format: { with: /\A([ァ-ン]|ー)+\z/ }

  has_many :items
end
