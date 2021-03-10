require 'rails_helper'

RSpec.describe Consultation, type: :model do
  before do
    @consultation = FactoryBot.build(:consultation)
  end

  describe '#create' do
    context '投稿できる場合' do
      it '投稿情報全て入力済みあれば投稿できる' do
        expect(@consultation).to be_valid
      end
    end

    context '投稿できない場合' do
      it '相談名が空では投稿できない' do
        @consultation.name = ''
        @consultation.valid?
        expect(@consultation.errors.full_messages).to include("相談名を入力してください")
      end
      it '相談内容が空では投稿できない' do
        @consultation.post_text = ''
        @consultation.valid?
        expect(@consultation.errors.full_messages).to include("相談内容を入力してください")
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @consultation.user = nil
        @consultation.valid?
        expect(@consultation.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
 