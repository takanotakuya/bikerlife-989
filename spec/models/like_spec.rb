require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end

  describe '#create' do
    context 'いいねできる場合' do
      it 'ユーザーが紐付いていればいいねできる' do
        expect(@like).to be_valid
      end
    end

    context 'いいねできない場合' do
      it 'ユーザーが紐付いていなければいいねできない' do
        @like.user = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
 