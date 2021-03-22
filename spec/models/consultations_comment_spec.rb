require 'rails_helper'

RSpec.describe ConsultationsComment, type: :model do
  before do
    @consultations_comment = FactoryBot.build(:consultations_comment)
  end

  describe '#create' do
    context 'コメント投稿できる場合' do
      it 'コメント入力済みあれば投稿できる' do
        expect(@consultations_comment).to be_valid
      end
    end

    context '投稿できない場合' do
      it 'コメントが空では投稿できない' do
        @consultations_comment.comment_text = ''
        @consultations_comment.valid?
        expect(@consultations_comment.errors.full_messages).to include("Comment textを入力してください")
      end
      it 'ユーザーが紐付いていなければコメントできない' do
        @consultations_comment.user = nil
        @consultations_comment.valid?
        expect(@consultations_comment.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
 