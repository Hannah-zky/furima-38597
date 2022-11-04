require 'rails_helper'

RSpec.describe OrderCustomer, type: :model do
  describe '配送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_customer = FactoryBot.build(:order_customer, user_id: user.id, item_id: item.id)
      sleep(0.1)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_customer).to be_valid
      end
      it 'buildingは空でも保存できる' do
        @order_customer.building = ''
        expect(@order_customer).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'zipcodeが空だと保存できない' do
        @order_customer.zipcode = ''
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include("Zipcode can't be blank")
      end
      it 'zipcodeが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @order_customer.zipcode = '1234567'
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include('Zipcode is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefecture_idが1以外では保存できない' do
        @order_customer.prefecture_id = 1
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できない' do
        @order_customer.city = ''
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include("City can't be blank")
      end
      it 'address_lineが空だと保存できない' do
        @order_customer.address_line = ''
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include("Address line can't be blank")
      end
      it 'phone_numberが空だと保存できない' do
        @order_customer.phone_number = ''
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberにハイフンがあると保存できない' do
        @order_customer.phone_number = '090-1234-5678'
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが半角数字でなければ保存できない' do
        @order_customer.phone_number = '０１２３４５６７８９'
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが9桁以下だと保存できない' do
        @order_customer.phone_number = '012345678'
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_numberが12桁以上だと保存できない' do
        @order_customer.phone_number = '012345678912'
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'userが紐付いていなければ保存できない' do
        @order_customer.user_id = nil
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていなければ保存できない' do
        @order_customer.item_id = nil
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では保存できない' do
        @order_customer.token = nil
        @order_customer.valid?
        expect(@order_customer.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
