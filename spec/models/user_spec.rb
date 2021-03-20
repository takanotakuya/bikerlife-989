require 'rails_helper'
RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録できるとき' do
      it 'ユーザー情報全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'ユーザー情報(自己紹介)の項目が無くても登録できる' do
        @user.self_introduction = ""
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'パスワードは、5文字以下では登録できない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'パスワードは、半角英数字混合での入力でないと登録できない' do
        @user.password = '///あいう'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字（半角）と数字（半角）の両方を含めて設定してください")
      end
      it 'パスワードは、英語のみでは登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字（半角）と数字（半角）の両方を含めて設定してください")
      end
      it 'パスワードは、数字のみでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字（半角）と数字（半角）の両方を含めて設定してください")
      end
      it 'パスワードは、全角では登録できない' do
        @user.password = '１２３ABC'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字（半角）と数字（半角）の両方を含めて設定してください")
      end
      it 'パスワードとパスワード（確認用）は、値の一致しないと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end
  end
end
