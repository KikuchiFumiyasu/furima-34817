require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '購入・配送先情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end

      it '郵便番号があれば保存できること' do
        @purchase_address.post_code = '123-4567'
        expect(@purchase_address).to be_valid
      end

      it '都道府県があれば保存できること' do
        @purchase_address.shipping_area_id = 2
        expect(@purchase_address).to be_valid
      end

      it '市町村があれば保存できること' do
        @purchase_address.city = '横浜市'
        expect(@purchase_address).to be_valid
      end

      it '番地があれば保存できること' do
        @purchase_address.address = 1 - 1
        expect(@purchase_address).to be_valid
      end

      it '建物名は未記入でも保存できること' do
        @purchase_address.building_name = nil
        expect(@purchase_address).to be_valid
      end

      it '電話番号があれば保存できること' do
        @purchase_address.phone_number = '08012123434'
        expect(@purchase_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空だと保存できないこと' do
        @purchase_address.post_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_address.post_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Post code is invalid')
      end

      it '都道府県が空だと保存できない' do
        @purchase_address.shipping_area_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Shipping area can't be blank")
      end

      it '都道府県を選択していないと保存できないこと' do
        @purchase_address.shipping_area_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Shipping area must be greater than 1')
      end

      it '市町村が空だと保存できないこと' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと保存できないこと' do
        @purchase_address.address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は半角数字以外では保存できないこと(全角数字)' do
        @purchase_address.phone_number = '０８０１２１２３４３４'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is not a number')
      end

      it '電話番号は半角数字以外では保存できないこと(半角英・全角半角カタカナ)' do
        @purchase_address.phone_number = '080aｂあアｱ555'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is not a number')
      end

      it '電話番号は11文字を超える数字だと保存できないこと' do
        @purchase_address.phone_number = '080121234345'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end

      it 'ユーザIDが空だと保存できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'アイテムIDが空だと保存できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'トークン情報が空だと保存できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
