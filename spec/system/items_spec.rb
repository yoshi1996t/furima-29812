require 'rails_helper'

RSpec.describe "商品出品", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end
  context '出品ができる時'do
    it 'ログインしている時' do
      # サインインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('出品する')
      # 出品ページに移動する
      visit new_item_path
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.jpeg')
      # 商品情報の入力
      attach_file('item[image]', image_path, make_visible: true)
      fill_in 'item[name]', with: @item.name
      fill_in 'item[info]', with: @item.info
      select 'レディース', from: 'item-category'
      select '新品、未使用', from: 'item-sales-status'
      select '着払い(購入者負担)', from: 'item-shipping-fee-status'
      select '東京都', from: 'item-prefecture'
      select '1~2日で発送', from: 'item-scheduled-delivery'
      fill_in 'item[price]', with: @item.price
      # 送信するとItemモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      # トップページに遷移することを確認する
      visit root_path
      # トップページには先ほど出品した商品の情報が存在することを確認する（画像）
      expect(page).to have_content(@item_image)
      # トップページには先ほど投稿した内容のが存在することを確認する（名前と金額）
      expect(page).to have_content(@item_mame)
      expect(page).to have_content(@item_price)
    end
  end

  context '出品できないとき'do
    it 'ログインしていないと商品出品ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへ遷移しようとすると新規登録画面に遷移する
      click_on '出品する'
    end
  end
end

RSpec.describe '商品編集', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item, name: "hoge")
  end
  context '商品編集ができるとき' do
    it 'ログインしたユーザーは自分が出品した商品の編集ができる' do
      # 商品1を出品したユーザーでログインする
      sign_in(@item1.user)   
      #トップページに商品詳細ページのリンクがあるか確認する
      expect(page).to have_content(@item1.name) 
      # 商品詳細ページへ遷移する
      click_link @item1.name
      # 商品詳細ページに編集ページへのリンクがあることを確認する
      expect(page).to have_content('商品の編集')
      # 編集ページへ遷移する
      click_on "商品の編集"
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#item-name').value
      ).to eq @item1.name
      expect(
        find('#item-info').value
      ).to eq @item1.info
      expect(
          find('#item-category').value
        ).to eq @item1.category.id.to_s
      expect(
        find('#item-sales-status').value
      ).to eq @item1.status.id.to_s
      expect(
        find('#item-shipping-fee-status').value
      ).to eq @item1.postage.id.to_s
      expect(
        find('#item-prefecture').value
      ).to eq @item1.prefecture.id.to_s
      expect(
        find('#item-scheduled-delivery').value
      ).to eq @item1.schduled_delivery.id.to_s
      # 商品内容を編集する
      fill_in 'item-name', with: "#{@item1.name}+変更"
      # 編集してもItemモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(0)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content("#{@item1.name}+変更")
    end
  end
  context '商品編集ができないとき' do
    it 'ログインしたユーザーは自分以外が出品した商品の編集画面には遷移できない' do
      # 商品1を出品したユーザーでログインする
      sign_in(@item1.user)
      # 商品2の詳細画面に遷移する
      click_link @item2.name
      # 商品2に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('商品の編集')
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 商品1の詳細ページに遷移する
      click_link @item1.name
      # 商品1に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('商品の編集')
      # トップページにいる
      visit root_path
      # 商品2の詳細ページに遷移する
      click_link @item2.name
      # 商品2に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('商品の編集')
    end
  end
end

RSpec.describe '商品の削除', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item, name: "hoge")
  end
  context '商品の削除ができるとき' do
    it 'ログインしたユーザーは自らが出品した商品の削除ができる' do
      # 商品1を出品したユーザーでログインする
      sign_in(@item1.user)
      #トップページに商品詳細ページのリンクがあるか確認する
      expect(page).to have_content(@item1.name) 
      # 商品詳細ページへ遷移する
      click_link @item1.name
      # 商品詳細ページに削除ページへのリンクがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        click_on "削除"}.to change { Item.count }.by(-1)
      # トップページには商品1の変更が存在することを確認する（名前）
      expect(page).to have_content(@item1_mame)
    end
  end
  context '商品の削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # 商品1を投稿したユーザーでログインする
      sign_in(@item1.user)
      # 商品2の詳細ページに遷移する
      click_link @item2.name
      # 商品2に「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除')
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # 商品1の詳細ページに遷移する
      click_link @item1.name
      # 商品1に「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除')
      # 商品2の詳細ページに遷移する
      visit root_path
      # 商品2の詳細ページに遷移する
      click_link @item2.name
      # 商品2に「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除')
    end
  end
end

