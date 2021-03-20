require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '#create' do
    context '投稿できる場合' do
      it '投稿情報全て入力済みあれば投稿できる' do
        expect(@post).to be_valid
      end
      it '投稿情報(投稿文)が無くても投稿できる' do
        @post.post_text = ""
        expect(@post).to be_valid
      end
    end

    context '投稿できない場合' do
      it '画像が空では投稿できない' do
        @post.images = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Imagesを入力してください")
      end
      it '投稿名が空では投稿できない' do
        @post.name = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("投稿名を入力してください")
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
 