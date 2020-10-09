require 'rails_helper'

RSpec.describe '商品購入', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item, name: 'hoge')
    @order = FactoryBot.build(:order_shape)
  end
  context '購入ができるとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の購入ができる' do
      # 商品1を出品したユーザーでサインインする
      sign_in(@item1.user)
      # トップページに商品詳細ページのリンクがあるか確認する
      expect(page).to have_content(@item2.name)
      # 商品詳細ページへ遷移する
      click_link @item2.name
      # 商品詳細ページに 購入ページへのリンクがあることを確認する
      expect(page).to have_content('購入画面に進む')
      # 商品購入画面に遷移する
      click_on '購入画面に進む'
      # クレジットカード情報を入力する
      fill_in 'order_shape[number]', with: '4242424242424242'
      fill_in 'order_shape[exp_month]', with: '3'
      fill_in 'order_shape[exp_year]', with: '33'
      fill_in 'order_shape[cvc]', with: '123'
      # 配送先情報を入力する
      fill_in 'order_shape[post_code]', with: @order.post_code
      select '東京都', from: 'order_shape[prefecture_id]'
      fill_in 'order_shape[city]', with: @order.city
      fill_in 'order_shape[municipality]', with: @order.municipality
      fill_in 'order_shape[phone_number]', with: @order.phone_number
      # 購入するとトップページに遷移する
      click_on '購入'
      # トップページには、購入した商品がSOLD OUT表示になっている
      expect(page).to have_content('Sold Out!!')
    end
  end
  context '購入ができないとき' do
    it 'ログインしていないと商品出品ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 商品詳細ページへのリンクがない
      click_link @item2.name
      expect(page).to have_no_content('購入画面に進む')
    end
    it '自分の出品した商品は購入できない' do
      # トップページに遷移する
      visit root_path
      # 商品1を出品したユーザーでログインする
      sign_in(@item1.user)
      # 商品1の詳細ページに購入へのリンクがない
      click_link @item1.name
      expect(page).to have_no_content('購入画面に進む')
    end
  end
end
