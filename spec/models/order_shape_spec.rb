require 'rails_helper'

RSpec.describe OrderShape, type: :model do
  describe '配送先の情報' do
    before do
      @order_shape = FactoryBot.build(:order_shape)
    end

    describe '商品購入' do
      context '商品購入がうまくいくとき'
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shape).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it 'tokenが空では保存できないこと' do
        @order_shape.token = nil
        @order_shape.valid?
        expect(@order_shape.errors.full_messages).to include("Token can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_shape.post_code = '1234567'
        @order_shape.valid?
        expect(@order_shape.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'prefectureが1では保存できないこと' do
        @order_shape.prefecture_id = 1
        @order_shape.valid?
        expect(@order_shape.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では保存できないこと' do
        @order_shape.city = nil
        @order_shape.valid?
        expect(@order_shape.errors.full_messages).to include("City can't be blank")
      end
      it 'municipalityが空では保存できないこと' do
        @order_shape.municipality = nil
        @order_shape.valid?
        expect(@order_shape.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'building_nameは空でも保存できること' do
        expect(@order_shape).to be_valid
      end
      it 'phone_numberが11桁の半角数字でないと保存できないこと' do
        @order_shape.phone_number = 'aaaaaaaaaaa'
        @order_shape.valid?
        expect(@order_shape.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
