require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    
    context 'ユーザー新規登録ができる時' do
      it '全ての情報があれば登録できること' do
        expect(@user).to be_valid
      end

      it 'ニックネームがあれば登録できること' do
        @user.nickname = 'nicknick'
        expect(@user).to be_valid
      end

      it 'メールアドレスは@を含むドメインがあれば登録できること' do
        @user.email = 'sample@test.com'
        expect(@user).to be_valid
      end

      it 'パスワードは半角英数字を含む6文字以上であれば登録できること' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end

      it 'パスワードとパスワード（確認用）、値の一致すれば登録できること' do
        expect(FactoryBot.build(:user, password: "password", password_confirmation: "passward")).to_not be_valid
      end

      it '姓があれば登録できること' do
        @user.last_name = '山田'
        expect(@user).to be_valid
      end

      it '姓は、全角（漢字・ひらがな・カタカナ）であれば登録できること' do
        @user.last_name = '山田ヤマダやまだ'
        expect(@user).to be_valid
      end

      it '名があれば登録できること' do
        @user.first_name = '一郎'
        expect(@user).to be_valid
      end

      it '名は、全角（漢字・ひらがな・カタカナ）であれば登録できること' do
        @user.first_name = '一郎イチロウいちろう'
        expect(@user).to be_valid
      end

      it '姓の読み方(カタカナ)があれば登録できること' do
        @user.last_name_how_to_read = 'ヤマダ'
        expect(@user).to be_valid
      end

      it '名の読み方(カタカナ)があれば登録できること' do
        @user.first_name_how_to_read = 'イチロウ'
        expect(@user).to be_valid
      end
      
      it '生年月日は年-月-日があれば登録できること' do
        @user.birth_day = '2021-4-20'
        expect(@user).to be_valid
      end
        

    end

    context 'ユーザー新規登録ができない時' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'sampletest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワード(確認用)が必須であること' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードは、パスワードとパスワード(確認用)が一致していること' do
        @user.password = 'a12345'
        @user.password_confirmation = '12345a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードは、半角英数字混合での入力が必須であること(数字)' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation is invalid")
      end

      it 'パスワードは、半角英数字混合での入力が必須であること(英字)' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation is invalid")
      end

      it 'パスワードが全角英数混合だと登録できない(大文字)' do
        @user.password = 'ＡＡＡ１１１'
        @user.password_confirmation = 'ＡＡＡ１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation is invalid")
      end

      it 'パスワードが全角英数混合だと登録できない(小文字)' do
        @user.password = 'ｉｉｉ１１１'
        @user.password_confirmation = 'ｉｉｉ１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation is invalid")
      end

      it '姓が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it '姓は、全角（漢字・ひらがな・カタカナ）での入力が必須であること(全角英字)' do
        @user.last_name = 'YAMADA'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it '姓は、全角（漢字・ひらがな・カタカナ）での入力が必須であること(半角英字)' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it '姓は、全角（漢字・ひらがな・カタカナ）での入力が必須であること (半角ｶﾀｶﾅ)' do
        @user.last_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
    
      it '名が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること(全角英字)' do
        @user.first_name = 'ICHIROU'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it '名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること(半角英字)' do
        @user.first_name = 'ichirou'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it '名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること(半角ｶﾀｶﾅ)' do
        @user.first_name = 'ｲﾁﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it '姓の読み方が必須であること' do
        @user.last_name_how_to_read = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name how to read can't be blank")
      end

      it '姓の読み方は、全角（カタカナ）での入力が必須であること(漢字)' do
        @user.last_name_how_to_read = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name how to read is invalid")
      end

      it '姓の読み方は、全角（カタカナ）での入力が必須であること(ひらがな)' do
        @user.last_name_how_to_read = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name how to read is invalid")
      end

      it '姓の読み方は、全角（カタカナ）での入力が必須であること(半角ｶﾀｶﾅ)' do
        @user.last_name_how_to_read = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name how to read is invalid")
      end

      it '姓の読み方は、全角（カタカナ）での入力が必須であること(全角英字)' do
        @user.last_name_how_to_read = 'YAMADA'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name how to read is invalid")
      end

      it '姓の読み方は、全角（カタカナ）での入力が必須であること(半角英字)' do
        @user.last_name_how_to_read = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name how to read is invalid")
      end

      it '名の読み方が必須であること' do
        @user.first_name_how_to_read = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name how to read can't be blank")
      end

      it '名の読み方は、全角（カタカナ）での入力が必須であること(漢字)' do
        @user.first_name_how_to_read = '一郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name how to read is invalid")
      end

      it '名の読み方は、全角（カタカナ）での入力が必須であること(ひらがな)' do
        @user.first_name_how_to_read = 'いちろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name how to read is invalid")
      end

      it '名の読み方は、全角（カタカナ）での入力が必須であること(半角ｶﾀｶﾅ)' do
        @user.first_name_how_to_read = 'ｲﾁﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name how to read is invalid")
      end

      it '名の読み方は、全角（カタカナ）での入力が必須であること(全角英字)' do
        @user.first_name_how_to_read = 'ICHIROU'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name how to read is invalid")
      end

      it '名の読み方は、全角（カタカナ）での入力が必須であること(半角英字)' do
        @user.first_name_how_to_read = 'ichirou'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name how to read is invalid")
      end

      it '誕生日が必須であること' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end
