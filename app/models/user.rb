class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,:birthday, presence: true

  # validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  validates :password, presence: true, format: { with: /(?=.*\d+.*)(?=.*[a-zA-Z]+.*)./ }
  # ユーザー本名は全角（漢字・ひらがな・カタカナ）で入力させること
  validates :first_name, :family_name, presence: true, format: { with: /\A([ぁ-んァ-ン一-龥]|ー)+\z/}
  # ユーザー本名のフリガナは全角（カタカナ）で入力させること
  validates :first_name_kana, :family_name_kana, presence: true, format: { with: /\A([ァ-ン]|ー)+\z/}
           
end
