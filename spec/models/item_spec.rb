require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品ができる場合' do
      it '全ての情報があれば出品できること' do
        expect(@item).to be_valid
      end

      it '商品画像があれば出品できること' do
        expect(@item.image).to be_valid
      end

      it '商品名があれば出品できること' do
        @item.name = 'test'
        expect(@item).to be_valid
      end

      it '商品説明があれば出品できること' do
        @item.description = 'test,test'
        expect(@item).to be_valid
      end

      it 'カテゴリー情報があれば出品できること' do
        @item.category_id = '2'
        expect(@item).to be_valid
      end

      it '商品状態、情報があれば出品できること' do
        @item.status_id = '2'
        expect(@item).to be_valid
      end

      it '配送料負担、情報があれば出品できること' do
        @item.shipping_charge_burden_id = '2'
        expect(@item).to be_valid
      end

      it '発送元地域、情報があれば出品できること' do
        @item.shipping_area_id = '2'
        expect(@item).to be_valid
      end

      it '発送日までの日数、情報があれば出品できること' do
        @item.shipping_period_id = '2'
        expect(@item).to be_valid
      end

      it '販売価格の情報がある　＆　半角数字である　＆　価格が300以上であれば出品できること' do
        @item.price = 300
        expect(@item).to be_valid
      end

      it '販売価格の情報がある　＆　半角数字である　＆　価格が10,000,000未満であれば出品できること' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end

    context '商品出品ができない場合' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が必須であること' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が必須であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態についての情報が必須であること' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it '配送料の負担についての情報が必須であること' do
        @item.shipping_charge_burden_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge burden can't be blank")
      end

      it '発送元の地域についての情報が必須であること' do
        @item.shipping_area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area can't be blank")
      end

      it '発送までの日数についての情報が必須であること' do
        @item.shipping_period_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping period can't be blank")
      end

      it '販売価格についての情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '販売価格は300以上が必須であること' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '販売価格は10,000,000未満が必須であること' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '販売価格は半角数字の入力が必須であること(全角数字)' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '販売価格は半角数字の入力が必須であること(全角文字)' do
        @item.price = 'あああ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '販売価格は半角数字の入力が必須であること(半角文字)' do
        @item.price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '販売価格は半角数字の入力が必須であること(半角大文字)' do
        @item.price = 'AAA'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '販売価格は半角数字の入力が必須であること(半角カタカナ)' do
        @item.price = 'ｱｱｱ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
